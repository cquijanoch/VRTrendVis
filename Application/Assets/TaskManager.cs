using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;
using Valve.VR;
using Valve.VR.InteractionSystem;

public class TaskManager : MonoBehaviour
{
    AsyncOperation async;

    public GameObject StartPosition;
    public GameObject MiddleCapsule;
    public GameObject ControllerHintsLeft;
    public GameObject ControllerHintsRigth;

    public GameObject ScatterplotStatic1;
    public GameObject ScatterplotStatic2;
    public GameObject ScatterplotStaticEmpty3;
    public GameObject ScatterplotAnimated1;
    public GameObject ScatterplotAnimated2;
    public GameObject ScatterplotAnimated3;
    public GameObject ScatterplotOverlaid1;
    public GameObject ScatterplotSmallMultiples1;

    public GameObject Logger;

    public GameObject InputDataTrain;
    public GameObject InputDataTaskA;
    public GameObject InputDataTaskB;

    public int m_step = 0;
    public int m_tutorialPhase = 0; //1: Vis , 2: Interaction , 3: Trial, 4:experiment
    public int m_currentQuestion = 0;//1.2.3
    public int m_currentVisMode = 0; //1,2,3,4
    public int m_currentTask = 0;//{1 - 12}
    public int m_trialTask = 0; //{ 1, 2, 3}  
    public int m_prevNumerAnswer = -10; //impossible number
    public List<int> m_listVisMode;// = new List<int> { 1, 2, 3};// 1: Animation, 2: Overlay, 3: SMultiples
    public List<int> m_listTask = new List<int> { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 };
    public int m_dataset;//0 : data , 1:dataA

    public GameObject m_console;
    public GameObject m_player;
    private GameObject m_interaction;
    public List<GameObject> Scatterplots = new List<GameObject>();

    private Coroutine buttonHintCoroutine;

    public bool animationLoop = true;

    private bool m_haveWalked = false;
    private bool m_haveGrabbed = false;
    private bool m_haveScaled = false;
    public bool m_haveSelected = false;

    private string m_dialogPractice;
    public GameObject codeInput;

    /**
     * Logger
     */
    public string TimeInitTutorial;
    public string TimeEndTutorial;
    public string TimeInitPractice;
    public string TimeEndPractice;
    public string TimeInitTask;
    public string TimeEndTask;
    public string TimeEndExperiment;
    public string Question1;
    public string Question2;
    public string Question3;

    public string code;
    public bool isCorrectCode = false;

    private void Awake()
    {
        DontDestroyOnLoad(gameObject);
        DontDestroyOnLoad(StartPosition);
        DontDestroyOnLoad(MiddleCapsule);
        DontDestroyOnLoad(InputDataTrain);
        DontDestroyOnLoad(InputDataTaskA);
        DontDestroyOnLoad(InputDataTaskB);
        DontDestroyOnLoad(Logger);
        StartCoroutine(LoadElements());
        //m_listVisMode.Shuffle();
    }

    private void Start()
    {
        InputDataTaskA.GetComponent<DataManager>().ReadCsv();
        InputDataTaskB.GetComponent<DataManager>().ReadCsv();
        //StartCoroutine(WelcomeTutorial());
        //m_dataset = UnityEngine.Random.Range(0, 2);
    }

    private void Update()
    {
        if ((Input.GetKeyDown(KeyCode.Return) || Input.GetKeyDown(KeyCode.KeypadEnter)) && codeInput.GetComponent<Text>().text.Length == 2)
        {
            code = codeInput.GetComponent<Text>().text;
            m_dataset = int.Parse(code[0].ToString());
            m_listVisMode = Constants.VISSEQUESCE[(int.Parse(code[1].ToString()) - 1)];
            codeInput.transform.parent.gameObject.SetActive(false);
            isCorrectCode = true;
            StartCoroutine(WelcomeTutorial());
        }

        /**
         * Tutorial Vis
         * **/
        if (m_tutorialPhase == 1)
        {
            if (m_step == 3 && ScatterplotAnimated1.activeSelf && !animationLoop)
            {
                Animation anim = ScatterplotAnimated1.GetComponent<Subspace>().pointHolder.GetComponentInChildren<Animation>();
                if (anim)
                    foreach (AnimationState state in anim)
                    {
                        //print(state.normalizedTime);
                        if (state.normalizedTime > 1f)
                        {
                            animationLoop = true;
                            if (buttonHintCoroutine != null)
                                StopCoroutine(buttonHintCoroutine);
                            buttonHintCoroutine = StartCoroutine(NextButtonTextHints("Continue"));
                            break;
                        }  
                    }
            }
        }

        /**
         * Tutorial Interaction
         **/
        if (m_tutorialPhase == 2)
        {
            if (!m_haveWalked && m_player.GetComponent<MovementVR>().isWalking)
            {
                m_haveWalked = true;
                if (m_step == 6)
                {
                    if (buttonHintCoroutine != null)
                        StopCoroutine(buttonHintCoroutine);
                    buttonHintCoroutine = StartCoroutine(NextButtonTextHints());
                }
            }

            if (!m_haveGrabbed && ScatterplotAnimated2 && ScatterplotAnimated2.activeSelf && ScatterplotAnimated2.GetComponent<Subspace>().m_PrimaryHand)
            {
                m_haveGrabbed = true;
                PrintConsoleFooterText(" * Grabbed sucessfull.");
            }

            if (!m_haveGrabbed && ScatterplotAnimated3 && ScatterplotAnimated3.activeSelf && ScatterplotAnimated3.GetComponent<Subspace>().m_PrimaryHand)
            {
                m_haveGrabbed = true;
                PrintConsoleFooterText(" * Grab sucessfull.");
            }

            if (!m_haveScaled && ScatterplotAnimated2 && ScatterplotAnimated2.activeSelf && ScatterplotAnimated2.GetComponent<Subspace>().m_SecondaryHand)
            {
                m_haveScaled = true;
                PrintConsoleFooterText(" * Scale sucessfull.");
            }

            if (!m_haveScaled && ScatterplotAnimated3 && ScatterplotAnimated3.activeSelf && ScatterplotAnimated3.GetComponent<Subspace>().m_SecondaryHand)
            {
                m_haveScaled = true;
                PrintConsoleFooterText(" * Scale sucessfull.");
            }

            if (!m_haveSelected && m_interaction.GetComponent<Interaction>().m_selectSingle > 0)
            {
                m_haveSelected = true;
                PrintConsoleFooterText(" * Select sucessfull.");
            }

            if (m_haveSelected && m_haveGrabbed && m_haveScaled)
            {
                if (!animationLoop && ScatterplotAnimated2 && ScatterplotAnimated2.activeSelf)
                {
                    Animation anim = ScatterplotAnimated2.GetComponent<Subspace>().pointHolder.GetComponentInChildren<Animation>();
                    if (anim)
                        foreach (AnimationState state in anim)
                        {
                            if (state.normalizedTime > 1f)
                            {
                                animationLoop = true;
                                if (buttonHintCoroutine != null)
                                    StopCoroutine(buttonHintCoroutine);
                                buttonHintCoroutine = StartCoroutine(NextButtonTextHints());
                                break;
                            }
                        }
                    return;
                }

                if (!animationLoop && ScatterplotAnimated3 && ScatterplotAnimated3.activeSelf)
                {
                    Animation anim = ScatterplotAnimated3.GetComponent<Subspace>().pointHolder.GetComponentInChildren<Animation>();
                    if (anim)
                        foreach (AnimationState state in anim)
                        {
                            if (state.normalizedTime > 1f)
                            {
                                animationLoop = true;
                                if (buttonHintCoroutine != null)
                                    StopCoroutine(buttonHintCoroutine);
                                buttonHintCoroutine = StartCoroutine(NextButtonTextHints());
                                break;
                            }
                        }
                    return;
                }
            }
        }

        /**
         * Practice Trial Interaction 3
         * Task Trial Interaction 4
         **/

        if (m_tutorialPhase == 3 || m_tutorialPhase == 4)
        {
            Hand leftHand = GameObject.Find("LeftHand").GetComponent<Hand>();
            Hand rightHand = GameObject.Find("RightHand").GetComponent<Hand>();
            if (Scatterplots.Count > 0 && Scatterplots[0].activeSelf && (m_trialTask > 0 || m_currentTask > 0))
            {
                int numberOfAnwer = m_tutorialPhase == 3 ? Constants.PRACTICE_NUMBER_OF_ANSWER[m_trialTask - 1] : Constants.TASKS_NUMBER_OF_ANSWER[m_listTask[m_currentTask - 1] - 1];
                int numberOfSelects = m_interaction.GetComponent<Interaction>().m_dataSelected.Count;
                int rest = numberOfAnwer - numberOfSelects;
                if (m_prevNumerAnswer == rest && animationLoop)
                    return;
                if (rest == 0)
                {
                    if (!animationLoop && Scatterplots[0].GetComponent<Subspace>().isAnimated)
                    {
                        Animation anim = Scatterplots[0].GetComponent<Subspace>().pointHolder.GetComponentInChildren<Animation>();
                        if (anim)
                            foreach (AnimationState state in anim)
                            {
                                if (state.normalizedTime > 1f)
                                {
                                    animationLoop = true;
                                    if (buttonHintCoroutine != null)
                                        StopCoroutine(buttonHintCoroutine);
                                    buttonHintCoroutine = StartCoroutine(NextButtonTextHints("Done"));
                                }
                                else
                                {
                                    PrintConsoleFooterText(" * Wait the end of first animation to continue.");
                                }
                                break;
                            }
                    }
                    else
                    {
                        if (buttonHintCoroutine != null)
                            StopCoroutine(buttonHintCoroutine);
                        buttonHintCoroutine = StartCoroutine(NextButtonTextHints("Done"));
                    }
                }
                else if (rest > 0)
                {
                    if (buttonHintCoroutine != null)
                        StopCoroutine(buttonHintCoroutine);
                    ControllerButtonHints.HideAllButtonHints(leftHand.GetSteamVRHand());
                    ControllerButtonHints.HideAllButtonHints(rightHand.GetSteamVRHand());
                    ControllerButtonHints.HideAllTextHints(leftHand.GetSteamVRHand());
                    ControllerButtonHints.HideAllTextHints(rightHand.GetSteamVRHand());

                    PrintConsoleFooterText("Select " + rest + " country(es).");
                }
                else if (rest < 0)
                {
                    if (buttonHintCoroutine != null)
                        StopCoroutine(buttonHintCoroutine);
                    ControllerButtonHints.HideAllButtonHints(leftHand.GetSteamVRHand());
                    ControllerButtonHints.HideAllButtonHints(rightHand.GetSteamVRHand());
                    ControllerButtonHints.HideAllTextHints(leftHand.GetSteamVRHand());
                    ControllerButtonHints.HideAllTextHints(rightHand.GetSteamVRHand());
                    PrintConsoleFooterText("Select only " + numberOfAnwer + " country(es).");
                }
                m_prevNumerAnswer = rest;
            }
        }

        /**
         * Question
         **/

        if (m_tutorialPhase == 5 && m_haveSelected)
        {
            PrintConsoleFooterText("Press Next to Continue.");
            if (buttonHintCoroutine != null)
                StopCoroutine(buttonHintCoroutine);
            buttonHintCoroutine = StartCoroutine(NextButtonTextHints("Next"));
            m_haveSelected = false;
        }
    }

