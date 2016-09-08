#' updateEntity - Create a new instance of a entitiy.
#'
#' \code{updateEntity} Creates a new entity instance.
#' @param coreApi coreApi object with valid jsessionid
#' @param entityType entity type to get as character string
#' @param barcode User provided barcode as a character string
#' @param attributeValues atributes as a list of key-vlaues pairs
#' @param locationId location ID for inital location as character string
#' @param projectIds project comma seperated list of project IDs as character string
#' @param associations association as a list of dataframes (see details)
#' @param useVerbose Use verbose communitcaion for debuggins
#' @export
#' @return RETURN returns a list $entity contains entity information, $response contains the entire http response
#' @examples
#'\dontrun{
#' response<- CoreAPI::authBasic(coreApi)
#'
#' newitem<-CoreAPI::updateEntity(response$coreapi,entityType,barcode)
#' jsonlite::toJSON(newitem$item)
#' logOut(coreUrl,js,postVerbose=FALSE )
#' }
#'@author Craig Parman
#'@description \code{updateEntity} Creates a new entity instance. Required inputs are url, jsessionId and entityType.





updateEntity<-function (coreApi,entityType,barcode,attributeValues=NULL,
                        locationId=NULL,projectIds=NULL,associations=NULL,useVerbose=FALSE)

{

  ##Notes
  ## locationId not required but would need to be looked up if only location barcode is known.
  #Should add functionality to look pass location barcode and look up ID
  #todo asscociations,xxx-locations, xxxx- project, xxxx-barcode

  sdkCmd<-jsonlite::unbox("update")
  data<-list()
  #data<-list(entityTypeName= jsonlite::unbox(entityType))

  if(!is.null(attributeValues))
  {

    values<-list()


    for(i in 1:length(attributeValues))
    {
      values[[names(attributeValues)[i]]] <- list(stringData= jsonlite::unbox(attributeValues[[i]]))
    }

    data[["values"]]<-values
  }






  if(!is.null(locationId))
  {
    data[["locationId"]]<- jsonlite::unbox(locationId)
  }


  if(!is.null(projectIds))
  {
    data[["projectIds"]]<- jsonlite::unbox(projectIds)
  }

  if(!is.null(barcode))
  {
    data[["barcode"]]<- jsonlite::unbox(barcode)
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






  sdk_url<-paste(coreApi$coreUrl,"/sdk",";jsessionid=",coreApi$jessionid,sep="")


  response<-httr::POST(sdk_url,body = request, encode="json",
                       httr::verbose(data_out = useVerbose, data_in = useVerbose, info = useVerbose, ssl = useVerbose))


  list(entity=httr::content(response)$response$data,response=response)

}
