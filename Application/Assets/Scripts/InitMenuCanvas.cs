using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class InitMenuCanvas : MonoBehaviour
{
    public GameObject Head;

    public bool modeHand = true; // true : macro - false : micro

    public GameObject buttonMode;

    void Start()
    {
        Head = GameObject.FindGameObjectWithTag("MainCamera");
        if (transform.parent)
            transform.position = transform.parent.position;
    }

    void Update()
    {
        transform.rotation = Quaternion.LookRotation(transform.position - Head.transform.position);
    }

    public void ChangeModeMenu(bool isModeMacro)
    {
        modeHand = isModeMacro;
    }
}