    public void Next()
    {
        if (Time.timeSinceLevelLoad%60 < 2)
            return;

        if (!Logger.GetComponent<Logger>().Permission)
            return;

        if (!isCorrectCode)
            return;

        switch (m_step)
        {
            case 0:
                m_step++;
                TutorialVisEmpty();
                m_tutorialPhase = 1;
                break;
            case 1:
                m_step++;
                TutorialVisStatic();
                break;
            case 2:
                m_step++;
                animationLoop = false;
                TutorialVisAnimation();
                break;
            case 3:
                if (!animationLoop) return;
                m_step++;
                TutorialVisOverlaid();
                break;
            case 4:
                m_step++;
                TutorialVisSmallMultiples();
                break;
            case 5:
                m_step++;
                TutorialMovement();
                m_tutorialPhase = 2;
                break;
            case 6:
                if (m_haveWalked)
                {
                    m_step++;
                    animationLoop = false;
                    TutorialHand();
                }
                else
                {
                    PrintConsoleFooterText(" * Move in your Play Area walking or using Joystick.");
                }
                break;
            case 7: // TutorialHand
                if (!m_haveGrabbed)
                {
                    PrintConsoleFooterText(" * Grab the Container with any hand.");
                    return;
                }
                if (!m_haveScaled)
                {
                    PrintConsoleFooterText(" * Scale the Container, grabbing with both hands.");
                    return;
                }
                if (!m_haveSelected)
                {
                    PrintConsoleFooterText(" * Point one data and Select.");
                    return;
                }

                if (!animationLoop)
                {
                    PrintConsoleFooterText(" * Wait the end of first animation to continue.");
                    return;
                }

                m_step++;
                m_haveGrabbed = false;
                m_haveScaled = false;
                m_haveSelected = false;
                m_interaction.GetComponent<Interaction>().m_selectSingle = 0;
                animationLoop = false;
                TutorialRay();
                break;
            case 8: //TutorialRay
                if (!m_haveGrabbed)
                {
                    PrintConsoleFooterText(" * Grab the Container with any hand.");
                    return;
                }
                if (!m_haveScaled)
                {
                    PrintConsoleFooterText(" * Scale the Container, grabbing with both hands.");
                    return;
                }
                if (!m_haveSelected)
                {
                    PrintConsoleFooterText(" * Point one data and Select.");
                    return;
                }

                if (!animationLoop)
                {
                    PrintConsoleFooterText(" * Wait the end of first animation to continue.");
                    return;
                }

                m_step++;
                m_haveGrabbed = false;
                m_haveScaled = false;
                m_haveSelected = false;
                m_interaction.GetComponent<Interaction>().m_selectSingle = 0;
                TutorialTrainBegin();
                break;
            case 9:
                m_step++;
                async = SceneManager.LoadSceneAsync(1);
                async.allowSceneActivation = false;
                TutorialTrainFinish();
                Logger.GetComponent<Logger>().Write();
                break;
            case 10: //Practice Dialog
                m_tutorialPhase = 3;
                m_prevNumerAnswer = -10;
                enabled = false;
                async.allowSceneActivation = true;
                StartCoroutine(LoadElements());
                if (m_currentQuestion == 3 && m_currentVisMode < 4)
                {
                    m_currentQuestion = 0;
                    StartCoroutine(BreakDialog());
                    return;
                }
                m_trialTask++;
                if (m_trialTask == 1)
                    m_currentVisMode++;
                if (m_currentVisMode == 5)
                {
                    StartCoroutine(FinishDialogExperiment());
                    Logger.GetComponent<Logger>().Write();
                    return;
                }
                
                if (m_currentVisMode == 4)
                {
                    m_tutorialPhase = 4;
                    m_listTask.Shuffle();
                    StartCoroutine(StartTripleVisTask());
                    m_step = 13;
                    return;
                }
                StartCoroutine(PracticeDialogTrial());
                m_step++;
                break;
            case 11: // Practice Run
                if (m_prevNumerAnswer == -10)
                {
                    async = SceneManager.LoadSceneAsync(SceneManager.GetActiveScene().name);
                    async.allowSceneActivation = false;
                    enabled = true;
                    PracticeRunTrial();
                }
                else if (m_prevNumerAnswer == 0)
                {
                    if (!animationLoop)
                    {
                        PrintConsoleFooterText(" * Wait the end of first animation to continue.");
                        return;
                    }

                    foreach (string id in m_interaction.GetComponent<Interaction>().m_dataSelected)
                    {
                        string[] answers = Constants.PRACTICE_ANSWER_ID[m_trialTask - 1].Split('-');
                        if (!answers.Contains(id))
                        {
                            PrintConsoleFooterText(" * INCORRECT!");
                            return;
                        }
                    }
                    enabled = false;
                    //m_tutorialPhase = -3;
                    PrintConsoleFooterText(" * CORRECT!");
                    if (m_trialTask == 3)
                    {
                        m_step = 12;
                        Invoke("Next", 2);
                    }
                    else
                    {
                        m_step = 10;
                        Invoke("Next", 2);
                    }      
                } 
                break;
            case 12:
                StartTasks();
                Logger.GetComponent<Logger>().Write();
                m_tutorialPhase = 4;
                m_step++;
                m_listTask.Shuffle();
                break;
            case 13: // Task Dialog
                m_currentTask++;
                m_prevNumerAnswer = -10;
                async.allowSceneActivation = true;
                StartCoroutine(LoadElements());
                StartCoroutine(TaskDialogTrial());
                m_step++;
                break;
            case 14: // Task Run
                if (m_prevNumerAnswer == -10)
                {
                    if (m_currentTask < 12)
                        async = SceneManager.LoadSceneAsync(SceneManager.GetActiveScene().name);
                    async.allowSceneActivation = false;
                    enabled = true;
                    TaskRunTrial();
                }
                else if (m_prevNumerAnswer == 0)
                {
                    if (!animationLoop)
                    {
                        PrintConsoleFooterText(" * Wait the end of first animation to continue.");
                        return;
                    }
                    /**
                    foreach (string id in m_interaction.GetComponent<Interaction>().m_dataSelected)
                    {
                        string[] answers = Constants.TASKS_ANSWER_ID[m_listTask[m_currentTask - 1] - 1].Split('-');
                        if (!answers.Contains(id))
                        {
                            PrintConsoleFooterText(" * INCORRECT!");
                            return;
                        }
                    }**/
                    TimeEndTask = DateTime.Now.ToString("yyyyMMddHHmmss");
                    enabled = false;
                    Logger.GetComponent<Logger>().Write();
                    if (m_currentTask == 12)
                    {
                        m_step = 15;
                        Next();
                    }
                    else
                    {
                        m_step = 13;
                        Next();
                    }
                }
                break;
            case 15: // StartQuestions 
                async = SceneManager.LoadSceneAsync(2);
                async.allowSceneActivation = false;
                StartQuestions();
                m_currentQuestion = 0;
                m_haveSelected = false;
                m_tutorialPhase = 5;
                m_prevNumerAnswer = 0;
                m_step++;
                break;
            case 16: //Question Dialog
                if (m_prevNumerAnswer == -10)
                    return;
                if (m_currentQuestion == 1)
                    Question1 = m_prevNumerAnswer.ToString();
                if (m_currentQuestion == 2)
                    Question2 = m_prevNumerAnswer.ToString();
                if (m_currentQuestion == 3)
                    Question3 = m_prevNumerAnswer.ToString();
                m_prevNumerAnswer = -10;
                

                if (m_currentQuestion == 3)
                {
                    Logger.GetComponent<Logger>().Write();
                    m_dataset++;
                    m_step = 10;
                    m_trialTask = 0;
                    m_currentTask = 0;
                    Next();
                    return;
                }
                async.allowSceneActivation = true;
                StartCoroutine(LoadElements());
                m_currentQuestion++;
                StartCoroutine(TaskRunQuestion()); // Here is the loading the scene
                enabled = true;
                break;
        }   
    }

