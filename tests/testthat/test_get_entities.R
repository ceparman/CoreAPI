
context("Tests for getByBarcodeEntity")




test_that("get entity by entity and barcode values",
          { source("testfiles/userAndEntity.R")
            s<-CoreAPI::authBasic(coreUrl,user,pwd)
            js<-s$sessionInfo$jessionid
            item<- CoreAPI::getByBarcodeEntity(coreUrl,js,entityType,barcode)
            id<-item$entity$entityId
            out<-CoreAPI::logOut(coreUrl,js)
            expect_equal(object=id,expected=sampleId)
           })

