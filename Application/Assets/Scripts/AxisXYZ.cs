using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
public class AxisXYZ : MonoBehaviour
{
    private GameObject labelXini;
    private GameObject labelXend;
    private GameObject labelYini;
    private GameObject labelYend;
    private GameObject labelZini;
    private GameObject labelZend;
    private GameObject labelAxisX;
    private GameObject labelAxisY;
    private GameObject labelAxisZ;
    static Material lineMaterial;
    public bool labelAxis = false;
    public GameObject label;
    public GameObject axis;
    public string AxisXini = "";
    public string AxisXend = "";
    public string AxisYini = "";
    public string AxisYend = "";
    public string AxisZini = "";
    public string AxisZend = "";
    public string AxisXlabel = "";
    public string AxisYlabel = "";
    public string AxisZlabel = "";
    public bool labelOnStart = true;

    private void Start()
    {
        if (!labelAxis || !axis || !label)
            return;
        if (labelOnStart)
            LabelAxis();
    }

    public void LabelAxis()
    {
        labelXini = Instantiate(label, transform);
        labelXini.name = "Xini";
        labelXini.transform.localPosition = new Vector3(-0.5f, -0.5f, -0.6f);
        labelXini.transform.Rotate(90f, -90f, 0);
        labelXini.GetComponent<TextMesh>().text = AxisXini;
        labelXini.GetComponent<TextMesh>().color = Color.red;

        labelXend = Instantiate(label, transform);
        labelXend.name = "Xend";
        labelXend.transform.localPosition = new Vector3(0.4f, -0.5f, -0.6f);
        labelXend.transform.Rotate(90f, -90f, 0);
        labelXend.GetComponent<TextMesh>().text = AxisXend;
        labelXend.GetComponent<TextMesh>().color = Color.red;

        labelAxisX = Instantiate(axis, transform);
        labelAxisX.name = "Xlabel";
        labelAxisX.transform.localPosition = new Vector3(-0.3f, -0.5f, -0.55f);
        labelAxisX.transform.Rotate(90f, 0, 0);
        labelAxisX.GetComponent<TextMesh>().text = AxisXlabel;
        labelAxisX.GetComponent<TextMesh>().color = Color.red;

        labelYini = Instantiate(label, transform);
        labelYini.name = "Yini";
        labelYini.transform.localPosition = new Vector3(-0.5f, -0.4f, -0.6f);
        labelYini.transform.Rotate(0, -90f, 0);
        labelYini.GetComponent<TextMesh>().text = AxisYini;
        labelYini.GetComponent<TextMesh>().color = Color.green;

        labelYend = Instantiate(label, transform);
        labelYend.name = "Yend";
        labelYend.transform.localPosition = new Vector3(-0.5f, 0.5f, -0.6f);
        labelYend.transform.Rotate(0, -90f, 0);
        labelYend.GetComponent<TextMesh>().text = AxisYend;
        labelYend.GetComponent<TextMesh>().color = Color.green;

        labelAxisY = Instantiate(axis, transform);
        labelAxisY.name = "Ylabel";
        labelAxisY.transform.localPosition = new Vector3(-0.6f, -0.25f, -0.5f);
        labelAxisY.transform.Rotate(0, 0, 90f);
        labelAxisY.GetComponent<TextMesh>().text = AxisYlabel;
        labelAxisY.GetComponent<TextMesh>().color = Color.green;

        labelZini = Instantiate(label, transform);
        labelZini.name = "Zini";
        labelZini.transform.localPosition = new Vector3(-0.6f, -0.5f, -0.5f);
        labelZini.transform.Rotate(90f, -90f, 0f);
        labelZini.GetComponent<TextMesh>().text = AxisZini;
        labelZini.GetComponent<TextMesh>().color = Color.blue;

        labelZend = Instantiate(label, transform);
        labelZend.name = "Zend";
        labelZend.transform.localPosition = new Vector3(-0.6f, -0.5f, 0.4f);
        labelZend.transform.Rotate(90f, -90f, 0f);
        labelZend.GetComponent<TextMesh>().text = AxisZend;
        labelZend.GetComponent<TextMesh>().color = Color.blue;

        labelAxisZ = Instantiate(axis, transform);
        labelAxisZ.name = "Zlabel";
        labelAxisZ.transform.localPosition = new Vector3(-0.6f, -0.5f, -0.3f);
        labelAxisZ.transform.Rotate(90f, -90f, 0);
        labelAxisZ.GetComponent<TextMesh>().text = AxisZlabel;
        labelAxisZ.GetComponent<TextMesh>().color = Color.blue;
    }

    static void CreateLineMaterial()
    {
        if (!lineMaterial)
        {
            Shader shader = Shader.Find("Hidden/Internal-Colored");
            lineMaterial = new Material(shader);
            lineMaterial.hideFlags = HideFlags.HideAndDontSave;
            lineMaterial.SetInt("_SrcBlend", (int)UnityEngine.Rendering.BlendMode.SrcAlpha);
            lineMaterial.SetInt("_DstBlend", (int)UnityEngine.Rendering.BlendMode.OneMinusSrcAlpha);
            lineMaterial.SetInt("_Cull", (int)UnityEngine.Rendering.CullMode.Off);
            lineMaterial.SetInt("_ZWrite", 0);
        }
    }

    public void OnRenderObject()
    {
        CreateLineMaterial();
        lineMaterial.SetPass(0);

        GL.PushMatrix();
        GL.MultMatrix(transform.localToWorldMatrix);

        GL.Begin(GL.LINES);
        GL.Color(Color.red); //x
        GL.Vertex3(-0.5f, -0.5f, -0.5f);
        GL.Vertex3(0.5f, -0.5f, -0.5f);
        //GL.Vertex3(-0.5f, -0.5f, 0.5f);
        //GL.Vertex3(0.5f, -0.5f, 0.5f);
        //GL.Vertex3(-0.5f, 0.5f, -0.5f);
        //GL.Vertex3(0.5f, 0.5f, -0.5f);
        //GL.Vertex3(-0.5f, 0.5f, 0.5f);
        //GL.Vertex3(0.5f, 0.5f, 0.5f);
        GL.Color(Color.green);//y
        GL.Vertex3(-0.5f, -0.5f, -0.5f);
        GL.Vertex3(-0.5f, 0.5f, -0.5f);
        //GL.Vertex3(-0.5f, -0.5f, 0.5f);
        //GL.Vertex3(-0.5f, 0.5f, 0.5f);
        //GL.Vertex3(0.5f, -0.5f, -0.5f);
        //GL.Vertex3(0.5f, 0.5f, -0.5f);
        //GL.Vertex3(0.5f, -0.5f, 0.5f);
        //GL.Vertex3(0.5f, 0.5f, 0.5f);
        GL.Color(Color.blue);//z
        GL.Vertex3(-0.5f, -0.5f, -0.5f);
        GL.Vertex3(-0.5f, -0.5f, 0.5f);
        //GL.Vertex3(-0.5f, 0.5f, -0.5f);
        //GL.Vertex3(-0.5f, 0.5f, 0.5f);
        //GL.Vertex3(0.5f, -0.5f, -0.5f);
        //GL.Vertex3(0.5f, -0.5f, 0.5f);
        //GL.Vertex3(0.5f, 0.5f, -0.5f);
        //GL.Vertex3(0.5f, 0.5f, 0.5f);

        GL.End();
        GL.PopMatrix();
    }
}