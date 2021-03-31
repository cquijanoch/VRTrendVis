using System;
using System.Linq;
using System.Text;
using UnityEngine;
using Valve.VR;
using Valve.VR.InteractionSystem;

public class Logger : MonoBehaviour
{
    TaskManager TaskManager;
    public string hmd;
    string TimeHMDRemoved;
    string TimeHMDRecovery;
    string TimeCloseApplication;
    public bool Permission = true;
    

    Record Recorder = new Record();

    void Start()
    {
        TaskManager = GameObject.Find("TaskManager").GetComponent<TaskManager>();
        string model = UnityEngine.XR.XRDevice.model != null ? UnityEngine.XR.XRDevice.model : "";
        if (model.IndexOf("Rift") >= 0)
        {
            hmd = "oculus_touch";
        }
        else
        {
            hmd = "htc_vive";
        }
        try
        {
            Recorder.LogHeader("result");
        }
        catch (UnauthorizedAccessException e)
        {
            Debug.Log("UnauthorizedAccess " + e.Message);
            Permission = false;
        }
        
    }

    void Update()
    {
        if (!TaskManager.m_player)
            return;

        if (SteamVR.initializedState != SteamVR.InitializedStates.InitializeSuccess)
            return;
        
        if (TaskManager.m_player.GetComponent<Player>().headsetOnHead != null)
        {
            if (TaskManager.m_player.GetComponent<Player>().headsetOnHead.GetStateDown(SteamVR_Input_Sources.Head))
            {
                TimeHMDRecovery = DateTime.Now.ToString("yyyyMMddHHmmss");
                Write();
            }
            else if (TaskManager.m_player.GetComponent<Player>().headsetOnHead.GetStateUp(SteamVR_Input_Sources.Head))
            {
                TimeHMDRemoved = DateTime.Now.ToString("yyyyMMddHHmmss");
                Write();
            }
        }
    }

    private void OnApplicationQuit()
    {
        TimeCloseApplication = DateTime.Now.ToString("yyyyMMddHHmmss");
        Write();
    }

