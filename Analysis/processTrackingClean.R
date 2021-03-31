
library(matlib)
loadTracking <- function(path, id) { 
    data.df <- read.csv(path,sep=";", header = TRUE, encoding = "UTF-8") 
    data.df <- as.data.frame(data.df,stringsAsFactors=F)

    data.df$ID <- id %>% as.factor()
    data.df$Time <- strptime(data.df$Time, format="%Y%m%d%H%M%S")
    data.df$Phase <- data.df$Phase %>% as.factor()
    data.df$Step <- data.df$Step %>% as.factor()
    data.df$TaskID <- data.df$Task %>% as.factor()
    data.df$VisModeID <- data.df$Vis %>% as.factor()
    data.df$AreaX <- gsub(",",".",data.df$AreaX) %>% as.numeric()
    data.df$AreaZ <- gsub(",",".",data.df$AreaZ) %>% as.numeric()
    data.df$AreaTotal <- gsub(",",".",data.df$AreaTotal) %>% as.numeric()
    data.df$PositionXPlayer <- gsub(",",".",data.df$PositionXPlayer) %>% as.numeric() #joystick
    data.df$PositionZPlayer <- gsub(",",".",data.df$PositionZPlayer) %>% as.numeric() #joystick
    data.df$PositionXHead <- gsub(",",".",data.df$PositionXHead) %>% as.numeric() #camera
    data.df$PositionYHead <- gsub(",",".",data.df$PositionYHead) %>% as.numeric() #camera
    data.df$PositionZHead <- gsub(",",".",data.df$PositionZHead) %>% as.numeric() #camera
    data.df$RotationHead <- data.df$RotationHead %>% as.character() # rotation camera
    return(data.df)
}

tracking.df <- loadTracking("tracking/tracking_1.csv",1)
tracking.df <- rbind(tracking.df, loadTracking("tracking/tracking_2.csv",2))
tracking.df <- rbind(tracking.df, loadTracking("tracking/tracking_3.csv",3))
tracking.df <- rbind(tracking.df, loadTracking("tracking/tracking_4.csv",4))
tracking.df <- rbind(tracking.df, loadTracking("tracking/tracking_5.csv",5))
tracking.df <- rbind(tracking.df, loadTracking("tracking/tracking_6.csv",6))
tracking.df <- rbind(tracking.df, loadTracking("tracking/tracking_7.csv",7))
tracking.df <- rbind(tracking.df, loadTracking("tracking/tracking_8.csv",8))
tracking.df <- rbind(tracking.df, loadTracking("tracking/tracking_9.csv",9))
tracking.df <- rbind(tracking.df, loadTracking("tracking/tracking_10.csv",10))
tracking.df <- rbind(tracking.df, loadTracking("tracking/tracking_11.csv",11))
tracking.df <- rbind(tracking.df, loadTracking("tracking/tracking_12.csv",12))
tracking.df <- rbind(tracking.df, loadTracking("tracking/tracking_13.csv",13))
tracking.df <- rbind(tracking.df, loadTracking("tracking/tracking_14.csv",14))
tracking.df <- rbind(tracking.df, loadTracking("tracking/tracking_15.csv",15))
tracking.df <- rbind(tracking.df, loadTracking("tracking/tracking_16.csv",16))
tracking.df <- rbind(tracking.df, loadTracking("tracking/tracking_17.csv",17))
tracking.df <- rbind(tracking.df, loadTracking("tracking/tracking_18.csv",18))

