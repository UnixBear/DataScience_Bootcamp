library(jsonlite) #importing jsonlite library to read json files
demo_table2 <- fromJSON(txt='01_Demo/demo.json') 
demo_table <- read.csv(file = '01_Demo/demo.csv', check.names = F, stringsAsFactors = F)
demo_table <- demo_table %>% mutate(Mileage_per_Year=Total_Miles/(2020-Year), IsActive=TRUE)
summarize_demo <- demo_table2 %>% group_by(condition) %>% summarize(Mean_Mileage=mean(odometer),Maximum_Price=max(price),Num_Vehicles=n(), .groups = 'keep') #create summary table with multiple columns
demo_table3 = read.csv("demo2.csv", check.names = F, stringsAsFactors = F)

#creating table where we smoosh the data into a thin but long table
#each row is only looking at 2 values each but there are many rows for
#the same vehicle comparing 2 values
long_table = demo_table3 %>% gather(key="Metric", value = "Score", buying_price:popularity)

#looking at the first 6 rows on the mpg dataset of cars that comes with R
head(mpg)

#creating a plot object using ggplot2 
#aes is the function that manages basic aesthetic considerations
#like the x-axist label and the y-axis label
plt <- ggplot(mpg, aes(x=class))
plt + geom_bar() #the ggplot object plus the geom_*() function actually draws the plot

#creating a summary table involves first grouping data by some column's variable.
#in this case we're grouping by manufacturer. The object created by the group_by
#function doesn't do much without being passed to summarize which gives us
#the metric in which the grouped data object can be compared, in this case it's
#the vehical count.  Essentially it's combining all the entries that share a
#manufacturer and counting (hence the n() function which aggregates observables)
#all the vehicles.  The .group argument is about how the grouped object is dealt
#with, like deep the grouping or discard it etc.  
mpg_summary <- mpg %>% group_by(manufacturer) %>% summarize(Vehicle_Count=n(), .groups = 'keep') #create summary table
plt <- ggplot(mpg_summary,aes(x=manufacturer,y=Vehicle_Count)) #import dataset into ggplot2
plt + geom_col() #plot a bar plot
plt + geom_col() + xlab("Manufacturing Company") + ylab("Number of Vehicles in Dataset") #plot bar plot with labels
plt + geom_col() + xlab("Manufacturing Company") + ylab("Number of Vehicles in Dataset") + theme(axis.text.x=element_text(angle=45,hjust=1)) #rotate the x-axis label 45 degrees
mpg_summary <- subset(mpg,manufacturer=="toyota") %>% group_by(cyl) %>% summarize(Mean_Hwy=mean(hwy), .groups = 'keep') #create summary table
plt <- ggplot(mpg_summary,aes(x=cyl,y=Mean_Hwy)) #import dataset into ggplot2
plt + geom_line() + scale_x_discrete(limits=c(4,6,8)) + scale_y_continuous(breaks = c(15:30)) #add line plot with labels
plt <- ggplot(mpg,aes(x=displ,y=cty)) #import dataset into ggplot2
plt + geom_point() + xlab("Engine Size (L)") + ylab("City Fuel-Efficiency (MPG)") #add scatter plot with labels

#here we use a unified label method "labs()" instead of an xlab and a ylab
plt <- ggplot(mpg,aes(x=displ,y=cty,color=class)) #import dataset into ggplot2
plt + geom_point() + labs(x="Engine Size (L)", y="City Fuel-Efficiency (MPG)", color="Vehicle Class") #add scatter plot with labels
#we can add something like size = cty to our ggplot declaration to set sizes of
#data points proportional to their city mpg

plt <- ggplot(mpg,aes(y=hwy)) #import dataset into ggplot2
plt + geom_boxplot() #add boxplot

#similar to above but this will compare two groups instead of one
plt <- ggplot(mpg,aes(x=manufacturer,y=hwy)) #import dataset into ggplot2
plt + geom_boxplot() + theme(axis.text.x=element_text(angle=45,hjust=1)) #add boxplot and rotate x-axis labels 45 degrees

