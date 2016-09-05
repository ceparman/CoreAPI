#'Get an entity from the LIMS by barcode
#'
#'\code{getByBarcodeEntity} get an entity from the LIMS by barcode and
#'
#'@param coreUrl character string that is the url of LIMS
#'@param jsessionid valid jsessionid
#'@param entityType entity type to get
#'@param barcode barcode of entity to get
#'@param useVerbose TRUE or FALSE to indicate if verbose options should be used in http POST
#'@return returns a list $entity contains entity information, $response contains the entire http response
#'@export
#'@examples
#'\dontrun{
#' response<- CoreAPI::authBasic(coreUrl,user,pwd)
#' js<-response$sessionInfo$jsessionid
#' item<-CoreAPI::getByBarcodeEntity(coreUrl,js,entityType,barcode,useVerbose)
#' jsonlite::toJSON(item$entity)
#' logOut(coreUrl,js,postVerbose=FALSE )}
#'@author Craig Parman
#'@description \code{getByBarcodeEntity} Get an entity from the LIMS by barcode and entyType.



getByBarcodeEntity<-function (coreUrl,jsessionid,entityType,barcode,useVerbose=FALSE)

{



  request<-list(request=list(sdkCmd=jsonlite::unbox("get"),
                             data=list(entityRef=list(name=jsonlite::unbox(""),entitiyID=jsonlite::unbox(""),barcode=jsonlite::unbox(barcode))),
                             responseOptions=c("CONTEXT_GET","MESSAGE_LEVEL_WARN"),
                             typeParam = jsonlite::unbox(entityType),
                             logicOptions=list()
                    ))


      sdk_url<-paste(coreUrl,"/sdk",";jsessionid=",jsessionid,sep="")


    response<-httr::POST(sdk_url,body = request, encode="json",
            httr::verbose(data_out = useVerbose, data_in = useVerbose, info = useVerbose, ssl = useVerbose))

  list(entity=httr::content(response)$response$data,response=response)

  }



