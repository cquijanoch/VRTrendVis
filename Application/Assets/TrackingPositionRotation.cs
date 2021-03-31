using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using UnityEngine;

public class TrackingPositionRotation : MonoBehaviour
{
    public GameObject Player;
    TaskManager TaskManager;
    Record Recorder = new Record();
    public float timeDelay = 2f;
    float elapsed = 0f;

    void Start()
    {
        DontDestroyOnLoad(gameObject);
        TaskManager = GameObject.Find("TaskManager").GetComponent<TaskManager>();
        try
        {
            Recorder.LogHeaderPosition("tracking");
        }
        catch (UnauthorizedAccessException e)
        {
            Debug.Log("UnauthorizedAccess " + e.Message);
        }
    }
    
    void Update()
    {
        if (!TaskManager.m_player)
            return;

        elapsed += Time.deltaTime;
        if (elapsed >= timeDelay)
        {
            elapsed = elapsed % timeDelay;
            RecordPositionRotation();
        }

        //DateTime.Now.ToString("yyyyMMddHHmmss");
    }

    void RecordPositionRotation()
    {
        StringBuilder row = new StringBuilder();
        row.Append(DateTime.Now.ToString("yyyyMMddHHmmss"));
        row.Append(";");
        row.Append(TaskManager.m_tutorialPhase);
        row.Append(";");
        row.Append(TaskManager.m_step);
        row.Append(";");
        if (TaskManager.m_tutorialPhase == 3)
        {
            row.Append(TaskManager.m_trialTask);
            row.Append(";");
            if (TaskManager.m_currentVisMode == 5)
                row.Append("5");
            else
                row.Append(TaskManager.m_listVisMode[TaskManager.m_currentVisMode - 1]);
        }
        else if (TaskManager.m_tutorialPhase == 4 && TaskManager.m_currentTask > 0)
        {
            row.Append(TaskManager.m_listTask[TaskManager.m_currentTask - 1]);
            row.Append(";");
            if (TaskManager.m_currentVisMode > 3)
                row.Append("4");
            else
                row.Append(TaskManager.m_listVisMode[TaskManager.m_currentVisMode - 1]);
        }
        else
        {
            row.Append(";");
        }
        row.Append(";");
        row.Append(TaskManager.m_player.GetComponent<MovementVR>().XArea);
        row.Append(";");
        row.Append(TaskManager.m_player.GetComponent<MovementVR>().ZArea);
        row.Append(";");
        row.Append(TaskManager.m_player.GetComponent<MovementVR>().areaTotal);
        row.Append(";");
        row.Append(TaskManager.m_player.transform.position.x);
        row.Append(";");
        row.Append(TaskManager.m_player.transform.position.z);
        row.Append(";");
        row.Append(TaskManager.m_player.GetComponent<MovementVR>().Head.transform.position.x);
        row.Append(";");
        row.Append(TaskManager.m_player.GetComponent<MovementVR>().Head.transform.position.y);
        row.Append(";");
        row.Append(TaskManager.m_player.GetComponent<MovementVR>().Head.transform.position.z);
        row.Append(";");
        row.Append(TaskManager.m_player.GetComponent<MovementVR>().Head.transform.forward);
        Recorder.LogRow(row.ToString(), "tracking");
    }
}
