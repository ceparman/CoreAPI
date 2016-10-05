#' updateExperimentSampleData - Update experiment sample data.
#'
#' \code{updateExperimentSampleData} Update experiment sample data.
#'
#' @param coreApi coreApi object with valid jsessionid
#' @param entityType entity type to get as character string
#' @param experimentSamplebarcode User provided barcode as a character string
#' @param assayAttributeValues assay attributes as a list of key-values pairs
#' @param useVerbose Use verbose communication for debugging
#' @export
#' @return RETURN returns a list $entity contains entity information,
#'        $response contains the entire http response
#' @examples
#'\dontrun{
#' api<-CoreAPI("PATH TO JSON FILE")
#' login<- CoreAPI::authBasic(api)
#' newdata<-CoreAPI::updateExperimentSampleData(login$coreApi,entityType,
#'                   experimentSampleBarcode,assayAtributeValues)
#' logOut(login$coreApi ) response<- CoreAPI::authBasic(coreApi)
#' }
#'@author Craig Parman
#'@description \code{updateExperimentSampleData} Update experiment sample data.



updateExperimentSampleData<-function (coreApi,entityType,experimentSamplebarcode,assayAttributeValues,
                                      useVerbose=FALSE)

{




  sdkCmd<-jsonlite::unbox("update-experiment-sample-data")
  data<-list()


  if(!is.null(assayAttributeValues))
  {

    values<-list()


    for(i in 1:length(assayAttributeValues))
    {
      values[[names(assayAttributeValues)[i]]] <- list(stringData= jsonlite::unbox(as.character( assayAttributeValues[[i]] ) ))
    }

    data[["experimentData"]]<-values
  }


 data[["entityRef"]] <- list(barcode = experimentSamplebarcode )



  responseOptions<-c("CONTEXT_GET","MESSAGE_LEVEL_WARN","INCLUDE_EXPERIMENT_DATA")

  typeParam <- jsonlite::unbox(entityType)




  request<-list(request=list(sdkCmd=sdkCmd,data=data,typeParam =typeParam,
                             responseOptions=responseOptions))



  response<- CoreAPI::apiCall(coreApi,request,"json",useVerbose=useVerbose)


  list(entity=httr::content(response)$response$data,response=response)

}




#r<-CoreAPI::authBasic(tapi)

#CoreAPI::updateExperimentSampleData(r$coreApi,entityType,experimentSamplebarcode,assayAttributeValues,useVerbose=TRUE)
