using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Valve.VR;
using UnityEngine.XR;

public class MovementVR : MonoBehaviour
{
    private Vector2 trackpad;
    private float direction;
    private Vector3 moveDirection;

    public SteamVR_Input_Sources Hand;//Set Hand To Get Input From
    public float speed;
    public GameObject Head;
    public GameObject Player;

    //public GameObject LeftHand;
    //public GameObject RightHand;
    //public GameObject Coordination;
    public float Deadzone;//the Deadzone of the trackpad. used to prevent unwanted walking.
    public bool walk = false;
    public bool fly = false;
    public bool stopMovement = false;
    public bool isWalking = false;
    public GameObject playArea;
    private Vector3[] vertices;
    public float XArea = 0f;
    public float ZArea = 0f;
    public float areaTotal = 0f;

    private void Awake()
    {
        XRSettings.enabled = true;
        if (Display.displays.Length > 1)
            Display.displays[1].Activate();
        //m_Pose = GetComponent<SteamVR_Behaviour_Pose>();
        if (!Head)
            Head = GameObject.FindGameObjectWithTag("MainCamera");
    }

    private void Start()
    {
        var pRect = new HmdQuad_t();
        var chaperone = OpenVR.Chaperone;
        bool checkPlayArea = (chaperone != null) && chaperone.GetPlayAreaRect(ref pRect);
        XArea = pRect.vCorners3.v0;
        ZArea = pRect.vCorners3.v2;

        Debug.Log("x = " + XArea);
        Debug.Log("z = " + ZArea);
        vertices = playArea.GetComponent<SteamVR_PlayArea>().vertices;
        areaTotal = Utils.SuperficieIrregularPolygon(vertices, vertices.Length / 2);
        Debug.Log("Area = " + areaTotal);
    }
    /**
    IEnumerator InitCoroutine()
    {
        yield return new WaitForSeconds(2);
        Coordination = GameObject.Find("Coordination");

    }**/

    void Update()
    {
        if (!walk)
            return;
        //Collider.height = Head.transform.localPosition.y;
        //Collider.center = new Vector3(Head.transform.localPosition.x, Head.transform.localPosition.y / 2, Head.transform.localPosition.z);
        isWalking = false;
        moveDirection = Quaternion.AngleAxis(Angle(trackpad), Vector3.up) * Head.transform.forward;//get the angle of the touch and correct it for the rotation of the controller
        UpdateInput();
        moveDirection.y = 0;
        if (GetComponent<Rigidbody>().velocity.magnitude < speed && trackpad.magnitude > Deadzone && !stopMovement)
        {//make sure the touch isn't in the deadzone and we aren't going to fast.
         //GetComponent<Rigidbody>().AddForce(moveDirection * 30);
            Vector3 transformation = moveDirection * speed * Time.deltaTime;
            Vector3 newPos = Player.transform.position + Player.transform.TransformDirection(transformation.x, 0, transformation.z);
            if (newPos.x < Constants.XMAX && newPos.x > Constants.XMIN
                && newPos.z < Constants.ZMAX && newPos.z > Constants.ZMIN)
            {
                Player.transform.Translate(transformation);
                isWalking = true;
            }   
        }
    }


    public static float Angle(Vector2 p_vector2)
    {
        if (p_vector2.x < 0)
        {
            return 360 - (Mathf.Atan2(p_vector2.x, p_vector2.y) * Mathf.Rad2Deg * -1);
        }
        else
        {
            return Mathf.Atan2(p_vector2.x, p_vector2.y) * Mathf.Rad2Deg;
        }
    }

    private void UpdateInput()
    {
        trackpad = SteamVR_Actions._default.JostickPad.GetAxis(Hand);
    }
}
