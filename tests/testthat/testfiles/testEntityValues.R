
entityType<-"PATIENT SAMPLE"
lotType<- "PATIENT SAMPLE LOT"
barcode<-"PS1"
sampleId<-9531054

#required create entities

attributeValues<-list(SOURCE_LAB = "New York Medical Center",Number = 5,REQUESTOR="CEP")
associations<-list(SAMPLE_ENZYME=data.frame(name="",entitiyId="",barcode="ENZ1"))
locationId<-6204106
projectIds<-5000005

#Container data

containerType <- "VIAL"
cellNum <-1
containerSampleLot<- "PS137-1"


#test data
experimentType <- "TEST EXPERIMENT"
experimentBarcode <- "TE1"
experimentSampleType <- "TEST EXPERIMENT SAMPLE"

#assay data

assayBarcode <- "TA1"

assayAttributeValues1 <- list(ASSAY_ATTRIBUTE = "data1", ASSAY_ATTRIBUTE2 = 23.1)
assayAttributeValues2 <- list(ASSAY_ATTRIBUTE = "data2", ASSAY_ATTRIBUTE2 = 24.1)

#protocol data

protocolBarcode <- "ZE1"

#filled container

containerBarcode <- "VIA7"

sampleLot <- "PS160-1"
