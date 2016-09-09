#'Creates a object of class coreAPI that contains user and connection information
#'\code{coreApi("path to json")}
#'@param CoreAccountInfo file with account information in json format.
#'@return Object of class coreAPI
#'@export
#'@examples
#'\dontrun{
#'   api<-coreApi("/home")
#'}
#'@details  Creates a object of class coreAPI that contains user name,            \cr
#'          password base url, and account                                        \cr
#'          if needed. It has slots for account, jsessionID, AWSELB, and base URL. \cr
#'          Requires a json file that contains the user pwd and account.           \cr
#'
#'         \code{#'Creates a object of class coreAPI that contains account information} \cr
#'         \code{coreAPI("path to json")}  \cr \cr
#' The json must include the fields shown below.  The account value may be set to "" if the user only has access to one tenant. \cr \cr
#' Example json object.  \cr \cr
#'          \code{
#'                [{                             \cr
#'                  "user": "xxxxxxxxx",         \cr
#'                  "pwd": "xxxxxxxxx",          \cr
#'                  "coreUrl": "xxxxxxx",        \cr
#'                 "account": "xxxxxxxxx",       \cr
#'                }]                              \cr
#'           }



coreAPI<- function(CoreAccountInfo)
{

  accountinfo <-jsonlite::fromJSON(CoreAccountInfo)
  if  (accountinfo$account == "") accountinfo$account <- NULL
   structure(
             list(user=accountinfo$user,
                  pwd = accountinfo$pwd,
                  account = accountinfo$account,
                  coreUrl = accountinfo$coreUrl,
                  jsessionId = NULL,
                  awselb = NULL,
                  employeeId = NULL
               )

    ,class="coreAPI"
  )


}

