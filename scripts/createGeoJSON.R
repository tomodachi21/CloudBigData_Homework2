#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)
.libPaths("/home/ubuntu/R_libs")
library(jsonlite)

print("outside for loop")
for(n in args){

print("inside for loop")
print("parsing data")
export <- data.frame(text = "", lat = "", long = "", screename = "", url = "", senti = "")

tryCatch({
fileName <- paste("/home/ubuntu/JSON_Files/", n, ".txt", sep="")
output <- data.frame(text = readLines(fileName))

print(fileName)
print("Read File")
sources <- ""
print("Finding sources")
sources <- c(sources, grep("_source", output$text, ignore.case=TRUE))
sources <- sources[-1]
print("finished sources")

for(i in 1:(length(sources)-1)){
if(nchar(toString(output$text[sources[i]])) > 17){
sources <- sources[-i]
}}

print("parsing data")
for(i in 1:(length(sources)-1)){
sub <- output$text[as.numeric(sources[i]):(as.numeric(sources[i+1])-1)]
if(length(grep("type\" : \"Point", sub, ignore.case=TRUE)) != 0){
print("Yes - GeoLocation")
ind = grep("type\" : \"Point", sub, ignore.case=TRUE)
loc = strsplit(toString(sub[ind[1]+1]), ":")[[1]][2]
lat = strsplit(strsplit(loc, ",")[[1]][2], " ")[[1]][2]
lng = strsplit(strsplit(loc, ",")[[1]][1], " ")[[1]][3]
txt = gsub("https", "", substring(strsplit(toString(sub[4]), ":")[[1]][2],3,nchar(strsplit(toString(sub[4]), ":")[[1]][2])))
screename = gsub('\"', "", gsub(",","",gsub(" ", "",strsplit(toString(sub[grep("screen_name", sub, ignore.case=TRUE)[length(grep("screen_name", sub, ignore.case=TRUE))]]),":")[[1]][2]))) 
url = gsub(",", "", gsub('\"', "", (strsplit(toString(sub[grep("expanded_url", sub, ignore.case=TRUE)[1]]), " : ")[[1]][2])))
insert <- data.frame(text = txt, lat = lat, long = lng, screename = screename, url = url, senti = "neutral")
export <- rbind(export, insert) 
}}  
    
}, error = function(err) {
print(fileName) 
print("Read File")
sources <- ""
print("Finding sources")
sources <- c(sources, grep("_source", output_pos$text, ignore.case=TRUE))
sources <- sources[-1]
print("finished sources")

for(i in 1:(length(sources)-1)){
if(nchar(toString(output_pos$text[sources[i]])) > 17){
sources <- sources[-i]
}}

print("parsing data")
for(i in 1:(length(sources)-1)){
sub <- output_pos$text[as.numeric(sources[i]):(as.numeric(sources[i+1])-1)]
if(length(grep("type\" : \"Point", sub, ignore.case=TRUE)) != 0){
print("Yes - GeoLocation")
ind = grep("type\" : \"Point", sub, ignore.case=TRUE)
loc = strsplit(toString(sub[ind[1]+1]), ":")[[1]][2]
lat = strsplit(strsplit(loc, ",")[[1]][2], " ")[[1]][2]
lng = strsplit(strsplit(loc, ",")[[1]][1], " ")[[1]][3]
txt = gsub("https", "", substring(strsplit(toString(sub[4]), ":")[[1]][2],3,nchar(strsplit(toString(sub[4]), ":")[[1]][2])))
screename = gsub('\"', "", gsub(",","",gsub(" ", "",strsplit(toString(sub[grep("screen_name", sub, ignore.case=TRUE)[length(grep("screen_name", sub, ignore.case=TRUE))]]),":")[[1]][2])))
url = gsub(",", "", gsub('\"', "", (strsplit(toString(sub[grep("expanded_url", sub, ignore.case=TRUE)[1]]), " : ")[[1]][2])))
insert <- data.frame(text = txt, lat = lat, long = lng, screename = screename, url = url, senti = "positive")
export <- rbind(export, insert)
}}

}, error = function(err) {
print(fileName_pos)
print("does not exist")
})

tryCatch({
fileName_neg <- paste("/home/ubuntu/JSON_Files/", n, "_neg.txt", sep="")
output_neg <- data.frame(text = readLines(fileName_neg))

print(fileName_neg)
print("Read File")
sources <- ""
print("Finding sources")
sources <- c(sources, grep("_source", output_neg$text, ignore.case=TRUE))
sources <- sources[-1]
print("finished sources")
print("Read File")
sources <- ""
print("Finding sources")
sources <- c(sources, grep("_source", output_neg$text, ignore.case=TRUE))
sources <- sources[-1]
print("finished sources")

for(i in 1:(length(sources)-1)){
if(nchar(toString(output_neg$text[sources[i]])) > 17){
sources <- sources[-i]
}}

for(i in 1:(length(sources)-1)){
sub <- output_neg$text[as.numeric(sources[i]):(as.numeric(sources[i+1])-1)]
if(length(grep("type\" : \"Point", sub, ignore.case=TRUE)) != 0){
print("Yes - GeoLocation")
ind = grep("type\" : \"Point", sub, ignore.case=TRUE)
loc = strsplit(toString(sub[ind[1]+1]), ":")[[1]][2]
lat = strsplit(strsplit(loc, ",")[[1]][2], " ")[[1]][2]
lng = strsplit(strsplit(loc, ",")[[1]][1], " ")[[1]][3]
txt = gsub("https", "", substring(strsplit(toString(sub[4]), ":")[[1]][2],3,nchar(strsplit(toString(sub[4]), ":")[[1]][2])))
screename = gsub('\"', "", gsub(",","",gsub(" ", "",strsplit(toString(sub[grep("screen_name", sub, ignore.case=TRUE)[length(grep("screen_name", sub, ignore.case=TRUE))]]),":")[[1]][2])))
url = gsub(",", "", gsub('\"', "", (strsplit(toString(sub[grep("expanded_url", sub, ignore.case=TRUE)[1]]), " : ")[[1]][2])))
insert <- data.frame(text = txt, lat = lat, long = lng, screename = screename, url = url, senti = "negative")
export <- rbind(export, insert)
}}

}, error = function(err) {
print(fileName_neg)
print("does not exist")
})

export <- export[2:(dim(export)[1]),]
jsn <- toJSON(export, pretty=TRUE)
path = paste("/home/ubuntu/JSON_Files/output/", n, ".json", sep="")
print(path)
write(jsn, path)}