entropy <- function(p1){
  p2 = 1 - p1
  -(p1*log2(p1) + p2*log2(p2))
}

error <- seq(0,1,.01)
caps <- NULL
for(i in 1:length(error)){
  e <- error[i]
  caps[i] <- 1 - entropy((2*e - 2*e^2))
  
}
plot(error,caps)