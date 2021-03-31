using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class InitTitleCanvas : MonoBehaviour
{
    public GameObject Head;
    public GameObject objectToFollow;
    public string text;

    void Start()
    {
        transform.rotation = objectToFollow.transform.rotation;
        transform.Rotate(0, -90,0);
        text = gameObject.GetComponentInChildren<Text>().text;
        Head = GameObject.FindGameObjectWithTag("MainCamera") ;
    }
    
    void Update()
    {
        var lookPos = transform.position - Head.transform.position;
        lookPos.y = 0;
        var rotation = Quaternion.LookRotation(lookPos);
        transform.rotation = Quaternion.Slerp(transform.rotation, rotation, Time.deltaTime * 1);
        if (objectToFollow)
        {
            transform.position = objectToFollow.transform.position + transform.TransformDirection(new Vector3(0, objectToFollow.transform.lossyScale.y/2f + 0.05f, 0));
            //transform.rotation = objectToFollow.transform.rotation;
            //transform.Rotate(0, -90,0);
        }
            
    }

    public void UpdateTitleValues(string title)
    {
        text = title;
        gameObject.GetComponentInChildren<Text>().text = text;
    }

}

