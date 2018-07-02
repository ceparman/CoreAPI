#' updateExperimentContainers -  Adds a container to an experiment.
#'
#' \code{updateExperimentContainers} Adds a container to an experiment.
#' @param coreApi coreApi object with valid jsessionid
#' @param experimentType experiment entity type
#' @param containerBarcode barcode of container that has a cell lot in it
#' @param experimentBarcode barcode of the experiment
#' @param useVerbose Use verbose communication for debugging
#' @export
#' @return RETURN returns a list $entity contains updated experiment information,
#'         $response contains the entire http response
#' @examples
#'\dontrun{
#' api<-CoreAPI("PATH TO JSON FILE")
#' login<- CoreAPI::authBasic(api)
#' update<- CoreAPI::updateExperimentContainers(login$coreApi,containerBarcode,
#'                                             experimentType, newExptbarcode,useVerbose = TRUE)
#'                                             logOut(login$coreApi )
#' }
#'@author Craig Parman
#'@description \code{updateExperimentContainers} - Adds a container to an experiment.





updateExperimentContainers<- function(coreApi,containerBarcode, experimentType,
                                      experimentBarcode,useVerbose = FALSE)

{


  sdkCmd<-jsonlite::unbox("update-experiment-containers")

  data<-list()

  data[["containerRefs"]] <- list( c( list(barcode =jsonlite::unbox(containerBarcode))))

  data[["entityRef"]] <- list(barcode =jsonlite::unbox(experimentBarcode))



  responseOptions<-c("CONTEXT_GET","MESSAGE_LEVEL_WARN","INCLUDE_EXPERIMENT_CONTAINER")
  logicOptions<-jsonlite::unbox("")
  typeParam <- jsonlite::unbox(experimentType)



  request<-list(request=list(sdkCmd=sdkCmd,data=data,typeParam =typeParam,
                             responseOptions=responseOptions,
                             logicOptions=logicOptions))



  response<- CoreAPI::apiCall(coreApi,request,"json",useVerbose=useVerbose)



  list(entity=httr::content(response)$response$data,response=response)

}

