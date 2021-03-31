using UnityEngine;
using Valve.VR;

public class Hand : MonoBehaviour
{
    private SteamVR_Behaviour_Pose m_Pose = null;
    public int modeTypeHand = Constants.INT_HAND_MODE_MICRO;
    private MacroHand m_currentMacroHand;
    private MicroHand m_currentMicroHand;
    private LaserPointer m_currentLaserPointer;
    private bool m_lastEnableMacroHand;
    
    public bool activate_hand = true;
    public bool activate_laser = true;

    private bool m_custonStatusFingerOtherHand = false;

    void Start()
    {
        m_Pose = GetComponent<SteamVR_Behaviour_Pose>();
        m_currentMacroHand = GetComponent<MacroHand>();
        m_currentMicroHand = GetComponent<MicroHand>();
        m_currentLaserPointer = GetComponent<LaserPointer>();
    }

    void Update()
    {

        if (SteamVR_Actions._default.TouchXbutton.GetStateDown(m_Pose.inputSource)
            || SteamVR_Actions._default.TouchYbutton.GetStateDown(m_Pose.inputSource))
        {
            FinishTask();
            return;
        }

        if (!m_currentMacroHand.m_CurrentTakedSubspace && 
            SteamVR_Actions._default.TouchNoPressGrabPinch.GetState(m_Pose.inputSource))
        {
            m_currentMacroHand.enabled = false;
            DesactivateFingerHand();
            if (activate_laser)
            {
                m_currentLaserPointer.enabled = true;
                if (IsDataObject())
                {
                    modeTypeHand = Constants.INT_HAND_MODE_MICRO;
                    m_currentMicroHand.enabled = true;
                }
                else
                {
                    modeTypeHand = Constants.INT_HAND_MODE_MACRO;
                    m_currentMicroHand.enabled = false;
                }
            }
            return;
        }

        if (!m_currentMacroHand.m_CurrentTakedSubspace && 
            (SteamVR_Actions._default.TouchNoPressGrabPinch.GetStateUp(m_Pose.inputSource)
            || !SteamVR_Actions._default.TouchNoPressGrabPinch.GetState(m_Pose.inputSource))
            && (SteamVR_Actions._default.GrabGrip.GetStateUp(m_Pose.inputSource)
            || !SteamVR_Actions._default.GrabGrip.GetState(m_Pose.inputSource)))
        {
            if (m_currentLaserPointer.enabled)
                m_currentLaserPointer.enabled = false;
            if (!getStatusFingerHand())
                ActivateFingerHand();
            if (activate_hand)
            {
                if (IsDataObject() && modeTypeHand == Constants.INT_HAND_MODE_MACRO)
                    MacroToMicro();
                if (!IsDataObject())
                    MicroToMacro();
            }
            return;
        }  
    }

    public void ActivateHandVR()
    {
        activate_hand = true;
    }

    public void DeactivateHandVR()
    {
        activate_hand = false;
    }

    public void ActivateRay()
    {
        activate_laser = true;
    }

    public void DeactivateRay()
    {
        activate_laser = false;
    }

    public void ChangeModeTypeHand(int intHandMode)
    {
        if (intHandMode == Constants.INT_HAND_MODE_MACRO)
        {
            m_currentMicroHand.enabled = false;
            m_currentMacroHand.enabled = true;
        }

        if (intHandMode == Constants.INT_HAND_MODE_MICRO)
        {
            m_currentMacroHand.enabled = false;
            m_currentMicroHand.enabled = true;
        }
    }

    private void ToogleModeHand()
    {
        if (modeTypeHand == Constants.INT_HAND_MODE_MACRO) // Change MACRO to MICRO
            MacroToMicro();
        else if (modeTypeHand == Constants.INT_HAND_MODE_MICRO)  //Change MICRO TO MACRO
            MicroToMacro();
    }

    private void MicroToMacro()
    {
        //GetComponent<Valve.VR.InteractionSystem.Hand>().ShowController(true);
        //if (m_currentMacroHand.GetCurrentSubspace())
        //    m_currentMacroHand.GetCurrentSubspace().m_HandsActivedInner.Add(m_currentMacroHand);
        //GetComponent<Collider>().enabled = true;
        modeTypeHand = Constants.INT_HAND_MODE_MACRO;
        ChangeModeTypeHand(modeTypeHand);
        m_currentMacroHand.SetAutoColorSubspaces();
        //GetComponent<Valve.VR.InteractionSystem.Hand>().useFingerJointHover = false;
    }

