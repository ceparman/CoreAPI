#' attachFile - Attaches a file to an entity or file attribute.
#'
#' \code{attachFile}  Attaches a file to an entity or file attribute.
#' @param coreApi coreApi object with valid jsessionid
#' @param barcode User provided barcode as a character string
#' @param filename name to use for the attached file
#' @param filepath path to the file to attach
#' @param targetAttributeName - if included the name if the attribute to attach the file to.  Must be in all caps.
#' @param useVerbose Use verbose communication for debugging
#' @export
#' @return RETURN returns a list $entity contains entity information, $response contains the entire http response
#' @examples
#'\dontrun{
#' api<-CoreAPI("PATH TO JSON FILE")
#' login<- CoreAPI::authBasic(api)
#' newitem<-CoreAPI::attachFile(response$coreApi,barcode,filename,
#'          filepath,targetAttributeName="",useVerbose=FALSE)
#' logOut(login$coreApi )
#' }
#'@author Craig Parman
#'@description \code{attachFile} Attaches a file to entity identified by barcode or one of its attributes.




attachFile<-function (coreApi,barcode,filename,filepath,targetAttributeName="",useVerbose=FALSE)

{




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




   #upload file
   response<- CoreAPI::apiCall(coreApi,form,"multipart",useVerbose=useVerbose)



  list(entity=httr::content(response)$response$data,response=response)

}
