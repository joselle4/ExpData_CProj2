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

# PLot 3: Of the four types of sources indicated by the 𝚝𝚢pe
# (point, nonpoint, onroad, nonroad) variable, which of these
# four sources have seen decreases in emissions from 1999–2008 
# for Baltimore City? Which have seen increases in emissions 
# from 1999–2008? Use the ggplot2 plotting system to make a plot 
# answer this question.

# subset Baltimore, Maryland
baltimore <- subset(NEI, fips == "24510")

# total the data by type and by year for faster processing
baltimoreByTypeYear <- aggregate(baltimore$Emissions, 
    by = list(baltimore$year, baltimore$type),
    FUN = sum)
names(baltimoreByTypeYear) <- c("Year", "Type", "Emissions")

# create plot and save as png
filePath <- paste0(getwd(), "/coursera/ExpData_CProj2/plot3.png")
gg <- ggplot(data = baltimoreByTypeYear, aes(x = Year, y = Emissions)) + 
    geom_bar(stat = "identity", aes(fill = Type), position = "dodge") + 
    facet_grid(. ~ Type) + geom_smooth(method = "lm", se = FALSE) + 
    ggtitle("Annual Baltimore Emissions by Type") + xlab("Year") + 
    theme(axis.text.x = element_text(angle = 90, hjust = 1))
ggsave(filename = filePath, plot = gg)
