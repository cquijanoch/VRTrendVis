

loadData <- function(path, id) { 
    data.df <- read.csv(path,sep=";", header = TRUE, encoding = "UTF-8") 
    data.df <- as.data.frame(data.df,stringsAsFactors=F)

    data.df$ID <- id %>% as.factor()
    data.df$Input <- data.df$Input %>% as.factor()
    data.df$HMD <- data.df$HMD %>% as.factor()
    data.df$TimeInitTutorial <- data.df$TimeInitTutorial %>% as.character()
    data.df$TimeInitTutorial <- strptime(data.df$TimeInitTutorial, format="%Y%m%d%H%M%S")
    data.df$TimeEndTutorial <- data.df$TimeEndTutorial %>% as.character()
    data.df$TimeEndTutorial <- strptime(data.df$TimeEndTutorial, format="%Y%m%d%H%M%S")
    data.df$TimeInitPractice <- data.df$TimeInitPractice %>% as.character()
    data.df$TimeInitPractice <- strptime(data.df$TimeInitPractice, format="%Y%m%d%H%M%S")
    data.df$TimeEndPractice <- data.df$TimeEndPractice %>% as.character()
    data.df$TimeEndPractice <- strptime(data.df$TimeEndPractice, format="%Y%m%d%H%M%S")
    data.df$VisModeID <- data.df$VisModeID %>% as.factor()
    data.df$TaskID <- data.df$TaskID %>% as.factor()
    data.df$TimeInitTask <- data.df$TimeInitTask %>% as.character()
    data.df$TimeInitTask <- strptime(data.df$TimeInitTask, format="%Y%m%d%H%M%S")
    data.df$TimeEndTask <- data.df$TimeEndTask %>% as.character()
    data.df$TimeEndTask <- strptime(data.df$TimeEndTask, format="%Y%m%d%H%M%S")
    data.df$UserAnswerID <- data.df$UserAnswerID %>% as.character()
    data.df$CorrectAnswerID <- data.df$CorrectAnswerID %>% as.character()
    data.df$NumAnswers <- data.df$NumAnswers %>% as.numeric()
    data.df$NumCorrectAnswers <- data.df$NumCorrectAnswers %>% as.numeric()
    data.df$SubspacesName <- data.df$SubspacesName %>% as.character()
    data.df$InteractionMode <- data.df$InteractionMode %>% as.factor()
    data.df$Controller <- data.df$Controller %>% as.factor()
    data.df$TimeGrab <- data.df$TimeGrab %>% as.character()
    data.df$TimeGrab <- gsub(",",".",data.df$TimeGrab) %>% as.numeric()
    #d#ata.df$TimeGrab <- data.df$TimeGrab %>% as.numeric()
    data.df$TimeScale <- data.df$TimeScale %>% as.character()
    data.df$TimeScale <- gsub(",",".",data.df$TimeScale) %>% as.numeric()
    #data.df$TimeScale <- data.df$TimeScale %>% as.numeric()
    data.df$Selects <- data.df$Selects %>% as.numeric()
    data.df$Q1 <- data.df$Q1 %>% as.numeric()
    data.df$Q2 <- data.df$Q2 %>% as.numeric()
    data.df$Q3 <- data.df$Q3 %>% as.numeric()
    data.df$TimeEndExperiment <- data.df$TimeEndExperiment %>% as.character()
    data.df$TimeEndExperiment <- strptime(data.df$TimeEndExperiment, format="%Y%m%d%H%M%S")
    data.df$TimeHMDRemoved <- data.df$TimeHMDRemoved %>% as.character()
    data.df$TimeHMDRemoved <- strptime(data.df$TimeHMDRemoved, format="%Y%m%d%H%M%S")
    data.df$TimeHMDRecovery <- data.df$TimeHMDRecovery %>% as.character()
    data.df$TimeHMDRecovery <- strptime(data.df$TimeHMDRecovery, format="%Y%m%d%H%M%S")
    data.df$TimeCloseApplication <- data.df$TimeCloseApplication %>% as.character()
    data.df$TimeCloseApplication <- strptime(data.df$TimeCloseApplication, format="%Y%m%d%H%M%S")

    return(data.df)
}

