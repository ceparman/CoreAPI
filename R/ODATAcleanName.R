#' ODATAcleanName - converts names to ODATA compliant version. Used to clean names in ODATA calls.
#'
#' \code{ODATAcleanName} Clean a name for ODATA.
#' @param name  string to clean 
#' @export
#' @return Returns name in ODATA compliant form
#' @examples
#'\dontrun{
#' new_name <-CoreAPIV2::ODATAcleanName("384 Well Plate")
#' new_name
#' _384_WELL_PLATE
#'  }
#'@author Craig Parman ngsAnalytics, ngsanalytics.com
#'@description \code{ODATAcleanName} - converts names to ODATA compliant version. Used to clean names in ODATA calls.



ODATAcleanName <- function(name)
{
  name <- gsub("(^[1-9])", "_\\1", name)
  
  name <- gsub(" ", "_", name)
  
  
  name
  
  
}