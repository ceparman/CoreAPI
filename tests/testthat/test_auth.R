
context("Tests for authentication ")

#create coreApi object

tapi<-CoreAPI::coreAPI(CoreAccountInfo = "testfiles/account.json")



 test_that("test sourcing login parameters",
           {
            expect_match(tapi$coreUrl,"http://experience.platformforscience.com",all=TRUE)
           })


 test_that("single account successful login",

           {
            response<- CoreAPI::authBasic(tapi)
            expect_that(is.null(response$coreApi$jsessionId),equals(FALSE))
            expect_match(CoreAPI::logOut(response$coreApi)$success,"Success" )
            }
           )

bapi<-tapi
bapi$pwd <-"bad"

 test_that("single account with bad password return NULL jsessionID",
           {
             response<- CoreAPI::authBasic(bapi)
             expect_that(is.null(response$coreApi$jsessionId),equals(TRUE))}
  )

 mapi<-CoreAPI::coreAPI(CoreAccountInfo = "testfiles/multiaccount.json")

 test_that("login with multi account user",
           {

             response<- CoreAPI::authBasic(mapi)
             expect_that(is.null(response$coreApi$jsessionId),equals(FALSE))
             expect_match(CoreAPI::logOut(response$coreApi)$success,"Success" )
             }
 )



 test_that("single account sucessful login with verbose output",

           {
             response<- CoreAPI::authBasic(tapi,useVerbose=FALSE)
             expect_that(is.null(response$coreApi$jsessionId),equals(FALSE))
             expect_match(CoreAPI::logOut(response$coreApi)$success,"Success" )

             }
 )
#

