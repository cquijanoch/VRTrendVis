


loadForm <- function(path) { 
    data.df <- read.csv(path,sep=";", header = TRUE, encoding = "UTF-8") 

    data.df$ID <- data.df$ID %>% as.factor()
    data.df$Time <- data.df$Time %>% as.character()
    data.df$Agree <- data.df$Agree %>% as.character()
    data.df$Age <- data.df$Age %>% as.numeric()
    data.df$Gender <- data.df$Gender %>% as.factor()
    data.df$Occupation <- data.df$Occupation %>% as.character()
    data.df$Dominant_hand <- data.df$Occupation %>% as.factor()
    data.df$Writting <- data.df$Writting %>% as.factor()
    data.df$Mouse <- data.df$Mouse %>% as.factor()
    data.df$Throwing <- data.df$Throwing %>% as.factor()
    data.df$Brushing <- data.df$Brushing %>% as.factor()
    data.df$Writting <- data.df$Writting %>% as.factor()
    data.df$Vision_problems <- data.df$Vision_problems %>% as.character()
    data.df$Disconfort <- data.df$Disconfort %>% as.factor()
    data.df$Disconfort2 <- data.df$Disconfort2 %>% as.factor()
    data.df$Disconfort3 <- data.df$Disconfort3 %>% as.factor()
    data.df$Disconfort4 <- data.df$Disconfort4 %>% as.factor()
    data.df$Familiar_Gamepads_Joypads <- data.df$Familiar_Gamepads_Joypads %>% as.factor()
    data.df$Familiar_3D_videogames <- data.df$Familiar_3D_videogames %>% as.factor()
    data.df$Familiar_VR <- data.df$Familiar_VR %>% as.factor()
    data.df$Familiar_controls <- data.df$Familiar_controls %>% as.factor()
    data.df$Familiar_oculus_controls <- data.df$Familiar_oculus_controls %>% as.factor()

    ####CYBERSICKNESS BEFORE###
    data.df$General_discomfort <- data.df$General_discomfort %>% as.factor()
    data.df$Headache <- data.df$Headache %>% as.factor()
    data.df$Fatigue <- data.df$Fatigue %>% as.factor()
    data.df$Eyestrain <- data.df$Eyestrain %>% as.factor()
    data.df$Difficulty_focusing <- data.df$Difficulty_focusing %>% as.factor()
    data.df$Increased_salivation <- data.df$Increased_salivation %>% as.factor()
    data.df$Sweating <- data.df$Sweating %>% as.factor()
    data.df$Nausea <- data.df$Nausea %>% as.factor()
    data.df$Difficulty_concentrating <- data.df$Difficulty_concentrating %>% as.factor()
    data.df$Fullness_head <- data.df$Fullness_head %>% as.factor()
    data.df$Blurred_vision <- data.df$Blurred_vision %>% as.factor()
    data.df$Dizziness_eyes_open <- data.df$Dizziness_eyes_open %>% as.factor()
    data.df$Dizziness_eyes_closed <- data.df$Dizziness_eyes_closed %>% as.factor()
    data.df$Vertigo <- data.df$Vertigo %>% as.factor()
    data.df$Stomach <- data.df$Stomach %>% as.factor()
    data.df$Burping <- data.df$Burping %>% as.factor()

    data.df$Code_finish <- data.df$Code_finish %>% as.factor()

    ####CYBERSICKNESS AFTER###
    data.df$General_discomfort2 <- data.df$General_discomfort2 %>% as.factor()
    data.df$Headache2 <- data.df$Headache2 %>% as.factor()
    data.df$Fatigue2 <- data.df$Fatigue2 %>% as.factor()
    data.df$Eyestrain2 <- data.df$Eyestrain2 %>% as.factor()
    data.df$Difficulty_focusing2 <- data.df$Difficulty_focusing2 %>% as.factor()
    data.df$Increased_salivation2 <- data.df$Increased_salivation2 %>% as.factor()
    data.df$Sweating2 <- data.df$Sweating2 %>% as.factor()
    data.df$Nausea2 <- data.df$Nausea2 %>% as.factor()
    data.df$Difficulty_concentrating2 <- data.df$Difficulty_concentrating2 %>% as.factor()
    data.df$Fullness_head2 <- data.df$Fullness_head2 %>% as.factor()
    data.df$Blurred_vision2 <- data.df$Blurred_vision2 %>% as.factor()
    data.df$Dizziness_eyes_open2 <- data.df$Dizziness_eyes_open2 %>% as.factor()
    data.df$Dizziness_eyes_closed2 <- data.df$Dizziness_eyes_closed2 %>% as.factor()
    data.df$Vertigo2 <- data.df$Vertigo2 %>% as.factor()
    data.df$Stomach2 <- data.df$Stomach2 %>% as.factor()
    data.df$Burping2 <- data.df$Burping2 %>% as.factor()

    data.df$Upload_files <- data.df$Upload_files %>% as.character()

    data.df$First_choice <- data.df$First_choice %>% as.factor()
    data.df$Second_choice <- data.df$Second_choice %>% as.factor()
    data.df$Third_choice <- data.df$Third_choice %>% as.factor()

    data.df$Capabilities <- data.df$Capabilities %>% as.numeric()
    data.df$Easy <- data.df$Easy %>% as.numeric()
    data.df$Comments <- data.df$Comments %>% as.character()    

    return(data.df)
}