tracking.df <- tracking.df[tracking.df$Phase == "4",]
tracking.df <- tracking.df[!is.na(tracking.df$TaskID),]
tracking.df <- tracking.df[!is.na(tracking.df$VisModeID),]
tracking.df$ID <- factor(tracking.df$ID) 
tracking.df$VisModeID <- factor(tracking.df$VisModeID) 
tracking.df$TaskID <- factor(tracking.df$TaskID) 
## RottationHead
tracking.df$RotationHead <- substr(tracking.df$RotationHead, 2 ,nchar(tracking.df$RotationHead) - 1)##clean '(' ')'
tracking.df <- transform(tracking.df, Rotation = do.call('rbind', strsplit(as.character(RotationHead), ', ', fixed=TRUE)))
tracking.df$Rotation.1 <- gsub(",",".",tracking.df$Rotation.1) %>% as.numeric()
tracking.df$Rotation.2 <- gsub(",",".",tracking.df$Rotation.2) %>% as.numeric()
tracking.df$Rotation.3 <- gsub(",",".",tracking.df$Rotation.3) %>% as.numeric()

tracking.df <- tracking.df[with(tracking.df,order(VisModeID, TaskID,ID)),]

tracking.df$VisModeID <- revalue(tracking.df$VisModeID, c("1" = "Animation",
                                                    "2" = "Overlaid",
                                                    "3" = "SMultiples",
                                                    "4" = "Mix"
))

