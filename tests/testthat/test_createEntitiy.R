
context("Tests for getByBarcodeEntity")


#Test createEntitiy functionality
#Entity specific info and locations IDs are in testfiles/userAndEntity.R




test_that("Minimal createEnitiy example",
          { source("testfiles/userAndEntity.R")
            s<-CoreAPI::authBasic(coreUrl,user,pwd)
            jessionid<-s$sessionInfo$jessionid
            item<- CoreAPI::createEntity(coreUrl,jessionid,entityType)
            type<-item$entity$entityTypeName
            out<-CoreAPI::logOut(coreUrl,jessionid)
            expect_equal(object=type,expected="PATIENT SAMPLE")
          })

test_that("CreatEenitiy example with attribute, project and location ",
          { source("testfiles/userAndEntity.R")
            s<-CoreAPI::authBasic(coreUrl,user,pwd)
            jessionid<-s$sessionInfo$jessionid
            item<-CoreAPI::createEntity(coreUrl,jessionid,entityType,attributeValues,
                                                   locationId, projectIds,associations=NULL,useVerbose=FALSE)
            out<-CoreAPI::logOut(coreUrl,jessionid)
            type<-item$entity$entityTypeName
            location<-item$entity$locationId
            attribute_name<-names(attributeValues[1])
            attribute_value<-attributeValues[[attribute_name]]
            ret_value<-item$entity[["values"]][[attribute_name]]$stringData

            expect_equal(object=type,expected="PATIENT SAMPLE")
            expect_equal(object=location,expected=locationId)
            expect_equal(object=ret_value,expected=attribute_value)

          })






