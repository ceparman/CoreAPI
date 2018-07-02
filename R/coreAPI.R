#'coreAPI Creates a object of class coreAPI that contains user and connection information.
#'@param CoreAccountInfo file with account information in json format.
#'@return Object of class coreAPI
#'@export
#'@examples
#'\dontrun{
#'api<-CoreAPIV::coreAPI("/home/environment.json")
#'}
#'@details{ Creates a object of class coreAPI that contains user name,
#'          password base url, account, port.
#'          It has slots for account, jsessionId, AWSELB, and base URL.
#'          Requires a json file that is a POSTMAN environment file.
#'         \code{#'Creates a object of class coreAPI that contains account information}
#'         \code{coreAPI("path to json")}.
#' }
#'The json must include the fields shown below.
#'     \code{
#'      {
#'    "values": [
#'  {
#'    "key": "tenant",
#'    "value": "R-Integration_Baseline"
#'  },
#'  {
#'    "key": "TenantShortName",
#'    "value": "bp2",
#'    "type": "text",
#'    "enabled": true
#'  },
#'  {
#'    "key": "scheme",
#'    "value": "https"
#'  },
#'  {
#'    "key": "host",
#'    "value": "lims.ccc.cloud"
#'  },
#'  {
#'    "key": "username",
#'   "value": "yyyy"
#'  },
#'  {
#'    "key": "password",
#'    "value": "xxxxx"
#'  },
#'  {
#'    "key": "port",
#'    "value": "443"
#'  }
#'  ]
#'
#'}
#'
#'
#'     }
#'
#'  The account value may be set to "" if the user only has access to one tenant.
#' As an alternative the environment json object from Postman can be used directly.
#'@author Craig Parman ngsAnalytics, ngsanalytics.com
coreAPI <- function(CoreAccountInfo)
{
  accountinfo <- jsonlite::fromJSON(CoreAccountInfo)$values
  # if  (accountinfo$account == "") accountinfo$account <- NULL
  structure(
    list(
      user = accountinfo$value[accountinfo$key == "username"],
      pwd = accountinfo$value[accountinfo$key == "password"],
      account = accountinfo$value[accountinfo$key == "tenant"],
      TenantShortName = accountinfo$value[accountinfo$key == "TenantShortName"],
      coreUrl = accountinfo$value[accountinfo$key == "host"],
      port = accountinfo$value[accountinfo$key == "port"],
      scheme = accountinfo$value[accountinfo$key == "scheme"],
      jsessionId = NULL,
      awselb = NULL,
      employeeId = NULL
    )

    ,
    class = "coreAPI"
  )


}
