
context("Tests for attachRile")


#Test attachFile functionality
#Entity specific info and locations IDs are in testfiles/testEntityValues.R

tapi<-CoreAPI::coreAPI(CoreAccountInfo = "testfiles/account.json")



test_that("Create enitiy example with attribute, project and location ",
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

            #Now attach a file to the entity
            filepath="testfiles/SAgraph.PNG"

            item1<-CoreAPI::attachFile(r$coreApi,item$entity$barcode,filename="SAgraph.png",filepath=filepath,targetAttributeName="",useVerbose=FALSE)

            #Now attach a file to the entity

            items2<-CoreAPI::attachFile(r$coreApi,item$entity$barcode,"SAgraph.png",filepath,targetAttributeName="File",useVerbose=FALSE)




            filepath="testfiles/InvCapMgmtAppExport3.xml"
            items2<-CoreAPI::attachFile(r$coreApi,item$entity$barcode,"InvCapMgmtAppExport3.xml",filepath,targetAttributeName="File",useVerbose=FALSE)

            expect_match(CoreAPI::logOut(r$coreApi)$success,"Success" )


             })





# test_that("Try to attach a file that does not exist ",       #need to finish
#           {
#             filepath="bad_path"
#             r<-CoreAPI::authBasic(tapi)
#             CoreAPI::attachFile(r$coreApi,item$entity$barcode,"SAgraph.png",filepath,targetAttributeName="File",useVerbose=FALSE)
#
#           }
