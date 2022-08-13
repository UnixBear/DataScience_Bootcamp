library(dplyr)
library(ggplot2)
population_table <- read.csv('used_car_data.csv',check.names = F,stringsAsFactors = F) #import used car dataset
plt <- ggplot(population_table,aes(x=log10(Miles_Driven))) #import dataset into ggplot2
plt + geom_density() #visualize distribution using density plot

#Now that we characterized our population data using our density plot, we'll create a sample dataset using dplyr's sample_n() function.
#It should give us a random sample dataset from our population data that contains minimal bias and (ideally) represents the population data.
sample_table <- population_table %>% sample_n(50) #randomly sample 50 data points
plt <- ggplot(sample_table,aes(x=log10(Miles_Driven))) #import dataset into ggplot2
plt + geom_density() #visualize distribution using density plot

#we want to test if the miles driven from our previous sample dataset is statistically different from the miles driven in our population data, we would use our t.test()function as follows
t.test(log10(sample_table$Miles_Driven),mu=mean(log10(population_table$Miles_Driven))) #compare sample versus population means

#let's test whether the mean miles driven of two samples from our used car dataset are statistically different
sample_table <- population_table %>% sample_n(50) #generate 50 randomly sampled data points
sample_table2 <- population_table %>% sample_n(50) #generate another 50 randomly sampled data points
t.test(log10(sample_table$Miles_Driven),log10(sample_table2$Miles_Driven)) #compare means of two samples

#paired t-tests using mpg_modified.csv that is modified to pair each 1998 
#vehicles with a 2008 vehicle
mpg_data <- read.csv('mpg_modified.csv') #import dataset
mpg_1999 <- mpg_data %>% filter(year==1999) #select only data points where the year is 1999
mpg_2008 <- mpg_data %>% filter(year==2008) #select only data points where the year is 2008
t.test(mpg_1999$hwy,mpg_2008$hwy,paired = T) #compare the mean difference between two samples

#To practice our one-way ANOVA, return to the mtcars dataset. For this 
#statistical test, we'll answer the question, "Is there any statistical 
#difference in the horsepower of a vehicle based on its engine type?"
mtcars_filt <- mtcars[,c("hp","cyl")] #filter columns from mtcars dataset
mtcars_filt$cyl <- factor(mtcars_filt$cyl) #convert numeric column to factor
aov(hp ~ cyl,data=mtcars_filt) #compare means across multiple levels