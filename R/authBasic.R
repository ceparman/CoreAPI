#'Authenticates against the LIMS using basic authentication
#'
#'\code{authBasic} authenticates to Core API
#'
#'@param coreApi object of class coreApi that contains user, password,  baseURL and account(optional)
#'@param useVerbose - Use verbose setting for HTTP commands
#'@return { returns a list $coreApi which retuned passed coreApi object with  jsessionid, \cr
#'            awselb and employeeid populated, $response contains the entire http response \cr
#'         }
#'
#'@export
#'@examples
#'\dontrun{
#' response<- CoreAPI::authBasic(coreUrl,user,pwd)
#' js<-response$sessionInfo$jessionid
#' logOut(coreUrl,js,postVerbose=FALSE )}
#'@author Craig Parman
#'@description \code{logOut} Logs in and create a jsession using a username and password..



authBasic<-function(coreApi,useVerbose=FALSE)

{

  if (is.null( coreApi$account))
      { request<-list(request=list(data=list(lims_userName = jsonlite::unbox(coreApi$user),
                                           lims_password=jsonlite::unbox(coreApi$pwd)),
                                          typeParam =jsonlite::unbox("*"), sdkCmd =jsonlite::unbox("sdk-login")))

  } else  { accountObject<-list("entityID" = jsonlite::unbox(""), "barcode" = jsonlite::unbox(""),
            "name" = jsonlite::unbox(coreApi$account))

     request<-list(request=list(data=list(lims_userName = jsonlite::unbox(coreApi$user),
                                    lims_password=jsonlite::unbox(coreApi$pwd),accountRef = accountObject),typeParam =jsonlite::unbox("*"), sdkCmd =jsonlite::unbox("sdk-login")))

  }

   login_url<-paste(coreApi$coreUrl,"/sdklogin",sep="")

   response<-httr::POST(login_url,body = request, encode="json",
                        httr::verbose(data_out = useVerbose, data_in = useVerbose, info = useVerbose, ssl = useVerbose))



getSession<-function(response){

  #jsessionid<-  httr::cookies(response)[which(httr::cookies(response)[,6] == "JSESSIONID"),7]
  jsessionid<-  httr::content(response)$response$data$jsessionid
  awselb<- httr::cookies(response)[which(httr::cookies(response)[,6] == "AWSELB"),7]
  if (length(awselb) == 0) {awselb <- NULL}
  employeeId<- httr::content(response)$response$data$ employeeId
   list( jsessionid = jsessionid, awselb = awselb ,employeeId =employeeId)
}

if(httr::http_error(response)) {

stop(
  {print("API call failed")
  print( httr::http_status(response))
   },
    call.=FALSE
)

}


session<-tryCatch(getSession(response), error = function(e) { list( "jsessionid" = NULL, "employeeId" =  NULL )}
          )



coreApi$jsessionId <-session$jsessionid
coreApi$awselb <- session$awselb
coreApi$employeeId <- session$employeeId

list(coreApi=coreApi,response=response)

}
