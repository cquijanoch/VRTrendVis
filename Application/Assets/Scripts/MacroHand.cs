using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Valve.VR;

public class MacroHand : MonoBehaviour
{
    private SteamVR_Behaviour_Pose m_Pose = null;
    private FixedJoint m_Joint = null;
    [HideInInspector]
    public GameObject m_currentDialog;
    [HideInInspector]
    
    private Hand m_myHand;
    private MacroHand m_otherHand;
    private bool m_custonStatusFingerOtherHand = false;
    private SteamVR_Action_Boolean m_GrabAction = null;
    private SteamVR_Action_Boolean m_GripAction = null;
    public List<Subspace> m_ContactInteractables = new List<Subspace>(); //List of Subspaces inner into MacroHand
    private int m_currentIndexSelected = -1;
    public bool m_isPressedPrimaryPickup = false;
    private bool m_isPressedSecundaryPickup = false;
    public int m_TypeHand = Constants.HAND_NONE_USE;
    private Interaction m_interactionsCoordinated = null;
    private Console m_console = null;
    private Console m_consoleLeft = null;

    public Subspace m_CurrentTakedSubspace = null; // subspace when is pickup
    
    public bool printEvents = false;
    public bool stoppingScaleOnTriggerExit = false;
    public GameObject interactions;
    public GameObject console;

    public int m_selectSubspaces = 0;

    /**
     * Logger
     */
    public float m_pickupTime = 0f;
    public float m_scaleTime = 0f;

    private void Awake()
    {
        m_Pose = GetComponent<SteamVR_Behaviour_Pose>();
        m_Joint = GetComponent<FixedJoint>();
    }
    void Start()
    {
        m_myHand = GetComponent<Hand>();
        m_otherHand = m_myHand.GetOtherMacroHand();
        if (interactions)
            m_interactionsCoordinated = interactions.GetComponent<Interaction>();
        if (console)
        {
            m_console = console.GetComponent<Console>();
            m_console.AddText("MACRO HAND NAME: " + transform.name);
        }

        GameObject consoleLeft = GameObject.Find("ConsoleLeft");
        if (consoleLeft)
            m_consoleLeft = consoleLeft.GetComponent<Console>();
        StartCoroutine(InitCoroutine());
    }

    IEnumerator InitCoroutine()
    {
        yield return new WaitForSeconds(2);
        if (!interactions)
        {
            GameObject coordenation = GameObject.Find("Coordination");
            if (coordenation)
                m_interactionsCoordinated = coordenation.GetComponent<Interaction>();
        }
    }

    void Update()
    {
        if (m_Joint.connectedBody)
            m_pickupTime += Time.deltaTime;

        if (m_CurrentTakedSubspace && m_CurrentTakedSubspace.m_modeScale && !m_CurrentTakedSubspace.isGrid)
            m_scaleTime += Time.deltaTime;

        /** FIX BUG **/
        if (!m_isPressedPrimaryPickup && m_Joint.connectedBody)
        {
            m_CurrentTakedSubspace = null;
            Subspace joined = m_Joint.connectedBody.GetComponent<Subspace>();
            joined.m_PrimaryHand = null;
            joined.m_SecondaryHand = null;
            m_Joint.connectedBody = null;
            if (m_console) m_console.AddText("FIX BUG");
            return;
        }

        if (SteamVR_Actions._default.GrabGrip.GetStateDown(m_Pose.inputSource))
        {
            if (printEvents) print(Time.deltaTime + " " + m_Pose.inputSource + " Pickup");
            if (m_console) m_console.AddText("PICKUP()");
            Pickup();
            if (m_console) m_console.AddText("m_currentIndexSelected: " + m_currentIndexSelected);
            return;
        }

        if (SteamVR_Actions._default.GrabGrip.GetStateUp(m_Pose.inputSource))
        {
            if (printEvents) print(Time.deltaTime + " " + m_Pose.inputSource + " Drop");
            if (m_console) m_console.AddText("DROP()");
            Drop();
            if (m_console) m_console.AddText("m_currentIndexSelected: " + m_currentIndexSelected);
            return;
        }
    }