    private void MacroToMicro()
    {
        //GetComponent<Valve.VR.InteractionSystem.Hand>().HideController(true);
        if (m_currentMacroHand.GetCurrentSubspace() && m_currentMacroHand.GetCurrentSubspace().GetNumberUsedHandsInner() == 0)//if isnt other macrohand inner
            m_currentMacroHand.SetEmptyColorCurrentSubspace();
        //if (m_currentMacroHand.GetCurrentSubspace())
        //    m_currentMacroHand.GetCurrentSubspace().m_HandsActivedInner.Remove(m_currentMacroHand);
        //GetComponent<Collider>().enabled = false;
        modeTypeHand = Constants.INT_HAND_MODE_MICRO;
        ChangeModeTypeHand(modeTypeHand);
        //GetComponent<Valve.VR.InteractionSystem.Hand>().useFingerJointHover = true;
    }

    public void HideFisicHand()
    {
        GetComponent<Valve.VR.InteractionSystem.Hand>().HideSkeleton();
        GetComponent<Valve.VR.InteractionSystem.Hand>().HideGrabHint();
    }

    public void ShowFisicHand()
    {
        GetComponent<Valve.VR.InteractionSystem.Hand>().ShowSkeleton();
        ActivateFingerHand();
        //GetComponent<Valve.VR.InteractionSystem.Hand>().ShowGrabHint();
    }

    public void HideFisicController()
    {
        GetComponent<Valve.VR.InteractionSystem.Hand>().HideController();
        GetComponent<Valve.VR.InteractionSystem.Hand>().HideGrabHint();
    }

    public void ShowFisicController()
    {
        GetComponent<Valve.VR.InteractionSystem.Hand>().ShowController();
        //GetComponent<Valve.VR.InteractionSystem.Hand>().ShowGrabHint();
    }

    public void HideHand()
    {
        GetComponent<Valve.VR.InteractionSystem.Hand>().HideController();
        GetComponent<Valve.VR.InteractionSystem.Hand>().HideSkeleton();
        GetComponent<Valve.VR.InteractionSystem.Hand>().enabled = false;
        m_lastEnableMacroHand = m_currentMacroHand.enabled;
        m_currentMacroHand.enabled = false;
    }

    public void ShowHand()
    {
        GetComponent<Valve.VR.InteractionSystem.Hand>().enabled = true;
        GetComponent<Valve.VR.InteractionSystem.Hand>().ShowController();
        GetComponent<Valve.VR.InteractionSystem.Hand>().ShowSkeleton();
        m_currentMacroHand.enabled = m_lastEnableMacroHand;
    }

    public void DisableBothMacroHand()
    {
        GetComponent<MacroHand>().enabled = false;
        DisableOtherMacroHand();
    }

    public void DisableOtherMacroHand()
    {
        GetComponent<Valve.VR.InteractionSystem.Hand>().otherHand.GetComponent<MacroHand>().enabled = false;
    }

    public void EnableBothMacroHand()
    {
        GetComponent<MacroHand>().enabled = true;
        EnableOtherMacroHand();
    }

    public void EnableOtherMacroHand()
    {
        GetComponent<Valve.VR.InteractionSystem.Hand>().otherHand.GetComponent<MacroHand>().enabled = true;
    }

    public MacroHand GetOtherMacroHand()
    {
        return GetComponent<Valve.VR.InteractionSystem.Hand>().otherHand.GetComponent<MacroHand>();
    }

    public LaserPointer GetOtherLaserPointer()
    {
        return GetComponent<Valve.VR.InteractionSystem.Hand>().otherHand.GetComponent<LaserPointer>();
    }

    public Data getDataFromIndex()
    {
        if (m_currentLaserPointer.enabled)
            return m_currentLaserPointer.data;
        if (GetComponent<Valve.VR.InteractionSystem.Hand>().hoveringInteractable)
            return GetComponent<Valve.VR.InteractionSystem.Hand>().hoveringInteractable.GetComponent<Data>();
        return null;
    }

    public bool getStatusFingerHand()
    {
        return GetComponent<Valve.VR.InteractionSystem.Hand>().useFingerJointHover;
    }
    public void ActivateFingerHand()
    {
        GetComponent<Valve.VR.InteractionSystem.Hand>().useFingerJointHover = true;
    }

    public void DesactivateFingerHand()
    {
        GetComponent<Valve.VR.InteractionSystem.Hand>().useFingerJointHover = false;
    }

    private void FinishTask()
    {
        GameObject taskManager = GameObject.Find("TaskManager");
        taskManager.GetComponent<TaskManager>().Next();
    }

    public bool IsDataObject()
    {
        if (getDataFromIndex() && (getDataFromIndex().gameObject.CompareTag("DataScatterplot")
            || getDataFromIndex().gameObject.CompareTag("DataBarchart")))
            return true;
        return false;
    }

    public Valve.VR.InteractionSystem.Hand GetSteamVRHand()
    {
        return GetComponent<Valve.VR.InteractionSystem.Hand>();
    }
}