#' createExperimentSample- Creates an experiment sample.
#'
#' \code{createExperimentSample} Creates an experiment sample.
#' @param coreApi coreApi object with valid jsessionid
#' @param entityType entity type to get as character string
#' @param sampleLotBarcode parent sample barcode
#' @param experimentBarcode experiment barcode
#' @param attributeValues attributes as a list of key-value pairs
#' @param locationId location ID for initial location as character string
#' @param projectIds project comma separated list of project IDs as character string
#' @param barcode User provided barcode as a character string
#' @param associations association as a list of dataframes (see details)
#' @param concentration sample lot concentration
#' @param concentrationUnit concentration unit
#' @param timeMin min time value
#' @param useVerbose Use verbose communication for debugging
#' @export
#' @return RETURN returns a list $entity contains entity information, $response contains the entire http response
#' @examples
#'\dontrun{
#' api<-CoreAPI("PATH TO JSON FILE")
#' login<- CoreAPI::authBasic(api)
#' item<-createExperimentSample(login$coreApi,
#' logOut(login$coreApi )
#' }
#'@author Craig Parman
#'@description \code{createExperimentSample} Creates an experiment sample.




createExperimentSample<-function (coreApi,entityType, sampleLotBarcode,experimentBarcode, attributeValues=NULL,
                        locationId=NULL,projectIds=NULL,barcode=NULL,associations=NULL,
                        concentration = NULL, concentrationUnit = NULL, timeMin = NULL,
                        useVerbose=FALSE)

{

data <-NULL
  sdkCmd<-jsonlite::unbox("create")
  data<-list(entityTypeName= jsonlite::unbox(entityType))

  if(!is.null(attributeValues))
  {

    values<-list()


    for(i in 1:length(attributeValues))
      {
      values[[names(attributeValues)[i]]] <- list(stringData= jsonlite::unbox(as.character( attributeValues[[i]] ) ))
      }

    data[["values"]]<-values
  }




  data[["lotRef"]] <- list(barcode = jsonlite::unbox(sampleLotBarcode))




  data[["experimentRef"]] <- list(barcode = jsonlite::unbox(experimentBarcode))



 if(!is.null(locationId))
  {
  data[["locationId"]]<- locationId
  }


 if(!is.null(projectIds))
 {
   data[["projectIds"]]<- projectIds
 }







 if(!is.null(associations))
 {
   data[["associations"]]<- associations
 }


  if(!is.null(concentration))
  {
    data[["concentration"]]<- concentration
  }


  if(!is.null(concentrationUnit))
  {
    data[["concentrationUnit"]]<- concentrationUnit
  }


  if(!is.null(timeMin))
  {
    data[["timeMin"]]<- timeMin
  }


  responseOptions<-c("CONTEXT_GET","MESSAGE_LEVEL_WARN")
  logicOptions<-jsonlite::unbox("EXECUTE_TRIGGERS")
  typeParam <- jsonlite::unbox(entityType)





 request<-list(request=list(sdkCmd=sdkCmd,data=data,typeParam =typeParam,
                             responseOptions=responseOptions,
                             logicOptions=logicOptions))



response<- CoreAPI::apiCall(coreApi,request,"json",useVerbose=useVerbose)





list(entity=httr::content(response)$response$data,response=response)

}

