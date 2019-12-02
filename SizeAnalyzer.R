
if(!require(tools)) {install.packages(tools)}

AllowExtensions = c("java")

AllowExtensions = tolower(AllowExtensions)


#list files in a browsed folder
files <- list.files(path ="data", recursive = TRUE)

sizes = data.frame(file=character(),
                   width=numeric(),
                   height=numeric(),
                   stringsAsFactors=FALSE
                   )

cnt= 1
maxFiles=length(files)

for (f in files) {
  cat("read ", cnt, "/", maxFiles,": ", f, sep="")
  if (tolower(tools::file_ext(paste0("data/",f))) %in% AllowExtensions) {
    sourcecode = scan(paste0("data/",f), 
                      what=character(), 
                      blank.lines.skip = FALSE,
                      quiet=TRUE,
                      sep="\n"
                      )
     sizes[nrow(sizes)+1,] = list(file=f,
                                  width=max(nchar(sourcecode)),
                                  height=length(sourcecode)
                                  )
  } else { cat(": skipped.")}
  cat("\n")
  cnt=cnt+1
}


hist(sizes$width, breaks=seq(from=0, to=max(sizes$width), by=10))
abline(v=80, col="red")