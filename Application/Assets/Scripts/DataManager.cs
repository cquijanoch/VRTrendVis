using System;
using System.Collections.Generic;
using System.Globalization;
using UnityEngine;

public struct Palette
{
    public Color color;
    public string name;
    public Palette(string name, Color color)
    {
        this.name = name;
        this.color = color;
    }
}

public class DataManager : MonoBehaviour
{
    private List<string> columnList;
    public string inputfile;
    public string columnID = "ID";
    public int numberOfChildren = 0;
    
    public string columnParentX = "X";
    public string columnParentY = "Y";
    public string columnParentZ = "Z";
    public string columnParentW = "W";

    public int initYear = 1975;
    public List<string> names = new List<string> { "A", "B" , "C" , "D" , "E" , "F" , "G" , "H" , "I" , "J" , "K" , "L" , "M" , "N" , "O" , "P" };

    private List<string> regionNames = new List<string> {"OC", "AS", "EU", "AF", "NA"};
    public Dictionary<string, Palette> regions;

    public List<Palette> paleta = new List<Palette> {
       new Palette("Red", new Color(228f/255f, 26f/255f, 28f/255f)), //Red - OC
       new Palette("Blue", new Color(55f/255f, 126f/255f, 184f/255f)),//Blue - AS
       new Palette("Green", new Color(77f/255f, 175f/255f, 74f/255f)),//Green - EU
       new Palette("Purple", new Color(152f/255f, 78f/255f, 163f/255f)),//Purple - AF
       new Palette("Orange", new Color(255f/255f, 127f/255f, 0f/255f))//orange - NA
    };

    public List<Dictionary<string, object>> m_pointList;
    public Dictionary<string, List<Vector4>> m_childList;

    [HideInInspector]
    public float maxColumnX;
    [HideInInspector]
    public float maxColumnY;
    [HideInInspector]
    public float maxColumnZ;
    [HideInInspector]
    public float maxColumnW;
    
    [HideInInspector]
    public float minColumnX;
    [HideInInspector]
    public float minColumnY;
    [HideInInspector]
    public float minColumnZ;
    [HideInInspector]
    public float minColumnW;

    public bool ReadUpdateOnAwake = true;

    private void Awake()
    {
        if (ReadUpdateOnAwake)
        {
            ReadCsv();
            UpdateValues();
        }
    }

    public void UpdateValues()
    {
        columnList = new List<string>(m_pointList[0].Keys);
        int xPos = columnList.IndexOf(columnParentX);
        int yPos = columnList.IndexOf(columnParentY);
        int zPos = columnList.IndexOf(columnParentZ);
        int wpos = columnList.IndexOf(columnParentW);

        m_childList = new Dictionary<string, List<Vector4>>();
        for (var p = 0; p < m_pointList.Count; p++)
        {
            List<Vector4> objs = new List<Vector4>();
            for (var i = 0; i < numberOfChildren; i++)
                objs.Add(new Vector4(Convert.ToSingle(m_pointList[p][columnList[xPos + i]], new CultureInfo("en-US")),
                    Convert.ToSingle(m_pointList[p][columnList[yPos + i]], new CultureInfo("en-US")),
                    Convert.ToSingle(m_pointList[p][columnList[zPos + i]], new CultureInfo("en-US")),
                    Convert.ToSingle(m_pointList[p][columnList[wpos + i]], new CultureInfo("en-US"))));
            m_childList.Add(m_pointList[p][columnID].ToString(), objs);
        }


        regions = new Dictionary<string, Palette>();
        for (int k = 0; k < regionNames.Count ;k++ )
            regions.Add(regionNames[k], paleta[k]);

        maxColumnW = FindMaxValue(columnParentW);
        maxColumnX = FindMaxValue(columnParentX);
        maxColumnY = FindMaxValue(columnParentY);
        maxColumnZ = FindMaxValue(columnParentZ);
        minColumnW = FindMinValue(columnParentW);
        minColumnX = FindMinValue(columnParentX);
        minColumnY = FindMinValue(columnParentY);
        minColumnZ = FindMinValue(columnParentZ);

    }

    public void ReadCsv()
    {
        m_pointList = new List<Dictionary<string, object>>();
        m_pointList = CSVReader.Read(inputfile);
        m_pointList.Shuffle();
    }

    private float FindMaxValue(string columnName)
    {
        int pos = columnList.IndexOf(columnName);
        float maxValue = Convert.ToSingle(m_pointList[0][columnName], new CultureInfo("en-US"));
        for (var i = 0; i < m_pointList.Count; i++)
        {
            for (var j = 0; j < numberOfChildren; j++)
            {
                if (maxValue < Convert.ToSingle(m_pointList[i][columnList[pos + j]], new CultureInfo("en-US")))
                    maxValue = Convert.ToSingle(m_pointList[i][columnList[pos + j]], new CultureInfo("en-US"));
            }  
        }
        return maxValue;
    }

    private float FindMinValue(string columnName)
    {
        int pos = columnList.IndexOf(columnName);
        float minValue = Convert.ToSingle(m_pointList[0][columnName], new CultureInfo("en-US"));
        for (var i = 0; i < m_pointList.Count; i++)
        {
            for (var j = 0; j < numberOfChildren; j++)
            {
                if (Convert.ToSingle(m_pointList[i][columnList[pos + j]], new CultureInfo("en-US")) < minValue)
                    minValue = Convert.ToSingle(m_pointList[i][columnList[pos + j]], new CultureInfo("en-US"));
            }  
        }
        return minValue;
    }

    public void ShuffleNames()
    {
        names.Shuffle();
    }

}
