# Define the function 'rankall'
rankall <- function(outcome, num = "best") {
  # Initialize a data frame to store the results
  df <- data.frame(hospital=character(), state=character())
  
  # Read the csv file into a data frame
  dat <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  # Get the unique states
  states <- unique(dat$State)
  
  # Determine the column number based on the outcome
  colnum <- (-1)
  if (outcome  == "heart attack") {
    colnum <- 11
  }
  else if (outcome  == "heart failure") {
    colnum <- 17
  }
  else if (outcome  == "pneumonia") {
    colnum <- 23
  }
  else{
    stop("Invalid outcome")
  }
  
  # Convert the column to numeric and remove NA values
  dat[, colnum] <- as.numeric(dat[, colnum])
  dat <- na.omit(dat)
  
  # Loop over each state
  for(sta in states){
    # Filter the data for the current state and sort it
    tempdat <- dat[dat$State == sta, ]
    tempdat <- tempdat[order(tempdat[, colnum],tempdat$Hospital.Name),]
    
    # Determine the hospital name based on the num parameter
    if (num == "best") {
      hospitalName <- tempdat[1, ]$Hospital.Name
    }
    else if (num == "worst") {
      hospitalName <- tail(tempdat, n =1)$Hospital.Name
    }
    else if(num<=nrow(tempdat)){
      hospitalName <- tempdat[num, ]$Hospital.Name
      
    }
    else{
      hospitalName<- NA
    }
    
    # Add the hospital name and state to the result data frame
    df<-rbind(df,data.frame(hospital = hospitalName,state = sta))
  
  }
  
  # Sort the result data frame by state and return it
  df<-df[order(df[,"state"]),]
 df
}

r <- rankall("heart attack", 4)
as.character(subset(r, state == "HI")$hospital)

