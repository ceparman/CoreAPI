
context("Tests for authentication ")

source("testfiles/user.R")

test_that("test sourcing login parameters",
          {
           expect_match(coreUrl,"http://experience.platformforscience.com",all=TRUE)
          })


test_that("single account successful login",

          {
          #  source("testfiles/user.R")
           response<- CoreAPI::authBasic(coreUrl,user,pwd)
           expect_that(is.null(response$sessionInfo$jessionid),equals(FALSE))
           expect_match(CoreAPI::logOut(coreUrl,response$sessionInfo$jessionid)$success,"Success" )
           }
          )




test_that("single account with bad password return NULL jsessionID",
          {
            source("testfiles/user.R")
            response<- CoreAPI::authBasic(coreUrl,user,badpwd)
            expect_that(is.null(response$sessionInfo$jessionid),equals(TRUE))}
)


test_that("login with multi account user",
          {
            source("testfiles/user.R")
            response<- CoreAPI::authBasic(coreUrl,muser,mpwd,account)
            expect_that(is.null(response$sessionInfo$jessionid),equals(FALSE))
            expect_match(CoreAPI::logOut(coreUrl,response$sessionInfo$jessionid)$success,"Success" )
            }
)


test_that("single account sucessful login with verbose output",

          { source("testfiles/user.R")
            response<- CoreAPI::authBasic(coreUrl,user,pwd,useVerbose=TRUE)
            expect_that(is.null(response$sessionInfo$jessionid),equals(FALSE))
            expect_match(CoreAPI::logOut(coreUrl,response$sessionInfo$jessionid)$success,"Success" )
            }
)


