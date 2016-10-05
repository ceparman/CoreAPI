#'authBasic - Authenticates against the LIMS using basic authentication.
#'
#'\code{authBasic} Authenticates to Core API
#'
#'@param coreApi object of class coreApi that contains user, password,  baseURL and
#'        account. account is required if user has access to multiple tenants.
#'@param useVerbose - Use verbose settings for HTTP commands
#'@return returns a list with coreApi which returns the passed coreApi object with  jsessionid,
#'            awselb and employeeid populated, $response contains the entire http response
#'@export
#'@examples
#'\dontrun{
#' api<-CoreAPI("PATH TO JSON FILE")
#' response<- CoreAPI::authBasic(api)
#' logOut(response$coreApi,useVerbose=TRUE )
#'}
#'@author Craig Parman
#'@description \code{authBasic} Logs in and returns a fully populated coreApi object in $coreAPI.



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


  #need special URL for login

  #login_url<-paste(coreApi$coreUrl,"/sdklogin",sep="")

#  response<-httr::POST(login_url,body = request, encode="json",
#                       httr::verbose(data_out = useVerbose, data_in = useVerbose, info = useVerbose, ssl = useVerbose))


  response<- CoreAPI::apiCall(coreApi,request,"json",useVerbose=useVerbose,special="login")



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



if(!is.null( session$jsessionid)) coreApi$jsessionId <-session$jsessionid
if(!is.null( session$awselb)) coreApi$awselb <- session$awselb
if(!is.null( session$employeeId)) coreApi$employeeId <- session$employeeId


list(coreApi=coreApi,response=response)

}