#heatmap
mpg_summary <- mpg %>% group_by(class,year) %>% summarize(Mean_Hwy=mean(hwy), .groups = 'keep') #create summary table
plt <- ggplot(mpg_summary, aes(x=class,y=factor(year),fill=Mean_Hwy)) #import dataset into ggplot2
plt + geom_tile() + labs(x="Vehicle Class",y="Vehicle Year",fill="Mean Highway (MPG)") #create heatmap with labels
#juxtaposing model with year
mpg_summary <- mpg %>% group_by(model,year) %>% summarize(Mean_Hwy=mean(hwy), .groups = 'keep') #create summary table
plt <- ggplot(mpg_summary, aes(x=model,y=factor(year),fill=Mean_Hwy)) #import dataset into ggplot2
plt + geom_tile() + labs(x="Model", y="Vehicle Year", fill="Mean Highway (MPG)") + theme(axis.text.x=element_text(angle=90, hjust=1, vjust=0.5)) + scale_fill_distiller(palette = "RdPu") #rotate x-axis labels 90 degrees and add red/purple coloration

#There are two types of plot layers (combining plots into single visual:
  #1)Layering additional plots that use the same variables and input data as
    #the original plot
  #2)Layering of additional plots that use different but complementary data to 
    #the original plot

#recreate our previous boxplot example comparing the highway fuel 
#efficiency across manufacturers, add our data points using the geom_point() 
#function:
plt <- ggplot(mpg, aes(x=manufacturer, y=hwy)) #importing db into ggplot2
plt + geom_boxplot() + #add boxplot
  theme(axis.text.x=element_text(angle=45,hjust=1)) + #rotate x-axis labels 45 degrees
  geom_point() #overlay scatter plot on top

#mapping argument version
mpg_summary <- mpg %>% group_by(class) %>% summarize(Mean_Engine=mean(displ), .groups = 'keep') #create summary table
plt <- ggplot(mpg_summary,aes(x=class,y=Mean_Engine)) #import dataset into ggplot2
plt + geom_point(size=4) + labs(x="Vehicle Class",y="Mean Engine Size") #add scatter plot

#adding an errorbar function to see the upper and lower bounds of the std and
#adding a standard deviation engine
mpg_summary <- mpg %>% group_by(class) %>% summarize(Mean_Engine=mean(displ),SD_Engine=sd(displ), .groups = 'keep')
plt <- ggplot(mpg_summary,aes(x=class,y=Mean_Engine)) #import dataset into ggplot2
plt + geom_point(size=4) + labs(x="Vehicle Class",y="Mean Engine Size") + #add scatter plot with labels
geom_errorbar(aes(ymin=Mean_Engine-SD_Engine,ymax=Mean_Engine+SD_Engine)) #overlay with error bars

#preparing to use the facet() function to separate plots by reducing the amount
#of columns so we have less variables to consider
mpg_long <- mpg %>% gather(key="MPG_Type",value="Rating",c(cty,hwy)) #convert to long format
#or equivalently replacing gather() with pivot_longer()
mpg_long <- mpg %>% pivot_longer(c(cty,hwy), names_to = "MPG_Type", values_to = "Rating")
plt <- ggplot(mpg_long,aes(x=manufacturer,y=Rating,color=MPG_Type)) #import dataset into ggplot2 colored along miles per gallon types
plt + geom_boxplot() + theme(axis.text.x=element_text(angle=45,hjust=1)) #add boxplot with labels rotated 45 degrees
#to add a metric where we add manufacturer metrics to compare the MPGs, we use
#facet_wrap()
plt + geom_boxplot() + facet_wrap(vars(MPG_Type)) + #create multiple boxplots, one for each MPG type
  theme(axis.text.x=element_text(angle=45,hjust=1),legend.position = "none") + xlab("Manufacturer") #rotate x-axis labels

#attemp at juxtaposing different transmission types by year and seeing their city mpg change
mpg_summary_trans <- mpg %>% group_by(trans, year) %>% summarize(Mean_Cty=mean(cty), Mean_Hwy=mean(hwy), .groups = 'keep')
plt <- ggplot(mpg_summary_trans, aes(x=trans, y=factor(year), fill=Mean_Cty))
plt + geom_tile() + labs(x="Transmission Type", y="Year", fill="Mean City (MPG)") + theme(axis.text.x=element_text(angle=45, hjust=1))