# =============form===================

form.df <- loadForm("data/form.csv")

#Before#
form.df$General_discomfort <- revalue(form.df$General_discomfort, c("None" = 0,
                                                    "Low" = 1,
                                                    "Moderate" = 2,
                                                    "High" = 3,
                                                    "Intense" = 4
))
form.df$General_discomfort <- as.numeric(levels(form.df$General_discomfort))[form.df$General_discomfort]

form.df$Headache <- revalue(form.df$Headache, c("None" = 0,
                                                    "Low" = 1,
                                                    "Moderate" = 2,
                                                    "High" = 3,
                                                    "Intense" = 4
))
form.df$Headache <- as.numeric(levels(form.df$Headache))[form.df$Headache]

form.df$Fatigue <- revalue(form.df$Fatigue, c("None" = 0,
                                                    "Low" = 1,
                                                    "Moderate" = 2,
                                                    "High" = 3,
                                                    "Intense" = 4
))
form.df$Fatigue <- as.numeric(levels(form.df$Fatigue))[form.df$Fatigue]

form.df$Eyestrain <- revalue(form.df$Eyestrain, c("None" = 0,
                                                    "Low" = 1,
                                                    "Moderate" = 2,
                                                    "High" = 3,
                                                    "Intense" = 4
))
form.df$Eyestrain <- as.numeric(levels(form.df$Eyestrain))[form.df$Eyestrain]

form.df$Difficulty_focusing <- revalue(form.df$Difficulty_focusing, c("None" = 0,
                                                    "Low" = 1,
                                                    "Moderate" = 2,
                                                    "High" = 3,
                                                    "Intense" = 4
))
form.df$Difficulty_focusing <- as.numeric(levels(form.df$Difficulty_focusing))[form.df$Difficulty_focusing]

form.df$Increased_salivation <- revalue(form.df$Increased_salivation, c("None" = 0,
                                                    "Low" = 1,
                                                    "Moderate" = 2,
                                                    "High" = 3,
                                                    "Intense" = 4
))
form.df$Increased_salivation <- as.numeric(levels(form.df$Increased_salivation))[form.df$Increased_salivation]

form.df$Sweating <- revalue(form.df$Sweating, c("None" = 0,
                                                    "Low" = 1,
                                                    "Moderate" = 2,
                                                    "High" = 3,
                                                    "Intense" = 4
))
form.df$Sweating <- as.numeric(levels(form.df$Sweating))[form.df$Sweating]

form.df$Nausea <- revalue(form.df$Nausea, c("None" = 0,
                                                    "Low" = 1,
                                                    "Moderate" = 2,
                                                    "High" = 3,
                                                    "Intense" = 4
))
form.df$Nausea <- as.numeric(levels(form.df$Nausea))[form.df$Nausea]

form.df$Difficulty_concentrating <- revalue(form.df$Difficulty_concentrating, c("None" = 0,
                                                    "Low" = 1,
                                                    "Moderate" = 2,
                                                    "High" = 3,
                                                    "Intense" = 4
))
form.df$Difficulty_concentrating <- as.numeric(levels(form.df$Difficulty_concentrating))[form.df$Difficulty_concentrating]