    private IEnumerator LoadElements()
    {
        yield return new WaitForSeconds(0);
        m_console = GameObject.Find("ConsoleTV");
        m_player = GameObject.Find("PlayerVR");
        m_interaction = GameObject.Find("Coordination");
    }

    public IEnumerator WelcomeTutorial()
    {
        yield return new WaitForSeconds(0.5f);
        m_step = 0;
        Hand leftHand = GameObject.Find("LeftHand").GetComponent<Hand>();
        Hand rightHand = GameObject.Find("RightHand").GetComponent<Hand>();
        leftHand.DeactivateHandVR();
        leftHand.DeactivateRay();
        rightHand.DeactivateHandVR();
        rightHand.DeactivateRay();
        if (!Logger.GetComponent<Logger>().Permission)
        {
            StartCoroutine(ShowConsoleText("Unauthorized Access!" + "\n\n" +
           " * Unable to save results for unauthorized permissions." + "\n" +
           " * Copy the folder to another directory and run again."));
        }
        else
        {
            StartCoroutine(ShowConsoleText("Welcome to the Experiment!" + "\n\n" +
            "1. Grab the controllers." + "\n" +
            "2. You can walk within the marked area on the floor."));
            buttonHintCoroutine = StartCoroutine(NextButtonTextHints());
        }
        
        TimeInitTutorial = DateTime.Now.ToString("yyyyMMddHHmmss");
    }

    public void TutorialVisEmpty()
    {
        ScatterplotStaticEmpty3.SetActive(true);
        StartCoroutine(ShowConsoleText("Visualization Tutorial" + "\n\n" +
            "1. You will view 3D charts depicting numerical values." + "\n" +
            "2. Here, 'Life Expectancy' increases from bottom to top, " + "\n" +
            "'Infant Mortality' increases left to right," + "\n" +
            "and 'Energy Consumption' increases from the inside out."));
    }

    public void TutorialVisStatic()
    {
        ScatterplotStaticEmpty3.GetComponent<Subspace>().pointHolder.SetActive(true);
        ScatterplotStaticEmpty3.GetComponent<Subspace>().ShowTitle();
        StartCoroutine(ShowConsoleText("Visualization Tutorial" + "\n\n" +
            "1. Each sphere represent a Country, where the size is its population." + "\n" +
            "2. We will assign each country a letter and a region's color." + "\n" +
            "This chart shows the 1950 'Life Expectancy',  'Energy Consumption', and 'Infant Mortality' values for some countries."));
    }

    public void TutorialVisAnimation()
    {
        Destroy(ScatterplotStaticEmpty3);
        Hand leftHand = GameObject.Find("LeftHand").GetComponent<Hand>();
        Hand rightHand = GameObject.Find("RightHand").GetComponent<Hand>();
        leftHand.GetComponent<MacroHand>().Clean();
        rightHand.GetComponent<MacroHand>().Clean();
        ScatterplotAnimated1.SetActive(true);

        if (buttonHintCoroutine != null)
            StopCoroutine(buttonHintCoroutine);
        ControllerButtonHints.HideAllButtonHints(leftHand.GetSteamVRHand());
        ControllerButtonHints.HideAllButtonHints(rightHand.GetSteamVRHand());
        ControllerButtonHints.HideAllTextHints(leftHand.GetSteamVRHand());
        ControllerButtonHints.HideAllTextHints(rightHand.GetSteamVRHand());

        StartCoroutine(ShowConsoleText("Visualization Tutorial" + "\n\n" +
            "Animation" + "\n" +
            "1. The animation shows how the 'Life Expectancy',  'Energy Consumption', 'Infant Mortality' changed between 1950 to 1970." + "\n" +
            "2. The 12-seconds animation will restart after reaching 1970." + "\n" +
            "3. You start the task when the first animation finishes.", " * Wait the end of first animation to continue."));
    }

    public void TutorialVisOverlaid()
    {
        Destroy(ScatterplotAnimated1);
        Hand leftHand = GameObject.Find("LeftHand").GetComponent<Hand>();
        Hand righttHand = GameObject.Find("RightHand").GetComponent<Hand>();
        leftHand.GetComponent<MacroHand>().Clean();
        righttHand.GetComponent<MacroHand>().Clean();
        ScatterplotOverlaid1.SetActive(true);
        StartCoroutine(ShowConsoleText("Visualization Tutorial" + "\n\n" +
            "Overlaid Traces" + "\n" +
            "Trends are lines, one for each country. The dots are the values for the countries' attributes at 1950. Lines end at 1970."));
    }

    public void TutorialVisSmallMultiples()
    {
        Destroy(ScatterplotOverlaid1);
        Hand leftHand = GameObject.Find("LeftHand").GetComponent<Hand>();
        Hand righttHand = GameObject.Find("RightHand").GetComponent<Hand>();
        leftHand.GetComponent<MacroHand>().Clean();
        righttHand.GetComponent<MacroHand>().Clean();
        ScatterplotSmallMultiples1.SetActive(true);
        StartCoroutine(ShowConsoleText("Visualization Tutorial" + "\n\n" +
            "Small Multiples" + "\n" +
            "Each chart shows the trend of a country as a line. Dots are the values at 1950. Line ends at 1970."));
    }

    public void TutorialMovement()
    {
        Destroy(ScatterplotSmallMultiples1);
        Hand leftHand = GameObject.Find("LeftHand").GetComponent<Hand>();
        Hand rightHand = GameObject.Find("RightHand").GetComponent<Hand>();
        leftHand.GetComponent<MacroHand>().Clean();
        rightHand.GetComponent<MacroHand>().Clean();
        if (buttonHintCoroutine != null)
            StopCoroutine(buttonHintCoroutine);
        ControllerButtonHints.HideAllButtonHints (leftHand.GetSteamVRHand());
        ControllerButtonHints.HideAllButtonHints(rightHand.GetSteamVRHand());
        ControllerButtonHints.HideAllTextHints(leftHand.GetSteamVRHand());
        ControllerButtonHints.HideAllTextHints(rightHand.GetSteamVRHand());
        ActivatingControls();
        StartCoroutine(ShowConsoleText("Interaction Tutorial " + "\n\n" +
            "Now, you can walk or use the joystick if you want to go further."));
        buttonHintCoroutine = StartCoroutine(MovementButtonTextHints());
    }

    public void TutorialHand()
    {
        Hand leftHand = GameObject.Find("LeftHand").GetComponent<Hand>();
        Hand rightHand = GameObject.Find("RightHand").GetComponent<Hand>();
        if (buttonHintCoroutine != null)
            StopCoroutine(buttonHintCoroutine);
        ControllerButtonHints.HideAllButtonHints(leftHand.GetSteamVRHand());
        ControllerButtonHints.HideAllButtonHints(rightHand.GetSteamVRHand());
        ControllerButtonHints.HideAllTextHints(leftHand.GetSteamVRHand());
        ControllerButtonHints.HideAllTextHints(rightHand.GetSteamVRHand());
        ActivatingControls();
        ScatterplotAnimated2.SetActive(true);
        leftHand.ActivateHandVR();
        rightHand.ActivateHandVR();

        StartCoroutine(ShowConsoleText("Hand manipulation" + "\n\n" +
            "1. To select a chart, open the index finger of either hand, put the hand inside the container (chart's color will change), " +
            "and hold down the Grab button. Now you can move and rotate it." + "\n" +
            "2. To scale, hold the chart with both hands and move them apart." + "\n" +
            "3. To get information about a country, point with your index finger inside a sphere." + "\n" +
            "4. Hold down the Grab button to select it (sphere's color change to green)."));
        buttonHintCoroutine = StartCoroutine(GrabButtonTextHints());
    }

    public void TutorialRay()
    {
        Hand leftHand = GameObject.Find("LeftHand").GetComponent<Hand>();
        Hand rightHand = GameObject.Find("RightHand").GetComponent<Hand>();
        if (buttonHintCoroutine != null)
            StopCoroutine(buttonHintCoroutine);
        ControllerButtonHints.HideAllButtonHints(leftHand.GetSteamVRHand());
        ControllerButtonHints.HideAllButtonHints(rightHand.GetSteamVRHand());
        ControllerButtonHints.HideAllTextHints(leftHand.GetSteamVRHand());
        ControllerButtonHints.HideAllTextHints(rightHand.GetSteamVRHand());
        ActivatingControls();
        Destroy(ScatterplotAnimated2);
        leftHand.GetComponent<MicroHand>().enabled = false;
        rightHand.GetComponent<MicroHand>().enabled = false;
        leftHand.GetComponent<MacroHand>().enabled = false;
        rightHand.GetComponent<MacroHand>().enabled = false;
        leftHand.DeactivateHandVR();
        leftHand.ActivateRay();
        rightHand.DeactivateHandVR();
        rightHand.ActivateRay();
        ScatterplotAnimated3.SetActive(true);
        leftHand.GetComponent<MicroHand>().enabled = true;
        rightHand.GetComponent<MicroHand>().enabled = true;

        StartCoroutine(ShowConsoleText("Ray manipulation" + "\n\n" +
            "1. To select a chart, close the index finger of either hand, point to the container (chart's color will change)," +
            " and keep pressing the Grab button. Now you can move and rotate it." + "\n" +
            "2. To scale, hold the chart with both pointers and move them apart. " + "\n" +
            "3. To get information about a country, point to a sphere." + "\n" +
            "4. Hold down the Grab button to select it (sphere's color change to green)."));
        buttonHintCoroutine = StartCoroutine(GrabButtonTextHints());
    }

