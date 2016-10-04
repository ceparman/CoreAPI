#' getExperimentSamples - Gets experiment and experiment samples from experiment identified by barcode.
#'
#'\code{getExperimentSamples}  Gets experiment and experiment samples from experiment identified by barcode.
#'
#'@param coreApi coreApi object with valid jsessionid
#'@param entityType experiment entity type to get
#'@param barcode barcode of entity to get
#'@param useVerbose TRUE or FALSE to indicate if verbose options should be used in http POST
#'@return returns a list $entity contains entity information, $response contains the entire http response
#'@export
#'@examples
#'\dontrun{
#' api<-CoreAPI("PATH TO JSON FILE")
#' login<- CoreAPI::authBasic(api)
#' experiment<- getExperimentSamples(login$coreApi,"entityType","barcode")
#' logOut(login$coreApi)
#' }
#'@author Craig Parman
#'@description \code{ getExperimentSamples}  Gets experiment and experiment samples from experiment identified by barcode.



getExperimentSamples<-function (coreApi,entityType,barcode,useVerbose=FALSE)

{



  request<-list(request=list(sdkCmd=jsonlite::unbox("get"),
                             data=list(entityRef=list(name=jsonlite::unbox(""),entitiyID=jsonlite::unbox(""),barcode=jsonlite::unbox(barcode))),
                             responseOptions=c("CONTEXT_GET","MESSAGE_LEVEL_WARN", "INCLUDE_EXPERIMENT_SAMPLE",
                                               "INCLUDE_EXPERIMENT_DATA","INCLUDE_EXPERIMENT_CONTAINER"),
                             typeParam = jsonlite::unbox(entityType),
                             logicOptions=list()
                    ))


  response<- CoreAPI::apiCall(coreApi,request,"json",useVerbose=useVerbose)



  list(entity=httr::content(response)$response$data,response=response)

  }



