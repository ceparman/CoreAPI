#' createEntity - Create a new instance of a entitiy.
#'
#' \code{createEntity} Creates a new entity instance.
#' @param coreUrl character string that is the url of LIMS
#' @param jessionid valid jesssionid as character string
#' @param entityType entity type to get as character string
#' @param attributeValues atributes as a list of key-vlaues pairs
#' @param locationId location ID for inital location as character string
#' @param projectIds project comma seperated list of project IDs as character string
#' @param barcode User provided barcode as a character string
#' @param associations association as a list of dataframes (see details)
#' @param useVerbose Use verbose communitcaion for debuggins
#' @export
#' @return RETURN returns a list $entity contains entity information, $response contains the entire http response
#' @examples
#'\dontrun{
#' response<- CoreAPI::authBasic(coreUrl,user,pwd)
#' jessionid<-response$sessionInfo$jessionid
#' newitem<-CoreAPI::createEntity(coreUrl,jessionid,entityType)
#' jsonlite::toJSON(item$item)
#' logOut(coreUrl,js,postVerbose=FALSE )
#' }
#'@author Craig Parman
#'@description \code{createEntity} Creates a new entity instance. Required inputs are url, jsessionId and entityType.





createEntity<-function (coreUrl,jessionid,entityType,attributeValues=NULL,
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
        values[[names(attributeValues)[i]]] <- list(stringData= jsonlite::unbox(attributeValues[[i]]))
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






  sdk_url<-paste(coreUrl,"/sdk",";jsessionid=",jessionid,sep="")


  response<-httr::POST(sdk_url,body = request, encode="json",
                       httr::verbose(data_out = useVerbose, data_in = useVerbose, info = useVerbose, ssl = useVerbose))


  list(entity=httr::content(response)$response$data,response=response)

}



#
# login<-CoreAPI::authBasic(coreUrl,user,pwd)
#
# jessionid<-login$sessionInfo$jessionid
#
# attributeValues<-list(SOURCE_LAB = "New York Medical Center",NUMERIC_VALUE = 5,REQUESTOR="CEP")
#
# entityType<-"PATIENT SAMPLE"
#
#
# #response<-createEntity(coreUrl,jessionid,entityType,attributeValues,locationId=6185763, projectIds=6854513,associations=NULL,useVerbose=FALSE)
#
#
# response<-createEntity(coreUrl,jessionid,"PATIENT SAMPLE",attributeValues,locationId=6185763, projectIds="5000005,6854513"
#                        ,associations=NULL,useVerbose=FALSE)
#
#
#
#
# response<-createEntity(coreUrl,jessionid,"SAMPLEUB",attributeValues,locationId=6185763, projectIds="5000005,6854513"
#                        ,associations=NULL,useVerbose=FALSE)
#
#
# response<-createEntity(coreUrl,jessionid,"SAMPLEUB",attributeValues,locationId=6185763, projectIds="5000005,6854513",
#                        barcode="GGHHDHEG",associations=NULL,useVerbose=FALSE)
#
#
#
# response<-createEntity(coreUrl,jessionid,"SAMPLEUB",attributeValues,locationId=6185763, projectIds="5000005,6854513",
#                        barcode="GGHHHEG",associations=NULL,useVerbose=FALSE)
#
#
#
# associations<-list(SAMPLEENZYME=data.frame(name="",entitiyId="",barcode="ENZ1"))
#
# jsonlite::toJSON(associations,pretty = TRUE)
#
# response<-createEntity(coreUrl,jessionid,"SAMPLEUB",attributeValues,associations=associations,
#                        locationId=6185763, projectIds="5000005,6854513",useVerbose=FALSE)
#
# response<- CoreAPI::authBasic(coreUrl,user,pwd)
# js<-response$sessionInfo$jessionid
#  newitem<-createEntity(coreUrl,jessionid,entityType)
#  jsonlite::toJSON(item$item)
#
#
#
#   logOut(coreUrl,js,postVerbose=FALSE )
#
#
