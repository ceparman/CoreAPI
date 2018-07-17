
context("Tests for createEntity")


#Test createEntitiy functionality
#Entity specific info and locations IDs are in testfiles/testEntityValues.R

tapi<-CoreAPI::coreAPI(CoreAccountInfo = "testfiles/53account.json")




test_that("Minimal createEnitiy example",
          { source("testfiles/testEntityValues.R")
            r<-CoreAPI::authBasic(tapi)
            item<- CoreAPIV2::createEntity(r$coreApi,entityType,body=NULL,useVerbose=FALSE)
            type<-item$entity$`@odata.context`
            out<-CoreAPI::logOut(r$coreApi)
            expect_equal(object=type,expected="https://rshinyexperience02test.platformforscience.com/odata/$metadata#PATIENT_SAMPLE/$entity")
          })

 # test_that("CreatEenitiy example with attribute, project and location ",
 #           { source("testfiles/testEntityValues.R")
 #             r<-CoreAPI::authBasic(tapi)
 # 
 #            # item<-CoreAPI::createEntity(r$coreApi,entityType,attributeValues,
 #            #                                        locationId, projectIds,associations=NULL,useVerbose=FALSE)
 #             
 #             item<-CoreAPIV2::createEntity(r$coreApi,entityType,body=NULL)
 #             
 #             
 #             out<-CoreAPI::logOut(r$coreApi)
 #             type<-item$entity$entityTypeName
 #             location<-item$entity$locationId
 #             attribute_name<-names(attributeValues[1])
 #             attribute_value<-attributeValues[[attribute_name]]
 #             ret_value<-item$entity[["values"]][[attribute_name]]$stringData
 # 
 #             expect_equal(object=type,expected="PATIENT SAMPLE")
 #             expect_equal(object=location,expected=locationId)
 #             expect_equal(object=ret_value,expected=attribute_value)
 # 
 #           })
#
#
#
#
#
#
