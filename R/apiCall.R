#' apiCall - Base call to Core REST API.
#'
#' \code{apiCall}  base call to Core REST API.
#' @param coreApi coreApi object with valid jsessionid
#' @param body body for request
#' @param encode encodeing to use for request option are "multipart", "form", "json", "raw"
#' @param special - pased to buildUrl for special sdk endpoints
#' @param useVerbose  Use verbose communitcation for debugging
#' @export
#' @return RETURN return the entire http response
#' @examples
#'\dontrun{
#' api<-CoreAPI("PATH TO JSON FILE")
#' login<- CoreAPI::authBasic(api)
#' response <-CoreAPI::apiCall(login$coreApi,body,"json",,special=NULL,useVerbose=FALSE)
#' logOut(login$coreApi )
#' }
#'@author Craig Parman
#'@description \code{apiCall}  base call to Core REST API.



apiCall<-function(coreApi,body,encode,special=NULL,useVerbose=FALSE)
{
#Check that encode parameter is proper

   if ( !(encode %in% c("multipart", "form", "json", "raw"))) {
        stop(
          {print("encode parameter not recognised")
            print( httr::http_status(response))
          },
          call.=FALSE
        )

   }



sdk_url<-  CoreAPI::buildUrl(coreApi,special,useVerbose=useVerbose)


response<-httr::POST(sdk_url,body = body, encode=encode,
                     httr::verbose(data_out = useVerbose, data_in = useVerbose, info = useVerbose, ssl = useVerbose))

#check for general HTTP error in response

if(httr::http_error(response)) {

  stop(
    {print("API call failed")
      print( httr::http_status(response))
    },
    call.=FALSE
  )


}

return(response)
}
