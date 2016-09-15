
context("Tests for getEntityByBarcode")

tapi<-CoreAPI::coreAPI(CoreAccountInfo = "testfiles/account.json")



test_that("get entity by entity and barcode values",
          {
            source("testfiles/testEntityValues.R")
            r<-CoreAPI::authBasic(tapi)

            item<- CoreAPI::getEntityByBarcode(r$coreApi,entityType,barcode)
            id<-item$entity$entityId
            out<-CoreAPI::logOut(r$coreApi)
            expect_equal(object=id,expected=sampleId)
           })