filterTime <- function(id, df, dft, task) { 
    dataA.df <- df[which(df$ID == id & df$VisModeID=="Animation" & df$TaskID == task & 
                        df$Time >= dft[dft$VisModeID == "Animation" &
                                    dft$ID == id &
                                    dft$TaskID == task,"TimeInitTask"] &
                        df$Time <= dft[dft$VisModeID == "Animation" &
                                    dft$ID == id &
                                    dft$TaskID == task,"TimeEndTask"]),]

    for(row in dim(dataA.df)[1]:2)
    {
        if(dataA.df[row,"PositionXPlayer"] == dataA.df[row-1,"PositionXPlayer"] & dataA.df[row,"PositionZPlayer"] == dataA.df[row-1,"PositionZPlayer"])
        {
            dataA.df[row,c("Joystick")] <- "N"
        }
        else
        {
            dataA.df[row,c("Joystick")] <- "T"
        }

        dataA.df[row,c("DistTranslate")] <- sqrt(   
                    (dataA.df[row,"PositionXHead"] - dataA.df[row-1,"PositionXHead"])^2 +
                    (dataA.df[row,"PositionYHead"] - dataA.df[row-1,"PositionYHead"])^2 +
                    (dataA.df[row,"PositionZHead"] - dataA.df[row-1,"PositionZHead"])^2) 
        
        dataA.df[row,c("Angle")] <- angle(  c(dataA.df[row-1,"Rotation.1"], dataA.df[row-1,"Rotation.2"], dataA.df[row-1,"Rotation.3"]),
                                            c(dataA.df[row,"Rotation.1"], dataA.df[row,"Rotation.2"], dataA.df[row,"Rotation.3"]))
                                 
    }

    dataO.df <- subset(df, ID == id & VisModeID=="Overlaid" & TaskID == task & 
                        Time >= dft[dft$VisModeID == "Overlaid" &
                                    dft$ID == id &
                                    dft$TaskID == task,"TimeInitTask"] &
                        Time <= dft[dft$VisModeID == "Overlaid" &
                                    dft$ID == id &
                                    dft$TaskID == task,"TimeEndTask"])     

    for(row in dim(dataO.df)[1]:2)
    {
        if(dataO.df[row,c("PositionXPlayer")] == dataO.df[row-1,c("PositionXPlayer")] & dataO.df[row,c("PositionZPlayer")] == dataO.df[row-1,c("PositionZPlayer")])
        {
            dataO.df[row,c("Joystick")] <- "N"
        }
        else
        {
            dataO.df[row,c("Joystick")] <- "T"
        }

        dataO.df[row,c("DistTranslate")] <- sqrt(   
                    (dataO.df[row,"PositionXHead"] - dataO.df[row-1,"PositionXHead"])^2 +
                    (dataO.df[row,"PositionYHead"] - dataO.df[row-1,"PositionYHead"])^2 +
                    (dataO.df[row,"PositionZHead"] - dataO.df[row-1,"PositionZHead"])^2)    

        dataO.df[row,c("Angle")] <- angle(  c(dataO.df[row-1,"Rotation.1"], dataO.df[row-1,"Rotation.2"], dataO.df[row-1,"Rotation.3"]),
                                            c(dataO.df[row,"Rotation.1"], dataO.df[row,"Rotation.2"], dataO.df[row,"Rotation.3"]))
    }

    dataS.df <- subset(df, ID == id & VisModeID=="SMultiples" & TaskID == task & 
                        Time >= dft[dft$VisModeID == "SMultiples" &
                                    dft$ID == id &
                                    dft$TaskID == task,"TimeInitTask"] &
                        Time <= dft[dft$VisModeID == "SMultiples" &
                                    dft$ID == id &
                                    dft$TaskID == task,"TimeEndTask"])        
    
    for(row in dim(dataS.df)[1]:2)
    {
        if(dataS.df[row,c("PositionXPlayer")] == dataS.df[row-1,c("PositionXPlayer")] & dataS.df[row,c("PositionZPlayer")] == dataS.df[row-1,c("PositionZPlayer")])
        {
            dataS.df[row,c("Joystick")] <- "N"
        }
        else
        {
            dataS.df[row,c("Joystick")] <- "T"
        }

        dataS.df[row,c("DistTranslate")] <- sqrt(   
                    (dataS.df[row,"PositionXHead"] - dataS.df[row-1,"PositionXHead"])^2 +
                    (dataS.df[row,"PositionYHead"] - dataS.df[row-1,"PositionYHead"])^2 +
                    (dataS.df[row,"PositionZHead"] - dataS.df[row-1,"PositionZHead"])^2)    

        dataS.df[row,c("Angle")] <- angle(  c(dataS.df[row-1,"Rotation.1"], dataS.df[row-1,"Rotation.2"], dataS.df[row-1,"Rotation.3"]),
                                            c(dataS.df[row,"Rotation.1"], dataS.df[row,"Rotation.2"], dataS.df[row,"Rotation.3"]))
    }

    dataM.df <- subset(df, ID == id & VisModeID=="Mix" & TaskID == task & 
                        Time >= dft[dft$VisModeID == "Mix" &
                                    dft$ID == id &
                                    dft$TaskID == task,"TimeInitTask"] &
                        Time <= dft[dft$VisModeID == "Mix" &
                                    dft$ID == id &
                                    dft$TaskID == task,"TimeEndTask"])                                                                                                               

    for(row in dim(dataM.df)[1]:2)
    {
        if(dataM.df[row,c("PositionXPlayer")] == dataM.df[row-1,c("PositionXPlayer")] & dataM.df[row,c("PositionZPlayer")] == dataM.df[row-1,c("PositionZPlayer")])
        {
            dataM.df[row,c("Joystick")] <- "N"
        }
        else
        {
            dataM.df[row,c("Joystick")] <- "T"
        }

        dataM.df[row,c("DistTranslate")] <- sqrt(   
                    (dataM.df[row,"PositionXHead"] - dataM.df[row-1,"PositionXHead"])^2 +
                    (dataM.df[row,"PositionYHead"] - dataM.df[row-1,"PositionYHead"])^2 +
                    (dataM.df[row,"PositionZHead"] - dataM.df[row-1,"PositionZHead"])^2)    

        dataM.df[row,c("Angle")] <- angle(  c(dataM.df[row-1,"Rotation.1"], dataM.df[row-1,"Rotation.2"], dataM.df[row-1,"Rotation.3"]),
                                            c(dataM.df[row,"Rotation.1"], dataM.df[row,"Rotation.2"], dataM.df[row,"Rotation.3"]))
    }

    return(rbind(dataA.df,dataO.df,dataS.df,dataM.df))                                
}


#filterTime(18,tracking.df,task.df,"1")
tracking_clean.df <- data.frame()
## cleaning rows of task out
for(tid in unique(task.df$TaskID))
{
    for(id in unique(task.df$ID))
    {
        tracking_clean.df <- rbind(tracking_clean.df, filterTime(id,tracking.df,task.df,tid))
    }
}
