
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



          newExptbarcode <-item$entity$barcode

          #add a container which creates an experiment sample


         update<-CoreAPI::updateExperimentContainers(r$coreApi,containerBarcode, experimentType, newExptbarcode,useVerbose = FALSE)

         expt<-CoreAPI::getExperimentSamples(r$coreApi,"TEST EXPERIMENT",newExptbarcode,useVerbose=FALSE)

         expect_match(expt$entity$experimentSamples[[1]]$sampleEntityBarcode,containerSampleLot)

         # create a experient sample from a sample lot



       secondSample<-CoreAPI::createExperimentSample(r$coreApi,experimentSampleType,sampleLot,newExptbarcode,useVerbose=FALSE)


       expt<-CoreAPI::getExperimentSamples(r$coreApi,"TEST EXPERIMENT",newExptbarcode,useVerbose=FALSE)

       expect_match(expt$entity$experimentSamples[[2]]$sampleEntityBarcode,sampleLot)

       #add experiment data

       CoreAPI::updateExperimentSampleData(r$coreApi,experimentSampleType,expt$entity$experimentSamples[[1]]$barcode,
                                           assayAttributeValues1,useVerbose=TRUE)

       CoreAPI::updateExperimentSampleData(r$coreApi,experimentSampleType,expt$entity$experimentSamples[[2]]$barcode,
                                           assayAttributeValues2,useVerbose=TRUE)


       publish<- experimentPublish(r$coreApi, experimentType,newExptbarcode,useVerbose = FALSE)



      unpublish<- experimentUnPublish(r$coreApi, experimentType,newExptbarcode,useVerbose = FALSE)



        expect_match(CoreAPI::logOut(r$coreApi)$success,"Success" )

          })