    private void SetTransformForSimilar()
    {
        Subspace target = m_currentIndexSelected + 1 == m_ContactInteractables.Count ? m_ContactInteractables[0] : m_ContactInteractables[m_currentIndexSelected + 1];
        if (m_CurrentTakedSubspace.DetectSimimilarTransform(target))
        {
            m_CurrentTakedSubspace.SetTransformToObject(target);
            Drop();
        }
    }

    private void ChangeCurrentSelectionSpace()
    {
        if (m_TypeHand == Constants.HAND_PRIMARY_USE)
        {
            m_ContactInteractables[m_currentIndexSelected].m_HandsActivedInner.Remove(this);
            if (m_ContactInteractables[m_currentIndexSelected].GetNumberUsedHandsInner() == 0
                || m_otherHand.GetCurrentSubspace() != m_ContactInteractables[m_currentIndexSelected])
                m_ContactInteractables[m_currentIndexSelected].GetComponent<Renderer>().material.color = Constants.SPACE_COLOR_WITHOUT_CONTROLLER;
            Drop();
            if (++m_currentIndexSelected == m_ContactInteractables.Count)
                m_currentIndexSelected = 0;
            m_ContactInteractables[m_currentIndexSelected].m_HandsActivedInner.Add(this);
            m_ContactInteractables[m_currentIndexSelected].GetComponent<Renderer>().material.color = Constants.SPACE_COLOR_WITH_CONTROLLER;
            DetectTypeHand();
        }
    }

    private void OnTriggerEnter(Collider other)
    {
        if (!(other.gameObject.CompareTag("Subspace") || other.gameObject.CompareTag("Grid")))
            return;
        if (printEvents) print(Time.deltaTime + " " + "OnTriggerEnter : " + other.gameObject.name);
        if (m_console) m_console.AddText("ONTRIGGERENTERIN: " + other.gameObject.name);
        Subspace subspace = other.gameObject.GetComponent<Subspace>();
        
        m_ContactInteractables.Add(subspace);
        if (m_currentIndexSelected < 0)
        {
            m_currentIndexSelected = 0;
            subspace.m_HandsActivedInner.Add(this);
        }
        
        if (!m_CurrentTakedSubspace)
        {
            m_ContactInteractables[m_currentIndexSelected].m_HandsActivedInner.Remove(this);
            if (m_ContactInteractables[m_currentIndexSelected].m_HandsActivedInner.Count == 0)
                m_ContactInteractables[m_currentIndexSelected].GetComponent<Renderer>().material.color = Constants.SPACE_COLOR_WITHOUT_CONTROLLER;
            m_currentIndexSelected = m_ContactInteractables.IndexOf(subspace);
            subspace.m_HandsActivedInner.Add(this);
        }
        subspace.m_numControllersInner++;

        if (!subspace.isGrid && subspace.m_numControllersInner == 1)
        {
            subspace.ChangeColliderPoints(true);
            subspace.GetComponent<Rigidbody>().constraints = RigidbodyConstraints.FreezePosition;
        }
            
        if (enabled && !subspace.m_modePrepareToDelete)
            m_ContactInteractables[m_currentIndexSelected].GetComponent<Renderer>().material.color = Constants.SPACE_COLOR_WITH_CONTROLLER;
        DetectTypeHand();
        if (m_console) m_console.AddText("ONTRIGGERENTEROUT: " + other.gameObject.name
            + " , m_ContactInteractables.Count: " + m_ContactInteractables.Count
            + " , m_currentIndexSelected: " + m_currentIndexSelected
            + " , subspace.m_numControllersInner: " + subspace.m_numControllersInner
            + " , typeHand: " + m_TypeHand);
    }

