
using System.Collections.Generic;
using System.Linq;
using UnityEngine;


public class Interaction : MonoBehaviour
{
    /**
     * database: All data
     * - childs of one data, multiple parents(DataObj) of one data (string)
     */
    private Dictionary<string, List<Data>> m_dataBase = new Dictionary<string, List<Data>>();//<name of Data, List<Data>>
    public List<string> m_dataSelected = new List<string>();
    public List<string> m_subspaceSelected = new List<string>();
    public int m_selectSingle = 0;

    public bool InsertData2(Data data)
    {
        if (m_dataBase.ContainsKey(data.Id.ToString()))
            m_dataBase[data.Id.ToString()].Add(data);
        else
            m_dataBase.Add(data.Id.ToString(), new List<Data> { data });
        return true;
    }

    public bool FilterData(Data data)
    {
        string id = data.Id.ToString();
        bool state = false;
        m_selectSingle++;
        foreach (Data dt in m_dataBase[id])
        {
            if (dt)
                state = dt.ToogleSelectData();
        }
        if (state)
        {
            m_dataSelected.Add(id);
            m_subspaceSelected.Add(data.m_currentSubpace.gameObject.name+id);
        }
        else
        {
            m_dataSelected.Remove(id);
            m_subspaceSelected.Remove(data.m_currentSubpace.gameObject.name+id);
        }
            
        return state;
    }

    public void TransparencyNearData(Data data)
    {
        //List<Data> dataNear = new List<Data>();

        foreach (List<Data> dataValues in m_dataBase.Values)
        {
            foreach (Data _data in dataValues)
            {
                if (_data)
                {
                    Color color = _data.GetComponent<Renderer>().material.color;
                    if (_data == data)
                    {
                        _data.GetComponent<Renderer>().material.color = new Color(color.r, color.g, color.b, 1f);
                        if (_data.GetComponentInChildren<LineRenderer>()) //if has linerenderer
                            _data.GetComponentInChildren<LineRenderer>().material.color = color;
                        break;
                    }
                    if (Vector3.Distance(data.transform.position, _data.transform.position) < 0.05f)
                        _data.GetComponent<Renderer>().material.color = new Color(color.r, color.g, color.b, 0.3f);//dataNear.Add(_data);
                    else
                        _data.GetComponent<Renderer>().material.color = new Color(color.r, color.g, color.b, 1f);
                    if (_data.GetComponentInChildren<LineRenderer>()) //if has linerenderer
                        _data.GetComponentInChildren<LineRenderer>().material.color = _data.GetComponent<Renderer>().material.color;
                }
            }
        }
    }

    public void ResetTransparency()
    {
        foreach (List<Data> dataValues in m_dataBase.Values)
        {
            foreach (Data _data in dataValues)
            {
                if (_data)
                {
                    Color color = _data.GetComponent<Renderer>().material.color;
                    _data.GetComponent<Renderer>().material.color = new Color(color.r, color.g, color.b, 1f);
                    if (_data.GetComponentInChildren<LineRenderer>()) //if has linerenderer
                        _data.GetComponentInChildren<LineRenderer>().material.color = _data.GetComponent<Renderer>().material.color;
                }
                
            }
        }
    }
}
