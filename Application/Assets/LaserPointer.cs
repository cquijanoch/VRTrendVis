using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.Linq;
using Valve.VR;

public class LaserPointer : MonoBehaviour
{
    //**Visual**/
    public Color color;
    public float thickness = 0.2f;
    public Color clickColor = Color.green;
    public GameObject holder;
    public GameObject pointer;
    LineRenderer lr = null;
    public bool isActive = true;
    public bool printEvents = false;
    public GameObject interactions;
    public GameObject console;
    public Data data;
    public Subspace m_CurrentTakedSubspace = null;

    public bool isRotating = false;
    public bool isTranslating = false;
    public bool isScaling = false;

    private Transform m_previousInteractable = null;
    private SteamVR_Behaviour_Pose m_Pose = null;

    /**Interactions**/
    private Interaction m_interactionsCoordinated = null;
    private Console m_console = null;
    private Hand m_myHand;
    private LaserPointer m_otherPointer;
    private int m_priority = -1;// 0: Grid, 1: Subspace, 2: Data

    public float m_pickupTime = 0f;
    public float m_scaleTime = 0f;

    private void Awake()
    {
        holder = new GameObject();
        holder.transform.parent = this.transform;
        holder.transform.localPosition = Vector3.zero;
        holder.transform.localRotation = Quaternion.identity;

        pointer = GameObject.CreatePrimitive(PrimitiveType.Cube);
        pointer.transform.parent = holder.transform;
        pointer.transform.localScale = new Vector3(thickness, thickness, 100f);
        pointer.transform.localPosition = new Vector3(0f, 0f, 50f);
        pointer.transform.localRotation = Quaternion.identity;
        ViewRaycast(false);
    }
    void Start()
    {
        m_myHand = GetComponent<Hand>();
        m_otherPointer = m_myHand.GetOtherLaserPointer();

        Destroy(pointer.GetComponent<BoxCollider>());
        lr = gameObject.AddComponent<LineRenderer>();
        Utils.Reset(lr);
        m_Pose = GetComponent<SteamVR_Behaviour_Pose>();
        if (interactions)
            m_interactionsCoordinated = interactions.GetComponent<Interaction>();
        if (console)
        {
            m_console = console.GetComponent<Console>();
            m_console.AddText("Laser NAME: " + transform.name);
        }
    }

    void Update()
    {
        if (!isActive)
        {
            isActive = true;
            transform.GetChild(0).gameObject.SetActive(true);
            holder.SetActive(true);
        }

        if (m_previousInteractable && m_priority < 2) //Fix Bug
        {
            Subspace prevSubspace = m_previousInteractable.GetComponent<Subspace>();
            if (!prevSubspace.m_PrimaryHand && prevSubspace.m_SecondaryHand)
                prevSubspace.m_SecondaryHand = null;
        }

        if (m_priority < 2 && SteamVR_Actions._default.GrabGrip.GetStateUp(m_Pose.inputSource))//desactive Interactable
        {
            Utils.Reset(lr);
            holder.SetActive(true);
            Subspace prevSubspace = null;
            if (m_previousInteractable && m_previousInteractable.GetComponent<Subspace>())
                prevSubspace = m_previousInteractable.GetComponent<Subspace>();
            
            if (!prevSubspace)
                return;
            
            if (prevSubspace.m_PrimaryHand == m_myHand.GetComponent<MacroHand>())
            {
                prevSubspace.m_PrimaryHand = null;
                prevSubspace.AssignChildGrid(false);
                isScaling = false;
                isRotating = false;
                isTranslating = false;
            }
            else if (prevSubspace.m_SecondaryHand == m_myHand.GetComponent<MacroHand>())
            {
                prevSubspace.m_SecondaryHand = null;
                isScaling = false;
                isRotating = false;
                isTranslating = false;
            }
            else
            {
                prevSubspace.m_modeScale = false;
                prevSubspace.m_PrimaryHand = prevSubspace.m_SecondaryHand;
                prevSubspace.m_SecondaryHand = null;
                isScaling = false;
                m_otherPointer.isScaling = false;
            }
            m_CurrentTakedSubspace = null;
        }

        if (m_priority < 2 && (isTranslating || isRotating || isScaling))
        {
            ApplyInteraction(m_priority, m_previousInteractable);
            return;
        }

        float dist = 100f;

        Ray raycastPrimary = new Ray(transform.position, transform.forward);
        RaycastHit[] hits;

        hits = Physics.RaycastAll(raycastPrimary).OrderBy(h => h.distance).ToArray();

        m_priority = -1; 
        Transform interactable = null;
        data = null;
        for (int i = 0; i < hits.Length; i++)
        {
            if (hits[i].collider.transform.CompareTag("Grid"))
            {
                m_priority = 0;
                interactable = hits[i].collider.transform;
                dist = hits[i].distance;
            }

            if (hits[i].collider.transform.CompareTag("Subspace"))
            {
                m_priority = 1;
                interactable = hits[i].collider.transform;
                dist = hits[i].distance;
                if (!interactable.GetComponent<Subspace>().activateCollider)
                {
                    hits[i].transform.GetComponent<Subspace>().ChangeColliderPoints(true);
                    hits[i].transform.GetComponent<Rigidbody>().constraints = RigidbodyConstraints.FreezePosition;
                }
            }

            if (hits[i].collider.transform.CompareTag("DataScatterplot"))
            {
                m_priority = 2;
                interactable = hits[i].collider.transform;
                dist = hits[i].distance;
                data = interactable.GetComponent<Data>();
                if (m_previousInteractable && m_previousInteractable.CompareTag("Subspace"))
                    m_previousInteractable.GetComponent<Renderer>().material.color = Constants.SPACE_COLOR_WITHOUT_CONTROLLER;
                break;
            }
        }

        pointer.transform.localScale = new Vector3(thickness, thickness, dist);
        pointer.GetComponent<MeshRenderer>().material.color = color;
        pointer.transform.localPosition = new Vector3(0f, 0f, dist / 2f);
        pointer.transform.localRotation = Quaternion.identity;
        if ((m_priority == 1 || m_priority == 0) && interactable)
            ApplyInteraction(m_priority, interactable);
        if (m_priority < 0 && m_previousInteractable && !m_previousInteractable.CompareTag("DataScatterplot"))
            m_previousInteractable.GetComponent<Renderer>().material.color = Constants.SPACE_COLOR_WITHOUT_CONTROLLER;
        m_previousInteractable = interactable;

    }

