using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class VRItem : MonoBehaviour
{
    private BoxCollider boxCollider;
    private RectTransform rectTransform;

    private void OnEnable()
    {
        ValidateCollider();
    }

    private void OnValidate()
    {
        ValidateCollider();
    }

    private void ValidateCollider()
    {
        rectTransform = GetComponent<RectTransform>();

        boxCollider = GetComponent<BoxCollider>();
        if (boxCollider == null)
        {
            boxCollider = gameObject.AddComponent<BoxCollider>();
        }

        boxCollider.size = rectTransform.sizeDelta;
    }
}
