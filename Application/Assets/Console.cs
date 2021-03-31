using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class Console : MonoBehaviour
{
    private Queue<string> m_Inputs;
    public int m_MaxLines = 15;
    private Text[] m_ConsoleText;

    void Start()
    {
        m_Inputs = new Queue<string>();
        m_ConsoleText = GetComponentsInChildren<Text>();
    }

    public void AddText(string newInput)
    {
        if (m_Inputs.Count >= m_MaxLines)
            m_Inputs.Dequeue();

        m_Inputs.Enqueue(newInput);
        UpdateText();
    }

    public void AddFootText(string newInput)
    {
        m_ConsoleText[1].text = newInput;
    }

    public void UpdateText()
    {
        m_ConsoleText[0].text = "";

        foreach (string obj in m_Inputs)
            m_ConsoleText[0].text += obj + "\n";
    }

    public void Clear()
    {
        m_Inputs.Clear();
        //m_ConsoleText[1].text = "";
        UpdateText();
    }
}
