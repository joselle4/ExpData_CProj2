# data sources:
# PM2.5 Emissions Data (𝚜𝚞𝚖𝚖𝚊𝚛𝚢𝚂𝙲𝙲_𝙿𝙼𝟸𝟻.𝚛𝚍𝚜)
# Source Classification Code Table 
# (𝚂𝚘𝚞𝚛𝚌𝚎_𝙲𝚕𝚊𝚜𝚜𝚒𝚏𝚒𝚌𝚊𝚝𝚒𝚘𝚗_𝙲𝚘𝚍𝚎.𝚛𝚍𝚜)

# use: data frame with all of the PM2.5 emissions data 
# for 1999, 2002, 2005, and 2008

# set directories:
fileNEI <- paste0(getwd(), "/coursera/exdata-data-NEI_data/summarySCC_PM25.rds")
fileSCC <- paste0(getwd(), "/coursera/exdata-data-NEI_data/Source_Classification_Code.rds")

# read data:
NEI <- readRDS(fileNEI)
SCC <- readRDS(fileSCC)

# PLot 1: Have total emissions from PM2.5 decreased in the 
# United States from 1999 to 2008? Using the base plotting 
# system, make a plot showing the total PM2.5 emission from 
# all sources for each of the years 1999, 2002, 2005, and 2008.

# sum data by year
TotalEmissionsByYear <- aggregate(NEI$Emissions, 
                                  by = list(NEI$year), 
                                  FUN = sum)

# create plot and save as png
filePath <- paste0(getwd(), "/coursera/ExpData_CProj2/plot1.png")
png(filePath, width = 480, height = 480, units = "px")
plot(TotalEmissionsByYear[ ,1], TotalEmissionsByYear[ ,2], 
     xlab = "Year", ylab = "Total PM2.5 Emmisions", 
     main = "Total PM2.5 Emmisions by Year")
# add trendline to show annual decrease in emmision
abline(lm(TotalEmissionsByYear[ ,2] ~ TotalEmissionsByYear[ ,1]))
dev.off()
