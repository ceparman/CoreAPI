#' attachFile - attaches a file to an entitiy or attribute.
#'
#' \code{attachFile} Creates a new entity instance.
#' @param coreUrl character string that is the url of LIMS
#' @param jessionid valid jesssionid as character string
#' @param barcode User provided barcode as a character string
#' @param filename name to use for the attached file
#' @param filepath path to the firl to attach
#' @param targetAttributeName - if included the name if the attribute to attach the file to.  Must be in all caps.
#' @param useVerbose Use verbose communitcaion for debuggins
#' @export
#' @return RETURN returns a list $entity contains entity information, $response contains the entire http response
#' @examples
#'\dontrun{
#' response<- CoreAPI::authBasic(coreUrl,user,pwd)
#' jessionid<-response$sessionInfo$jessionid
#' newitem<-CoreAPI::fileAttach(coreUrl,jessionid,entityType,barcodefilename,filepath,targetAttributeName="",useVerbose=FALSE)
#' jsonlite::toJSON(newitem$item)
#' logOut(coreUrl,js,postVerbose=FALSE )
#' }
#'@author Craig Parman
#'@description \code{attachFile} Attaches a file to entity identified by barcode or one ot its attributes.





attachFile<-function (coreUrl,jessionid,barcode,filename,filepath,targetAttributeName="",useVerbose=FALSE)

{

  ##Notes


  sdkCmd<-jsonlite::unbox("file-attach")

   data<-list(targetEntityBarcode = jsonlite::unbox(barcode),
             name=jsonlite::unbox(filename),
             targetAttributeName=jsonlite::unbox(targetAttributeName),
             fileContentTypeOverride=jsonlite::unbox("")
   )




   responseOptions<-c("CONTEXT_GET","MESSAGE_LEVEL_WARN")
   logicOptions<-jsonlite::unbox("EXECUTE_TRIGGERS")
   typeParam <- jsonlite::unbox("FILE")




   request<-list(request=list(sdkCmd=sdkCmd,data=data,typeParam =typeParam,
                              responseOptions=responseOptions,
                              logicOptions=logicOptions))




   form<-list(json = jsonlite::toJSON(request),
              fileData=httr::upload_file(filepath)
   )



  sdk_url<-paste(coreUrl,"/sdk",";jsessionid=",jessionid,sep="")


  response<-httr::POST(sdk_url,body = request, encode="json",
                       httr::verbose(data_out = useVerbose, data_in = useVerbose, info = useVerbose, ssl = useVerbose))

  response<-httr::POST(sdk_url,body = form, encode="multipart",
                       httr::verbose(data_out = useVerbose, data_in = useVerbose, info = useVerbose, ssl = useVerbose))





  list(entity=httr::content(response)$response$data,response=response)

}
