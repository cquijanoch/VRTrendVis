using System.Collections.Generic;
using UnityEngine;
using System;
using System.Globalization;

public class BubblePlotter : MonoBehaviour
{
    private DataManager m_dataManager;
    private List<Dictionary<string, object>> m_pointList;
    private string m_parentsName;
    private string m_brothers;
    private int m_currentYear;
    private Interaction m_interactionsCoordinated = null;
    private GameObject dataPoint = null;
    private int m_indexColumnText1 = -1;
    private int m_indexColumnText2 = -1;
    private int m_indexColumnText3 = -1;
    private int m_indexColumnText4 = -1;
    private int m_indexColumnText5 = -1;

    public GameObject InputData;
    public bool allRows = true;
    public int specificRow = 1;
    public bool drawOnStart = true;
    public bool drawOverlay = false;
    public bool drawTrail = false;
    public bool animation = false;
    public string columnID = "ID";
    public string columnName = "name";
    public string columnRegion = "region";
    public string columnIsSelected = "selected";
    public float maxPlotScale = 0.2f;
    public float minPlotScale = 0.05f;
    public bool setMinX = false;
    public bool setMaxX = false;
    public bool setMinY = false;
    public bool setMaxY = false;
    public bool setMinZ = false;
    public bool setMaxZ = false;
    public bool setMaxW = false;
    public bool setMinW = false;
    public float minX = 0.0f;
    public float maxX = 0.0f;
    public float minY = 0.0f;
    public float maxY = 0.0f;
    public float minZ = 0.0f;
    public float maxZ = 0.0f;
    public float minW = 0.0f;
    public float maxW = 0.0f;
    public int initYear = 1975;
    public float smoothness = 3f;

    [HideInInspector]
    public int currentYear;
    public int columnParents = 7;
    public string text_1;
    public string text_2;
    public string text_3;
    public string text_4;
    public string text_5;
    public int columnBrothers = 12;
    public string subtitle_1;
    public string subtitle_2;
    public string subtitle_3;
    public string subtitle_4;
    public string subtitle_5;
    public string subtitle_6 = "Region:";

    public GameObject pointPrefab;
    public GameObject pointHolder;
    public GameObject interactions;
    public Material material_data;

    void Start()
    {
        if (interactions)
            m_interactionsCoordinated = interactions.GetComponent<Interaction>();
        if (InputData)
            m_dataManager = InputData.GetComponent<DataManager>();
        if (drawOnStart)
            DrawBubblePlotter();
    }