    public void TutorialTrainBegin()
    {
        m_player.GetComponent<MovementVR>().walk = false;
        Destroy(ScatterplotAnimated3);
        Hand leftHand = GameObject.Find("LeftHand").GetComponent<Hand>();
        Hand rightHand = GameObject.Find("RightHand").GetComponent<Hand>();
        leftHand.GetComponent<MicroHand>().enabled = false;
        rightHand.GetComponent<MicroHand>().enabled = false;
        leftHand.GetComponent<MacroHand>().Clean();
        rightHand.GetComponent<MacroHand>().Clean();
        leftHand.DeactivateHandVR();
        leftHand.DeactivateRay();
        rightHand.DeactivateHandVR();
        rightHand.DeactivateRay();

        StartCoroutine(ShowConsoleText("Visualization Tutorial" + "\n\n" +
            "1. You will be asked to select one or more countries based on their characteristics." + "\n" +
            "2. In some cases, there may be more correct responses than the required ones. The order you select them does not matter." + "\n" +
            "3. If you change your mind about a selection, tap it again to de-select it."));
    }

    public void TutorialTrainFinish()
    {
        Hand leftHand = GameObject.Find("LeftHand").GetComponent<Hand>();
        Hand rightHand = GameObject.Find("RightHand").GetComponent<Hand>();
        StartCoroutine(ShowConsoleText("Congratulations!" + "\n\n" +
            "Congratulations, you are ready to begin the experiment!" + "\n" +
            "   1. You will answer 15 questions for each trial." + "\n" +
            "   2. Each question is expected to take under a minute to complete." + "\n" +
            "   3. Some questions may have multiple correct responses." + "\n" +
            "   4. The question will always be shown here , in the TV.",
            "Press Next to practice."));
        TimeEndTutorial = DateTime.Now.ToString("yyyyMMddHHmmss");
    }

    public IEnumerator PracticeDialogTrial()
    {
        yield return new WaitForSeconds(0.5f);
        Scatterplots.Clear();
        Hand leftHand = GameObject.Find("LeftHand").GetComponent<Hand>();
        Hand rightHand = GameObject.Find("RightHand").GetComponent<Hand>();
        if (buttonHintCoroutine != null)
            StopCoroutine(buttonHintCoroutine);
        ControllerButtonHints.HideAllButtonHints(leftHand.GetSteamVRHand());
        ControllerButtonHints.HideAllButtonHints(rightHand.GetSteamVRHand());
        ControllerButtonHints.HideAllTextHints(leftHand.GetSteamVRHand());
        ControllerButtonHints.HideAllTextHints(rightHand.GetSteamVRHand());
        m_player.GetComponent<MovementVR>().walk = false;
        MiddleCapsule.SetActive(true);
        if (m_listVisMode[m_currentVisMode - 1] == 1) // Animation
            Scatterplots.Add(Utils.FindInActiveObjectByName("ScatterplotAnimated1"));
        else if (m_listVisMode[m_currentVisMode - 1] == 2) // Overlay
            Scatterplots.Add(Utils.FindInActiveObjectByName("ScatterplotOverlay1"));
        else if (m_listVisMode[m_currentVisMode - 1] == 3) // SmallMultiples
        {
            Scatterplots.Add(Utils.FindInActiveObjectByName("SmallMultiplesTrail"));
        }
        StartCoroutine(UpdateDataManager());
        StartCoroutine(PracticeDialogBuilder());
        TimeInitPractice = DateTime.Now.ToString("yyyyMMddHHmmss");
    }

    public IEnumerator PracticeDialogBuilder()
    {
        yield return new WaitForSeconds(0.3f);
        DataManager dataM = InputDataTrain.GetComponent<DataManager>();
        if (m_dataset % 2 == 0)
            m_dialogPractice = Constants.PRACTICE_DESCRIPTION[m_trialTask - 1];
        else
            m_dialogPractice = Constants.PRACTICE_DESCRIPTION_2[m_trialTask - 1];
        if (m_trialTask == 3)
        {
            StringBuilder builder = new StringBuilder(m_dialogPractice);
            builder.Replace("[color]", dataM.regions["EU"].name);
            m_dialogPractice = builder.ToString();
        }
        StartCoroutine(ShowConsoleText("Training Task " + Constants.VIS_MODE[m_listVisMode[m_currentVisMode - 1] - 1] + "\n\n" +
            "Go to the red circle marked on the floor and look at the TV." + "\n\n" + m_dialogPractice));
        buttonHintCoroutine = StartCoroutine(NextButtonTextHints("Start"));
    }

    public void PracticeRunTrial()
    {
        Hand leftHand = GameObject.Find("LeftHand").GetComponent<Hand>();
        Hand rightHand = GameObject.Find("RightHand").GetComponent<Hand>();
        if (buttonHintCoroutine != null)
            StopCoroutine(buttonHintCoroutine);
        ControllerButtonHints.HideAllButtonHints(leftHand.GetSteamVRHand());
        ControllerButtonHints.HideAllButtonHints(rightHand.GetSteamVRHand());
        ControllerButtonHints.HideAllTextHints(leftHand.GetSteamVRHand());
        ControllerButtonHints.HideAllTextHints(rightHand.GetSteamVRHand());
        MiddleCapsule.SetActive(false);
        ActivatingControls();
        leftHand.ActivateHandVR();
        rightHand.ActivateHandVR();
        leftHand.ActivateRay();
        rightHand.ActivateRay();

        StartCoroutine(ShowConsoleText("Practice Question" + "\n\n" + m_dialogPractice));
        PrintConsoleFooterText("");
        if (!Scatterplots[0].GetComponent<Subspace>().isGrid)
            Scatterplots[0].GetComponent<Subspace>().plotter.SetActive(true);
        else
        {
            foreach (Subspace cell in Scatterplots[0].GetComponent<Subspace>().childGrid.GetComponentsInChildren<Subspace>())
                cell.plotter.SetActive(true);    
        }
        if (m_listVisMode[m_currentVisMode - 1] == 1) // Animation
            animationLoop = false;
        Scatterplots[0].SetActive(true);
    }

    public void StartTasks()
    {
        m_player.GetComponent<MovementVR>().walk = false;
        ClearScatterplots();
        Hand leftHand = GameObject.Find("LeftHand").GetComponent<Hand>();
        Hand rightHand = GameObject.Find("RightHand").GetComponent<Hand>();
        if (buttonHintCoroutine != null)
            StopCoroutine(buttonHintCoroutine);
        ControllerButtonHints.HideAllButtonHints(leftHand.GetSteamVRHand());
        ControllerButtonHints.HideAllButtonHints(rightHand.GetSteamVRHand());
        ControllerButtonHints.HideAllTextHints(leftHand.GetSteamVRHand());
        ControllerButtonHints.HideAllTextHints(rightHand.GetSteamVRHand());
        leftHand.DeactivateHandVR();
        rightHand.DeactivateHandVR();
        leftHand.DeactivateRay();
        rightHand.DeactivateRay();
        StartCoroutine(ShowConsoleText("You have completed the training trials." + "\n\n" +
            "* Perform the following tasks as quickly and accurate as you can. You will not be told if responses are correct."));
        buttonHintCoroutine = StartCoroutine(NextButtonTextHints("Start"));
        TimeEndPractice = DateTime.Now.ToString("yyyyMMddHHmmss");
    }

    public IEnumerator TaskDialogTrial()
    {
        yield return new WaitForSeconds(0.5f);
        Hand leftHand = GameObject.Find("LeftHand").GetComponent<Hand>();
        Hand rightHand = GameObject.Find("RightHand").GetComponent<Hand>();
        ClearScatterplots();
        if (buttonHintCoroutine != null)
            StopCoroutine(buttonHintCoroutine);
        ControllerButtonHints.HideAllButtonHints(leftHand.GetSteamVRHand());
        ControllerButtonHints.HideAllButtonHints(rightHand.GetSteamVRHand());
        ControllerButtonHints.HideAllTextHints(leftHand.GetSteamVRHand());
        ControllerButtonHints.HideAllTextHints(rightHand.GetSteamVRHand());
        MiddleCapsule.SetActive(true);
        m_player.GetComponent<MovementVR>().walk = false;
        string task = m_dataset % 2 == 0 ? Constants.TASKS_DESCRIPTION[m_listTask[m_currentTask - 1] - 1] :
            Constants.TASKS_DESCRIPTION_2[m_listTask[m_currentTask - 1] - 1];
        StartCoroutine(ShowConsoleText("Task " + m_currentTask + "\n\n" +
            "Go to the red circle marked on the floor and look at the TV." + "\n\n" +
            task));
        if (m_currentVisMode == 4)
        {
            Scatterplots.Add(Utils.FindInActiveObjectByName("ScatterplotAnimated1"));
            Scatterplots.Add(Utils.FindInActiveObjectByName("ScatterplotOverlay1"));
            Scatterplots.Add(Utils.FindInActiveObjectByName("SmallMultiplesTrail"));
            Scatterplots.Shuffle();
        }
        else if (m_listVisMode[m_currentVisMode - 1] == 1) // Animation
            Scatterplots.Add(Utils.FindInActiveObjectByName("ScatterplotAnimated1"));
        else if (m_listVisMode[m_currentVisMode - 1] == 2) // Overlay
            Scatterplots.Add(Utils.FindInActiveObjectByName("ScatterplotOverlay1"));
        else if (m_listVisMode[m_currentVisMode - 1] == 3) // SmallMultiples
            Scatterplots.Add(Utils.FindInActiveObjectByName("SmallMultiplesTrail"));
        StartCoroutine(UpdateDataManager());
        
        buttonHintCoroutine = StartCoroutine(NextButtonTextHints("Start"));
    }

