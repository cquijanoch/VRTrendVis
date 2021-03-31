using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;
using Valve.VR.Extras;

[RequireComponent(typeof(SteamVR_LaserPointer))]
public class VRUIInput : MonoBehaviour
{
    private SteamVR_LaserPointer laserPointer;
    private TaskManager taskManager;

    void Awake()
    {
        laserPointer = GetComponent<SteamVR_LaserPointer>();
        //laserPointer.PointerIn += PointerInside;
        //laserPointer.PointerOut += PointerOutside;
        laserPointer.PointerClick += PointerClick;
    }

    private void Start()
    {
        taskManager = GameObject.Find("TaskManager").GetComponent<TaskManager>();
    }

    public void PointerClick(object sender, PointerEventArgs e)
    {
        if (e.target.name == "Option1")
        {
            GameObject[] options = GameObject.FindGameObjectsWithTag("OptionUI");
            foreach(GameObject opt in options)
                opt.GetComponent<Text>().color = Color.white;
            e.target.GetComponent<Text>().color = Color.green;
            taskManager.m_prevNumerAnswer = 1;
            taskManager.m_haveSelected = true;
        }
        else if (e.target.name == "Option2")
        {
            GameObject[] options = GameObject.FindGameObjectsWithTag("OptionUI");
            foreach (GameObject opt in options)
                opt.GetComponent<Text>().color = Color.white;
            e.target.GetComponent<Text>().color = Color.green;
            taskManager.m_prevNumerAnswer = 2;
            taskManager.m_haveSelected = true;
        }
        else if (e.target.name == "Option3")
        {
            GameObject[] options = GameObject.FindGameObjectsWithTag("OptionUI");
            foreach (GameObject opt in options)
                opt.GetComponent<Text>().color = Color.white;
            e.target.GetComponent<Text>().color = Color.green;
            taskManager.m_prevNumerAnswer = 3;
            taskManager.m_haveSelected = true;
        }
        else if (e.target.name == "Option4")
        {
            GameObject[] options = GameObject.FindGameObjectsWithTag("OptionUI");
            foreach (GameObject opt in options)
                opt.GetComponent<Text>().color = Color.white;
            e.target.GetComponent<Text>().color = Color.green;
            taskManager.m_prevNumerAnswer = 4;
            taskManager.m_haveSelected = true;
        }
        else if (e.target.name == "Option5")
        {
            GameObject[] options = GameObject.FindGameObjectsWithTag("OptionUI");
            foreach (GameObject opt in options)
                opt.GetComponent<Text>().color = Color.white;
            e.target.GetComponent<Text>().color = Color.green;
            taskManager.m_prevNumerAnswer = 5;
            taskManager.m_haveSelected = true;
        }
    }
    /**
    public void PointerInside(object sender, PointerEventArgs e)
    {
        if (e.target.name == "Cube")
        {
            Debug.Log("Cube was entered");
        }
        else if (e.target.name == "Button")
        {
            Debug.Log("Button was entered");
        }
    }

    public void PointerOutside(object sender, PointerEventArgs e)
    {
        if (e.target.name == "Cube")
        {
            Debug.Log("Cube was exited");
        }
        else if (e.target.name == "Button")
        {
            Debug.Log("Button was exited");
        }
    }**/
}
