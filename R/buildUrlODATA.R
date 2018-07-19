#' buildUrlODATA - build URL for call to Core ODATA API.
#'
#' \code{buildUrlODATA}  build URL for call to Core ODATA API.
#' @param coreApi coreApi object with valid jsessionid
#' @param resource resource path (required except for special requests)
#' @param query and additional property options (optional)
#' @param special flag for special sdk endpoints
#' @param useVerbose Use verbose communication for debugging
#' @export
#' @return RETURN Core REST URL
#' @examples
#'\dontrun{
#' api<-CoreAPI("PATH TO JSON FILE")
#' login<- CoreAPI::authBasic(api)
#' response <-CoreAPI::buildUrlODATA(coeApi,"Sample","('PS1')")
#' logOut(login$coreApi )
#' }
#'@author Craig Parman ngsAnalytics, ngsanalytics.com
#'@description \code{buildUrlODATA} build URL for call to Core REST API.





buildUrlODATA <-
  function(coreApi,
           resource = NULL,
           query = NULL,
           special = NULL,
           useVerbose = FALSE)
  {
    
    #Concat account and odata
    if (!is.null(coreApi$account) && is.null(coreApi$TenantShortName)){
      odat <- paste0("/", ODATAcleanName(coreApi$account), "/odata/")
    }else if (!is.null(coreApi$TenantShortName)){
      odat <- paste0("/", ODATAcleanName(coreApi$TenantShortName), "/odata/")
      }else{ 
      odat <- "/odata/" 
    }
    
    
    if (is.null(special)) {
      sdk_url <-
        paste(
          coreApi$scheme,
          "://",
          coreApi$coreUrl,
          ":",
          coreApi$port,
          odat,
          resource,
          query,
          sep = ""
        )
      
    } else {
      switch(
        special,
        login = sdk_url <-
          paste(
            coreApi$scheme,
            "://",
            coreApi$coreUrl,
            ":",
            coreApi$port,
            "/odatalogin",
            sep = ""
          ),
        file = sdk_url <-
          paste0(
            coreApi$scheme,
            "://",
            coreApi$coreUrl,
            ":",
            coreApi$port,
            "/sdk"
          ),
        json = sdk_url <-
          paste0(
            coreApi$scheme,
            "://",
            coreApi$coreUrl,
            ":",
            coreApi$port,
            "/sdk"
          )
        
        
      )
    }
    
    return(sdk_url)
    
  }