    public void TaskRunTrial()
    {
        Hand leftHand = GameObject.Find("LeftHand").GetComponent<Hand>();
        Hand rightHand = GameObject.Find("RightHand").GetComponent<Hand>();
        if (buttonHintCoroutine != null)
            StopCoroutine(buttonHintCoroutine);
        ControllerButtonHints.HideAllButtonHints(leftHand.GetSteamVRHand());
        ControllerButtonHints.HideAllButtonHints(rightHand.GetSteamVRHand());
        ControllerButtonHints.HideAllTextHints(leftHand.GetSteamVRHand());
        ControllerButtonHints.HideAllTextHints(rightHand.GetSteamVRHand());
        MiddleCapsule.SetActive(false);
        ActivatingControls();
        leftHand.ActivateHandVR();
        rightHand.ActivateHandVR();
        leftHand.ActivateRay();
        rightHand.ActivateRay();
        string task = m_dataset % 2 == 0 ? Constants.TASKS_DESCRIPTION[m_listTask[m_currentTask - 1] - 1] :
            Constants.TASKS_DESCRIPTION_2[m_listTask[m_currentTask - 1] - 1];
        StartCoroutine(ShowConsoleText("Task " + m_currentTask + "\n\n" +
            task));
        PrintConsoleFooterText("");

        int i = 0;
        foreach (GameObject vis in Scatterplots)
        {
            if (!vis.GetComponent<Subspace>().isGrid)
                vis.GetComponent<Subspace>().plotter.SetActive(true);
            else
            {
                foreach (Subspace cell in vis.GetComponent<Subspace>().childGrid.GetComponentsInChildren<Subspace>())
                {
                    cell.plotter.SetActive(true);
                }
            }
            if (i == 1)
            {
                vis.transform.position = new Vector3(-1.1f, vis.transform.position.y, 0.1f);
                vis.transform.rotation = Quaternion.Euler(0, 0, 0);
            }
            else if (i == 2)
            {
                vis.transform.position = new Vector3(1.1f, vis.transform.position.y, 0.1f);
                vis.transform.rotation = Quaternion.Euler(0, 180f, 0);
            }
            if (vis.GetComponent<Subspace>().isGrid)
            {
                vis.GetComponent<Subspace>().childGrid.transform.rotation = vis.transform.rotation;
                vis.GetComponent<Subspace>().childGrid.transform.position = vis.transform.position;
            }
                
            vis.SetActive(true);
            i++;
        }
        if (i == 1 && m_listVisMode[m_currentVisMode - 1] == 1)  
            animationLoop = false;
        TimeInitTask = DateTime.Now.ToString("yyyyMMddHHmmss");
    }

    public IEnumerator TaskRunQuestion()
    {
        yield return new WaitForSeconds(0.5f);
        Hand leftHand = GameObject.Find("LeftHand").GetComponent<Hand>();
        Hand rightHand = GameObject.Find("RightHand").GetComponent<Hand>();
        if (buttonHintCoroutine != null)
            StopCoroutine(buttonHintCoroutine);
        ControllerButtonHints.HideAllButtonHints(leftHand.GetSteamVRHand());
        ControllerButtonHints.HideAllButtonHints(rightHand.GetSteamVRHand());
        ControllerButtonHints.HideAllTextHints(leftHand.GetSteamVRHand());
        ControllerButtonHints.HideAllTextHints(rightHand.GetSteamVRHand());
        StartCoroutine(ShowConsoleText("Question " + m_currentQuestion + "\n\n" +
            Constants.QUESTIONS[m_currentQuestion - 1], "Select one option."));
        buttonHintCoroutine = StartCoroutine(ClickButtonTextHints());
        if (m_currentQuestion < 3)
        {
            async = SceneManager.LoadSceneAsync(SceneManager.GetActiveScene().name);
            async.allowSceneActivation = false;

        }
        else if (m_currentQuestion == 3)
        {
            async = SceneManager.LoadSceneAsync(1);
            async.allowSceneActivation = false;

        }
    }

    public void StartQuestions()
    {
        m_player.GetComponent<MovementVR>().walk = false;
        ClearScatterplots();
        Hand leftHand = GameObject.Find("LeftHand").GetComponent<Hand>();
        Hand rightHand = GameObject.Find("RightHand").GetComponent<Hand>();
        if (buttonHintCoroutine != null)
            StopCoroutine(buttonHintCoroutine);
        ControllerButtonHints.HideAllButtonHints(leftHand.GetSteamVRHand());
        ControllerButtonHints.HideAllButtonHints(rightHand.GetSteamVRHand());
        ControllerButtonHints.HideAllTextHints(leftHand.GetSteamVRHand());
        ControllerButtonHints.HideAllTextHints(rightHand.GetSteamVRHand());
        leftHand.DeactivateHandVR();
        rightHand.DeactivateHandVR();
        leftHand.DeactivateRay();
        rightHand.DeactivateRay();
        StartCoroutine(ShowConsoleText("Congratulations." + "\n\n" +
            "You have completed the trial tasks. Please take a moment to respond to three " +
            "questions about the chart design used in this study."));
        buttonHintCoroutine = StartCoroutine(NextButtonTextHints("Start"));
    }

    public IEnumerator BreakDialog()
    {
        yield return new WaitForSeconds(0.5f);
        m_player.GetComponent<MovementVR>().walk = false;
        ClearScatterplots();
        Hand leftHand = GameObject.Find("LeftHand").GetComponent<Hand>();
        Hand rightHand = GameObject.Find("RightHand").GetComponent<Hand>();
        if (buttonHintCoroutine != null)
            StopCoroutine(buttonHintCoroutine);
        ControllerButtonHints.HideAllButtonHints(leftHand.GetSteamVRHand());
        ControllerButtonHints.HideAllButtonHints(rightHand.GetSteamVRHand());
        ControllerButtonHints.HideAllTextHints(leftHand.GetSteamVRHand());
        ControllerButtonHints.HideAllTextHints(rightHand.GetSteamVRHand());
        leftHand.DeactivateHandVR();
        rightHand.DeactivateHandVR();
        leftHand.DeactivateRay();
        rightHand.DeactivateRay();
        StartCoroutine(ShowConsoleText("Now, if you want, you can rest, and then come back to continue!" + "\n\n" +
            "Press Start to continue the experiment."));
        buttonHintCoroutine = StartCoroutine(NextButtonTextHints("Start"));
    }

    public IEnumerator StartTripleVisTask()
    {
        yield return new WaitForSeconds(1);
        Hand leftHand = GameObject.Find("LeftHand").GetComponent<Hand>();
        Hand rightHand = GameObject.Find("RightHand").GetComponent<Hand>();
        if (buttonHintCoroutine != null)
            StopCoroutine(buttonHintCoroutine);
        ControllerButtonHints.HideAllButtonHints(leftHand.GetSteamVRHand());
        ControllerButtonHints.HideAllButtonHints(rightHand.GetSteamVRHand());
        ControllerButtonHints.HideAllTextHints(leftHand.GetSteamVRHand());
        ControllerButtonHints.HideAllTextHints(rightHand.GetSteamVRHand());
        leftHand.DeactivateHandVR();
        rightHand.DeactivateHandVR();
        leftHand.DeactivateRay();
        rightHand.DeactivateRay();
        StartCoroutine(ShowConsoleText("Perform the following tasks." + "\n\n" +
            "Now the three Visualization will be showed."));
        buttonHintCoroutine = StartCoroutine(NextButtonTextHints("Start"));
    }

    public IEnumerator FinishDialogExperiment()
    {
        yield return new WaitForSeconds(0.5f);
        m_player.GetComponent<MovementVR>().walk = false;
        ClearScatterplots();
        Hand leftHand = GameObject.Find("LeftHand").GetComponent<Hand>();
        Hand rightHand = GameObject.Find("RightHand").GetComponent<Hand>();
        if (buttonHintCoroutine != null)
            StopCoroutine(buttonHintCoroutine);
        ControllerButtonHints.HideAllButtonHints(leftHand.GetSteamVRHand());
        ControllerButtonHints.HideAllButtonHints(rightHand.GetSteamVRHand());
        ControllerButtonHints.HideAllTextHints(leftHand.GetSteamVRHand());
        ControllerButtonHints.HideAllTextHints(rightHand.GetSteamVRHand());
        leftHand.DeactivateHandVR();
        rightHand.DeactivateHandVR();
        leftHand.DeactivateRay();
        rightHand.DeactivateRay();
        StartCoroutine(ShowConsoleText("Thank you!" + "\n\n" +
            "You have completed the experiment. Copy your completion code below. " + "\n\n" +
            "This code will remain valid for finalizing the form filling. Close the Application and Go back to the form, please! ", "1234"));
        TimeEndExperiment = DateTime.Now.ToString("yyyyMMddHHmmss");
    }

