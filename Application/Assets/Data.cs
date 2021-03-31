
using UnityEngine;
using System.Collections.Generic;
using System;

[Serializable]
public class DataPass : ScriptableObject
{
    public string Name_1;
    public string Name_2;
    public string Name_3;
    public string Name_4;
    public string Name_5;
    public string Name_6;
}

public class Data : MonoBehaviour
{
    [SerializeField]
    private int id;
    [SerializeField]
    private string name_1;
    [SerializeField]
    private string name_2;
    [SerializeField]
    private string name_3;
    [SerializeField]
    private string name_4;
    [SerializeField]
    private string name_5;
    [SerializeField]
    private string name_6;
    private Color m_currentColor;
    private Material m_material;
    private List<Color> m_colorList = new List<Color>();

    public Subspace m_currentSubpace;
    public Color customColor;
    public bool is_selected = false;
    Renderer rend;

    /*
     * Highlight*
     */
    public GameObject highlightHolder;
    protected MeshRenderer[] highlightRenderers;
    protected MeshRenderer[] existingRenderers;
    public Material highlightMat;
   // public bool isHovering = false;

    private void Start()
    {
        rend = GetComponent<Renderer>();
        m_material = rend.material;
        //rend.sharedMaterial = rend.materials[0];
        m_currentColor = m_material.color;
    }

    private void Update()
    {
        UpdateHighlight();
       //if (isHovering == false && highlightHolder != null)
       //   Destroy(highlightHolder);
        if (highlightHolder != null)
            Destroy(highlightHolder);
    }

    public int Id
    {
        get
        {
            return id;
        }
        set
        {
            id = value;
        }
    }

    public string Name_1
    {
        get
        {
            return name_1;
        }
        set
        {
            name_1 = value;
        }
    }
    
    public string Name_2
    {
        get
        {
            return name_2;
        }
        set
        {
            name_2 = value;
        }
    }
    
    public string Name_3
    {
        get
        {
            return name_3;
        }
        set
        {
            name_3 = value;
        }
    }
    
    public string Name_4
    {
        get
        {
            return name_4;
        }
        set
        {
            name_4 = value;
        }
    }

    public string Name_5
    {
        get
        {
            return name_5;
        }
        set
        {
            name_5 = value;
        }
    }

    public string Name_6
    {
        get
        {
            return name_6;
        }
        set
        {
            name_6 = value;
        }
    }

    public Color CustomColor
    {
        get
        {
            return customColor;
        }
        set
        {
            customColor = value;
        }
    }

    public bool ToogleSelectData()
    {
        Material newMaterial = new Material(m_material);
        if (!is_selected)
        {
            m_currentColor = Constants.COLOR_DATA_OBJECT_SELECTED; //new Color(newMaterial.color.r, newMaterial.color.g, newMaterial.color.b, 1f);
            m_colorList.Add(m_currentColor);
            newMaterial.color = m_currentColor;//Constants.COLOR_DATA_OBJECT_SELECTED;
            gameObject.GetComponent<Renderer>().material = newMaterial;
            if (GetComponentInChildren<LineRenderer>()) //if has linerenderer
                gameObject.GetComponentInChildren<LineRenderer>().material.color = newMaterial.color;
            is_selected = true;
            m_currentSubpace.selectedData.Add(this);
        }
        else
        {
            m_colorList.Remove(m_currentColor);
            if (m_colorList.Count > 0)
                m_currentColor = m_colorList[m_colorList.Count - 1];
            else
            {
                m_currentColor = customColor;
                is_selected = false;
            }
            newMaterial.color = m_currentColor;
            gameObject.GetComponent<Renderer>().material = newMaterial;
            if (GetComponentInChildren<LineRenderer>()) //if has linerenderer
                gameObject.GetComponentInChildren<LineRenderer>().material.color = newMaterial.color;
            m_currentSubpace.selectedData.Remove(this);
        }
        return is_selected;
    }

