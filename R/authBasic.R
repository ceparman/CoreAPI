#'Authenticates against the LIMS using basic authentication
#'
#'\code{authBasic} authenticates to Core API
#'
#'@param coreUrl character string that is the url of LIMS
#'@param user character string that is username
#'@param pwd character string that is password
#'@param account character string that is the account to log into for multi tenant systems
#'@param useVerbose TRUE or FALSE to indicate if verbose options should be used in http POST
#'@return returns a list $sessionInfo contains jsessionid and employeeid, $response contains the entire http response
#'@export
#'@examples
#'\dontrun{
#' response<- CoreAPI::authBasic(coreUrl,user,pwd)
#' js<-response$sessionInfo$jessionid
#' logOut(coreUrl,js,postVerbose=FALSE )}
#'@author Craig Parman
#'@description \code{logOut} Logs in and create a jsession using a username and password..



authBasic<-function(coreUrl,user,pwd,account=NULL,useVerbose=FALSE)

{

  if (is.null( account))
      { request<-list(request=list(data=list(lims_userName = jsonlite::unbox(user),
                                           lims_password=jsonlite::unbox(pwd)),typeParam =jsonlite::unbox("*"), sdkCmd =jsonlite::unbox("sdk-login")))

  } else  { accountObject<-list("entityID" = jsonlite::unbox(""), "barcode" = jsonlite::unbox(""),"name" = jsonlite::unbox(account))

     request<-list(request=list(data=list(lims_userName = jsonlite::unbox(user),
                                    lims_password=jsonlite::unbox(pwd),accountRef = accountObject),typeParam =jsonlite::unbox("*"), sdkCmd =jsonlite::unbox("sdk-login")))

  }

   login_url<-paste(coreUrl,"/sdklogin",sep="")

   response<-httr::POST(login_url,body = request, encode="json",
                        httr::verbose(data_out = useVerbose, data_in = useVerbose, info = useVerbose, ssl = useVerbose))



getSession<-function(response){

  #jessionid<-  httr::cookies(response)[which(httr::cookies(response)[,6] == "JSESSIONID"),7]
  jessionid<-  httr::content(response)$response$data$jsessionid
  awselb<- httr::cookies(response)[which(httr::cookies(response)[,6] == "AWSELB"),7]
  if (length(awselb) == 0) {awselb <- NULL}
  employeeId<- httr::content(response)$response$data$ employeeId
   list( jessionid = jessionid, awselb = awselb ,employeeId =employeeId)
}

if(httr::http_error(response)) {

stop(
  {print("API call failed")
  print( httr::http_status(response))
   },
    call.=FALSE
)

}


session<-tryCatch(getSession(response), error = function(e) { list( "jessionid" = NULL, "employeeId" =  NULL )}
          )

list(sessionInfo=session,response=response)

}
