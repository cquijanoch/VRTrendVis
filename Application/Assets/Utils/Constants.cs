
using System.Collections.Generic;
using UnityEngine;

public class Constants
{
    /** Property for Hand mode **/
    public static int HAND_NONE_USE = 0;
    public static int HAND_PRIMARY_USE = 1;
    public static int HAND_SECONDARY_USE = 2;

    /** Color for subspace  **/
    public static Color SPACE_COLOR_WITH_CONTROLLER = new Color(0.13034f, 0.6665765f, 0.9528301f, 0.3f);
    public static Color SPACE_COLOR_WITHOUT_CONTROLLER = new Color(1f, 1f, 1f, 0f);
    public static Color SPACE_COLOR_PREPARE_TO_DELETE = new Color(1f, 0.7019f, 0.7019f, 0.15f);
    public static int MINIMAL_NUM_POINTS_FOR_STEP_1 = 40;

    /** Type MODE HAND **/
    public static int INT_HAND_MODE_MACRO = 1;
    public static int INT_HAND_MODE_MICRO = 2;
    public static string STR_HAND_MODE_MACRO = "Macro";
    public static string STR_HAND_MODE_MICRO = "Micro";

    /** Constants for Event Hand Macro **/
    public static float MINIMAL_TIME_PER_DOUBLE_TRIGGER = 0.5f;

    /** Tags  **/
    public static string TAG_SUBSBPACE = "Subspace";
    public static string TAG_DATA_SCATTERPLOT = "DataScatterplot";

    /** Color DataObject    **/
    public static Color COLOR_DATA_OBJECT_SELECTED = Color.green;
    //public static float TRANSPARENCY_DATA = 0.0f;

    public static Color BUTTON_COLOR_ACTIVATE = Color.green;
    public static Color BUTTON_COLOR_DESACTIVATE = Color.white;
    public static float COLOR_SELECT_A_COLOR = 1f;
    public static float COLOR_SELECT_OVERLAY_COLOR = 0.5f;
    public static float COLOR_UNSELECT_A_COLOR = 0.2f;

    public static string CSV_DATA_SELECTED = "1";
    public static string CSV_DATA_UNSELECTED = "0";

    //Scenario Limit
    public static float XMIN = -2f;
    public static float XMAX = 1.8f;
    public static float YMIN = 0f;
    public static float YMAX = 3f;
    public static float ZMIN = -1.6f;
    public static float ZMAX = 2.2f;

    public static List<List<int>> VISSEQUESCE = new List<List<int>>
    {
        new List<int> { 1, 2, 3},//1
        new List<int> { 2, 1, 3},//2
        new List<int> { 3, 2, 1},//3
        new List<int> { 1, 3, 2},//4
        new List<int> { 2, 3, 1},//5
        new List<int> { 3, 1, 2}//6
    };


    //Trials
    public static string[] PRACTICE_DESCRIPTION = new string[3]
    {
        "From 1980 to 2000 \n Select Country that had the largest change in 'GDP per Capita'.",
        "From 1985 to 2000 \n Select three countries with rapid growth in the 'Number of Personal Computers' between 1985 and 2000.",
        "From 1985 to 2000 \n Select one [color] country with little growth in the 'Number of Personal Computers'."
    };

    //Trials
    public static string[] PRACTICE_DESCRIPTION_2 = new string[3]
    {
        "From 1980 to 2000 \n Select Country that had the largest change in 'Budget Increase'.",
        "From 1985 to 2000 \n Select three countries with rapid growth in the 'Olympic Medals' between 1985 and 2000.",
        "From 1985 to 2000 \n Select one [color] country with little growth in the 'Olympic Medals'."
    };

    public static int[] PRACTICE_NUMBER_OF_ANSWER = new int[3]
    {
        1,
        3,
        1
    };

    public static string[] PRACTICE_ANSWER_ID = new string[]
    {
        "9", //"J"
        "2-6-9-13-14-0",//C-G-J-N-O-A
        "4"//E
    };

