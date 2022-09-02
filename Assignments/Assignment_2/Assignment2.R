getwd

#find all .csv files in ./Data/
csv_files <- list.files(path = "Data", 
                        pattern = ".csv", 
                        recursive = T, 
                        full.names = T)
#how many are there?
length(csv_files)

#save the file as the object df
wing <- list.files(path = "Data",
           recursive = T, 
           full.names = T,
           pattern = "wingspan_vs_mass.csv")
df <- read.csv(file = wing)

#have the first 5 lines of data shown
head(df,n = 5)

# ^ = "starts with"
# $ = "ends with"
# * = "Inf of anything"
# . = "any single character"

# find all files that start with "b" 
list.files(path = "Data",
           full.names = T,
           pattern = "^b", 
           recursive = T)

# reading in all 3 files the long way
readLines("Data/data-shell/creatures/basilisk.dat", n=1)
readLines("Data/data-shell/data/pdb/benzaldehyde.pdb", n=1)
readLines("Data/Messy_Take2/b_df.csv", n=1)

# the slightly easier way to read the first line of the 3 files
x <- list.files(path = "Data",
                full.names = T,
                recursive = T,
                pattern = "^b") # save line as x
readLines(x[1],n=1) # use [] notation to access those results
readLines(x[2],n=1) # run one at a time
readLines(x[3],n=1)

# for.loop for the first line of "^b" files
for(eachfile in x){
  print(readLines(eachfile,n=1)) # it wont show the results unless you use the print function 
}                   

# for.loop for all .csv files
for(eachfile in csv_files ){print(readLines(eachfile,n=1))}
  
