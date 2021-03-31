using System.Collections;
using System.Collections.Generic;
using UnityEngine.UI;
using UnityEngine;
using Valve.VR;

public class MicroHand : MonoBehaviour
{
    private SteamVR_Behaviour_Pose m_Pose = null;
    public Data m_currentDataSelect = null;
    private Hand m_myHand;
    public GameObject m_currentDialog;
    private Interaction m_interactionsCoordinated = null;
    private AudioSource m_audioSource;

    public bool printEvents = false;
    public GameObject descriptionDialog;
    public Data m_previousData = null;
    public bool m_stateSelect = true;
    public GameObject interactions;
    public AudioClip SingleSelectAudio;
    public AudioClip DoubleSelectAudio;

    private void Awake()
    {
        m_Pose = GetComponent<SteamVR_Behaviour_Pose>();
        m_audioSource = GetComponent<AudioSource>();
    }

    void Start()
    {
        m_myHand = GetComponent<Hand>();
        if (interactions)
            m_interactionsCoordinated = interactions.GetComponent<Interaction>();
        //StartCoroutine(InitCoroutine());
    }

    void Update()
    {
        if (m_myHand.IsDataObject())
        {
            if (printEvents) print(Time.deltaTime + "  Single pick");
            if (!m_currentDataSelect)
            {
                m_currentDataSelect = m_myHand.getDataFromIndex();
                m_currentDialog = Instantiate(descriptionDialog,
                    (m_currentDataSelect.transform.position + m_myHand.transform.position) / 2,
                    Quaternion.LookRotation(transform.position - GameObject.FindGameObjectWithTag("MainCamera").transform.position));
                m_currentDialog.GetComponentsInChildren<Text>()[0].text = m_currentDataSelect.Name_1;
                m_currentDialog.GetComponentsInChildren<Text>()[1].text = m_currentDataSelect.Name_2;
                m_currentDialog.GetComponentsInChildren<Text>()[2].text = m_currentDataSelect.Name_3;
                m_currentDialog.GetComponentsInChildren<Text>()[3].text = m_currentDataSelect.Name_4;
                m_currentDialog.GetComponentsInChildren<Text>()[4].text = m_currentDataSelect.Name_6;
                if (GetComponent<LaserPointer>().enabled)
                {
                    m_currentDataSelect.ShowHighlight();
                    m_currentDataSelect.UpdateHighlight();
                }
                m_interactionsCoordinated.TransparencyNearData(m_currentDataSelect);
                return;
            }

            if (m_currentDataSelect != m_myHand.getDataFromIndex() && m_currentDialog)
            {
                Destroy(m_currentDialog);
                m_previousData = m_currentDataSelect;
                m_currentDataSelect = m_myHand.getDataFromIndex();
                m_currentDialog = Instantiate(descriptionDialog,
                    (m_currentDataSelect.transform.position + m_myHand.transform.position)/2,
                    Quaternion.LookRotation(transform.position - GameObject.FindGameObjectWithTag("MainCamera").transform.position));
                m_currentDialog.GetComponentsInChildren<Text>()[0].text = m_currentDataSelect.Name_1;
                m_currentDialog.GetComponentsInChildren<Text>()[1].text = m_currentDataSelect.Name_2;
                m_currentDialog.GetComponentsInChildren<Text>()[2].text = m_currentDataSelect.Name_3;
                m_currentDialog.GetComponentsInChildren<Text>()[3].text = m_currentDataSelect.Name_4;
                m_currentDialog.GetComponentsInChildren<Text>()[4].text = m_currentDataSelect.Name_6;
                if (GetComponent<LaserPointer>().enabled)
                {
                    m_currentDataSelect.ShowHighlight();
                    m_currentDataSelect.UpdateHighlight();
                }
                m_interactionsCoordinated.TransparencyNearData(m_currentDataSelect);
                return;
            }

            if (m_currentDataSelect == m_myHand.getDataFromIndex() && m_currentDialog)
            {
                m_currentDialog.GetComponentsInChildren<Text>()[0].text = m_currentDataSelect.Name_1;
                m_currentDialog.GetComponentsInChildren<Text>()[1].text = m_currentDataSelect.Name_2;
                m_currentDialog.GetComponentsInChildren<Text>()[2].text = m_currentDataSelect.Name_3;
                m_currentDialog.GetComponentsInChildren<Text>()[3].text = m_currentDataSelect.Name_4;
                m_currentDialog.GetComponentsInChildren<Text>()[4].text = m_currentDataSelect.Name_6;
                if (GetComponent<LaserPointer>().enabled)
                {
                    m_currentDataSelect.ShowHighlight();
                    m_currentDataSelect.UpdateHighlight();
                }
                m_interactionsCoordinated.TransparencyNearData(m_currentDataSelect);
            }

            if (SteamVR_Actions._default.GrabGrip.GetStateDown(m_Pose.inputSource)  && m_currentDataSelect)
            {
                if (printEvents) print(Time.deltaTime + " Double push Data Object");
                m_interactionsCoordinated.FilterData(m_currentDataSelect);
                m_stateSelect = false;
                m_audioSource.PlayOneShot(DoubleSelectAudio, 1f);
                return;
            }
        }
        else
        {
            if (m_currentDataSelect)
            {
                if (GetComponent<LaserPointer>().enabled)
                    m_currentDataSelect.HideHighlight();
                m_interactionsCoordinated.ResetTransparency();
                m_previousData = m_currentDataSelect;
                Destroy(m_currentDialog);
                if (!m_stateSelect) m_stateSelect = true;
            }
            m_currentDataSelect = null;
        }
    }

    public void CleanDescriptionDialog()
    {
        if (m_currentDataSelect && GetComponent<LaserPointer>().enabled)
            m_currentDataSelect.HideHighlight();
        if (m_currentDialog)
            Destroy(m_currentDialog);
        m_interactionsCoordinated.ResetTransparency();
        m_currentDataSelect = null;
    }

    private void OnDisable()
    {
        CleanDescriptionDialog();
    }
}
