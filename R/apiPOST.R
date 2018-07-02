#' apiPOST - Do a POST to the Core ODATA REST API.
#'
#' \code{apiPOST}  Do a POST to the Core ODATA REST API.
#' @param coreApi coreApi object with valid jsessionid
#' @param resource entity type for POST
#' @param body body for request
#' @param encode encode type must be "multipart", "form", "json", "raw"
#' @param headers  headers to be added to get.
#' @param special  passed to buildUrl for special sdk endpoints
#' @param useVerbose  Use verbose communication for debugging
#' @export
#' @return Returns the entire http response
#' @examples
#'\dontrun{
#' api<-CoreAPI::CoreAPI("PATH TO JSON FILE")
#' login<- CoreAPI::authBasic(api)
#' response <-CoreAPI::apiPOST(login$coreApi,"SAMPLE",body,"json",special=NULL,useVerbose=FALSE)
#' message <- httr::content(response)
#' error <- httr::http_error(response)
#' CoreAPI::logOut(login$coreApi )
#' }
#'@author Craig Parman ngsAnalytics, ngsanalytics.com
#'@description \code{apiPOST} - Base call to Core ODATA REST API.




apiPOST <-
  function(coreApi,
           resource = NULL,
           body = NULL,
           encode,
           headers = NULL,
           special = NULL,
           useVerbose = FALSE)
  {
    #clean the resource name for ODATA

    resource <- CoreAPI::ODATAcleanName(resource)


    #Check that encode parameter is proper

    if (!(encode %in% c("multipart", "form", "json", "raw"))) {
      stop({
        print("encode parameter not recognized")
        print(httr::http_status(response))
      },
      call. = FALSE)

    }



    sdk_url <-
      CoreAPI::buildODATAUrl(
        coreApi,
        resource = resource,
        special = special,
        useVerbose = useVerbose
      )

    cookie <-
      c(JSESSIONID = coreApi$jsessionId,
        AWSELB = coreApi$awselb)

    response <-
      invisible(
        httr::POST(
          sdk_url,
          resource = resource,
          body = body,
          encode = encode,
          httr::add_headers(headers),
          httr::set_cookies(cookie),
          httr::verbose(
            data_out = useVerbose,
            data_in = useVerbose,
            info = useVerbose,
            ssl = useVerbose
          )
        )
      )






    #check for general HTTP error in response

    if (httr::http_error(response)) {
      stop({
        print("API call failed")
        print(httr::http_status(response))
      },
      call. = FALSE)


    }

    return(response)
  }