form.df$Fullness_head <- revalue(form.df$Fullness_head, c("None" = 0,
                                                    "Low" = 1,
                                                    "Moderate" = 2,
                                                    "High" = 3,
                                                    "Intense" = 4
))
form.df$Fullness_head <- as.numeric(levels(form.df$Fullness_head))[form.df$Fullness_head]

form.df$Blurred_vision <- revalue(form.df$Blurred_vision, c("None" = 0,
                                                    "Low" = 1,
                                                    "Moderate" = 2,
                                                    "High" = 3,
                                                    "Intense" = 4
))
form.df$Blurred_vision <- as.numeric(levels(form.df$Blurred_vision))[form.df$Blurred_vision]

form.df$Dizziness_eyes_open <- revalue(form.df$Dizziness_eyes_open, c("None" = 0,
                                                    "Low" = 1,
                                                    "Moderate" = 2,
                                                    "High" = 3,
                                                    "Intense" = 4
))
form.df$Dizziness_eyes_open <- as.numeric(levels(form.df$Dizziness_eyes_open))[form.df$Dizziness_eyes_open]

form.df$Dizziness_eyes_closed <- revalue(form.df$Dizziness_eyes_closed, c("None" = 0,
                                                    "Low" = 1,
                                                    "Moderate" = 2,
                                                    "High" = 3,
                                                    "Intense" = 4
))
form.df$Dizziness_eyes_closed <- as.numeric(levels(form.df$Dizziness_eyes_closed))[form.df$Dizziness_eyes_closed]

form.df$Vertigo <- revalue(form.df$Vertigo, c("None" = 0,
                                                    "Low" = 1,
                                                    "Moderate" = 2,
                                                    "High" = 3,
                                                    "Intense" = 4
))
form.df$Vertigo <- as.numeric(levels(form.df$Vertigo))[form.df$Vertigo]

form.df$Stomach <- revalue(form.df$Stomach, c("None" = 0,
                                                    "Low" = 1,
                                                    "Moderate" = 2,
                                                    "High" = 3,
                                                    "Intense" = 4
))
form.df$Stomach <- as.numeric(levels(form.df$Stomach))[form.df$Stomach]

form.df$Burping <- revalue(form.df$Burping, c("None" = 0,
                                                    "Low" = 1,
                                                    "Moderate" = 2,
                                                    "High" = 3,
                                                    "Intense" = 4
))
form.df$Burping <- as.numeric(levels(form.df$Burping))[form.df$Burping]

#After#
form.df$General_discomfort2 <- revalue(form.df$General_discomfort2, c("None" = 0,
                                                    "Low" = 1,
                                                    "Moderate" = 2,
                                                    "High" = 3,
                                                    "Intense" = 4
))
form.df$General_discomfort2 <- as.numeric(levels(form.df$General_discomfort2))[form.df$General_discomfort2]

form.df$Headache2 <- revalue(form.df$Headache2, c("None" = 0,
                                                    "Low" = 1,
                                                    "Moderate" = 2,
                                                    "High" = 3,
                                                    "Intense" = 4
))
form.df$Headache2 <- as.numeric(levels(form.df$Headache2))[form.df$Headache2]

form.df$Fatigue2 <- revalue(form.df$Fatigue2, c("None" = 0,
                                                    "Low" = 1,
                                                    "Moderate" = 2,
                                                    "High" = 3,
                                                    "Intense" = 4
))
form.df$Fatigue2 <- as.numeric(levels(form.df$Fatigue2))[form.df$Fatigue2]

form.df$Eyestrain2 <- revalue(form.df$Eyestrain2, c("None" = 0,
                                                    "Low" = 1,
                                                    "Moderate" = 2,
                                                    "High" = 3,
                                                    "Intense" = 4
))
form.df$Eyestrain2 <- as.numeric(levels(form.df$Eyestrain2))[form.df$Eyestrain2]

form.df$Difficulty_focusing2 <- revalue(form.df$Difficulty_focusing2, c("None" = 0,
                                                    "Low" = 1,
                                                    "Moderate" = 2,
                                                    "High" = 3,
                                                    "Intense" = 4
))
form.df$Difficulty_focusing2 <- as.numeric(levels(form.df$Difficulty_focusing2))[form.df$Difficulty_focusing2]

