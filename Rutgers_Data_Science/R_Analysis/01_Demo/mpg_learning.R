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