    /**
     * Change the select state and the color,
     * @param state is the state which will be changed
     * @param color is the color which will be setted
     */
    public bool ChangeSelectData(bool state, Color color, bool transparent = false)
    {
        //if (state == is_selected && m_currentColor.Equals(color)) return is_selected;
        Material newMaterial = new Material(m_material);
        if (state)
        {
            m_currentColor = new Color(color.r, color.g, color.b, Constants.COLOR_SELECT_A_COLOR);
            m_colorList.Add(m_currentColor);
            newMaterial.color = m_currentColor;
            gameObject.GetComponent<Renderer>().material = newMaterial;
            if (gameObject.GetComponentInChildren<LineRenderer>()) //if has linerenderer
                gameObject.GetComponentInChildren<LineRenderer>().material = newMaterial;
            is_selected = true;
            m_currentSubpace.selectedData.Add(this);
        }
        else
        {
            //m_currentColor.a = 1f;
            m_colorList.Remove(m_currentColor);
            if (m_colorList.Count > 0)
                m_currentColor = m_colorList[m_colorList.Count - 1];
            else 
            {
                if (transparent)
                    customColor.a = 0f;
                else
                    customColor.a = Constants.COLOR_UNSELECT_A_COLOR;
                m_currentColor = customColor;
                is_selected = false;
            }
            
            newMaterial.color = m_currentColor;
            gameObject.GetComponent<Renderer>().material = newMaterial;
            if (gameObject.GetComponentInChildren<LineRenderer>()) //if has linerenderer
                gameObject.GetComponentInChildren<LineRenderer>().material = newMaterial;
            m_currentSubpace.selectedData.Remove(this);
        }
        return is_selected;
    }

    public void UpdateDataValues(DataPass data)
    {
        Name_1 = data.Name_1;
        Name_2 = data.Name_2;
        Name_3 = data.Name_3;
        Name_4 = data.Name_4;
        Name_5 = data.Name_5;
        Name_6 = data.Name_6;
    }

    public void ShowHighlight()
    {
        if (highlightHolder != null)
            return;
        //isHovering = true;
        highlightHolder = new GameObject("Highlighter");
        MeshFilter[] existingFilters = this.GetComponentsInChildren<MeshFilter>(true);
        existingRenderers = new MeshRenderer[existingFilters.Length];
        highlightRenderers = new MeshRenderer[existingFilters.Length];

        for (int filterIndex = 0; filterIndex < existingFilters.Length; filterIndex++)
        {
            MeshFilter existingFilter = existingFilters[filterIndex];
            MeshRenderer existingRenderer = existingFilter.GetComponent<MeshRenderer>();

            if (existingFilter == null || existingRenderer == null)
                continue;

            GameObject newFilterHolder = new GameObject("FilterHolder");
            newFilterHolder.transform.parent = highlightHolder.transform;
            MeshFilter newFilter = newFilterHolder.AddComponent<MeshFilter>();
            newFilter.sharedMesh = existingFilter.sharedMesh;
            MeshRenderer newRenderer = newFilterHolder.AddComponent<MeshRenderer>();

            Material[] materials = new Material[existingRenderer.sharedMaterials.Length];
            for (int materialIndex = 0; materialIndex < materials.Length; materialIndex++)
            {
                materials[materialIndex] = highlightMat;
            }
            newRenderer.sharedMaterials = materials;

            highlightRenderers[filterIndex] = newRenderer;
            existingRenderers[filterIndex] = existingRenderer;
        }
    }

    public void UpdateHighlight()
    {
        if (highlightHolder == null)
            return;

        for (int rendererIndex = 0; rendererIndex < highlightRenderers.Length; rendererIndex++)
        {
            MeshRenderer existingRenderer = existingRenderers[rendererIndex];
            MeshRenderer highlightRenderer = highlightRenderers[rendererIndex];

            if (existingRenderer != null && highlightRenderer != null)
            {
                highlightRenderer.transform.position = existingRenderer.transform.position;
                highlightRenderer.transform.rotation = existingRenderer.transform.rotation;
                highlightRenderer.transform.localScale = existingRenderer.transform.lossyScale;
                highlightRenderer.enabled = true && existingRenderer.enabled && existingRenderer.gameObject.activeInHierarchy;
                //highlightRenderer.enabled = isHovering && existingRenderer.enabled && existingRenderer.gameObject.activeInHierarchy;
            }
            else if (highlightRenderer != null)
                highlightRenderer.enabled = false;
        }
    }

    public void HideHighlight()
    {
        //isHovering = false;
        if (highlightHolder != null)
            Destroy(highlightHolder);
    }

}
