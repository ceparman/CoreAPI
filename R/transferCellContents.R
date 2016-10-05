#' transferCellContents -  Transfers contents from one cell to another.
#'
#' \code{transferCellContents} Transfers contents from one cell to another.
#' @param coreApi coreApi object with valid jsessionid
#' @param sourceCellID source cell ID
#' @param destCellID destination cell ID
#' @param amount amount to transfer
#' @param concentration concentration for destination cell
#' @param amountUnit valid units for amount
#' @param concentrationUnit valid units for concentration
#' @param useVerbose use verbose messaging for debugging
#' @export
#' @return RETURN returns a list $entity contains cell information, $response contains the entire http response
#' @examples
#'\dontrun{
#' api<-CoreAPI("PATH TO JSON FILE")
#' login<- CoreAPI::authBasic(api)
#' newcell<-transferCellContents(login$coreApi,"98811","93221","1",".1","mg/ML","uL")
#' logOut(login$coreApi )
#' }
#'@author Craig Parman
#'@description \code{transferCellContents} - Transfers contents from one cell to another.





transferCellContents<-function (coreApi,sourceCellID,destCellID,amount,concentration,
                                amountUnit, concentrationUnit,useVerbose = FALSE)
{



  sdkCmd<-jsonlite::unbox("transfer")

  data<-list()




  data[["amount"]] <- jsonlite::unbox(amount)
  data[["amountUnit"]] <- jsonlite::unbox(amountUnit)

  data[["concentration"]] <- jsonlite::unbox(concentration)
  data[["concentrationUnit"]] <- jsonlite::unbox(concentrationUnit)



  data[["srcCellRef"]] <-list(cellId = jsonlite::unbox(sourceCellID))

  data[["destCellRef"]] <-list(cellId = jsonlite::unbox(destCellID))

  responseOptions<-c("CONTEXT_GET","MESSAGE_LEVEL_WARN","INCLUDE_CONTAINER_CELL_CONTENTS")
  logicOptions<-jsonlite::unbox("")
  typeParam <- jsonlite::unbox("CELL")




 request<-list(request=list(sdkCmd=sdkCmd,data=data,typeParam =typeParam,
                             responseOptions=responseOptions,
                             logicOptions=logicOptions))

response<- CoreAPI::apiCall(coreApi,request,"json",useVerbose=useVerbose)


list(entity=httr::content(response)$response$data,response=response)

}