test.df <- loadData("data/result_1.csv",1)
test.df <- rbind(test.df, loadData("data/result_2.csv",2))
test.df <- rbind(test.df, loadData("data/result_3.csv",3))
test.df <- rbind(test.df, loadData("data/result_4.csv",4))
test.df <- rbind(test.df, loadData("data/result_5.csv",5))
test.df <- rbind(test.df, loadData("data/result_6.csv",6))
test.df <- rbind(test.df, loadData("data/result_7.csv",7))
test.df <- rbind(test.df, loadData("data/result_8.csv",8))
test.df <- rbind(test.df, loadData("data/result_9.csv",9))
test.df <- rbind(test.df, loadData("data/result_10.csv",10))
test.df <- rbind(test.df, loadData("data/result_11.csv",11))
test.df <- rbind(test.df, loadData("data/result_12.csv",12))
test.df <- rbind(test.df, loadData("data/result_13.csv",13))
test.df <- rbind(test.df, loadData("data/result_14.csv",14))
test.df <- rbind(test.df, loadData("data/result_15.csv",15))
test.df <- rbind(test.df, loadData("data/result_16.csv",16))
test.df <- rbind(test.df, loadData("data/result_17.csv",17))
test.df <- rbind(test.df, loadData("data/result_18.csv",18))

subjetive.df <- test.df[!is.na(test.df$VisModeID),c("ID","VisModeID","Q1","Q2","Q3")]
subjetive.df <- ddply(subjetive.df, .(ID, VisModeID), function(x) x[c(nrow(x)), ])

task.df <- test.df[test.df$UserAnswerID != "",]

aggregate_timegrab.df <- aggregate(task.df$TimeGrab, by=list(ID=task.df$ID, VM=task.df$VisModeID, t=task.df$TaskID, IM=task.df$InteractionMode), FUN=sum)
aggregate_timescale.df <- aggregate(task.df$TimeScale, by=list(ID=task.df$ID, VM=task.df$VisModeID, t=task.df$TaskID, IM=task.df$InteractionMode), FUN=sum)

aggregate_timegrab.df <- inner_join(aggregate_timegrab.df[aggregate_timegrab.df$IM=="hand",],aggregate_timegrab.df[aggregate_timegrab.df$IM=="ray",],by=c("ID","VM","t"))
aggregate_timescale.df <- inner_join(aggregate_timescale.df[aggregate_timescale.df$IM=="hand",],aggregate_timescale.df[aggregate_timescale.df$IM=="ray",],by=c("ID","VM","t"))

aggregate_timegrab.df$GrabHand <- aggregate_timegrab.df$x.x / 60
aggregate_timegrab.df$GrabRay <- aggregate_timegrab.df$x.y / 60 
aggregate_timescale.df$ScaleHand <- aggregate_timescale.df$x.x / 60
aggregate_timescale.df$ScaleRay <- aggregate_timescale.df$x.y / 60

aggregate_test.df <- data.frame(aggregate_timegrab.df$ID,aggregate_timegrab.df$VM,aggregate_timegrab.df$t,aggregate_timegrab.df$GrabHand,aggregate_timegrab.df$GrabRay,aggregate_timescale.df$ScaleHand,aggregate_timescale.df$ScaleRay)
colnames(aggregate_test.df) <- c('ID','VisModeID','TaskID','GrabHand','GrabRay','ScaleHand', 'ScaleRay')

task.df <- unique(inner_join(aggregate_test.df,task.df[,c(  "ID",
                                                            "VisModeID",
                                                            "TaskID",
                                                            "TimeInitTask",
                                                            "TimeEndTask",
                                                            "NumAnswers",
                                                            "NumCorrectAnswers",
                                                            "Selects",
                                                            "SubspacesName",
                                                            "UserAnswerID")
                                                        ], by=c("ID","VisModeID","TaskID")))

