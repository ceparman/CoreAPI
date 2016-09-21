#'Get an entity from the LIMS by barcode
#'
#'\code{getEntityByBarcode} get an entity from the LIMS by barcode and
#'
#'@param coreApi coreApi object with valid jsessionid
#'@param entityType entity type to get
#'@param barcode barcode of entity to get
#'@param useVerbose TRUE or FALSE to indicate if verbose options should be used in http POST
#'@return returns a list $entity contains entity information, $response contains the entire http response
#'@export
#'@examples
#'\dontrun{
#' api<-CoreAPI("PATH TO JSON FILE")
#' login<- CoreAPI::authBasic(api)
#' item<-getEntityByBarcode(login$coreApi,"entityType","barcode")
#' logOut(login$coreApi)
#' }
#'@author Craig Parman
#'@description \code{getEntityByBarcode} Get an entity from the LIMS by barcode and entyType.



getEntityByBarcode<-function (coreApi,entityType,barcode,useVerbose=FALSE)

{



  request<-list(request=list(sdkCmd=jsonlite::unbox("get"),
                             data=list(entityRef=list(name=jsonlite::unbox(""),entitiyID=jsonlite::unbox(""),barcode=jsonlite::unbox(barcode))),
                             responseOptions=c("CONTEXT_GET","MESSAGE_LEVEL_WARN"),
                             typeParam = jsonlite::unbox(entityType),
                             logicOptions=list()
                    ))


      sdk_url<-paste(coreApi$coreUrl,"/sdk",";jsessionid=",coreApi$jsessionId,sep="")


    response<-httr::POST(sdk_url,body = request, encode="json",
            httr::verbose(data_out = useVerbose, data_in = useVerbose, info = useVerbose, ssl = useVerbose))

  list(entity=httr::content(response)$response$data,response=response)

  }



