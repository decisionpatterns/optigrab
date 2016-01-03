#' optigrab options
#' 
#' Options to control optigrab behaviors
#' 
#' @details 
#' 
#' \code{use.verb} tell optigrab that a verb is required
use.verb <- function() options( optigrab.verb = TRUE )


multiple.verbs <- function() { 
  options( optigrab.verb = TRUE, optigrab.multiple.verbs = TRUE )  
}

use.targets <- function() options( optigrab.targets = TRUE )

makeActiveBinding("fun",use.targets,  .GlobalEnv)

options( optigrab.allow_multiple_verbs = FALSE )