task.df$duration <- difftime(task.df$TimeEndTask, task.df$TimeInitTask, units="sec") %>% as.numeric()

task.df$error <- (task.df$NumAnswers - task.df$NumCorrectAnswers)/task.df$NumAnswers
task.df$binary_error <- task.df$error %>% as.logical()
task.df$accuracy <- 1 - task.df$binary_error %>% as.numeric()
task.df$points <- ((1 - task.df$error) * task.df$NumAnswers) %>% as.numeric()
task.df$points_factor <- task.df$points %>% as.factor()



task.df$VisModeID <- revalue(task.df$VisModeID, c("1" = "Animation",
                                                    "2" = "Overlaid",
                                                    "3" = "SMultiples",
                                                    "4" = "Mix"
))

###Mix Subspaces###

strsplits <- function(x, splits, ...)
{
    for (split in splits)
    {
        x <- unlist(strsplit(x, split, ...))
    }
    return(x[!x == ""]) # Remove empty values
}

mix.df <- data.frame(task.df[task.df$VisModeID == "Mix",])
mix.df$SubspacesName <- substr(mix.df$SubspacesName, 0 ,nchar(mix.df$SubspacesName)-1)
mix.df$UserAnswerID <- substr(mix.df$UserAnswerID, 0 ,nchar(mix.df$UserAnswerID)-1)

mix.df <- data.frame(mix.df %>% mutate(SubspacesName=strsplit(SubspacesName, "-")) %>% unnest(SubspacesName))
mix_temp.df <- data.frame(mix.df)
mix_temp.df$ID <- mix_temp.df$ID %>% as.numeric() 
mix_temp.df$SA <- strsplits(mix_temp.df$SubspacesName, c( "ScatterplotOverlay1",
                                                          "ScatterplotAnimated1",
                                                          "SMallA",
                                                          "SMallB",
                                                          "SMallC",
                                                          "SMallD",
                                                          "SMallE",
                                                          "SMallF",
                                                          "SMallG",
                                                          "SMallH",
                                                          "SMallI",
                                                          "SMallJ",
                                                          "SMallK",
                                                          "SMallL",
                                                          "SMallM",
                                                          "SMallN",
                                                          "SMallO",
                                                          "SMallP"

))


