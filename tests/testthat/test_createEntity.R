
context("Tests for createEntity")


#Test createEntitiy functionality
#Entity specific info and locations IDs are in testfiles/testEntityValues.R

tapi<-CoreAPI::coreAPI(CoreAccountInfo = "testfiles/account.json")




test_that("Minimal createEnitiy example",
          { source("testfiles/testEntityValues.R")
            r<-CoreAPI::authBasic(tapi)
            item<- CoreAPI::createEntity(r$coreApi,entityType)
            type<-item$entity$entityTypeName
            out<-CoreAPI::logOut(r$coreApi)
            expect_equal(object=type,expected="PATIENT SAMPLE")
          })

 test_that("CreatEenitiy example with attribute, project and location ",
           { source("testfiles/testEntityValues.R")
             r<-CoreAPI::authBasic(tapi)

             item<-CoreAPI::createEntity(r$coreApi,entityType,attributeValues,
                                                    locationId, projectIds,associations=NULL,useVerbose=FALSE)
             out<-CoreAPI::logOut(r$coreApi)
             type<-item$entity$entityTypeName
             location<-item$entity$locationId
             attribute_name<-names(attributeValues[1])
             attribute_value<-attributeValues[[attribute_name]]
             ret_value<-item$entity[["values"]][[attribute_name]]$stringData

             expect_equal(object=type,expected="PATIENT SAMPLE")
             expect_equal(object=location,expected=locationId)
             expect_equal(object=ret_value,expected=attribute_value)

           })
#
#
#
#
#
#