    public void Write()
    {
        if (!Permission)
            return;
        GameObject coordination = GameObject.Find("Coordination");
        Interaction interaction = null;
        if (coordination)
            interaction = coordination.GetComponent<Interaction>();
        StringBuilder row = new StringBuilder();
        row.Append(TaskManager.code);
        row.Append(";");
        row.Append(hmd);
        row.Append(";");
        row.Append(TaskManager.TimeInitTutorial);
        row.Append(";");
        row.Append(TaskManager.TimeEndTutorial);
        row.Append(";");
        row.Append(TaskManager.TimeInitPractice);
        row.Append(";");
        row.Append(TaskManager.TimeEndPractice);
        row.Append(";");
        if (TaskManager.m_currentVisMode > 0 && TaskManager.m_currentVisMode < 4)
            row.Append(TaskManager.m_listVisMode[TaskManager.m_currentVisMode - 1]);
        else if (TaskManager.m_currentVisMode == 4)
            row.Append("4");
        else
            row.Append("");
        row.Append(";");

        if (TaskManager.m_currentTask > 0)
            row.Append(TaskManager.m_listTask[TaskManager.m_currentTask - 1]);
        else
            row.Append("");
        row.Append(";");

        row.Append(TaskManager.TimeInitTask);
        row.Append(";");
        row.Append(TaskManager.TimeEndTask);
        row.Append(";");

        string UserAnswerID = "";
        int NumCorrectAnswers = 0;

        if (interaction && interaction.m_dataSelected.Count > 0 && TaskManager.m_currentTask > 0)
        {
            foreach (string id in interaction.m_dataSelected)
            {
                UserAnswerID = UserAnswerID + id + "-";
                string[] answers;
                if (TaskManager.m_dataset % 2 == 0)
                    answers = Constants.TASKS_ANSWER_ID[TaskManager.m_listTask[TaskManager.m_currentTask - 1] - 1].Split('-');
                else
                    answers = Constants.TASKS_ANSWER_ID_2[TaskManager.m_listTask[TaskManager.m_currentTask - 1] - 1].Split('-');
                if (answers.Contains(id))
                    NumCorrectAnswers++;
            }
            row.Append(UserAnswerID);
            row.Append(";");
            if (TaskManager.m_dataset % 2 == 0)
            {
                row.Append(Constants.TASKS_ANSWER_ID[TaskManager.m_listTask[TaskManager.m_currentTask - 1] - 1]);
                row.Append(";");
            }
            else
            {
                row.Append(Constants.TASKS_ANSWER_ID_2[TaskManager.m_listTask[TaskManager.m_currentTask - 1] - 1]);
                row.Append(";");
            }
            row.Append(Constants.TASKS_NUMBER_OF_ANSWER[TaskManager.m_listTask[TaskManager.m_currentTask - 1] - 1]);
            row.Append(";");
            row.Append(NumCorrectAnswers);
            row.Append(";");

            string subspaceName = "";
            foreach (string name in interaction.m_subspaceSelected)
                subspaceName = subspaceName + name + "-";
            row.Append(subspaceName);
            row.Append(";");
        }
        else
        {
            row.Append(UserAnswerID);
            row.Append(";");
            row.Append("");
            row.Append(";");
            row.Append("");
            row.Append(";");
            row.Append("");
            row.Append(";");

            row.Append("");
            row.Append(";");
        }

        

        Hand leftController = GameObject.Find("LeftHand").GetComponent<Hand>();
        Hand rightController = GameObject.Find("RightHand").GetComponent<Hand>();

        StringBuilder leftHand = new StringBuilder();
        leftHand.Append(row);
        leftHand.Append("hand");
        leftHand.Append(";");
        leftHand.Append("left");
        leftHand.Append(";");
        leftHand.Append(leftController.GetComponent<MacroHand>().m_pickupTime);
        leftHand.Append(";");
        leftHand.Append(leftController.GetComponent<MacroHand>().m_scaleTime);
        leftHand.Append(";");

        StringBuilder leftRay = new StringBuilder();
        leftRay.Append(row);
        leftRay.Append("ray");
        leftRay.Append(";");
        leftRay.Append("left");
        leftRay.Append(";");
        leftRay.Append(leftController.GetComponent<LaserPointer>().m_pickupTime);
        leftRay.Append(";");
        leftRay.Append(leftController.GetComponent<LaserPointer>().m_scaleTime);
        leftRay.Append(";");

        StringBuilder rightHand = new StringBuilder();
        rightHand.Append(row);
        rightHand.Append("hand");
        rightHand.Append(";");
        rightHand.Append("right");
        rightHand.Append(";");
        rightHand.Append(rightController.GetComponent<MacroHand>().m_pickupTime);
        rightHand.Append(";");
        rightHand.Append(rightController.GetComponent<MacroHand>().m_scaleTime);
        rightHand.Append(";");

        StringBuilder rightRay = new StringBuilder();
        rightRay.Append(row);
        rightRay.Append("ray");
        rightRay.Append(";");
        rightRay.Append("right");
        rightRay.Append(";");
        rightRay.Append(rightController.GetComponent<LaserPointer>().m_pickupTime);
        rightRay.Append(";");
        rightRay.Append(rightController.GetComponent<LaserPointer>().m_scaleTime);
        rightRay.Append(";");

        leftHand
            .Append(interaction ? interaction.m_selectSingle : 0)
            .Append(";")
            .Append(TaskManager.Question1)
            .Append(";")
            .Append(TaskManager.Question2)
            .Append(";")
            .Append(TaskManager.Question3)
            .Append(";")
            .Append(TaskManager.TimeEndExperiment)
            .Append(";")
            .Append(TimeHMDRemoved)
            .Append(";")
            .Append(TimeHMDRecovery)
            .Append(";")
            .Append(TimeCloseApplication);

        leftRay
            .Append(interaction ? interaction.m_selectSingle : 0)
            .Append(";")
            .Append(TaskManager.Question1)
            .Append(";")
            .Append(TaskManager.Question2)
            .Append(";")
            .Append(TaskManager.Question3)
            .Append(";")
            .Append(TaskManager.TimeEndExperiment)
            .Append(";")
            .Append(TimeHMDRemoved)
            .Append(";")
            .Append(TimeHMDRecovery)
            .Append(";")
            .Append(TimeCloseApplication);

        rightHand
            .Append(interaction ? interaction.m_selectSingle : 0)
            .Append(";")
            .Append(TaskManager.Question1)
            .Append(";")
            .Append(TaskManager.Question2)
            .Append(";")
            .Append(TaskManager.Question3)
            .Append(";")
            .Append(TaskManager.TimeEndExperiment)
            .Append(";")
            .Append(TimeHMDRemoved)
            .Append(";")
            .Append(TimeHMDRecovery)
            .Append(";")
            .Append(TimeCloseApplication);

        rightRay
            .Append(interaction ? interaction.m_selectSingle : 0)
            .Append(";")
            .Append(TaskManager.Question1)
            .Append(";")
            .Append(TaskManager.Question2)
            .Append(";")
            .Append(TaskManager.Question3)
            .Append(";")
            .Append(TaskManager.TimeEndExperiment)
            .Append(";")
            .Append(TimeHMDRemoved)
            .Append(";")
            .Append(TimeHMDRecovery)
            .Append(";")
            .Append(TimeCloseApplication);

        Recorder.LogRow(leftHand.ToString(), "result");
        Recorder.LogRow(leftRay.ToString(), "result");
        Recorder.LogRow(rightHand.ToString(), "result");
        Recorder.LogRow(rightRay.ToString(), "result");
    }

}