#we can use the cor() function to produce a correlation matrix. A correlation 
#matrix is a lookup table where the variable names of a data frame are stored 
#as rows and columns, and the intersection of each variable is the corresponding
#Pearson correlation coefficient. We can use the cor() function to produce a 
#correlation matrix by providing a matrix of numeric vectors.

#if we want to produce a correlation matrix for our used_cars dataset, we would
#first need to select our numeric columns from our data frame and convert to a
#matrix. Then we can provide our numeric matrix to the cor() function
used_cars <- read.csv('used_car_data.csv')
used_matrix <- as.matrix(used_cars[,c("Selling_Price","Present_Price","Miles_Driven")]) #convert data frame into numeric matrix
cor(used_matrix)

#to get metrics for our model, we'll use lm() to construct the linear model.
lm(qsec ~ hp,mtcars) #create linear model
#based off this, the equation for the line is qsec = -0.02hp + 20.56

#To determine our p-value and our r-squared value for a simple linear regression
#model, we'll use the summary() function
summary(lm(qsec~hp,mtcars)) #summarize linear model
#since the multiple r^2 output was 0.5016 (~50%), it means that roughly 50% of
#the variablilty of our dependent variable (quarter-mile time predictions) is
#explained using this linear model.

#we need to calculate the data points to use for our line plot using our 
#lm(qsec ~ hp,mtcars) coefficients
model <- lm(qsec ~ hp,mtcars) #create linear model
yvals <- model$coefficients['hp']*mtcars$hp +
  model$coefficients['(Intercept)'] #determine y-axis values from linear model

#finally we plot
plt <- ggplot(mtcars,aes(x=hp,y=qsec)) #import dataset into ggplot2
plt + geom_point() + geom_line(aes(y=yvals), color = "red") #plot scatter and linear model
#Using our visualization in combination with our calculated p-value and r-squared value, we have determined that there is a significant relationship between horsepower and quarter-mile time.

#Although the relationship between both variables is statistically significant,
#this linear model is not ideal. According to the calculated r-squared value,
#using only quarter-mile time to predict horsepower is roughly as accurate as
#guessing using a coin toss. In other words, the variability we observed within
#our horsepower data must come from multiple sources of variance. To accurately
#predict future horsepower observations, we need to use a more robust model.
#To better predict the quarter-mile time (qsec) dependent variable, we can add
#other variables of interest such as fuel efficiency (mpg), engine size (disp),
#rear axle ratio (drat), vehicle weight (wt), and horsepower (hp) as independent
#variables to our multiple linear regression model.
lm(qsec ~ mpg + disp + drat + wt + hp,data=mtcars) #generate multiple linear regression model
# According to our results, vehicle weight and horsepower (as well as intercept)
#are statistically unlikely to provide random amounts of variance to the linear
#model. In other words the vehicle weight and horsepower have a significant
#impact on quarter-mile race time. When an intercept is statistically
#significant, it means that the intercept term explains a significant amount of
#variability in the dependent variable when all independent vairables are equal
#to zero. Despite the number of significant variables, the multiple linear
#regression model outperformed the simple linear regression. According to the
#summary output, the r-squared value has increased from 0.50 in the simple
#linear regression model to 0.71 in our multiple linear regression model while
#the p-value remained significant.

#If the success metric is numerical and the sample size is small, a z-score 
  #summary statistic can be sufficient to compare the mean and variability of
  #both groups.
#If the success metric is numerical and the sample size is large, a two-sample
  #t-test should be used to compare the distribution of both groups.
#If the success metric is categorical, you may use a chi-squared test to
  #compare the distribution of categorical values between both groups.
#please see: http://www.statsoft.com/Textbook/Power-Analysis
# and https://www.statisticssolutions.com/dissertation-resources/sample-size-calculation-and-sample-size-justification/statistical-power-analysis/
# for outlining how to perform power analysis