    private void OnEnable()
    {
        GetComponent<TransformStep>().enabled = true;
        ViewRaycast(true);
    }

    private void OnDisable()
    {
        GetComponent<TransformStep>().enabled = false;
        ViewRaycast(false);
        if (m_previousInteractable && !m_previousInteractable.CompareTag("DataScatterplot"))
            m_previousInteractable.GetComponent<Renderer>().material.color = Constants.SPACE_COLOR_WITHOUT_CONTROLLER;
        Subspace subspace = null;
        data = null;
        Utils.Reset(lr);
        m_CurrentTakedSubspace = null;
        isScaling = false;
        isRotating = false;
        isTranslating = false;
        if (m_previousInteractable && m_previousInteractable.GetComponent<Subspace>())
            subspace = m_previousInteractable.GetComponent<Subspace>();
        if (subspace)
        {
            subspace.m_PrimaryHand = null;
            subspace.m_SecondaryHand = null;
        }
    }

    private void ApplyInteraction(int priority, Transform interactable)
    {
        if (!interactable.GetComponent<Subspace>())
        {
            print("ERROR Subspace not exist.!");
            return;
        }
        Subspace subspace = interactable.GetComponent<Subspace>();    
        
        if (priority == 0) //Grid
        {
            if (m_previousInteractable && m_previousInteractable != interactable && !m_previousInteractable.CompareTag("DataScatterplot"))
                m_previousInteractable.GetComponent<Renderer>().material.color = Constants.SPACE_COLOR_WITHOUT_CONTROLLER;
            interactable.GetComponent<Renderer>().material.color = Constants.SPACE_COLOR_WITH_CONTROLLER;

            if (SteamVR_Actions._default.GrabGrip.GetState(m_Pose.inputSource))
            {
                if (printEvents) print(Time.deltaTime + " " + m_Pose.inputSource + " Pickup");
                if (m_console) m_console.AddText("PICKUP()");
                if (m_console) m_console.AddText("Grid: " + interactable.name);
                holder.SetActive(false);
                DrawLine(transform.position, interactable.position, color);
                m_CurrentTakedSubspace = subspace;
                m_CurrentTakedSubspace.AssignChildGrid(true);
                Pickup(subspace, false);
                return;
            }
        }

        if (priority == 1)//Subspace
        {
            if (m_previousInteractable && m_previousInteractable != interactable && !m_previousInteractable.CompareTag("DataScatterplot"))
                m_previousInteractable.GetComponent<Renderer>().material.color = Constants.SPACE_COLOR_WITHOUT_CONTROLLER;
            interactable.GetComponent<Renderer>().material.color = Constants.SPACE_COLOR_WITH_CONTROLLER;

            if (SteamVR_Actions._default.GrabGrip.GetState(m_Pose.inputSource))
            {
                if (printEvents) print(Time.deltaTime + " " + m_Pose.inputSource + " Pickup");
                if (m_console) m_console.AddText("PICKUP()");
                if (m_console) m_console.AddText("Scatterplot: " + interactable.name);
                holder.SetActive(false);
                if (subspace.activateCollider)
                    subspace.ChangeColliderPoints(false);
                DrawLine(transform.position, interactable.position, color);
                m_CurrentTakedSubspace = subspace;
                bool freezeTranslating = subspace.isCell;
                Pickup(subspace, true, !freezeTranslating);
                return;
            }
        }
    }