filterRepeats <- function(df, num)
{
    result.df <- data.frame()
    for (id in 1:max(df$ID))
    {
      for (tid in unique(df[df$ID == id,c("TaskID")]))
      {
        filter.df <- subset(df,df$ID == id & df$TaskID == tid) 
        if(dim(filter.df)[1] == num)
        {
        
          if (num == 1)
            filter.df[1,c("SubspacesName")] <- substr(filter.df[1,"SubspacesName"], 0 ,nchar(filter.df[1,"SubspacesName"]) - nchar(filter.df[1,"A1"]))
          if (num == 2)
          {
            filter.df[2,c("SubspacesName")] <- substr(filter.df[2,"SubspacesName"], 0 ,nchar(filter.df[2,"SubspacesName"]) - nchar(filter.df[2,"A2"]))
            filter.df[1,c("SubspacesName")] <- substr(filter.df[1,"SubspacesName"], 0 ,nchar(filter.df[1,"SubspacesName"]) - nchar(filter.df[1,"A1"]))
          }   
          if (num == 3)
          {
            filter.df[3,c("SubspacesName")] <- substr(filter.df[3,"SubspacesName"], 0 ,nchar(filter.df[3,"SubspacesName"]) - nchar(filter.df[3,"A3"]))
            filter.df[2,c("SubspacesName")] <- substr(filter.df[2,"SubspacesName"], 0 ,nchar(filter.df[2,"SubspacesName"]) - nchar(filter.df[2,"A2"]))
            filter.df[1,c("SubspacesName")] <- substr(filter.df[1,"SubspacesName"], 0 ,nchar(filter.df[1,"SubspacesName"]) - nchar(filter.df[1,"A1"]))
          }  
        
          result.df <- rbind(result.df, filter.df)
        }
        else
        {
          cnum <- num
          for (k in dim(filter.df)[1]:1)
          {
            if (num == 1)
            {
              if(filter.df[k,"A1"] == filter.df[k,"SA"])
              {
                filter.df[k,c("SubspacesName")] <- substr(filter.df[k,"SubspacesName"], 0 ,nchar(filter.df[k,"SubspacesName"]) - nchar(filter.df[k,"A1"]))
                result.df <- rbind(result.df, filter.df[k,])
                break
              }
            }
            if (num == 2)
            {
              if(cnum==2 & filter.df[k,"A2"] == filter.df[k,"SA"])
              {
                filter.df[k,c("SubspacesName")] <- substr(filter.df[k,"SubspacesName"], 0 ,nchar(filter.df[k,"SubspacesName"]) - nchar(filter.df[k,"A2"]))
                result.df <- rbind(result.df, filter.df[k,])
                cnum <- cnum - 1
              }
              else if(cnum==1 & filter.df[k,"A1"] == filter.df[k,"SA"])
              {
                filter.df[k,c("SubspacesName")] <- substr(filter.df[k,"SubspacesName"], 0 ,nchar(filter.df[k,"SubspacesName"]) - nchar(filter.df[k,"A1"]))
                result.df <- rbind(result.df, filter.df[k,])
                break
              }
            }
            if (num == 3)
            {
              if(cnum==3 & filter.df[k,"A3"] == filter.df[k,"SA"])
              {
                filter.df[k,c("SubspacesName")] <- substr(filter.df[k,"SubspacesName"], 0 ,nchar(filter.df[k,"SubspacesName"]) - nchar(filter.df[k,"A3"]))
                result.df <- rbind(result.df, filter.df[k,])
                cnum <- cnum - 1
              }
              else if(cnum==2 & filter.df[k,"A2"] == filter.df[k,"SA"])
              {
                filter.df[k,c("SubspacesName")] <- substr(filter.df[k,"SubspacesName"], 0 ,nchar(filter.df[k,"SubspacesName"]) - nchar(filter.df[k,"A2"]))
                result.df <- rbind(result.df, filter.df[k,])
                cnum <- cnum - 1
              }
              else if(cnum==1 & filter.df[k,"A1"] == filter.df[k,"SA"])
              {
                filter.df[k,c("SubspacesName")] <- substr(filter.df[k,"SubspacesName"], 0 ,nchar(filter.df[k,"SubspacesName"]) - nchar(filter.df[k,"A1"]))
                result.df <- rbind(result.df, filter.df[k,])
                break
              }
            }
          }
        }
      }
    }
  return(result.df)
}

mix_temp.df <- mix_temp.df %>% separate(UserAnswerID, c("A1","A2","A3"),"-")

#mix_temp.df <- mix_temp.df[!mix_temp.df$SA %in% c("A1","A2","A3"),]
mix_temp.df <- mix_temp.df[mix_temp.df$SA == mix_temp.df$A1 | mix_temp.df$SA == mix_temp.df$A2 | mix_temp.df$SA == mix_temp.df$A3,]
mix_temp.df <- mix_temp.df[!is.na(mix_temp.df$SA),]

mix_temp1.df <- mix_temp.df[mix_temp.df$NumAnswers == "1",]
mix_temp2.df <- mix_temp.df[mix_temp.df$NumAnswers == "2",]
mix_temp3.df <- mix_temp.df[mix_temp.df$NumAnswers == "3",]

