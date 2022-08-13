mechaCarMpg <- read.csv("MechaCar_mpg.csv", stringsAsFactors = F) #Loading mpg dataset
library(dplyr) #imporing dplyr library
mechaLinear <- lm(mpg ~ vehicle_length + vehicle_weight + spoiler_angle + ground_clearance + AWD, mechaCarMpg) #creating linear model
mechaPvals <- temp$coefficients[,4]
summary(mechaLinear)

suspensionCoil <- read.csv("Suspension_Coil.csv", stringsAsFactors = F) #Loading suspension coil dataset
total_summary <- suspensionCoil %>% summarize(Mean=mean(PSI), Median=median(PSI),Variance=var(PSI), StdDev=sd(PSI)) #Create basic summary dataframe
lot_summary <- suspensionCoil %>% group_by(Manufacturing_Lot) %>% summarize(Mean=mean(PSI), Median=median(PSI),Variance=var(PSI), StdDev=sd(PSI)) #create summary dataframe per lot

t.test(suspensionCoil$PSI, mu=1500) #t test all with a mean of 1500
lot1 <- subset(suspensionCoil, Manufacturing_Lot == 'Lot1') #creating a set of vehicles from lot 1
lot2 <- subset(suspensionCoil, Manufacturing_Lot == 'Lot2') #creating a set of vehicles from lot 2
lot3 <- subset(suspensionCoil, Manufacturing_Lot == 'Lot3') #creating a set of vehicles from lot 3
t.test(lot1$PSI, mu=1500)
t.test(lot2$PSI, mu=1500)
t.test(lot3$PSI, mu=1500) # t tests on all three lots