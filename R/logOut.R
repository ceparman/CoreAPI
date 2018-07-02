#' logOut -Log user out of the LIMS.
#'
#'\code{logOut} logs user out of the Core API
#'
#'@param coreApi coreApi object returned during log in
#'@param useVerbose use verbose option for debuggin in http POST
#'@return returns list with $success = TRUE when sucessful, $response contains the entire http response
#'@export
#'@examples
#'\dontrun{
#' api<-CoreAPIV::coreAPI("PATH TO JSON FILE")
#' response<- CoreAPIV::authBasic(api)
#' logOut <- CoreAPIV::logOut(response$coreApi,useVerbose=TRUE )
#' }
#'@author Craig Parman ngsAnalytics, ngsanalytics.com
#'@description \code{logOut} logs out of the current session.



### Log out

logOut <- function(coreApi, useVerbose = FALSE)

{
  request <-
    list(
      request = list(
        sdkCmd = jsonlite::unbox("sdk-logout"),
        typeParam = jsonlite::unbox("*"),
        data = NULL
      ),
      responseOptions = list()
    )

  headers <-
    c('Content-Type' = "application/json;odata.metadata=full", accept = "application/json")

  response <-
    CoreAPI::apiPOST(
      coreApi = coreApi,
      body = request,
      headers = headers,
      encode = "json",
      special = "login",
      useVerbose = useVerbose
    )


  list(success = httr::http_status(response)$category,
       response = response)



}
