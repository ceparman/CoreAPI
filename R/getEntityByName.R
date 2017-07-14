#' getEntityByName - Get an entity from the LIMS by name.
#'
#'\code{getEntityByName} get an entity from the LIMS by name
#'
#'@param coreApi coreApi object with valid jsessionid
#'@param entityType entity type to get
#'@param name name of entity to get
#'@param useVerbose TRUE or FALSE to indicate if verbose options should be used in http POST
#'@return returns a list $entity contains entity information, $response contains the entire http response
#'@export
#'@examples
#'\dontrun{
#' api<-CoreAPI("PATH TO JSON FILE")
#' login<- CoreAPI::authBasic(api)
#' item<-getEntityByName(login$coreApi,"entityType","name")
#' logOut(login$coreApi)
#' }
#'@author Craig Parman
#'@description \code{getEntityByName} Get an entity from the LIMS by name and entityType.



getEntityByName<-function (coreApi,entityType,name,useVerbose=FALSE)

{



  request<-list(request=list(sdkCmd=jsonlite::unbox("get"),
                             data=list(entityRef=list(name=jsonlite::unbox(name),entitiyID=jsonlite::unbox(""),barcode=jsonlite::unbox(""))),
                             responseOptions=c("CONTEXT_GET","MESSAGE_LEVEL_WARN"),
                             typeParam = jsonlite::unbox(entityType),
                             logicOptions=list()
                    ))


  response<- CoreAPI::apiCall(coreApi,request,"json",useVerbose=useVerbose)



  list(entity=httr::content(response)$response$data,response=response)

  }



