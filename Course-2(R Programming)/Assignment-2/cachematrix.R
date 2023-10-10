## Put comments here that give an overall description of what your
## functions do

## Write a short comment describing this function
# This function return four functions and helps cache the inverse of matrix. 
# The functions can be accesed with $.
makeCacheMatrix <- function(X = matrix()) {
  m <- NULL
  set <- function(y) {
    X <<- y
    m <<- NULL
  }
  
  get <- function() X
  setinverse <- function(inv) m <<- inv
  getinverse <- function() m
  
  list(
    set = set,
    get = get,
    setinverse = setinverse,
    getinverse = getinverse
  )
}


## Write a short comment describing this function
# Gets the cached matrix if it is present. otherwise, calculates it matrix and 
# caches it.
cacheSolve <- function(X, ...) {
  m <- X$getinverse()
  if(!is.null(m)) {
    message("getting cached data")
    return(m)
  }
  data <- x$get()
  m <- solve(data, ...)
  X$setinverse(m)
  m
        ## Return a matrix that is the inverse of 'x'
}