    public void DrawBubblePlotter()
    {
        if (interactions)
            m_interactionsCoordinated = interactions.GetComponent<Interaction>();
        if (InputData)
            m_dataManager = InputData.GetComponent<DataManager>();
        m_pointList = m_dataManager.m_pointList;
        List<string> columnList = new List<string>(m_dataManager.m_pointList[0].Keys);

        initYear = m_dataManager.initYear;
        m_parentsName = columnList[columnParents];

        if (text_1.Length > 0) m_indexColumnText1 = columnList.IndexOf(text_1);
        if (text_2.Length > 0) m_indexColumnText2 = columnList.IndexOf(text_2);
        if (text_3.Length > 0) m_indexColumnText3 = columnList.IndexOf(text_3);
        if (text_4.Length > 0) m_indexColumnText4 = columnList.IndexOf(text_4);
        if (text_5.Length > 0) m_indexColumnText5 = columnList.IndexOf(text_5);
        if (columnBrothers > 0) m_brothers = columnList[columnBrothers];

        float xMax = setMaxX ? maxX : m_dataManager.maxColumnX;
        float yMax = setMaxY ? maxY : m_dataManager.maxColumnY;
        float zMax = setMaxZ ? maxZ : m_dataManager.maxColumnZ;
        float wMax = setMaxW ? maxW : m_dataManager.maxColumnW;

        float xMin = setMinX ? minX : m_dataManager.minColumnX;
        float yMin = setMinY ? minY : m_dataManager.minColumnY;
        float zMin = setMinZ ? minZ : m_dataManager.minColumnZ;
        float wMin = setMinW ? minW : m_dataManager.minColumnW;

        float midX = (xMax - xMin) / 2;
        float midY = (yMax - yMin) / 2;
        float midZ = (zMax - zMin) / 2;

        Transform subspace = transform.parent;
        Quaternion localrotation = subspace.rotation;
        subspace.rotation = Quaternion.Euler(new Vector3(0, 0, 0));
        float scaleSubspace = subspace.lossyScale.x / 2f;

        int rows = m_pointList.Count;
        int interval = allRows ? rows : specificRow;
        for (var i = allRows ? 0 : specificRow - 1; i < interval; i++)
        {
            string dataPointName = m_pointList[i][columnName].ToString();
            string dataPointId = m_pointList[i][columnID].ToString();

            int numberOfOverlays = 0;
            int numberOfInterpolations = 0;
            GameObject line = null;
            LineRenderer lr = null;

            /**
             * Distance
             * **/
            //float _Distance = 0f;

            List<Vector3> interpolatedPoints = new List<Vector3>();
            foreach (Vector4 elem in m_dataManager.m_childList[dataPointId])
                interpolatedPoints.Add(new Vector3(elem.x, elem.y, elem.z));
            interpolatedPoints = Utils.MakeSmoothCurve(interpolatedPoints.ToArray(), smoothness);

            foreach (Vector4 position in m_dataManager.m_childList[dataPointId])
            {
                float w = (position.w - wMin) * maxPlotScale / (wMax - wMin);
                float x = (position.x - xMin) * scaleSubspace * 2f / (xMax - xMin);
                x += subspace.position.x - scaleSubspace;
                float y = (position.y - yMin) * scaleSubspace * 2f / (yMax - yMin);
                y += subspace.position.y - scaleSubspace;
                float z = (position.z - zMin) * scaleSubspace * 2f / (zMax - zMin);
                z += subspace.position.z - scaleSubspace;
                Vector3 endpoint = new Vector3(x, y, z);

                Color color = m_dataManager.regions[m_pointList[i][columnRegion].ToString()].color;

                if (numberOfOverlays == 0 || drawOverlay)
                {
                    dataPoint = Instantiate(pointPrefab, endpoint, Quaternion.identity);
                    dataPoint.transform.SetParent(pointHolder.transform);
                    dataPoint.transform.localScale = new Vector3(w + minPlotScale, w + minPlotScale, w + minPlotScale);
                    m_currentYear = initYear + numberOfOverlays;
                    dataPoint.transform.name = dataPointName + " " + m_currentYear;

                    if (columnIsSelected.Length > 0 && m_pointList[i][columnIsSelected].ToString().Equals(Constants.CSV_DATA_UNSELECTED))//SELECTED
                    {
                        float transparency = Constants.COLOR_SELECT_A_COLOR - ((Constants.COLOR_SELECT_A_COLOR - Constants.COLOR_UNSELECT_A_COLOR) / m_dataManager.m_childList[dataPointId].Count) * numberOfOverlays;
                        material_data.color = new Color(color.r, color.g, color.b, transparency);
                        dataPoint.GetComponent<Data>().is_selected = false;//true
                    }
                    else
                        material_data.color = new Color(color.r, color.g, color.b, Constants.COLOR_UNSELECT_A_COLOR);

                    dataPoint.GetComponent<Renderer>().material = new Material(material_data);

                    dataPoint.GetComponent<Data>().Id = System.Convert.ToInt32(m_pointList[i][columnID]);
                    dataPoint.GetComponent<Data>().m_currentSubpace = subspace.GetComponent<Subspace>();
                    if (m_indexColumnText1 > 0) dataPoint.GetComponent<Data>().Name_1 = subtitle_1 + " " + m_dataManager.names[i];//m_pointList[i][text_1].ToString();
                    if (m_indexColumnText2 > 0) dataPoint.GetComponent<Data>().Name_2 = subtitle_2 + " " + m_pointList[i][columnList[m_indexColumnText2 + numberOfOverlays]].ToString();
                    if (m_indexColumnText3 > 0) dataPoint.GetComponent<Data>().Name_3 = subtitle_3 + " " + m_pointList[i][columnList[m_indexColumnText3 + numberOfOverlays]].ToString();
                    if (m_indexColumnText4 > 0) dataPoint.GetComponent<Data>().Name_4 = subtitle_4 + " " + m_pointList[i][columnList[m_indexColumnText4 + numberOfOverlays]].ToString();
                    dataPoint.GetComponent<Data>().Name_5 = subtitle_5 + " " + m_currentYear;
                    dataPoint.GetComponent<Data>().Name_6 = subtitle_6 + " " + m_pointList[i][columnRegion].ToString();
                    dataPoint.GetComponent<Data>().CustomColor = new Color(color.r, color.g, color.b, material_data.color.a);
                }

                if (drawTrail && numberOfOverlays == 0)
                {
                    line = new GameObject();
                    lr = line.AddComponent<LineRenderer>();
                    lr.useWorldSpace = false;
                    line.transform.SetParent(dataPoint.transform);
                    lr.positionCount = interpolatedPoints.Count;
                    lr.material = new Material(Shader.Find("Sprites/Default"));
                    lr.material.color = new Color(material_data.color.r, material_data.color.g, material_data.color.b, 1f);
                    float width = 0.004f;
                    if (subspace.GetComponent<Subspace>().isCell)
                        width = 0.003f;
                    lr.startWidth = width;
                    lr.endWidth = width;
                    //lr.SetPosition(0, endpoint);
                    Vector3 prevEndPoint = Vector3.zero;
                    foreach (Vector3 pos in interpolatedPoints)
                    {
                        float xi = (pos.x - xMin) * scaleSubspace * 2f / (xMax - xMin);
                        xi += subspace.position.x - scaleSubspace;
                        float yi = (pos.y - yMin) * scaleSubspace * 2f / (yMax - yMin);
                        yi += subspace.position.y - scaleSubspace;
                        float zi = (pos.z - zMin) * scaleSubspace * 2f / (zMax - zMin);
                        zi += subspace.position.z - scaleSubspace;

                        Vector3 interpolatePoint = new Vector3(xi, yi, zi);
                        
                        lr.SetPosition(numberOfInterpolations, interpolatePoint);
                        /**Distance**/
                        //if (numberOfInterpolations > 0)
                        //    _Distance += Vector3.Distance(prevEndPoint, interpolatePoint);
                        // prevEndPoint = interpolatePoint;
                        /**End Distance**/
                        numberOfInterpolations++;
                    }
                }
                /**Distance**/
                //if (drawTrail && numberOfOverlays == m_dataManager.m_childList[dataPointId].Count - 1)
                //{
                //    print("Id: " + dataPointId + " distance: " + _Distance);
                //}

                /** Interactions **/
                if (m_interactionsCoordinated)
                {
                    string brother_list = "";
                    string parent_list = "";

                    if (columnBrothers > 0)
                        brother_list = m_pointList[i][m_brothers].ToString();
                    if (columnParents > 0)
                        parent_list = m_pointList[i][m_parentsName].ToString();

                    if (numberOfOverlays == 0)
                        m_interactionsCoordinated.InsertData2(dataPoint.GetComponent<Data>());
                }

                if (!drawOverlay && !drawTrail)
                    break;
                numberOfOverlays++;
            }

            /** Animation - Aimated Positions**/
            if (animation)
            {
                Animation anim = dataPoint.GetComponent<Animation>();
                AnimationCurve curveX;
                AnimationCurve curveY;
                AnimationCurve curveZ;
                AnimationCurve curveW;
                AnimationClip clip = new AnimationClip();
                clip.name = dataPointName;
                clip.legacy = true;

                Keyframe[] keysX;
                Keyframe[] keysY;
                Keyframe[] keysZ;
                Keyframe[] keysW;
                keysX = new Keyframe[interpolatedPoints.Count];
                keysY = new Keyframe[interpolatedPoints.Count];
                keysZ = new Keyframe[interpolatedPoints.Count];
                keysW = new Keyframe[interpolatedPoints.Count];

                AnimationEvent[] dialogUpdates = new AnimationEvent[interpolatedPoints.Count + 1];

                var time = 0f;
                int step = 0;
                int interpolatedStep = 0;
                foreach (Vector3 position in interpolatedPoints)// m_dataManager.m_childList[dataPointId])
                {
                    float x = (position.x - xMin) * scaleSubspace * 2f / (xMax - xMin);
                    x += subspace.position.x - scaleSubspace;
                    float y = (position.y - yMin) * scaleSubspace * 2f / (yMax - yMin);
                    y += subspace.position.y - scaleSubspace;
                    float z = (position.z - zMin) * scaleSubspace * 2f / (zMax - zMin);
                    z += subspace.position.z - scaleSubspace;

                    float w = (m_dataManager.m_childList[dataPointId][step].w - wMin) * maxPlotScale / (wMax - wMin);

                    /**
                    float rest = (interpolatedStep + 1) % smoothness;
                    if (rest == 0)
                    {
                        w = (m_dataManager.m_childList[dataPointId][step].w - wMin) * maxPlotScale / (wMax - wMin);
                        step++;
                    }
                    else if (step == 0)
                        w = (m_dataManager.m_childList[dataPointId][step].w - wMin) * maxPlotScale / (wMax - wMin);
                    else
                    {
                        float wi = m_dataManager.m_childList[dataPointId][step].w;
                        float wf = m_dataManager.m_childList[dataPointId][step + 1].w;
                        float resultW = wi + (wf - wi) * rest / smoothness;
                        w = (resultW - wMin) * maxPlotScale / (wMax - wMin);
                    }**/

                    Vector3 nextPositionParent = pointHolder.transform.InverseTransformPoint(new Vector4(x, y, z));

                    keysX[interpolatedStep] = new Keyframe(time, nextPositionParent.x);
                    keysY[interpolatedStep] = new Keyframe(time, nextPositionParent.y);
                    keysZ[interpolatedStep] = new Keyframe(time, nextPositionParent.z);
                    keysW[interpolatedStep] = new Keyframe(time, w + minPlotScale);

                    DataPass dataStep = new DataPass();
                    dataStep.Name_1 = subtitle_1 + " " + m_dataManager.names[i];//m_pointList[i][columnList[m_indexColumnText1]].ToString();
                    dataStep.Name_2 = subtitle_2 + " " + m_pointList[i][columnList[m_indexColumnText2 + step]].ToString();
                    dataStep.Name_3 = subtitle_3 + " " + m_pointList[i][columnList[m_indexColumnText3 + step]].ToString();
                    dataStep.Name_4 = subtitle_4 + " " + m_pointList[i][columnList[m_indexColumnText4 + step]].ToString();
                    dataStep.Name_5 = (initYear + step) + "";
                    dataStep.Name_6 = subtitle_6 + " " + m_pointList[i][columnRegion].ToString();

                    dialogUpdates[interpolatedStep] = new AnimationEvent();
                    dialogUpdates[interpolatedStep].functionName = "UpdateDataValues";
                    dialogUpdates[interpolatedStep].objectReferenceParameter = dataStep;
                    dialogUpdates[interpolatedStep].time = time;

                    time += (12f/ interpolatedPoints.Count);
                    float rest = (interpolatedStep + 1) % smoothness;
                    interpolatedStep++;
                    if (rest == 0)
                        step++;
                }
                //LAST SECOND
                dialogUpdates[interpolatedStep] = new AnimationEvent();
                dialogUpdates[interpolatedStep].functionName = "UpdateDataValues";
                dialogUpdates[interpolatedStep].objectReferenceParameter = new DataPass();
                dialogUpdates[interpolatedStep].time = time;

                curveX = new AnimationCurve(keysX);
                curveY = new AnimationCurve(keysY);
                curveZ = new AnimationCurve(keysZ);
                curveW = new AnimationCurve(keysW);
                clip.SetCurve("", typeof(Transform), "localPosition.x", curveX);
                clip.SetCurve("", typeof(Transform), "localPosition.y", curveY);
                clip.SetCurve("", typeof(Transform), "localPosition.z", curveZ);
                clip.SetCurve("", typeof(Transform), "localScale.x", curveW);
                clip.SetCurve("", typeof(Transform), "localScale.y", curveW);
                clip.SetCurve("", typeof(Transform), "localScale.z", curveW);
                clip.events = dialogUpdates;

                anim.AddClip(clip, clip.name);
                anim.wrapMode = WrapMode.Loop;
                anim.Play(clip.name);
            }
        }
        subspace.rotation = localrotation;
        this.enabled = false;
    }
}