    public void OnTriggerExit(Collider other)
    {
        if (!(other.gameObject.CompareTag("Subspace") || other.gameObject.CompareTag("Grid")))
            return;
        if (printEvents) print(Time.deltaTime + " " + "OnTriggerExit : " + other.gameObject.name);
        if (m_console) m_console.AddText("ONTRIGGEREXITIN: " + other.gameObject.name);
        Subspace subspace = other.gameObject.GetComponent<Subspace>();

        m_ContactInteractables.Remove(subspace);
        subspace.m_numControllersInner--;
        if (subspace.m_numControllersInner == 0)
            subspace.ChangeColliderPoints(false);
        subspace.m_HandsActivedInner.Remove(this);

        if (enabled && !subspace.m_modePrepareToDelete && (subspace.GetNumberUsedHandsInner(true) == 0))
            other.GetComponent<Renderer>().material.color = Constants.SPACE_COLOR_WITHOUT_CONTROLLER;
            
        if (m_currentIndexSelected > m_ContactInteractables.Count - 1)
            m_currentIndexSelected = m_ContactInteractables.Count - 1;

        if (subspace.m_modeScale && subspace.m_PrimaryHand && subspace.m_SecondaryHand)
        {
            stoppingScaleOnTriggerExit = true;
            if (!m_otherHand.stoppingScaleOnTriggerExit)
                StopScaleAndAutoDetectHand(subspace);
            else
                StopScaleBothHands(subspace);
        }

        if (m_ContactInteractables.Count > 0 && !m_CurrentTakedSubspace)
        {
            m_ContactInteractables[m_currentIndexSelected].m_HandsActivedInner.Add(this);
            if (enabled)
                m_ContactInteractables[m_currentIndexSelected].GetComponent<Renderer>().material.color = Constants.SPACE_COLOR_WITH_CONTROLLER;  
        }

        if (m_ContactInteractables.Count == 0)
            m_CurrentTakedSubspace = null;

        DetectTypeHand();
        stoppingScaleOnTriggerExit = false;
        if (m_console) m_console.AddText("ONTRIGGEREXITIUT: " + other.gameObject.name
            + " , m_ContactInteractables.Count: " + m_ContactInteractables.Count
            + " , m_currentIndexSelected: " + m_currentIndexSelected
            + " , subspace.m_numControllersInner: " + subspace.m_numControllersInner
            + " , typeHand: " + m_TypeHand);
    }


    public void Pickup()
    {
        if (m_TypeHand == Constants.HAND_PRIMARY_USE)
            m_isPressedPrimaryPickup = true;
        if (m_TypeHand == Constants.HAND_SECONDARY_USE)
            m_isPressedSecundaryPickup = true;
        if (m_TypeHand == Constants.HAND_NONE_USE)
        {
            m_isPressedPrimaryPickup = false;
            m_isPressedSecundaryPickup = false;
        }
        
        if (m_CurrentTakedSubspace || m_currentIndexSelected < 0)
            return;
        m_CurrentTakedSubspace = m_ContactInteractables[m_currentIndexSelected];
        if (!m_CurrentTakedSubspace)
            return;
        DetectTypeHand();
        if (m_TypeHand == Constants.HAND_PRIMARY_USE)
        {
            Rigidbody targetBody = m_CurrentTakedSubspace.GetComponent<Rigidbody>();
            if (!m_CurrentTakedSubspace.isGrid && !m_CurrentTakedSubspace.isCell)
                targetBody.constraints = RigidbodyConstraints.None;
            m_Joint.connectedBody = targetBody;
            m_CurrentTakedSubspace.m_PrimaryHand = this;
            m_CurrentTakedSubspace.m_SecondaryHand = null;
            m_CurrentTakedSubspace.AssignChildGrid(true);
            m_selectSubspaces++;
            if (m_consoleLeft)
                m_consoleLeft.AddText("m_selectSubspaces: " + m_selectSubspaces);
        }
        if (m_TypeHand == Constants.HAND_SECONDARY_USE)
        {
            m_CurrentTakedSubspace.m_SecondaryHand = this;
            StopJoiningSubspace();
            m_CurrentTakedSubspace.m_distanceInitialForScale = Vector3.Distance(m_CurrentTakedSubspace.m_PrimaryHand.transform.position, transform.position);
            m_CurrentTakedSubspace.ChangeColliderPoints(false);
            m_CurrentTakedSubspace.m_modeScale = true;
        }
        DetectTypeHand();
    }

