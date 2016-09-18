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

# plot 6: Compare emissions from motor vehicle sources 
# in Baltimore City with emissions from motor vehicle 
# sources in Los Angeles County, California 
# (𝚏𝚒𝚙𝚜 == "𝟶𝟼𝟶𝟹𝟽"). Which city has seen
# greater changes over time in motor vehicle emissions?

# subset motor vehicles using highway
hwySCC <- SCC[grepl("[Highway|highway]", SCC$Short.Name),]

# subset Baltimore, Maryland
baltimoreLA <- subset(NEI, fips == "24510" | fips == "06037")

# merge data with highway data with baltimore data
baltimoreLAHwy <- merge(hwySCC, baltimoreLA, by = "SCC")

# total emmissions for faster processing
totalBaltimoreLAHwy <- aggregate(baltimoreLAHwy$Emissions, 
    by = list(baltimoreLAHwy$year, baltimoreLAHwy$fips), 
    FUN = sum)
names(totalBaltimoreLAHwy) <- c("Year", "fips", "Emissions")

# define cities
city <- data.frame(c("06037", "24510"), c("LA", "Baltimore"))
names(city) <- c("fips", "City")

# merge with totalBaltimoreLAHwy
totalBaltimoreLAHwy <- merge(totalBaltimoreLAHwy, city, by = "fips")

# create plot and save as png
filePath <- paste0(getwd(), "/coursera/ExpData_CProj2/plot6.png")
gg <- ggplot(data = totalBaltimoreLAHwy, aes(x = as.character(Year), y = Emissions)) + 
    geom_bar(stat = "identity", aes(fill = City), position = "dodge") + xlab("Year") + 
    ggtitle("Baltimore & LA Annual Motor Vehicle Emissions") 
ggsave(filename = filePath, plot = gg)