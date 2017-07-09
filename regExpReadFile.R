## Read the file from the path (parameter path2file) 
## Parameters 
##  @path2file --> character value to the complete path file
##  @regexp --> regular expresion to apply for each row
##  @trans --> define if the matrix would be transposed before transform in a data set 
## Result
##  resultObject --> Contains the dataframe with the file information
regExpReadFile <- function (path2file, regexp = "N/A", trans = FALSE) {
    ##Create a connection to the file
    conn <- file(path2file, "r")
    ##Read the fille by lines
    resultObject <- readLines(conn)
    resultObject <- trimws(resultObject)
    if (regexp != "N/A")  {
        ##Split lines by regexp pattern
        resultObject <- strsplit(resultObject, regexp)        
    }
    ##Close connection
    close(conn)
    if (trans) {
        resultObject <- t(sapply(resultObject, c))
    } else {
        resultObject <- sapply(resultObject, c)
    }
    resultObject
}