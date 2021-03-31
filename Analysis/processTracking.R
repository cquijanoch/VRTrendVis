
tracking_clean.df$seconds <- 2
tracking_clean.df$translate <- ifelse(tracking_clean.df$DistTranslate > 0.1, "T", "N")
tracking_clean.df$rotating10 <- ifelse(tracking_clean.df$Angle > 10, "T", "N")
tracking_clean.df$rotating15 <- ifelse(tracking_clean.df$Angle > 15, "T", "N")
tracking_clean.df$rotating20 <- ifelse(tracking_clean.df$Angle > 20, "T", "N")
tracking_clean.df$rotating30 <- ifelse(tracking_clean.df$Angle > 45, "T", "N")

area.df <- unique(tracking_clean.df[,c("ID","AreaX","AreaZ","AreaTotal")])
area.df$AreaX <- area.df$AreaX*2
area.df$AreaZ <- area.df$AreaZ*2

tracking_time.df <- aggregate(tracking_clean.df$seconds, by = list(VisModeID = tracking_clean.df$VisModeID,
                                                                ID = tracking_clean.df$ID,
                                                                TaskID = tracking_clean.df$TaskID,
                                                                Translate = tracking_clean.df$translate,
                                                                Joystick = tracking_clean.df$Joystick,
                                                                Rotating10 = tracking_clean.df$rotating10,
                                                                Rotating15 = tracking_clean.df$rotating15,
                                                                Rotating20 = tracking_clean.df$rotating20,
                                                                Rotating30 = tracking_clean.df$rotating30), FUN=sum)
tracking_time.df$x <- tracking_time.df$x/60 #minutes

plot_duration_tracking <- ggplot(tracking_time.df, aes(x=ID,y=x,fill=VisModeID)) + geom_col() + coord_flip()

plot_duration_joystick <- ggplot(tracking_time.df, aes(x=ID,y=x,fill=Joystick)) + geom_col() + coord_flip()

plot_duration_joystick_vis <- ggplot(tracking_time.df[tracking_time.df$Joystick == "T",], aes(x=ID,y=x,fill=VisModeID)) + geom_col() + coord_flip()

plot_duration_joystick_task <- ggplot(tracking_time.df[tracking_time.df$Joystick == "T",], aes(x=TaskID,y=x,fill=VisModeID)) + geom_col() + coord_flip()

plot_duration_translate <- ggplot(tracking_time.df, aes(x=ID,y=x,fill=Translate)) + geom_col() + coord_flip()

plot_duration_translate_vis <- ggplot(tracking_time.df[tracking_time.df$Translate == "T",], aes(x=ID,y=x,fill=VisModeID)) + geom_col() + coord_flip()

plot_duration_translate_task <- ggplot(tracking_time.df[tracking_time.df$Translate == "T",], aes(x=TaskID,y=x,fill=VisModeID)) + geom_col() + coord_flip()

plot_duration_rotate_vis_10 <- ggplot(tracking_time.df[tracking_time.df$Rotating10 == "T",], aes(x=ID,y=x,fill=VisModeID)) + geom_col() + coord_flip()

plot_duration_rotate_task_10 <- ggplot(tracking_time.df[tracking_time.df$Rotating10 == "T",], aes(x=TaskID,y=x,fill=VisModeID)) + geom_col() + coord_flip()

plot_duration_rotate_vis_15 <- ggplot(tracking_time.df[tracking_time.df$Rotating15 == "T",], aes(x=ID,y=x,fill=VisModeID)) + geom_col() + coord_flip()

plot_duration_rotate_task_15 <- ggplot(tracking_time.df[tracking_time.df$Rotating15 == "T",], aes(x=TaskID,y=x,fill=VisModeID)) + geom_col() + coord_flip()

plot_duration_rotate_vis_20 <- ggplot(tracking_time.df[tracking_time.df$Rotating20 == "T",], aes(x=ID,y=x,fill=VisModeID)) + geom_col() + coord_flip()

plot_duration_rotate_task_20 <- ggplot(tracking_time.df[tracking_time.df$Rotating20 == "T",], aes(x=TaskID,y=x,fill=VisModeID)) + geom_col() + coord_flip()

plot_duration_rotate_vis_30 <- ggplot(tracking_time.df[tracking_time.df$Rotating30 == "T",], aes(x=ID,y=x,fill=VisModeID)) + geom_col() + coord_flip()

plot_duration_rotate_task_30 <- ggplot(tracking_time.df[tracking_time.df$Rotating30 == "T",], aes(x=TaskID,y=x,fill=VisModeID)) + geom_col() + coord_flip()


task_clean.df <- task.df[task.df$TaskID != "12",]

task_clean.df$ID <- ordered(task_clean.df$ID, levels = c("1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18"))
task_clean.df$VisModeID <- ordered(task_clean.df$VisModeID, levels = c("SMultiples","Overlaid","Animation","Mix"))
task_clean.df$TaskID <- ordered(task_clean.df$TaskID, levels = c("1","2","3","4","5","6","7","8","9","10","11"))

interaction.df <- task_clean.df[,c("ID","VisModeID","TaskID")]
interaction.df$duration <- task_clean.df[,"GrabHand"]
interaction.df$feature <- "Grab Hand"

interaction2.df <- task_clean.df[,c("ID","VisModeID","TaskID")]
interaction2.df$duration <- task_clean.df[,"GrabRay"]
interaction2.df$feature <- "Grab Ray"

interaction3.df <- task_clean.df[,c("ID","VisModeID","TaskID")]
interaction3.df$duration <- task_clean.df[,"ScaleHand"]
interaction3.df$feature <- "Scale Hand"

interaction4.df <- task_clean.df[,c("ID","VisModeID","TaskID")]
interaction4.df$duration <- task_clean.df[,"ScaleHand"]
interaction4.df$feature <- "Scale Ray"