    //Tasks
    public static string[] TASKS_DESCRIPTION = new string[12] 
    {
        "From 1975 to 2000 \n Select two countries whose 'Indexed Energy Consumption' grew faster than their 'Indexed GDP'.",
        "From 1975 to 2000 \n Select three countries that had little change in 'GDP Per Capita'.",
        "From 1975 to 2000 \n Select one country with a decreasing 'Infant Mortality' rate, but little change in 'Life Expectancy'.",
        "From 1975 to 2000 \n Select two countries whose 'Infant Mortality' rate decreased first, then increased later.",
        "From 1975 to 2000 \n Select two countries whose 'Infant Mortality' rate decreased the most.",
        "From 1975 to 2000 \n Select two countries whose 'Ind. Population' grew faster than their 'Indexed Energy Consumption'.",
        "From 1975 to 2000 \n Select one country where 'Life Expectancy (Women & Men)' increased first and decreased later.",
        "From 1975 to 2000 \n Select one country that had a decrease in 'Arable Area', even as their 'Population' increased.",
        "From 1975 to 2000 \n Select one country that had an increase in 'Arable Area', but only a slight increase in 'Population'.",
        "From 1975 to 2000 \n Select one country that had similar change in 'Life Expectancy', 'Infant Mortality' and 'Arable Area'.",
        "From 1975 to 2000 \n Select three countries whose 'Life Expectancy (Men & Women)' and ''Infant Mortality' rate changed the most. ",
        "From 1975 to 2000 \n Select the two countries having the largest 'Population' in the year 1975"
    };

    public static string[] TASKS_DESCRIPTION_2 = new string[12]
    {
        "From 1975 to 2000 \n Select two countries whose 'Won Competitions' grew faster than their 'Lost Competitions'.",
        "From 1975 to 2000 \n Select three countries that had little change in 'Budget Increase'.",//X10,X11
        "From 1975 to 2000 \n Select one country with a decreasing 'Winter Events' rate, but little change in 'Summer Events'.",
        "From 1975 to 2000 \n Select two countries whose 'Winter Events' rate decreased first, then increased later.",
        "From 1975 to 2000 \n Select two countries whose 'Winter Events' rate decreased the most.",
        "From 1975 to 2000 \n Select two countries whose 'Num. Athletes' grew faster than their 'Won Competitions'.",
        "From 1975 to 2000 \n Select one country where 'Medals (Gold & Silver)' increased first and decreased later.",
        "From 1975 to 2000 \n Select one country that had a decrease in 'Sports Centers', even as their 'Num. Athletes' increased.",
        "From 1975 to 2000 \n Select one country that had an increase in 'Sports Centers', but only a slight increase in 'Num. Athletes'.",
        "From 1975 to 2000 \n Select one country that had similar change in 'Events (Summer & Winter)' and 'Won Competitions'.",
        "From 1975 to 2000 \n Select three countries whose 'Medals (Gold & Silver)' and ''Winter Events' rate changed the most. ",
        "From 1975 to 2000 \n Select the two countries having the largest 'Num. Athletes' in the year 1975"
    };

    public static int[] TASKS_NUMBER_OF_ANSWER = new int[12]
    {
        2,
        3,
        1,
        2,
        2,
        2,
        1,
        1,
        1,
        1,
        3,
        2
    };

    public static string[] TASKS_ANSWER_ID = new string[12]
    {
        "5-1",//F-B
        "3-8-11",//D-I-L
        "4",//E
        "8-11",//I-L
        "3-12",//D-M
        "1-5",//F-B
        "8-11",//I-L
        "14",//O
        "0",//A
        "1",//B
        "12-3-11",//M-D-L
        "5-1"//F-B
    };

    public static string[] TASKS_ANSWER_ID_2 = new string[12]
    {
        "5-1",//F-B
        "3-8-11",//D-I-L
        "4",//E
        "8-11",//I-L
        "3-12",//D-M
        "1-5",//F-B
        "8-11",//I-L
        "14",//O
        "0",//A
        "10",//K
        "3-0-11",//D -A - L
        "2-3"// C-D
    };

    public static string[] QUESTIONS = new string[3]
    {
        "Prior to this experiment, how familiar were you with the type of chart used in this experiment on a scale ranging from 1 (not familiar at all) to 5 (very familiar)?",
        "Throughout this experiment, how confident were you when responding to the questions on a scale ranging from 1 (not confident at all) to 5 (completely confident)?",
        "Throughout this experiment, how easy was it to answer the questions using the interface provided to you on a scale ranging from 1 (very difficult) to (very easy)?"
    };

    public static string[] VIS_MODE = new string[3]
    {
        "Animation",
        "Overaid",
        "Small Multiples"
    };
}