    public void Drop()
    {
        if (m_TypeHand == Constants.HAND_PRIMARY_USE)
            m_isPressedPrimaryPickup = false;
        if (m_TypeHand == Constants.HAND_SECONDARY_USE)
            m_isPressedSecundaryPickup = false;

        if (m_TypeHand == Constants.HAND_NONE_USE)
        {
            m_isPressedPrimaryPickup = false;
            m_isPressedSecundaryPickup = false;
        }

        if (m_currentIndexSelected < 0)
            return;

        if (!m_CurrentTakedSubspace)
            return;
        if (m_TypeHand == Constants.HAND_PRIMARY_USE)
        {
            if (m_CurrentTakedSubspace.m_PrimaryHand && !m_CurrentTakedSubspace.m_SecondaryHand)
            {
                Rigidbody targetBody = m_CurrentTakedSubspace.GetComponent<Rigidbody>();
                if (!m_CurrentTakedSubspace.isGrid && !m_CurrentTakedSubspace.isCell)
                    targetBody.constraints = RigidbodyConstraints.FreezePosition;
                targetBody.velocity = Vector3.zero;
                targetBody.angularVelocity = Vector3.zero;
                m_Joint.connectedBody = null;
                m_CurrentTakedSubspace.m_PrimaryHand = null;
                m_CurrentTakedSubspace.AssignChildGrid(false);
                m_CurrentTakedSubspace = null;
            }
            else if (m_CurrentTakedSubspace.m_PrimaryHand && m_CurrentTakedSubspace.m_SecondaryHand)
            {
                m_CurrentTakedSubspace.ResetDistanceInitialForScale();
                m_CurrentTakedSubspace.m_PrimaryHand = m_CurrentTakedSubspace.m_SecondaryHand;
                m_CurrentTakedSubspace.m_SecondaryHand = null;
                m_CurrentTakedSubspace = null;
                m_otherHand.m_isPressedPrimaryPickup = true;
                m_otherHand.m_isPressedSecundaryPickup = false;
                m_otherHand.DetectTypeHand();
                m_otherHand.JoiningSubspace();
            }
        }

        else if (m_TypeHand == Constants.HAND_SECONDARY_USE)
        {
            m_CurrentTakedSubspace.ResetDistanceInitialForScale();
            m_CurrentTakedSubspace.m_SecondaryHand = null;
            m_CurrentTakedSubspace = null;
            JoiningSubspace();
        }
        DetectTypeHand();
    }

    private void StopJoiningSubspace()
    {
        MacroHand hp = GetPrimaryHandPressedFromInner();
        if (!hp)
            return;
        if (m_currentIndexSelected < 0)
            return;
        if (!hp.m_ContactInteractables[m_currentIndexSelected])
            return;
        Rigidbody targetBody = hp.m_ContactInteractables[m_currentIndexSelected].GetComponent<Rigidbody>();
        targetBody.velocity = Vector3.zero;
        targetBody.angularVelocity = Vector3.zero;
        hp.m_ContactInteractables[m_currentIndexSelected].AssignChildGrid(false);
        hp.m_Joint.connectedBody = null;
    }

    public void JoiningSubspace()
    {
        MacroHand hp = GetPrimaryHandPressedFromInner();
        if (!hp)
            return;
        if (!hp.m_ContactInteractables[hp.m_currentIndexSelected])
            return;
        Rigidbody targetBody = hp.m_ContactInteractables[hp.m_currentIndexSelected].GetComponent<Rigidbody>();
        hp.m_Joint.connectedBody = targetBody;
        m_selectSubspaces++;
        hp.m_ContactInteractables[hp.m_currentIndexSelected].AssignChildGrid(true);
        if (m_consoleLeft)
            m_consoleLeft.AddText("m_selectSubspaces: " + m_selectSubspaces);
    }

    /**
    *  Get MacroHand that is primary and has pressed Pickup  from the contact subspace
    **/
    private MacroHand GetPrimaryHandPressedFromInner()
    {
        foreach (MacroHand h in m_ContactInteractables[m_currentIndexSelected].m_HandsActivedInner)
        {
            if (h.m_TypeHand == Constants.HAND_PRIMARY_USE && h.m_isPressedPrimaryPickup && h.m_CurrentTakedSubspace)
                return h;
        }
        return null;
    }

