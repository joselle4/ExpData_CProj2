# data sources:
# PM2.5 Emissions Data (𝚜𝚞𝚖𝚖𝚊𝚛𝚢𝚂𝙲𝙲_𝙿𝙼𝟸𝟻.𝚛𝚍𝚜)
# Source Classification Code Table 
# (𝚂𝚘𝚞𝚛𝚌𝚎_𝙲𝚕𝚊𝚜𝚜𝚒𝚏𝚒𝚌𝚊𝚝𝚒𝚘𝚗_𝙲𝚘𝚍𝚎.𝚛𝚍𝚜)

# use: data frame with all of the PM2.5 emissions data 
# for 1999, 2002, 2005, and 2008

# load library
library(ggplot2)

# set directories:
fileNEI <- paste0(getwd(), "/coursera/exdata-data-NEI_data/summarySCC_PM25.rds")
fileSCC <- paste0(getwd(), "/coursera/exdata-data-NEI_data/Source_Classification_Code.rds")

# read data:
NEI <- readRDS(fileNEI)
SCC <- readRDS(fileSCC)

# plot 4 Across the United States, how have emissions from coal 
# combustion-related sources changed from 1999–2008?

# subset coal combustion-related sources only
coalSCC <- SCC[grepl("[Coal|coal|COAL]", SCC$Short.Name),]

# merge data with NEI
coalNEI <- merge(NEI, coalSCC, by = "SCC")

# total emmissions for faster processing
totalCoalNEI <- aggregate(coalNEI$Emissions, 
    by = list(coalNEI$year), FUN = sum)
names(totalCoalNEI) <- c("Year", "Emissions")

# create plot and save as png
filePath <- paste0(getwd(), "/coursera/ExpData_CProj2/plot4.png")
gg <- ggplot(data = totalCoalNEI, aes(x = as.character(Year), y = Emissions)) + 
    geom_bar(stat = "identity", aes(fill = Year)) + xlab("Year") + 
    ggtitle("Annual Coal Combustion-Related Emissions") 
ggsave(filename = filePath, plot = gg)

#gg <- ggplot(data = totalCoalNEI, aes(x = Year, y = Emissions)) + 
#    geom_point() + ggtitle("Annual Coal Combustion-Related Emissions") 
#ggsave(filename = filePath, plot = gg)
#filePath <- paste0(getwd(), "/coursera/ExpData_CProj2/plot4.1.png")