    public IEnumerator UpdateDataManager()
    {
        yield return new WaitForSeconds(0);
        DataManager dataManager = null;
        List<string> columns = null;
        List<string> axisLabel = null;
        List<string> limits = null;
        List<float> limitsNumber = null;
        List<int> positionAxis = new List<int>{0, 1, 2};
        int childrenNum = 0;
        int initYear = 1975;

        if (m_tutorialPhase == 3) // TrialPractice
        {
            dataManager = InputDataTrain.GetComponent<DataManager>();
            dataManager.columnParentW = "Population/1975";
            if (m_dataset % 2 == 0)
            {
                if (m_trialTask == 1)
                {
                    columns = new List<string> { "Energy Consumption/1980", "GDP Per Capita/1980", "Life Expectancy/1980" };
                    axisLabel = new List<string> { "Energy Consumption", "GDP Per Capita", "Life Expectancy" };
                    limits = new List<string> { "0.0", "4M", "0.0", "35K", "20", "85" };
                    limitsNumber = new List<float> { 0f, 4000000f, 0f, 35000f, 20f, 85f };
                    childrenNum = 21;
                    initYear = 1980;
                }
                if (m_trialTask == 2)
                {
                    columns = new List<string> { "Number of Personal Computers/1985", "GDP Per Capita/1985", "Life Expectancy/1985" };
                    axisLabel = new List<string> { "Num. Personal Comp.", "GDP Per Capita", "Life Expectancy" };
                    limits = new List<string> { "0", "40", "0.0", "35K", "20", "85" };
                    limitsNumber = new List<float> { 0f, 40f, 0f, 35000f, 20f, 85f };
                    childrenNum = 16;
                    initYear = 1985;
                }
                if (m_trialTask == 3)
                {
                    columns = new List<string> { "Number of Personal Computers/1985", "Life Expectancy/1985", "GDP Per Capita/1985" };
                    axisLabel = new List<string> { "Num. Personal Comp.", "Life Expectancy", "GDP Per Capita" };
                    limits = new List<string> { "0", "40", "20", "85", "0.0", "35K" };
                    limitsNumber = new List<float> { 0f, 40f, 20f, 85f, 0f, 35000f };
                    childrenNum = 16;
                    initYear = 1985;
                }
            }
            else
            {
                if (m_trialTask == 1)
                {
                    columns = new List<string> { "Energy Consumption/1980", "GDP Per Capita/1980", "Life Expectancy/1980" };
                    axisLabel = new List<string> { "Won Competitions", "Budget Increase", "Summer Events" };
                    limits = new List<string> { "0.0", "4M", "0.0", "35K", "20", "85" };
                    limitsNumber = new List<float> { 0f, 4000000f, 0f, 35000f, 20f, 85f };
                    childrenNum = 21;
                    initYear = 1980;
                }
                if (m_trialTask == 2)
                {
                    columns = new List<string> { "Number of Personal Computers/1985", "GDP Per Capita/1985", "Life Expectancy/1985" };
                    axisLabel = new List<string> { "Olympic Medals", "Budget Increase", "Summer Events" };
                    limits = new List<string> { "0", "40", "0.0", "35K", "20", "85" };
                    limitsNumber = new List<float> { 0f, 40f, 0f, 35000f, 20f, 85f };
                    childrenNum = 16;
                    initYear = 1985;
                }
                if (m_trialTask == 3)
                {
                    columns = new List<string> { "Number of Personal Computers/1985", "Life Expectancy/1985", "GDP Per Capita/1985" };
                    axisLabel = new List<string> { "Olympic Medals", "Summer Events", "Budget Increase" };
                    limits = new List<string> { "0", "40", "20", "85", "0.0", "35K" };
                    limitsNumber = new List<float> { 0f, 40f, 20f, 85f, 0f, 35000f };
                    childrenNum = 16;
                    initYear = 1985;
                }
            }
        }

        if (m_tutorialPhase == 4) // TrialTask
        {
            if (m_dataset % 2 == 0)
            {
                dataManager = InputDataTaskA.GetComponent<DataManager>();
                dataManager.columnParentW = "Population/1975";
                if (m_listTask[m_currentTask - 1] == 1)
                {
                    columns = new List<string> { "Indexed Energy Consumption/1975", "Indexed GDP/1975", "Arable Area/1975" };
                    axisLabel = new List<string> { "Ind. Energy Consumption", "Indexed GDP", "Arable Area" };
                    limits = new List<string> { "0", "1.1", "0", "1.1", "0.0", "220K" };
                    limitsNumber = new List<float> { 0f, 1.1f, 0f, 1.1f, 0f, 220000f };
                    childrenNum = 26;
                }
                if (m_listTask[m_currentTask - 1] == 2)
                {
                    columns = new List<string> { "Energy Consumption/1975", "GDP Per Capita/1975", "Population/1975" };
                    axisLabel = new List<string> { "Energy Consumption", "GDP Per Capita", "Population" };
                    limits = new List<string> { "0.0", "4M", "0.0", "35K", "0.0", "1.3B" };
                    limitsNumber = new List<float> { 0f, 4000000f, 0f, 35000f, 0f, 1300000000f };
                    childrenNum = 26;
                }
                if (m_listTask[m_currentTask - 1] == 3)
                {
                    columns = new List<string> { "Life Expectancy/1975", "Infant Mortality/1975", "Arable Area/1975" };
                    axisLabel = new List<string> { "Life Expectancy", "Infant Mortality", "Arable Area" };
                    limits = new List<string> { "20", "85", "0", "200", "0.0", "220K" };
                    limitsNumber = new List<float> { 20f, 85f, 0f, 200f, 0f, 220000f };
                    childrenNum = 26;
                }
                if (m_listTask[m_currentTask - 1] == 4)
                {
                    columns = new List<string> { "Life Expectancy/1975", "Infant Mortality/1975", "Arable Area/1975" };
                    axisLabel = new List<string> { "Life Expectancy", "Infant Mortality", "Arable Area" };
                    limits = new List<string> { "20", "85", "0", "200", "0.0", "220K" };
                    limitsNumber = new List<float> { 20f, 85f, 0f, 200f, 0f, 220000f };
                    childrenNum = 26;
                }
                if (m_listTask[m_currentTask - 1] == 5)
                {
                    columns = new List<string> { "Life Expectancy/1975", "Infant Mortality/1975", "Arable Area/1975" };
                    axisLabel = new List<string> { "Life Expectancy", "Infant Mortality", "Arable Area" };
                    limits = new List<string> { "20", "85", "0", "200", "0.0", "220K" };
                    limitsNumber = new List<float> { 20f, 85f, 0f, 200f, 0f, 220000f };
                    childrenNum = 26;
                }
                if (m_listTask[m_currentTask - 1] == 6)
                {
                    columns = new List<string> { "Indexed Energy Consumption/1975", "Indexed Population/1975", "Indexed GDP/1975" };
                    axisLabel = new List<string> { "Ind. Energy Consumption", "Indexed Population", "Indexed GDP" };
                    limits = new List<string> { "0.0", "1.1", "0.0", "1.1", "0", "1.1" };
                    limitsNumber = new List<float> { 0f, 1.1f, 0f, 1.1f, 0f, 220000f };
                    childrenNum = 26;
                }
                if (m_listTask[m_currentTask - 1] == 7)
                {
                    columns = new List<string> { "Life Expectancy (Women)/1975", "Life Expectancy (Men)/1975", "Infant Mortality/1975" };
                    axisLabel = new List<string> { "Life Expectancy(Women)", "Life Expectancy(Men)", "Infant Mortality" };
                    limits = new List<string> { "20", "85", "15", "80", "0", "200" };
                    limitsNumber = new List<float> { 20f, 85f, 15f, 80f, 0f, 200f };
                    childrenNum = 26;
                }
                if (m_listTask[m_currentTask - 1] == 8)
                {
                    columns = new List<string> { "Arable Area/1975", "Population/1975", "Life Expectancy/1975" };
                    axisLabel = new List<string> { "Arable Area", "Population", "Life Expectancy" };
                    limits = new List<string> { "0.0", "220K", "0.0", "1.3B", "20", "85" };
                    limitsNumber = new List<float> { 0f, 220000f, 0f, 1300000000f, 20f, 85f };
                    childrenNum = 26;
                }
                if (m_listTask[m_currentTask - 1] == 9)
                {
                    columns = new List<string> { "Arable Area/1975", "Population/1975", "Life Expectancy (Women)/1975" };
                    axisLabel = new List<string> { "Arable Area", "Population", "Life Expectancy (Women)" };
                    limits = new List<string> { "0.0", "220K", "0.0", "1.3B", "20", "85" };
                    limitsNumber = new List<float> { 0f, 220000f, 0f, 1300000000f, 20f, 85f };
                    childrenNum = 26;
                }
                if (m_listTask[m_currentTask - 1] == 10) //3D
                {
                    columns = new List<string> { "Life Expectancy/1975", "Infant Mortality/1975", "Arable Area/1975" };
                    axisLabel = new List<string> { "Life Expectancy", "Infant Mortality", "Arable Area" };
                    limits = new List<string> { "20", "85", "0", "200", "0.0", "220K" };
                    limitsNumber = new List<float> { 20f, 85f, 0f, 200f, 0f, 220000f };
                    childrenNum = 26;
                }
                if (m_listTask[m_currentTask - 1] == 11)//3d
                {
                    columns = new List<string> { "Life Expectancy (Women)/1975", "Life Expectancy (Men)/1975", "Infant Mortality/1975" };
                    axisLabel = new List<string> { "Life Expectancy(Women)", "Life Expectancy(Men)", "Infant Mortality" };
                    limits = new List<string> { "20", "85", "15", "80", "0", "200" };
                    limitsNumber = new List<float> { 20f, 85f, 15f, 80f, 0f, 200f };
                    childrenNum = 26;
                }
                if (m_listTask[m_currentTask - 1] == 12)
                {
                    columns = new List<string> { "Population/1975", "GDP Per Capita/1975", "Energy Consumption/1975" };
                    axisLabel = new List<string> { "Population", "GDP Per Capita", "Energy Consumption" };
                    limits = new List<string> { "0.0", "1.3B", "0.0", "35K", "0", "4M" };
                    limitsNumber = new List<float> { 0f, 1300000000f, 0f, 35000f, 0f, 4000000f };
                    childrenNum = 26;
                }
            }
            else
            {
                dataManager = InputDataTaskB.GetComponent<DataManager>();
                dataManager.columnParentW = "X5/1975";
                if (m_listTask[m_currentTask - 1] == 1)
                {
                    columns = new List<string> { "X2/1975", "X1/1975", "X8/1975" };
                    axisLabel = new List<string> { "Won Competitions", "Lost Competitions", "Sports Centers" };
                    limits = new List<string> { "0", "250", "0", "250", "0", "300" };
                    limitsNumber = new List<float> { 0f, 250f, 0f, 250f, 0f, 300f };
                    childrenNum = 26;
                }
                if (m_listTask[m_currentTask - 1] == 2)
                {
                    columns = new List<string> { "X10/1975", "X9/1975", "X11/1975" };
                    axisLabel = new List<string> { "Won Medals", "Budget Increase", "Taxes" };
                    limits = new List<string> { "0", "250", "0.0%", "250%", "0.0", "2.5M" };
                    limitsNumber = new List<float> { 0f, 250f, 0f, 250f, 0f, 2500000f };
                    childrenNum = 26;
                }
                if (m_listTask[m_currentTask - 1] == 3)
                {
                    columns = new List<string> { "X3/1975", "X4/1975", "X8/1975" };
                    axisLabel = new List<string> { "Summer Events", "Winter Events", "Sports Centers" };
                    limits = new List<string> { "0", "350", "0", "300", "0", "300" };
                    limitsNumber = new List<float> { 0f, 350f, 0f, 300f, 0f, 300f };
                    childrenNum = 26;
                }
                if (m_listTask[m_currentTask - 1] == 4)
                {
                    columns = new List<string> { "X3/1975", "X4/1975", "X8/1975" };
                    axisLabel = new List<string> { "Summer Events", "Winter Events", "Sports Centers" };
                    limits = new List<string> { "0", "350", "0", "300", "0", "300" };
                    limitsNumber = new List<float> { 0f, 350f, 0f, 300f, 0f, 300f };
                    childrenNum = 26;
                }
                if (m_listTask[m_currentTask - 1] == 5)
                {
                    columns = new List<string> { "X3/1975", "X4/1975", "X8/1975" };
                    axisLabel = new List<string> { "Summer Events", "Winter Events", "Sports Centers" };
                    limits = new List<string> { "0", "350", "0", "300", "0", "300" };
                    limitsNumber = new List<float> { 0f, 350f, 0f, 300f, 0f, 300f };
                    childrenNum = 26;
                }
                if (m_listTask[m_currentTask - 1] == 6)
                {
                    columns = new List<string> { "X2/1975", "X5/1975", "X1/1975" };
                    axisLabel = new List<string> { "Won Competitions", "Num. Athletes", "Lost Competitions" };
                    limits = new List<string> { "0", "250", "0.0", "0.8M", "0.0", "250" };
                    limitsNumber = new List<float> { 0f, 250f, 0f, 800000f, 0f, 250f };
                    childrenNum = 26;
                }
                if (m_listTask[m_currentTask - 1] == 7)
                {
                    columns = new List<string> { "X6/1975", "X7/1975", "X4/1975" };
                    axisLabel = new List<string> { "Medals(Gold)", "Medals(Silver)", "Winter Events" };
                    limits = new List<string> { "0", "300", "0", "300", "0", "300" };
                    limitsNumber = new List<float> { 0f, 300f, 0f, 300f, 0f, 300f };
                    childrenNum = 26;
                }
                if (m_listTask[m_currentTask - 1] == 8)
                {
                    columns = new List<string> { "X8/1975", "X5/1975", "X3/1975" };
                    axisLabel = new List<string> { "Sports Centers", "Num. Athletes", "Summer Events" };
                    limits = new List<string> { "0", "300", "0", "0.8M", "0", "350" };
                    limitsNumber = new List<float> { 0f, 300f, 0f, 800000f, 0f, 350f };
                    childrenNum = 26;
                }
                if (m_listTask[m_currentTask - 1] == 9)
                {
                    columns = new List<string> { "X8/1975", "X5/1975", "X6/1975" };
                    axisLabel = new List<string> { "Sports Centers", "Num. Athletes", "Medals(Gold)" };
                    limits = new List<string> { "0", "300", "0", "0.8M", "0.0", "300" };
                    limitsNumber = new List<float> { 0f, 300f, 0f, 800000f, 0f, 300f };
                    childrenNum = 26;
                }
                if (m_listTask[m_currentTask - 1] == 10) //3D
                {
                    columns = new List<string> { "X3/1975", "X4/1975", "X2/1975" };
                    axisLabel = new List<string> { "Summer Events", "Winter Events", "Won Competitions" };
                    limits = new List<string> { "0", "350", "0", "300", "0", "250" };
                    limitsNumber = new List<float> { 0f, 350f, 0f, 300f, 0f, 250f };
                    childrenNum = 26;
                }
                if (m_listTask[m_currentTask - 1] == 11)//3d
                {
                    columns = new List<string> { "X6/1975", "X7/1975", "X4/1975" };
                    axisLabel = new List<string> { "Medals(Gold)", "Medals(Silver)", "Winter Events" };
                    limits = new List<string> { "0", "300", "0", "300", "0", "300" };
                    limitsNumber = new List<float> { 0f, 300f, 0f, 300f, 0f, 300f };
                    childrenNum = 26;
                }
                if (m_listTask[m_currentTask - 1] == 12)
                {
                    columns = new List<string> { "X5/1975", "X9/1975", "X2/1975" };
                    axisLabel = new List<string> { "Num. Athletes", "Budget Increase", "Won Competitions" };
                    limits = new List<string> { "0.0", "0.8M", "0.0%", "250%", "0", "250" };
                    limitsNumber = new List<float> { 0f, 800000f, 0f, 250f, 0f, 250f };
                    childrenNum = 26;
                }
            }
        }
        positionAxis.Shuffle();
        dataManager.columnParentX = columns[positionAxis[0]];
        dataManager.columnParentY = columns[positionAxis[1]];
        dataManager.columnParentZ = columns[positionAxis[2]];
        dataManager.paleta.Shuffle();
        //if (shuffleNames)
        //    dataManager.ShuffleNames();

        foreach (GameObject vis in Scatterplots)
        {
            if (!vis.GetComponent<Subspace>().isGrid)
            {
                vis.GetComponent<Subspace>().plotter.GetComponent<BubblePlotter>().text_2 = columns[positionAxis[0]];
                vis.GetComponent<Subspace>().plotter.GetComponent<BubblePlotter>().text_3 = columns[positionAxis[1]];
                vis.GetComponent<Subspace>().plotter.GetComponent<BubblePlotter>().text_4 = columns[positionAxis[2]];
                vis.GetComponent<Subspace>().plotter.GetComponent<BubblePlotter>().subtitle_2 = axisLabel[positionAxis[0]] + ":";
                vis.GetComponent<Subspace>().plotter.GetComponent<BubblePlotter>().subtitle_3 = axisLabel[positionAxis[1]] + ":";
                vis.GetComponent<Subspace>().plotter.GetComponent<BubblePlotter>().subtitle_4 = axisLabel[positionAxis[2]] + ":";
                vis.GetComponent<Subspace>().plotter.GetComponent<BubblePlotter>().InputData = dataManager.gameObject;
                vis.GetComponent<AxisXYZ>().AxisXlabel = axisLabel[positionAxis[0]];
                vis.GetComponent<AxisXYZ>().AxisYlabel = axisLabel[positionAxis[1]];
                vis.GetComponent<AxisXYZ>().AxisZlabel = axisLabel[positionAxis[2]];
                vis.GetComponent<AxisXYZ>().AxisXini = limits[positionAxis[0] * 2];
                vis.GetComponent<AxisXYZ>().AxisXend = limits[positionAxis[0] * 2 + 1];
                vis.GetComponent<AxisXYZ>().AxisYini = limits[positionAxis[1] * 2];
                vis.GetComponent<AxisXYZ>().AxisYend = limits[positionAxis[1] * 2 + 1];
                vis.GetComponent<AxisXYZ>().AxisZini = limits[positionAxis[2] * 2];
                vis.GetComponent<AxisXYZ>().AxisZend = limits[positionAxis[2] * 2 + 1];
                vis.GetComponent<AxisXYZ>().LabelAxis();

                vis.GetComponent<Subspace>().plotter.GetComponent<BubblePlotter>().minX = limitsNumber[positionAxis[0] * 2];
                vis.GetComponent<Subspace>().plotter.GetComponent<BubblePlotter>().maxX = limitsNumber[positionAxis[0] * 2 + 1];
                vis.GetComponent<Subspace>().plotter.GetComponent<BubblePlotter>().minY = limitsNumber[positionAxis[1] * 2];
                vis.GetComponent<Subspace>().plotter.GetComponent<BubblePlotter>().maxY = limitsNumber[positionAxis[1] * 2 + 1];
                vis.GetComponent<Subspace>().plotter.GetComponent<BubblePlotter>().minZ = limitsNumber[positionAxis[2] * 2];
                vis.GetComponent<Subspace>().plotter.GetComponent<BubblePlotter>().maxZ = limitsNumber[positionAxis[2] * 2 + 1];
            }
            else
            {
                foreach (Subspace cell in vis.GetComponent<Subspace>().childGrid.GetComponentsInChildren<Subspace>())
                {
                    cell.plotter.GetComponent<BubblePlotter>().text_2 = columns[positionAxis[0]];
                    cell.plotter.GetComponent<BubblePlotter>().text_3 = columns[positionAxis[1]];
                    cell.plotter.GetComponent<BubblePlotter>().text_4 = columns[positionAxis[2]];
                    cell.plotter.GetComponent<BubblePlotter>().subtitle_2 = axisLabel[positionAxis[0]] + ":";
                    cell.plotter.GetComponent<BubblePlotter>().subtitle_3 = axisLabel[positionAxis[1]] + ":";
                    cell.plotter.GetComponent<BubblePlotter>().subtitle_4 = axisLabel[positionAxis[2]] + ":";
                    cell.plotter.GetComponent<BubblePlotter>().InputData = dataManager.gameObject;
                    cell.GetComponent<AxisXYZ>().AxisXlabel = axisLabel[positionAxis[0]];
                    cell.GetComponent<AxisXYZ>().AxisYlabel = axisLabel[positionAxis[1]];
                    cell.GetComponent<AxisXYZ>().AxisZlabel = axisLabel[positionAxis[2]];
                    cell.GetComponent<AxisXYZ>().AxisXini = limits[positionAxis[0] * 2];
                    cell.GetComponent<AxisXYZ>().AxisXend = limits[positionAxis[0] * 2 + 1];
                    cell.GetComponent<AxisXYZ>().AxisYini = limits[positionAxis[1] * 2];
                    cell.GetComponent<AxisXYZ>().AxisYend = limits[positionAxis[1] * 2 + 1];
                    cell.GetComponent<AxisXYZ>().AxisZini = limits[positionAxis[2] * 2];
                    cell.GetComponent<AxisXYZ>().AxisZend = limits[positionAxis[2] * 2 + 1];
                    cell.GetComponent<AxisXYZ>().LabelAxis();

                    cell.plotter.GetComponent<BubblePlotter>().minX = limitsNumber[positionAxis[0] * 2];
                    cell.plotter.GetComponent<BubblePlotter>().maxX = limitsNumber[positionAxis[0] * 2 + 1];
                    cell.plotter.GetComponent<BubblePlotter>().minY = limitsNumber[positionAxis[1] * 2];
                    cell.plotter.GetComponent<BubblePlotter>().maxY = limitsNumber[positionAxis[1] * 2 + 1];
                    cell.plotter.GetComponent<BubblePlotter>().minZ = limitsNumber[positionAxis[2] * 2];
                    cell.plotter.GetComponent<BubblePlotter>().maxZ = limitsNumber[positionAxis[2] * 2 + 1];
                }
            }
        }

        dataManager.numberOfChildren = childrenNum;
        dataManager.initYear = initYear;
        dataManager.UpdateValues();
    }

