#'experimentUnPublish Unpublishes an experiment.
#'
#' \code{experimentUnPublish} Unpublishes an experiment.
#' @param coreApi coreApi object with valid jsessionid
#' @param experimentType experiment entity type
#' @param experimentBarcode barcode of the experiment
#' @param useVerbose Use verbose communication for debugging
#' @export
#' @return RETURN returns a list $entity contains updated experiment information, $response contains the entire http response
#' @examples
#'\dontrun{
#' api<-CoreAPI("PATH TO JSON FILE")
#' login<- CoreAPI::authBasic(api)
#' update<- CoreAPI::experimentUnPublish(login$coreApi,experimentType, exptbarcode,useVerbose = TRUE)
#' logOut(login$coreApi )
#' }
#'@author Craig Parman
#'@description \code{experimentUnPublish} -  Unpublishes an experiment.




experimentUnPublish<- function(coreApi, experimentType, experimentBarcode,useVerbose = FALSE)

{


  sdkCmd<-jsonlite::unbox("experiment-unpublish")

  data<-list()



  data[["entityRef"]] <- list(barcode =jsonlite::unbox(experimentBarcode))



  responseOptions<-c("CONTEXT_GET","MESSAGE_LEVEL_WARN")
  logicOptions<-jsonlite::unbox("EXECUTE_TRIGGERS")
  typeParam <- jsonlite::unbox(experimentType)



  request<-list(request=list(sdkCmd=sdkCmd,data=data,typeParam =typeParam,
                             responseOptions=responseOptions,
                             logicOptions=logicOptions))



  response<- CoreAPI::apiCall(coreApi,request,"json",useVerbose=useVerbose)



  list(entity=httr::content(response)$response$data,response=response)

}

