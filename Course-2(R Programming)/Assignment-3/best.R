# Define the function 'best'
best <- function(state, outcome) {
  # Read the csv file into a data frame
  dat <-  read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  # Check if the state is valid
  if(!(state %in% unique(dat$State))){
    stop("Invalid state")
  }
  
  # Determine the column number based on the outcome
  colnum<-(-1)
  if (outcome  == "heart attack") {
    colnum<-11
  }
  else if (outcome  == "heart failure") {
    colnum<-17
  } 
  else if (outcome  == "pneumonia"){
    colnum<-23
  }
  else{
    stop("Invalid outcome")
  }
  
  # Convert the column to numeric and remove NA values
  dat[, colnum] <- as.numeric(dat[, colnum])
  dat <- na.omit(dat)
  
  # Filter the data for the given state
  tempdat<-dat[dat$State == state,]
  
  # Find the row(s) with the minimum value in the specified column
  ans<-tempdat[tempdat[,colnum]==min(tempdat[,colnum]),]
  
  # Sort the result by hospital name and select the first one
  ans <- ans[order(ans$Hospital.Name), ]$Hospital.Name
  head(ans,1)
}

# Test the function with an example
best("TX", "heart attack")
