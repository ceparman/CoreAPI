#' createEntity - Create a new instance of a entity.
#'
#' \code{createEntity} Creates a new instance of an entity.
#' @param coreApi coreApi object with valid jsessionid
#' @param entityType entity type to get as character string
#' @param attributeValues attributes as a list of key-values pairs
#' @param locationId location ID for initial location as character string
#' @param projectIds project comma separated list of project IDs as character string
#' @param barcode User provided barcode as a character string
#' @param associations association as a list of dataframes (see vignette for details)
#' @param useVerbose Use verbose communication for debugging
#' @export
#' @return RETURN returns a list $entity contains entity information, $response contains the entire http response
#' @examples
#'\dontrun{
#' api<-CoreAPI("PATH TO JSON FILE")
#' login<- CoreAPI::authBasic(api)
#' item<-CoreAPI::createEntity(login$coreApi,"Entity_Type")
#' logOut(login$coreApi )
#' }
#'@author Craig Parman
#'@description \code{createEntity} Creates a new entity instance. Required inputs are url, jsessionId and entityType.



createEntity<-function (coreApi,entityType,attributeValues=NULL,
                        locationId=NULL,projectIds=NULL,barcode=NULL,associations=NULL,useVerbose=FALSE)

{

  ##Notes
  ## locationId not required but would need to be looked up if only location barcode is known.
  #Should add functionality to look pass location barcode and look up ID
  #todo asscociations,xxx-locations, xxxx- project, xxxx-barcode

  sdkCmd<-jsonlite::unbox("create")
  data<-list(entityTypeName= jsonlite::unbox(entityType))

  if(!is.null(attributeValues))
  {

    values<-list()


    for(i in 1:length(attributeValues))
      {
        values[[names(attributeValues)[i]]] <- list(stringData= jsonlite::unbox(as.character(attributeValues[[i]] ) ))
      }

    data[["values"]]<-values
  }






 if(!is.null(locationId))
  {
  data[["locationId"]]<- locationId
  }


 if(!is.null(projectIds))
 {
   data[["projectIds"]]<- projectIds
 }

 if(!is.null(barcode))
 {
   data[["barcode"]]<- barcode
 }


 if(!is.null(associations))
 {
   data[["associations"]]<- associations
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


