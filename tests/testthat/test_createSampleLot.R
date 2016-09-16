
context("Tests for samples and lota")


#Test createEntitiy functionality
#Entity specific info and locations IDs are in testfiles/testEntityValues.R

tapi<-CoreAPI::coreAPI(CoreAccountInfo = "testfiles/account.json")




test_that("Minimal sample lot example",
          { source("testfiles/testEntityValues.R")
            r<-CoreAPI::authBasic(tapi)
            item<- CoreAPI::createEntity(r$coreApi,entityType)
            type<-item$entity$entityTypeName

            expect_equal(object=type,expected="PATIENT SAMPLE")
            sampleBarcode<-item$entity$barcode
            lot<-CoreAPI::createSampleLot(r$coreApi,"PATIENT SAMPLE LOT",sampleBarcode)
            expect_equal(object=lot$entity$superTypeName, expected="SAMPLE_LOT")
            out<-CoreAPI::logOut(r$coreApi)
            })

