#'Log user out of the LIMS
#'
#'\code{logOut} logs user out of the LIMS using Core API
#'
#'@param coreApi coreApi object returned during log in
#'@param useVerbose use verbose option for debuggin in http POST
#'@return returns list with $success = TRUE when sucessful, $response contains the entire http response
#'@export
#'@examples
#'\dontrun{
#' response<- CoreAPI::authBasic(coreapi,pwd)
#'
#' logOut(response$coreApi,useVerbose=FALSE )}
#'@author Craig Parman
#'@description \code{logOut} logs out of the current jsession.


### Log out
#
logOut<-function(coreApi, useVerbose = FALSE)

{

  log_out_url<-paste(coreApi$coreUrl,"/sdklogin",";jsessionid=",coreApi$jsessionId,sep="")


  request<-list(request=list(data=list(),typeParam =jsonlite::unbox("*"), sdkCmd =jsonlite::unbox("sdk-logout")))


  response<-httr::POST(log_out_url,body = request, encode="json",
                       httr::verbose(data_out = useVerbose, data_in = useVerbose, info = useVerbose, ssl = useVerbose))


  list(success= httr::http_status(response)$category,response=response)



}


# r<-authBasic(coreUrl,user,pwd)
#
# logOut(coreUrl,r$sessionInfo$jessionid)
#