    public void ActivatingControls()
    {
        MiddleCapsule.SetActive(false);
        GameObject.Find("PlayerVR").GetComponent<MovementVR>().walk = true;
    }

    IEnumerator NextButtonTextHints(string text = "Next")
    {
        Hand leftHand = GameObject.Find("LeftHand").GetComponent<Hand>();
        Hand rightHand = GameObject.Find("RightHand").GetComponent<Hand>();
        ControllerButtonHints.HideAllButtonHints(leftHand.GetSteamVRHand());
        ControllerButtonHints.HideAllButtonHints(rightHand.GetSteamVRHand());
        ControllerButtonHints.HideAllTextHints(leftHand.GetSteamVRHand());
        ControllerButtonHints.HideAllTextHints(rightHand.GetSteamVRHand());
        PrintConsoleFooterText(" * Press '" + text + "' to continue.");
        while (true)
        {
            ControllerButtonHints.ShowTextHint(leftHand.GetSteamVRHand(), SteamVR_Actions._default.TouchYbutton, text);
            ControllerButtonHints.ShowTextHint(rightHand.GetSteamVRHand(), SteamVR_Actions._default.TouchYbutton, text);
            yield return new WaitForSeconds(1.0f);
            ControllerButtonHints.HideButtonHint(leftHand.GetSteamVRHand(), SteamVR_Actions._default.TouchYbutton);
            ControllerButtonHints.HideButtonHint(rightHand.GetSteamVRHand(), SteamVR_Actions._default.TouchYbutton);
            yield return new WaitForSeconds(0.5f);
            yield return null;
        }
    }

