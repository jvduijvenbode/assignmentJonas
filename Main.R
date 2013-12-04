
# Metadata ----------------------------------------------------------------

#Name: Plot population per degree (Long or LAT) for years between 1850 and 2100
#Author: Jonas van Duijvenbode
#Date: 05-12-2013
# Required R-version: 3.0.2


# Description -------------------------------------------------------------

# This script will visualize the population for different years between 1950 and 2100 for 
# the degrees in latitude or longitude of the earth.


#Note that it is required to manually go to Session->Set working directory-> Click To source File Location
rm(list = ls())
# Set Parameters ----------------------------------------------------------
# set orientation to LONG (population per longitude degree) or LAT (per latitude degree)
orient="LONG"
#set the years to be plotted, must be between 1950 and 2100. TIP: Don't make it more than 3 or it becomes unreadable
years=c(2010)
#set if the population should be showed as absolute numbers ("total") or as a percentage ("percentage") of the total population
SettingY="percentage"


# Run the script ----------------------------------------------------------

source("LoadPackages.R", chdir = TRUE)
source("LoadFunctions.R", chdir = TRUE)
source("DownloadNLoadData.R", chdir = TRUE)
source("RunModel.R", chdir = TRUE)
source("PlotResults.R", chdir = TRUE)

