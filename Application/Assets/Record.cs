using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.IO;
using System.Text;
using System;

public class Record
{
    StreamWriter fTaskResults;
    //StreamWriter fUserPostion;
    StringBuilder header = new StringBuilder();

    public Record()
    {

    }

    public void LogHeader(string filename)
    {
        if (Application.isEditor)
        {
            fTaskResults = File.CreateText(Application.persistentDataPath + "\\Experiments\\" + filename + ".csv");
            Debug.Log(Application.persistentDataPath + "\\Experiments\\" + filename + ".csv");
        }
        else
        {
            fTaskResults = File.CreateText(System.AppDomain.CurrentDomain.BaseDirectory + "\\Experiments\\" + filename + ".csv");
            Debug.Log(System.AppDomain.CurrentDomain.BaseDirectory + "\\Experiments\\" + filename + ".csv");
        }
        header.Append("Input;");
        header.Append("HMD;");
        header.Append("TimeInitTutorial;");
        header.Append("TimeEndTutorial;");
        header.Append("TimeInitPractice;");
        header.Append("TimeEndPractice;");
        header.Append("VisModeID;");
        header.Append("TaskID;");
        header.Append("TimeInitTask;");
        header.Append("TimeEndTask;");
        header.Append("UserAnswerID;");
        header.Append("CorrectAnswerID;");
        header.Append("NumAnswers;");
        header.Append("NumCorrectAnswers;");
        header.Append("SubspacesName;");
        header.Append("InteractionMode;");//Hand / Ray
        header.Append("Controller;");//Left / Hand
        header.Append("TimeGrab;");
        header.Append("TimeScale;");
        header.Append("Selects;");
        header.Append("Q1;");
        header.Append("Q2;");
        header.Append("Q3;");
        header.Append("TimeEndExperiment;");
        header.Append("TimeHMDRemoved;");
        header.Append("TimeHMDRecovery;");
        header.Append("TimeCloseApplication");

        fTaskResults.WriteLine(header);
        fTaskResults.Close();
    }

    public void LogHeaderPosition(string filename)
    {
        if (Application.isEditor)
        {
            fTaskResults = File.CreateText(Application.persistentDataPath + "\\Experiments\\" + filename + ".csv");
            Debug.Log(Application.persistentDataPath + "\\Experiments\\" + filename + ".csv");
        }
        else
        {
            fTaskResults = File.CreateText(System.AppDomain.CurrentDomain.BaseDirectory + "\\Experiments\\" + filename + ".csv");
            Debug.Log(System.AppDomain.CurrentDomain.BaseDirectory + "\\Experiments\\" + filename + ".csv");
        }

        header.Append("Time;");
        header.Append("Phase;");
        header.Append("Step;");
        header.Append("Task;");
        header.Append("Vis;");
        header.Append("AreaX;");
        header.Append("AreaZ;");
        header.Append("AreaTotal;");
        header.Append("PositionXPlayer;");
        header.Append("PositionZPlayer;");
        header.Append("PositionXHead;");
        header.Append("PositionYHead;");
        header.Append("PositionZHead;");
        header.Append("RotationHead;");

        fTaskResults.WriteLine(header);
        fTaskResults.Close();
    }

    public void LogRow(string row, string filename)
    {
        if (Application.isEditor)
            fTaskResults = new StreamWriter(Application.persistentDataPath + "\\Experiments\\" + filename + ".csv", true);
        else
            fTaskResults = new StreamWriter(System.AppDomain.CurrentDomain.BaseDirectory + "\\Experiments\\" + filename + ".csv", true);
        //Debug.Log(header);

        fTaskResults.WriteLine(row);
        fTaskResults.Close();
    }

    /**
    public void LogPosition(List<string> results, string filename)
    {
        fUserPostion = File.CreateText(Application.persistentDataPath + "/Experiments/" + filename + ".csv");
        header = "x, z, facing";
        fUserPostion.WriteLine(header);
        foreach (string row in results)
            fUserPostion.WriteLine(row);
        fUserPostion.Flush();
        fUserPostion.Close();

    }**/

    //public void close()
    //{
        /*fUsersActions.Close();
        fPiecesState.Close();
        fResumed.Close();*/
        //fTaskResults.Close();
    //}
    /**
    public void flush()
    {
        fTaskResults.Flush();/*
        fUsersActions.Flush();
        fPiecesState.Flush();
        fResumed.Flush();*/
    //}
}