    IEnumerator MovementButtonTextHints()
    {
        Hand leftHand = GameObject.Find("LeftHand").GetComponent<Hand>();
        Hand rightHand = GameObject.Find("RightHand").GetComponent<Hand>();
        ControllerButtonHints.HideAllButtonHints(leftHand.GetSteamVRHand());
        ControllerButtonHints.HideAllButtonHints(rightHand.GetSteamVRHand());
        ControllerButtonHints.HideAllTextHints(leftHand.GetSteamVRHand());
        ControllerButtonHints.HideAllTextHints(rightHand.GetSteamVRHand());
        PrintConsoleFooterText("");
        while (true)
        {
            ControllerButtonHints.ShowTextHint(leftHand.GetSteamVRHand(), SteamVR_Actions._default.JostickPad, "Movement");
            ControllerButtonHints.ShowTextHint(rightHand.GetSteamVRHand(), SteamVR_Actions._default.JostickPad, "Movement");
            yield return new WaitForSeconds(1.0f);
            ControllerButtonHints.HideButtonHint(leftHand.GetSteamVRHand(), SteamVR_Actions._default.JostickPad);
            ControllerButtonHints.HideButtonHint(rightHand.GetSteamVRHand(), SteamVR_Actions._default.JostickPad);
            yield return new WaitForSeconds(0.5f);
            yield return null;
        }
    }

    IEnumerator GrabButtonTextHints()
    {
        Hand leftHand = GameObject.Find("LeftHand").GetComponent<Hand>();
        Hand rightHand = GameObject.Find("RightHand").GetComponent<Hand>();
        ControllerButtonHints.HideAllButtonHints(leftHand.GetSteamVRHand());
        ControllerButtonHints.HideAllButtonHints(rightHand.GetSteamVRHand());
        ControllerButtonHints.HideAllTextHints(leftHand.GetSteamVRHand());
        ControllerButtonHints.HideAllTextHints(rightHand.GetSteamVRHand());
        PrintConsoleFooterText("");
        while (true)
        {
            ControllerButtonHints.ShowTextHint(leftHand.GetSteamVRHand(), SteamVR_Actions._default.GrabGrip, "Grab");
            ControllerButtonHints.ShowTextHint(rightHand.GetSteamVRHand(), SteamVR_Actions._default.GrabGrip, "Grab");
            yield return new WaitForSeconds(1.0f);
            ControllerButtonHints.HideButtonHint(leftHand.GetSteamVRHand(), SteamVR_Actions._default.GrabGrip);
            ControllerButtonHints.HideButtonHint(rightHand.GetSteamVRHand(), SteamVR_Actions._default.GrabGrip);
            yield return new WaitForSeconds(0.5f);
            yield return null;
        }
    }

    IEnumerator ClickButtonTextHints()
    {
        Hand leftHand = GameObject.Find("LeftHand").GetComponent<Hand>();
        Hand rightHand = GameObject.Find("RightHand").GetComponent<Hand>();
        ControllerButtonHints.HideAllButtonHints(leftHand.GetSteamVRHand());
        ControllerButtonHints.HideAllButtonHints(rightHand.GetSteamVRHand());
        ControllerButtonHints.HideAllTextHints(leftHand.GetSteamVRHand());
        ControllerButtonHints.HideAllTextHints(rightHand.GetSteamVRHand());
        PrintConsoleFooterText("");
        while (true)
        {
            ControllerButtonHints.ShowTextHint(leftHand.GetSteamVRHand(), SteamVR_Actions._default.InteractUI, "Select");
            ControllerButtonHints.ShowTextHint(rightHand.GetSteamVRHand(), SteamVR_Actions._default.InteractUI, "Select");
            yield return new WaitForSeconds(1.0f);
            ControllerButtonHints.HideButtonHint(leftHand.GetSteamVRHand(), SteamVR_Actions._default.InteractUI);
            ControllerButtonHints.HideButtonHint(rightHand.GetSteamVRHand(), SteamVR_Actions._default.InteractUI);
            yield return new WaitForSeconds(0.5f);
            yield return null;
        }
    }


    IEnumerator ShowConsoleText(string text, string footer = "")
    {
        yield return new WaitForSeconds(0);
        if (m_console)
        {
            Console current_console = m_console.GetComponent<Console>();
            current_console.Clear();
            current_console.AddText(text);
            if (footer.Length > 0)
                current_console.AddFootText(footer);
        }
    }

    public void PrintConsoleFooterText(string text)
    {
        if (m_console)
        {
            Console current_console = m_console.GetComponent<Console>();
            current_console.AddFootText(text);
        }
    }

    public void ClearScatterplots()
    {
        foreach (GameObject sc in Scatterplots)
            Destroy(sc);
        Scatterplots.Clear();
    }

    /**public void CreatePlayer()
    {
        m_player = Instantiate(PlayerVR, StartPosition.transform.position, StartPosition.transform.rotation) as GameObject;
        print(m_player.name);
    }

    public void DestroyPlayer()
    {
        Destroy(m_player);
        m_player = null;
    }**/
}