    private void Pickup(Subspace subspace, bool rotate = false, bool translate = true)
    {
        if (!subspace)
            return;
        if (!subspace.m_PrimaryHand || subspace.m_PrimaryHand == GetComponent<MacroHand>())//translating
        {
            subspace.m_PrimaryHand = GetComponent<MacroHand>();
            var newTranslation = CalcTranslation();
            if (rotate && !isScaling)
            {
                var newRotation = CalcRotation();
                subspace.transform.rotation = newRotation * subspace.transform.rotation;
                isRotating = true;
            }
            if(translate && !isScaling)
            {
                Vector3 newPos = subspace.transform.position + newTranslation * 2;
                if (newPos.x < Constants.XMAX && newPos.x > Constants.XMIN
                    && newPos.y < Constants.YMAX && newPos.y > Constants.YMIN
                    && newPos.z < Constants.ZMAX && newPos.z > Constants.ZMIN)
                    subspace.transform.position = newPos;
                isTranslating = true;
            }
            m_pickupTime += Time.deltaTime;
        }   
        else
        {
            subspace.m_SecondaryHand = GetComponent<MacroHand>();
            subspace.m_distanceInitialForScale = Vector3.Distance(subspace.m_PrimaryHand.transform.position, transform.position);
            subspace.m_modeScale = true;
            isScaling = true;
            m_otherPointer.isScaling = true;
            isTranslating = false;
            isRotating = false;
            m_scaleTime += Time.deltaTime;
        }
    }

    Quaternion CalcRotation()
    {
        Quaternion finalRotation = Quaternion.identity;
        //if (interactingHands.Count == 1) // grabbing with one hand
        finalRotation = transform.GetComponent<TransformStep>().rotationStep;
        return finalRotation;
    }

    public Vector3 CalcTranslation()
    {
        Vector3 averagePoint = new Vector3();
        averagePoint = new Vector3(gameObject.GetComponent<TransformStep>().positionStep.x,
            gameObject.GetComponent<TransformStep>().positionStep.y,
            gameObject.GetComponent<TransformStep>().positionStep.z);
        return averagePoint;
    }

    public float AngleAroundAxis(Quaternion controllerRot, Vector3 dir)
    {
        var rot = controllerRot * Vector3.forward; //creates a new coordinate system
        var cross1 = Vector3.Cross(rot, dir); //based on the axis of rotation 
        Vector3 right = Vector3.Cross(cross1, dir).normalized; // and the controller
        cross1 = Vector3.Cross(right, dir).normalized;
        Vector3 v = Vector3.Cross(Vector3.forward, dir);
        return Mathf.Atan2(Vector3.Dot(v, right), Vector3.Dot(v, cross1)) * MathUtil.RAD_TO_DEG;

    }

    public void ViewRaycast(bool isActive)
    {
        if (!pointer) return;
        if (!isActive)
           holder.SetActive(false);
        else
           holder.SetActive(true);
    }

    public void DrawLine (Vector3 initPoint, Vector3 endPoint, Color c)
    {
        lr.positionCount = 2;
        lr.startWidth = thickness;
        lr.endWidth = thickness;
        lr.material = new Material(Shader.Find("Sprites/Default"));
        lr.startColor = c;
        lr.endColor = c;
        lr.SetPosition(0, initPoint);
        lr.SetPosition(1, endPoint);
    }
}
