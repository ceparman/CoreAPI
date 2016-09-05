

source("tests/testthat/testfiles/user2.R")

login<-CoreAPI::authBasic(coreUrl,user,pwd)

jessionid<-login$sessionInfo$jessionid

useVerbose<-TRUE
entityType<-"CLIENT SAMPLE"
#barcode<-"CS15"
attributeValues<-list(CI_CLIENT_ID = "11111",CI_SENDER="Acme Labs",CI_STATUS="1. New")

newEntity<-CoreAPI::createEntity(coreUrl,jessionid,entityType,attributeValues)
barcode<-newEntity$entity$barcode



filename<-"attachedFile2.txt"
filename2<-"attached_gel.jpg"
filepath<-"README.md"
filepath2<-"gel.jpg"

CoreAPI::attachFile(coreUrl,jessionid,barcode,filename,filepath,targetAttributeName="",useVerbose=TRUE)

attributeValues<-list(CI_STATUS="2. Pathology QC")

CoreAPI::updateEntity(coreUrl,jessionid,entityType,barcode,attributeValues=attributeValues)

CoreAPI::attachFile(coreUrl,jessionid,barcode,filename,filepath,targetAttributeName="CI_CELFILE",useVerbose=FALSE)
CoreAPI::attachFile(coreUrl,jessionid,barcode,filename2,filepath2,targetAttributeName="CI_GEL_FILE",useVerbose=FALSE)


