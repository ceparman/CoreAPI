#'Creates a object of class coreAPI that contains connection information
#'\code{etradeAPI("path to json")}
#'@param CoreAccountInfo file with account information in json format.
#'@return Object of class coreAPI
#'@export
#'@examples
#'\dontrun {  }
#'@details { Creates a object of class coreAPI that contains user name, \cr
#'          password base url, and account \cr
#'          if needed. It has slots for account, jsessionID, AWSELB, and base URL. \cr
#'          Requires a json file that contains the user pwd and account. \cr
#'           }
#'\code{#'Creates a object of class coreAPI that contains account information}
#'\code{coreAPI("path to json")}

#'\code{
#'            [{
#'              "user": "xxxxxxxxx",         \cr
#'              "pwd": "xxxxxxxxx",          \cr
#'              "coreUrl": "xxxxxxx",        \cr
#'              "account": "xxxxxxxxx",      \cr
#'            }]                             \cr
#' }
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

