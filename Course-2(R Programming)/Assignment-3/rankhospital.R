# Define the function rankhospital
rankhospital <- function(state, outcome, num = "best") {
  # Read the csv file into a data frame
  dat <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  # Check if the state is valid
  if (!(state %in% unique(dat$State))) {
    stop("Invalid state")
  }
  
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
  
  # Filter the data for the given state and sort it
  tempdat <- dat[dat$State == state, ]
  tempdat <- tempdat[order(tempdat[, colnum],tempdat$Hospital.Name),]
  
  # Determine the hospital name based on the num parameter
  if (num == "best") {
    ans <- tempdat[1, ]$Hospital.Name
  }
  else if (num == "worst") {
    ans <- tail(tempdat, n =1)$Hospital.Name
  }
  else if(num>nrow(tempdat)){
    return(NA)
  }
  else{
    ans <- tempdat[num, ]$Hospital.Name
  }
  
  # Return the hospital name
  ans
  
}

