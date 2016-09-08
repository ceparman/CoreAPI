#' attachFile - attaches a file to an entitiy or attribute.
#'
#' \code{attachFile} Creates a new entity instance.
#' @param coreApi coreApi object with valid jsessionid
#' @param barcode User provided barcode as a character string
#' @param filename name to use for the attached file
#' @param filepath path to the file to attach
#' @param targetAttributeName - if included the name if the attribute to attach the file to.  Must be in all caps.
#' @param useVerbose Use verbose communitcaion for debuggins
#' @export
#' @return RETURN returns a list $entity contains entity information, $response contains the entire http response
#' @examples
#'\dontrun{
#' response<- CoreAPI::authBasic(coreApi)
#'
#' newitem<-CoreAPI::attachFile(response$coreApi,barcode,filename,filepath,targetAttributeName="",useVerbose=FALSE)
#' jsonlite::toJSON(newitem$item)
#' logOut(coreUrl,js,postVerbose=FALSE )
#' }
#'@author Craig Parman
#'@description \code{attachFile} Attaches a file to entity identified by barcode or one ot its attributes.





attachFile<-function (coreApi,barcode,filename,filepath,targetAttributeName="",useVerbose=FALSE)

{

  ##Notes


  if(!file.exists(filepath)) {

    stop(
      {print("Unable to find file on local OS")
        print( filepath)
      },
      call.=FALSE
    )

  }




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



  sdk_url<-paste(coreApi$coreUrl,"/sdk",";jsessionid=",coreApi$jessionid,sep="")


  response<-httr::POST(sdk_url,body = request, encode="json",
                       httr::verbose(data_out = useVerbose, data_in = useVerbose, info = useVerbose, ssl = useVerbose))

  response<-httr::POST(sdk_url,body = form, encode="multipart",
                       httr::verbose(data_out = useVerbose, data_in = useVerbose, info = useVerbose, ssl = useVerbose))

  if(httr::http_error(response)) {

    stop(
      {print("API call failed")
        print( httr::http_status(response))
      },
      call.=FALSE
    )

  }




  list(entity=httr::content(response)$response$data,response=response)

}
