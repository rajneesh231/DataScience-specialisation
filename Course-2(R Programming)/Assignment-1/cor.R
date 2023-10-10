# Define the file path where all the .csv files are stored
path <- ''

# Function to calculate the mean of a pollutant across a set of monitors
pollutantmean <- function(directory, pollutant, id = 1:332) {
  finaldat <- NULL
  # Loop over each monitor
  for (i in id) {
    i <- sprintf("%03d", i) # Format the monitor id to have three digits
    # Read the data for the current monitor
    tempdat <- read.csv(paste(path, "\\", i, ".csv", sep = ""))
    # Combine the data for the current monitor with the data from previous monitors
    finaldat <- c(finaldat, tempdat[,pollutant])
  }
  # Calculate and return the mean of the pollutant, ignoring NA values
  mean(finaldat, na.rm = TRUE)
}

# Function to count the number of complete cases in each monitor
complete<-function(directory, id=1:332){
  df<-data.frame(id=integer(),nobs=integer())
  
  # Loop over each monitor
  for(i in id){
    i <- sprintf("%03d", i) # Format the monitor id to have three digits
    # Read the data for the current monitor
    tempdat <- read.csv(paste(path, "\\", i, ".csv", sep = ""))
    cleanf<-na.omit(tempdat) # Remove rows with NA values
    tempnobs<-nrow(cleanf) # Count the number of complete cases
    # Add the monitor id and number of complete cases to the data frame
    df<-rbind(df,data.frame(id = as.numeric(i),nobs = tempnobs))
  }
  df # Return the data frame
}

# Function to calculate correlation between sulfate and nitrate for monitors with enough complete cases
corr<- function(dir,threshold=0){
  finalCor<-c() # Initialize a vector to store correlation coefficients
  
  # Loop over each monitor
  for(i in 1:332){
    i <- sprintf("%03d", i) # Format the monitor id to have three digits
    # Read the data for the current monitor
    tempdat <- read.csv(paste(path, "\\", i, ".csv", sep = ""))
    tempdat<-na.omit(tempdat) # Remove rows with NA values
    
    # If the monitor has more than 'threshold' complete cases,
    if(complete("specdata", c(as.numeric(i)))$nobs>threshold){
      # calculate correlation between sulfate and nitrate and add it to 'finalCor'
      finalCor<-c(finalCor,cor(tempdat$nitrate,tempdat$sulfate))
    }
  }
  finalCor # Return 'finalCor'
}

# Test 'corr' function with threshold of 400 complete cases
cr <- corr("specdata", 400)
head(cr)