form.df$Increased_salivation2 <- revalue(form.df$Increased_salivation2, c("None" = 0,
                                                    "Low" = 1,
                                                    "Moderate" = 2,
                                                    "High" = 3,
                                                    "Intense" = 4
))
form.df$Increased_salivation2 <- as.numeric(levels(form.df$Increased_salivation2))[form.df$Increased_salivation2]

form.df$Sweating2 <- revalue(form.df$Sweating2, c("None" = 0,
                                                    "Low" = 1,
                                                    "Moderate" = 2,
                                                    "High" = 3,
                                                    "Intense" = 4
))
form.df$Sweating2 <- as.numeric(levels(form.df$Sweating2))[form.df$Sweating2]

form.df$Nausea2 <- revalue(form.df$Nausea2, c("None" = 0,
                                                    "Low" = 1,
                                                    "Moderate" = 2,
                                                    "High" = 3,
                                                    "Intense" = 4
))
form.df$Nausea2 <- as.numeric(levels(form.df$Nausea2))[form.df$Nausea2]

form.df$Difficulty_concentrating2 <- revalue(form.df$Difficulty_concentrating2, c("None" = 0,
                                                    "Low" = 1,
                                                    "Moderate" = 2,
                                                    "High" = 3,
                                                    "Intense" = 4
))
form.df$Difficulty_concentrating2 <- as.numeric(levels(form.df$Difficulty_concentrating2))[form.df$Difficulty_concentrating2]

form.df$Fullness_head2 <- revalue(form.df$Fullness_head2, c("None" = 0,
                                                    "Low" = 1,
                                                    "Moderate" = 2,
                                                    "High" = 3,
                                                    "Intense" = 4
))
form.df$Fullness_head2 <- as.numeric(levels(form.df$Fullness_head2))[form.df$Fullness_head2]

form.df$Blurred_vision2 <- revalue(form.df$Blurred_vision2, c("None" = 0,
                                                    "Low" = 1,
                                                    "Moderate" = 2,
                                                    "High" = 3,
                                                    "Intense" = 4
))
form.df$Blurred_vision2 <- as.numeric(levels(form.df$Blurred_vision2))[form.df$Blurred_vision2]

form.df$Dizziness_eyes_open2 <- revalue(form.df$Dizziness_eyes_open2, c("None" = 0,
                                                    "Low" = 1,
                                                    "Moderate" = 2,
                                                    "High" = 3,
                                                    "Intense" = 4
))
form.df$Dizziness_eyes_open2 <- as.numeric(levels(form.df$Dizziness_eyes_open2))[form.df$Dizziness_eyes_open2]

form.df$Dizziness_eyes_closed2 <- revalue(form.df$Dizziness_eyes_closed2, c("None" = 0,
                                                    "Low" = 1,
                                                    "Moderate" = 2,
                                                    "High" = 3,
                                                    "Intense" = 4
))
form.df$Dizziness_eyes_closed2 <- as.numeric(levels(form.df$Dizziness_eyes_closed2))[form.df$Dizziness_eyes_closed2]

form.df$Vertigo2 <- revalue(form.df$Vertigo2, c("None" = 0,
                                                    "Low" = 1,
                                                    "Moderate" = 2,
                                                    "High" = 3,
                                                    "Intense" = 4
))
form.df$Vertigo2 <- as.numeric(levels(form.df$Vertigo2))[form.df$Vertigo2]

form.df$Stomach2 <- revalue(form.df$Stomach2, c("None" = 0,
                                                    "Low" = 1,
                                                    "Moderate" = 2,
                                                    "High" = 3,
                                                    "Intense" = 4
))
form.df$Stomach2 <- as.numeric(levels(form.df$Stomach2))[form.df$Stomach2]

form.df$Burping2 <- revalue(form.df$Burping2, c("None" = 0,
                                                    "Low" = 1,
                                                    "Moderate" = 2,
                                                    "High" = 3,
                                                    "Intense" = 4
))
form.df$Burping2 <- as.numeric(levels(form.df$Burping2))[form.df$Burping2]