mix_clean.df <- rbind(filterRepeats(mix_temp1.df,1),filterRepeats(mix_temp2.df,2),filterRepeats(mix_temp3.df,3))
mix_clean.df$SubspacesName <- substr(mix_clean.df$SubspacesName, 0 ,nchar(mix_clean.df$SubspacesName)-1)
mix_clean.df$ID <- mix_clean.df$ID %>% as.factor() 
mix_clean.df$answers <- 1 
mix_clean.df[mix_clean.df$TaskID == "1",c("Characteristic")] <- "Compare Axes"
mix_clean.df[mix_clean.df$TaskID == "6",c("Characteristic")] <- "Compare Axes"
mix_clean.df[mix_clean.df$TaskID == "5",c("Characteristic")] <- "Longer Trajectory"
mix_clean.df[mix_clean.df$TaskID == "11",c("Characteristic")] <- "Longer Trajectory"
mix_clean.df[mix_clean.df$TaskID == "3",c("Characteristic")] <- "Strict Compare"
mix_clean.df[mix_clean.df$TaskID == "8",c("Characteristic")] <- "Strict Compare"
mix_clean.df[mix_clean.df$TaskID == "9",c("Characteristic")] <- "Strict Compare"
mix_clean.df[mix_clean.df$TaskID == "4",c("Characteristic")] <- "Reversals"
mix_clean.df[mix_clean.df$TaskID == "7",c("Characteristic")] <- "Reversals"
mix_clean.df[mix_clean.df$TaskID == "2",c("Characteristic")] <- "Overlaid points"
mix_clean.df[mix_clean.df$TaskID == "10",c("Characteristic")] <- "Similar"
mix_clean.df[mix_clean.df$TaskID == "12",c("Characteristic")] <- "Placement"

mix_clean.df$TaskID <- ordered(mix_clean.df$TaskID, levels = c("12","11","10","9","8","7","6","5","4","3","2","1"))
plot_Mix_by_ID <- ggplot(mix_clean.df[mix_clean.df$TaskID != "12",], aes(x=ID,y=answers,fill=SubspacesName)) + geom_col() + coord_flip() + labs(y = "Answers", x = "Participant") + 
scale_fill_discrete(name = "Visualization", labels = c("Animation", "Overlaid", "Small Multiples"))

