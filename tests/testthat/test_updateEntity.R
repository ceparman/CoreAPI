context("Tests for updateEntity")


#Test updateEntity functionality
#Entity specific info and locations IDs are in testfiles/testEntityValues.R

tapi<-CoreAPI::coreAPI(CoreAccountInfo = "testfiles/53account.json")



test_that("CreatEnitiy example with attribute, project and location then update ",
          { source("testfiles/testEntityValues.R")
            r<-CoreAPI::authBasic(tapi)

            item<-CoreAPI::createEntity(r$coreApi,entityType,attributeValues,
                                        locationId, projectIds,associations=NULL,useVerbose=FALSE)

            type<-item$entity$entityTypeName
            location<-item$entity$locationId
            attribute_name<-names(attributeValues[1])
            attribute_value<-attributeValues[[attribute_name]]
            ret_value<-item$entity[["values"]][[attribute_name]]$stringData

            expect_equal(object=type,expected="PATIENT SAMPLE")
            expect_equal(object=location,expected=locationId)
            expect_equal(object=ret_value,expected=attribute_value)

            expect_equal(object=item$entity$values$SOURCE_LAB$stringData,expected="New York Medical Center")

          #now update the item
            attributeValues$SOURCE_LAB <- "new"
            nitem<-CoreAPI::updateEntity(r$coreApi,item$entity$entityTypeName,item$entity$barcode,attributeValues)

           expect_equal(object=nitem$entity$values$SOURCE_LAB$stringData,expected="new")


          })
#