    /**
    * Detect Type Hand
    **/
    public void DetectTypeHand()
    {
        /* If not exists contact with subsapces*/
        if (m_ContactInteractables.Count == 0)
        {
            m_TypeHand = Constants.HAND_NONE_USE;
            return;
        }

        /* If in the current subspace is not asigned primaryHand*/
        if (!m_ContactInteractables[m_currentIndexSelected].m_PrimaryHand ||
            !m_ContactInteractables[m_currentIndexSelected].m_PrimaryHand.enabled) // Laser
        {
            foreach (MacroHand h in m_ContactInteractables[m_currentIndexSelected].m_HandsActivedInner)
                h.m_TypeHand = Constants.HAND_PRIMARY_USE;
            return;
        }

        /*  RECALIBRATING HANDS INNER INTO SUBSPACE     */

        foreach (MacroHand h in m_ContactInteractables[m_currentIndexSelected].m_HandsActivedInner)
        {
            if (h.m_isPressedPrimaryPickup)
                h.m_TypeHand = Constants.HAND_PRIMARY_USE;
            else
                h.m_TypeHand = Constants.HAND_SECONDARY_USE;
        }
    }

    /**
    * Stop Scale mode and refactor type of Hands
    **/
    private void StopScaleAndAutoDetectHand(Subspace subspace)
    {
        subspace.ResetDistanceInitialForScale();
        // If the output MacroHand is the same that primaryHand
        if (this == subspace.m_PrimaryHand)
        {
            subspace.m_PrimaryHand = subspace.m_SecondaryHand;
            subspace.m_SecondaryHand = null;
            m_CurrentTakedSubspace = null;
            m_otherHand.m_isPressedPrimaryPickup = true;
            m_otherHand.m_isPressedSecundaryPickup = false;
            m_isPressedPrimaryPickup = false;
            m_isPressedSecundaryPickup = false;
            m_otherHand.DetectTypeHand();
            m_otherHand.JoiningSubspace();
        }
        else
        {
            subspace.m_SecondaryHand = null;
            m_CurrentTakedSubspace = null;
            m_isPressedPrimaryPickup = false;
            m_isPressedSecundaryPickup = false;
            DetectTypeHand();
            m_otherHand.DetectTypeHand();
            m_otherHand.JoiningSubspace();

        }
        if (subspace.GetNumberUsedHandsInner() == 0)
            subspace.m_PrimaryHand = null;
    }

    private void StopScaleBothHands(Subspace subspace)
    {
        subspace.ResetDistanceInitialForScale();
        subspace.m_PrimaryHand = null;
        subspace.m_SecondaryHand = null;
        m_CurrentTakedSubspace = null;
        m_isPressedPrimaryPickup = false;
        m_isPressedSecundaryPickup = false;
        Rigidbody targetBody = subspace.GetComponent<Rigidbody>();
        targetBody.velocity = Vector3.zero;
        targetBody.angularVelocity = Vector3.zero;
        m_Joint.connectedBody = null;
        m_otherHand.DetectTypeHand();
    }

    /**
     * Set Empty COlor to subspaces that has contact with this Macrohand
     **/
    public void SetEmptyColorSubspaces()
    {
        foreach (Subspace sub in m_ContactInteractables)
            sub.GetComponent<Renderer>().material.color = Constants.SPACE_COLOR_WITHOUT_CONTROLLER;
    }

    /**
     * Set Empty COlor to Current Subspace
     **/
    public void SetEmptyColorCurrentSubspace()
    {
        if (m_currentIndexSelected < 0)
            return;
        m_ContactInteractables[m_currentIndexSelected].GetComponent<Renderer>().material.color = Constants.SPACE_COLOR_WITHOUT_CONTROLLER;
    }

    /**
     * Set Color to Subspaces that has contact with this Macrohand
     **/
    public void SetAutoColorSubspaces()
    {
        foreach (Subspace sub in m_ContactInteractables)
            sub.SetAutoColor();
    }

    /**
     * Get Current Subspace to selected or selected already
     * This is colored in the visualization
     **/
    public Subspace GetCurrentSubspace()
    {
        if (m_currentIndexSelected < 0)
            return null;
        return m_ContactInteractables[m_currentIndexSelected];
    }

    private void OnEnable()
    {
        SetEmptyColorCurrentSubspace();
    }

    private void OnDisable()
    {
        SetEmptyColorSubspaces();
    }

    public void Clean()
    {
        m_ContactInteractables.Clear();
        m_currentIndexSelected = -1;
        m_TypeHand = Constants.HAND_NONE_USE;
    }
}