tracking_time.df$ID <- ordered(tracking_time.df$ID, levels = c("1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18"))
tracking_time.df$VisModeID <- ordered(tracking_time.df$VisModeID, levels = c("SMultiples","Overlaid","Animation","Mix"))
tracking_time.df$TaskID <- ordered(tracking_time.df$TaskID, levels = c("1","2","3","4","5","6","7","8","9","10","11","12"))

virtualMovement <- tracking_time.df[tracking_time.df$Joystick == "T" & tracking_time.df$TaskID != "12",]
virtualMovement <- aggregate(virtualMovement$x, by=list(ID=virtualMovement$ID, VisModeID=virtualMovement$VisModeID, TaskID=virtualMovement$TaskID), FUN=sum)

virtualMovement$ID <- ordered(virtualMovement$ID, levels = c("1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18"))
virtualMovement$VisModeID <- ordered(virtualMovement$VisModeID, levels = c("SMultiples","Overlaid","Animation","Mix"))
virtualMovement$TaskID <- ordered(virtualMovement$TaskID, levels = c("11","10","9","8","7","6","5","4","3","2","1"))
colnames(virtualMovement)[4] <- "duration"
virtualMovement$feature <- "Virtual Movement"

translate <- tracking_time.df[tracking_time.df$Translate == "T" & tracking_time.df$TaskID != "12",]
translate <- aggregate(translate$x, by=list(ID=translate$ID, VisModeID=translate$VisModeID, TaskID=translate$TaskID), FUN=sum)
translate$ID <- ordered(translate$ID, levels = c("1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18"))
translate$VisModeID <- ordered(translate$VisModeID, levels = c("SMultiples","Overlaid","Animation","Mix"))
translate$TaskID <- ordered(translate$TaskID, levels = c("11","10","9","8","7","6","5","4","3","2","1"))
colnames(translate)[4] <- "duration"
translate$feature <- "Translating Camera"

rotating <- tracking_time.df[tracking_time.df$Rotating30 == "T" & tracking_time.df$TaskID != "12",]
rotating <- aggregate(rotating$x, by=list(ID=rotating$ID, VisModeID=rotating$VisModeID, TaskID=rotating$TaskID), FUN=sum)
rotating$ID <- ordered(rotating$ID, levels = c("1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18"))
rotating$VisModeID <- ordered(rotating$VisModeID, levels = c("SMultiples","Overlaid","Animation","Mix"))
#rotating$TaskID <- ordered(rotating$TaskID, levels = c("1","2","3","4","5","6","7","8","9","10","11"))
rotating$TaskID <- ordered(rotating$TaskID, levels = c("11","10","9","8","7","6","5","4","3","2","1"))
colnames(rotating)[4] <- "duration"
rotating$feature <- "Rotating Camera"

interaction.df <- rbind(virtualMovement,translate,rotating,interaction.df,interaction3.df,interaction2.df,interaction4.df)
#interaction.df$feature <- ordered(interaction.df$feature, levels = c("Virtual Movement","Translating Camera","Rotating Camera","Grab Hand","Scale Hand","Grab Ray","Scale Ray"))
interaction.df$feature <- ordered(interaction.df$feature, levels = c("Grab Hand","Scale Hand","Grab Ray","Scale Ray","Virtual Movement","Translating Camera","Rotating Camera"))
plot_interaction <- ggplot(interaction.df, aes(x=TaskID,y=duration,fill=feature)) + geom_col() + coord_flip()+ facet_wrap(~ VisModeID, nrow = 2)
ggsave(plot = plot_interaction, filename = "plot_interaction.png", device="png", width = 7, height = 4.25, units = "in", dpi = 300)

plot_interaction_animation <- ggplot(interaction.df[interaction.df$VisModeID == "Animation",], aes(x=TaskID,y=duration,fill=feature)) + geom_col() + coord_flip()+ facet_wrap(~ VisModeID, nrow = 2)
ggsave(plot = plot_interaction_animation, filename = "plot_interaction_animation.png", device="png", width = 7, height = 2.25, units = "in", dpi = 300)

plot_interaction_overlaid <- ggplot(interaction.df[interaction.df$VisModeID == "Overlaid",], aes(x=TaskID,y=duration,fill=feature)) + geom_col() + coord_flip()+ facet_wrap(~ VisModeID, nrow = 2)
ggsave(plot = plot_interaction_overlaid, filename = "plot_interaction_overlaid.png", device="png", width = 7, height = 2.25, units = "in", dpi = 300)

plot_interaction_multiples <- ggplot(interaction.df[interaction.df$VisModeID == "SMultiples",], aes(x=TaskID,y=duration,fill=feature)) + geom_col() + coord_flip()+ facet_wrap(~ VisModeID, nrow = 2)
ggsave(plot = plot_interaction_multiples, filename = "plot_interaction_multiples.png", device="png", width = 7, height = 2.25, units = "in", dpi = 300)

plot_interaction_mix <- ggplot(interaction.df[interaction.df$VisModeID == "Mix",], aes(x=TaskID,y=duration,fill=feature)) + geom_col() + coord_flip()+ facet_wrap(~ VisModeID, nrow = 2)
ggsave(plot = plot_interaction_mix, filename = "plot_interaction_mix.png", device="png", width = 7, height = 2.25, units = "in", dpi = 300)

# tracking.df <- tracking.df[tracking.df$VisModeID == task.df$VisModeID &
#                 tracking.df$ID == task.df$ID &
#                 tracking.df$TaskID == task.df$TaskID &
#                 (tracking.df$Time >= task.df$TimeInitTask &
#                 tracking.df$Time <= task.df$TimeEndTask),]