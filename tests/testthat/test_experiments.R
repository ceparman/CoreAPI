
context("Tests for experiments, assays and protocols")



tapi<-CoreAPI::coreAPI(CoreAccountInfo = "testfiles/account.json")



test_that("Get an experiment ",
        { source("testfiles/testEntityValues.R")

        r<-CoreAPI::authBasic(tapi)

        item <- CoreAPI::getEntityByBarcode(r$coreApi,entityType = experimentType,barcode = experimentBarcode)

        expect_match(item$entity$barcode,experimentBarcode)

        expect_match(CoreAPI::logOut(r$coreApi)$success,"Success" )

        })


test_that("Create an experiment ",
          { source("testfiles/testEntityValues.R")

            r<-CoreAPI::authBasic(tapi)

            item <- CoreAPI::createEntity(r$coreApi,entityType = experimentType,attributeValues = list(TEST_ATTRIBUTE = "a value"),
                                          associations = list(EXPERIMENT_ASSAY=data.frame(name="",entityId ="",barcode=assayBarcode),
                                                              EXPERIMENT_PROTOCOL=data.frame(name="",entityId ="",barcode=protocolBarcode)
                                                              )
                                         )

            print(item$entity)

            newExptbarcode <-item$entity$barcode

          #add a sample

            update<-CoreAPI::updateExperimentContainers(r$coreApi,containerBarcode, experimentType, newExptbarcode,useVerbose = TRUE)


            print(httr::content(update$response))

            publish<- experimentPublish(r$coreApi, experimentType,newExptbarcode,useVerbose = FALSE)

            print(httr::content(publish$response))

            unpublish<- experimentUnPublish(r$coreApi, experimentType,newExptbarcode,useVerbose = FALSE)

            print(httr::content(unpublish$response))

            expect_match(CoreAPI::logOut(r$coreApi)$success,"Success" )

          })
