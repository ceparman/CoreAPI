#'getContainerLineage - Get lineage for a container by barcode
#'
#'\code{getContainerLineage} get an entity from the LIMS by barcode and
#'
#'@param coreApi coreApi object with valid jsessionid
#'@param barcode barcode of container to get lineage for
#'@param useVerbose TRUE or FALSE to indicate if verbose options should be used in http POST
#'@return returns a list $entity contains entity information, $response contains the entire http response
#'@export
#'@examples
#'\dontrun{
#'api<-CoreAPI("PATH TO JSON FILE")
#' login<- CoreAPI::authBasic(api)
#' lineage<-getContainerLineage(login$coreApi,"barcode")
#' parents <- ineage$entity$parents
#' logOut(login$coreApi )
#' }
#'@author Craig Parman
#'@description \code{getContainerLineage} Get the parent and child conttainers for a container referenced by barcode..



getContainerLineage<-function (coreApi,barcode,useVerbose=FALSE)

{

  sdkCmd<-jsonlite::unbox("get-lineage")

data<-list()

data[["entityRef"]] <- list(barcode = jsonlite::unbox(barcode))


responseOptions<-c("CONTEXT_GET","MESSAGE_LEVEL_WARN","INCLUDE_CONTAINER_CELL_CONTENTS")

logicOptions<-jsonlite::unbox("")

typeParam <- jsonlite::unbox("CONTAINER")


request<-list(request=list(sdkCmd=sdkCmd,data=data,typeParam =typeParam,
                           responseOptions=responseOptions,
                           logicOptions=logicOptions))

response<- CoreAPI::apiCall(coreApi,request,"json",useVerbose=useVerbose)

list(entity=httr::content(response)$response$data,response=response)

  }



