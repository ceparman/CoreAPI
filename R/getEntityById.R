#' getEntityById - Get an entity from the LIMS by entity ID.
#'
#'\code{getEntityById} get an entity from the LIMS by ID.
#'
#'@param coreApi coreApi object with valid jsessionid
#'@param entityType entity type to get
#'@param entityId ID of entity to get
#'@param useVerbose TRUE or FALSE to indicate if verbose options should be used in http POST
#'@return returns a list $entity contains entity information, $response contains the entire http response
#'@export
#'@examples
#'\dontrun{
#' api<-CoreAPI("PATH TO JSON FILE")
#' login<- CoreAPI::authBasic(api)
#' item<-getEntityById(login$coreApi,"entityType","entityId")
#' logOut(login$coreApi)
#' }
#'@author Craig Parman
#'@description \code{getEntityById} Get an entity from the LIMS by ID and entityType.

getEntityById<-function (coreApi,entityType,entityId,useVerbose=FALSE)

{



  request<-list(request=list(sdkCmd=jsonlite::unbox("get"),
                             data=list(entityRef=list(name=jsonlite::unbox(""),entitiyID=jsonlite::unbox(""),entityId=jsonlite::unbox(entityId))),
                             responseOptions=c("CONTEXT_GET","MESSAGE_LEVEL_WARN"),
                             typeParam = jsonlite::unbox(entityType),
                             logicOptions=list()
                    ))


  response<- CoreAPI::apiCall(coreApi,request,"json",useVerbose=useVerbose)



  list(entity=httr::content(response)$response$data,response=response)

  }