ggsave(plot = plot_Mix_by_ID, filename = "plot_Mix_by_ID.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)

plot_Mix_by_TaskID <- ggplot(mix_clean.df[mix_clean.df$TaskID != "12",], aes(x=TaskID,y=answers,fill=SubspacesName)) + geom_col() + coord_flip()+ labs(y = "Answers", x = "Task") +
#scale_fill_discrete(name = "Visualization", labels = c("Animation", "Overlaid", "Small Multiples")) +
geom_hline(aes(yintercept=18),show.legend = F,color="red") +
geom_hline(aes(yintercept=36),show.legend = F,color="red") + 
geom_hline(aes(yintercept=54),show.legend = F,color="red") 

ggsave(plot = plot_Mix_by_TaskID, filename = "plot_Mix_by_TaskID.png", device="png", width = 3.75, height = 2.25, units = "in", dpi = 300)

plot_Mix_by_Characteristic <- ggplot(mix_clean.df, aes(x=Characteristic,y=answers,fill=SubspacesName)) + geom_col() + coord_flip()

plot_duration2 <- ggplot(task.df, aes(x=ID,y=duration,fill=VisModeID)) + geom_col() + coord_flip()

plot_time_hand_vis <- ggplot(task.df, aes(x=ID,y=GrabHand + ScaleHand,fill=VisModeID)) + geom_col() + coord_flip() + labs(y = "Hand")

plot_time_ray_vis <- ggplot(task.df, aes(x=ID,y=GrabRay + ScaleRay,fill=VisModeID)) + geom_col() + coord_flip() + labs(y = "Ray")

plot_time_hand_task <- ggplot(task.df, aes(x=TaskID,y=GrabHand + ScaleHand,fill=VisModeID)) + geom_col() + coord_flip() + labs(y = "Hand")

plot_time_ray_task <- ggplot(task.df, aes(x=TaskID,y=GrabRay + ScaleRay,fill=VisModeID)) + geom_col() + coord_flip() + labs(y = "Ray")

plot_time_grab_vis <- ggplot(task.df, aes(x=ID,y=GrabHand + GrabRay,fill=VisModeID)) + geom_col() + coord_flip() + labs(y = "Grab")

plot_time_grab_task <- ggplot(task.df, aes(x=TaskID,y=GrabHand + GrabRay,fill=VisModeID)) + geom_col() + coord_flip() + labs(y = "Grab")

plot_time_scale_vis <- ggplot(task.df, aes(x=ID,y=ScaleHand + ScaleRay,fill=VisModeID)) + geom_col() + coord_flip() + labs(y = "Scale")

plot_time_scale_task <- ggplot(task.df, aes(x=TaskID,y=ScaleHand + ScaleRay,fill=VisModeID)) + geom_col() + coord_flip() + labs(y = "Scale")

plot_time_grab_hand_vis <- ggplot(task.df, aes(x=ID,y=GrabHand,fill=VisModeID)) + geom_col() + coord_flip()

plot_time_grab_ray_vis <- ggplot(task.df, aes(x=ID,y=GrabRay,fill=VisModeID)) + geom_col() + coord_flip()

plot_time_grab_hand_task <- ggplot(task.df, aes(x=TaskID,y=GrabHand,fill=VisModeID)) + geom_col() + coord_flip()##

plot_time_grab_ray_task <- ggplot(task.df, aes(x=TaskID,y=GrabRay,fill=VisModeID)) + geom_col() + coord_flip()

plot_time_scale_hand_vis <- ggplot(task.df, aes(x=ID,y=ScaleHand,fill=VisModeID)) + geom_col() + coord_flip()

plot_time_scale_ray_vis <- ggplot(task.df, aes(x=ID,y=ScaleRay,fill=VisModeID)) + geom_col() + coord_flip()

plot_time_scale_hand_task <- ggplot(task.df, aes(x=TaskID,y=ScaleHand,fill=VisModeID)) + geom_col() + coord_flip()

plot_time_scale_ray_task <- ggplot(task.df, aes(x=TaskID,y=ScaleRay,fill=VisModeID)) + geom_col() + coord_flip()

plot_time_selects_vis <- ggplot(task.df, aes(x=ID,y=Selects,fill=VisModeID)) + geom_col() + coord_flip()

plot_time_selects_task <- ggplot(task.df, aes(x=TaskID,y=Selects,fill=VisModeID)) + geom_col() + coord_flip()



plot_duration_final2 <- ggplot(task.df, aes(duration,fill=VisModeID)) + geom_histogram(binwidth = .25,show.legend = T) + facet_wrap(~ VisModeID, nrow = 2) +
  geom_vline(aes(xintercept=mean(duration)),show.legend = F,color="red") +
  geom_vline(aes(xintercept=(mean(duration) + 3 * sd(duration))),show.legend = F,color="blue")

cols <- c("0" = "#e31a1c", "1" = "#bdd7e7", "2" = "#6baed6", "3" = "#2171b5")

plot_points2 <- ggplot(task.df, aes(points, fill = points_factor)) + 
  geom_histogram(binwidth = 1) + 
  facet_grid(VisModeID ~ TaskID) +
  scale_fill_manual(values = cols)

#data.df$TimeInitTutorial <- as.POSIXlt(data.df$TimeInitTutorial)

#data.df$TimeEndTutorial <- as.POSIXlt(data.df$TimeEndTutorial)



time_task <- aggregate(task.df$duration, by=list(ID=task.df$ID), FUN=sum)
time_experiment.df <- unique(test.df[!is.na(test.df$TimeCloseApplication),c("ID", "TimeInitTutorial", "TimeCloseApplication") ])
time_experiment.df$time_experiment <- difftime(time_experiment.df$TimeCloseApplication, time_experiment.df$TimeInitTutorial, units="min") %>% as.numeric()
time_experiment.df$time_total <- time_experiment.df$time_experiment + 5
#test.df$time_experiment <- difftime(test.df$TimeCloseApplication, test.df$TimeInitPractice, units="min") %>% as.numeric()
#time_experiment.df <- aggregate(test.df$time_experiment, by=list(ID=test.df$ID), FUN=sum)