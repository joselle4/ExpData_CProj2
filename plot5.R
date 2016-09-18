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

# plot 5: How have emissions from motor vehicle sources 
# changed from 1999–2008 in Baltimore City?

# subset motor vehicles using highway
hwySCC <- SCC[grepl("[Highway|highway]", SCC$Short.Name),]

# subset Baltimore, Maryland
baltimore <- subset(NEI, fips == "24510")

# merge data with highway data with baltimore data
baltimoreHwy <- merge(hwySCC, baltimore, by = "SCC")

# total emmissions for faster processing
totalBaltimoreHwy <- aggregate(baltimoreHwy$Emissions, 
    by = list(baltimoreHwy$year), FUN = sum)
names(totalBaltimoreHwy) <- c("Year", "Emissions")

# create plot and save as png
filePath <- paste0(getwd(), "/coursera/ExpData_CProj2/plot5.png")
gg <- ggplot(data = totalBaltimoreHwy, aes(x = as.character(Year), y = Emissions)) + 
    geom_bar(stat = "identity", aes(fill = Year)) + xlab("Year") + 
    ggtitle("Annual Motor Vehicle Emissions") 
ggsave(filename = filePath, plot = gg)