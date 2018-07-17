
context("Tests for authentication ")

#create coreApi object

tapi<-CoreAPI::coreAPI(CoreAccountInfo = "testfiles/53account.json")



 test_that("test sourcing login parameters",
           {
            expect_match(tapi$coreUrl, "rshinyexperience02test.platformforscience.com",all=TRUE)
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
            expect_error(  response<- CoreAPI::authBasic(bapi))
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

