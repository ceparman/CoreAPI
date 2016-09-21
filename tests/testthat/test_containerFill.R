


context("Tests for create sample, create sample lot, create container, put lot in container cell")



tapi<-CoreAPI::coreAPI(CoreAccountInfo = "testfiles/account.json")




test_that("full sample to container cycle",
          {
            source("testfiles/testEntityValues.R")
            r<-CoreAPI::authBasic(tapi)
            #create Sample
            item<- CoreAPI::createEntity(r$coreApi,entityType)
            type<-item$entity$entityTypeName

            expect_equal(object=type,expected="PATIENT SAMPLE")
            sampleBarcode<-item$entity$barcode

            #create lot

            lot<-CoreAPI::createSampleLot(r$coreApi,"PATIENT SAMPLE LOT",sampleBarcode)
            expect_equal(object=lot$entity$superTypeName, expected="SAMPLE_LOT")

            lot_barcode <- lot$entity$barcode

            #create container

            cont <- CoreAPI::createEntity(r$coreApi,containerType)

            cont_barcode <- cont$entity$barcode

            #fill container

            uc<-CoreAPI::updateCellContents(r$coreApi,containerType,cont_barcode,"1", lot_barcode,2, "mL", 3, "mg/mL")

            expect_equal(object=uc$entity$cells[[1]]$amount[1], expected=2)

            #Get cell contents

            cc<-CoreAPI::getCellContents(r$coreApi, cont_barcode, "1")


            expect_equal(object=cc$entity$cells[[1]]$cellContents[[1]]$lotName, expected=lot_barcode)


            # create new container

            cont2 <- CoreAPI::createEntity(r$coreApi,containerType)


            #get cell IDs


            contCell <- CoreAPI::getCellContents(r$coreApi,cont$entity$barcode,"1")
            sourceCellID <-contCell$entity$cells[[1]]$cellId

            cont2Cell<- CoreAPI::getCellContents(r$coreApi,cont2$entity$barcode,"1")

            destCellID <- cont2Cell$entity$cells[[1]]$cellId



            #Get amounts move all

            amount <- contCell$entity$cells[[1]]$amount

             amountUnit <- contCell$entity$cells[[1]]$amountUnit



            concentration <- contCell$entity$cells[[1]]$cellContents[[1]]$concentration



            concentrationUnit <- contCell$entity$cells[[1]]$cellContents[[1]]$concentrationUnit

            #now transfer contents

            tc<-transferCellContents(r$coreApi,sourceCellID,destCellID,amount,concentration,
                                            amountUnit, concentrationUnit,useVerbose = FALSE)



            expect_equal(object=tc$entity$cells[[1]]$cellContents[[1]]$lotBarcode, expected=lot_barcode)

            #test lineage


           lineage<-CoreAPI::getContainerLineage(r$coreApi,cont2$entity$barcode)

           expect_equal(object=lineage$entity$parents[[1]]$name,
                        expected=cont$entity$barcode )

            out<-CoreAPI::logOut(r$coreApi)
          })





