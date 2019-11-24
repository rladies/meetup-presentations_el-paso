# R-Ladies El Paso
# Wed 11/20 5pm
# Code-along
# Elise Bell & Grace Smith Vidaurre
# Goals for today:
  # summarize a data set
  # view specific parts of a data set
  # what are regular expressions?
  # regular expression commands in R
  # regular expressions on strings
  # regular expressions over data sets

# Skip to step 1 iff:
# you already have the packages 'dplyr' and 'languageR' installed
# you have wifi and can download the packages directly

# 0. Install packages from flash drive if necessary

# Check working directory, and change to folder containing data if necessary
getwd()
setwd("~/Desktop/20191120_RLadies") # may need editing depend on PC vs Mac, please ask if you need help!
getwd() # Check that the working directory was indeed changed

# Read the package filenames and install
pkgFilenames <- read.csv("packages/pkgFilenames.csv", stringsAsFactors = FALSE)[, 1]
install.packages(pkgFilenames, repos = NULL, type = "binary")

# 1. Load libraries and set working directory

# install.packages("dplyr", "languageR")
library(dplyr)
library(languageR) 

# 2. Read in data
data <- read.csv("marvel-wikia-data.csv", header = TRUE)


# 3. View a summary of data
summary(data)

# 4. Calculate the mean number of appearances using the dplyr package
# Dplyr provides the flexibility to summarize the data in different ways
data %>%
  summarize(char_n = n(),
            mean = mean(APPEARANCES, na.rm = TRUE))

# We could also save the result of that command as a new dataframe
summ <- data %>%
  summarize(char_n = n(),
            mean = mean(APPEARANCES, na.rm = TRUE))
# And view the results
summ

# Something went wrong - there's no result for 'mean' in the data
## Without specifying not to include NAs in the data, we get NA as our result

# 5. Redo the calculation of the mean number of appearances while taking NAs into account
data %>%
  summarize(char_n = n(),
            mean = mean(APPEARANCES, na.rm = TRUE))


# 6. This summary above isn't very useful. 
# For instance, it would be more useful to ask how what the mean appearances are in the data set 
# for characters with different sexes and types of eyes 
# (each of these is a column of type factor in the data)

# To get summary values for different groups within the data, we can use group_by():
# Add the column names necessary to group the results by character sex and eye color
summ <- data %>%
  group_by(SEX, EYE) %>%
  summarize(char_n = n(),
            mean = mean(APPEARANCES, na.rm = TRUE))


# 7. Let's say we want the same summary as above, but we want to exclude characters that have black eyes 
# (i.e. we want to exclude one level of the EYE factor column):
data %>%
  group_by(SEX, EYE) %>%
  filter(EYE != "Black Eyes") %>%
  summarize(char_n = n(),
            mean = mean(APPEARANCES, na.rm = TRUE))

# 8. Dplyr piping lets you calculate summary variables internally without returning them after every command

# Here we want to filter by characters that appear less then the mean number of appearances across characters, 
# then summarize the number of characters in each combination of the sex and eye categories
data %>%
  group_by(SEX, EYE) %>%
  summarize(char_n = n()) %>%
  filter(APPEARANCES < mean(APPEARANCES, na.rm = TRUE))
  
# Why doesn't the command above work? (Hint: functions are run line by line in a piped command)
data %>%
  filter(APPEARANCES < mean(APPEARANCES, na.rm = TRUE)) %>%
  group_by(SEX, EYE) %>%
  summarize(char_n = n())

# 9. Use these commands to produce a summary table that has 
# the N and mean appearances for only characters with blue eyes, separated by sex?
data %>%
  filter(EYE == "Blue Eyes") %>%
  group_by(SEX) %>%
  summarize(char_n = n(),
            mean = mean(APPEARANCES, na.rm = TRUE),
            median = median(APPEARANCES, na.rm=TRUE),
            max = max(APPEARANCES, na.rm = T))

# 10. Filtering data using base R expressions

# In base R, to 'filter' data, you usually do something like this:
blue.eye.subset <- data[data$EYE == "Blue Eyes",]

# data[ROWS,COLUMNS] (easy to remember RC Cola for the order of rows & column)
# The command above says 'give me all the rows of data where the column EYES is equal to "blue eyes"'
# You could also say data[,c("NAME", "EYE", "HAIR")] = 'give me all the rows, but only the columns called "NAME", "EYE", and "HAIR"'
# Knowing this format is helpful if you want a quick way to look at a subset of your data
View(data[data$HAIR == "Brown Hair",])

# Modify the command above  to quickly see the data where eye color is equal to "Brown Eyes":



# This type of filtering is the equivalent of the filtering we just did above using piping in the dplyr package. 
# There are other, more flexible ways of filtering your data, in particular, methods based on "regular expressions".

# 11. Employing regular expression to filter data

# Regular expression is a very flexible way of searching for specific words, characters, or patterns in your data
# This can be useful when pre-processing or analyzing your data. 
# You can think of regular expression in R (or other coding languages) as the equivalent of searching for a pattern in an Excel sheet. 
# In Excel, pressing the Ctrl/cmd + F keys gives you a search box to type a pattern, 
# then hitting enter gives you all the instances where that pattern appears in the spreadsheet. 

# For example, you may want to find all instances of the name "Steve", or 
# find everything that looks like it could be a date "17-July-2019" & "July 17, 2019" etc, 
# or find everything that begins with a capital letter, like "Polish" but not "polish".

# Here are some basic examples, starting with grep() which is R's basic regex command. 
# The grep() command takes two main arguments, the pattern (what you're looking for) and the string (where to look).

# NB: The 'string' can be a single string ("word") or a vector of strings c("a", "lot", "of", "strings")

# If you've never used grep() before, check out the function documentation first:
?grep

# Create a vector of strings, we will use this to search for patterns
test.strings <- c("abcdefg", "hijklmnop", "qrstuv", "wxyandz")

# What does a grep() command return?
grep(pattern = "abc", x = test.strings) # this says 'find the pattern "abc" in the variable called test.strings'
grep("lmno", test.strings)
grep("and", test.strings)

# What pattern do you need to return the result 1, 4
grep("a", test.strings)

# Add in the pattern that returns the result 4
grep("", test.strings)


# 12. Special characters make regular expression a very powerful filtering method

# Regular expression is an advanced form of pattern searching, and has a subset of special characters that have cool properties. 
# All the special regex symbols can be found by typing ?regex in the command line. 
# For example, the documentation will tell you the difference between $ and \\>. 
# R documentation can be confusing, though. Sometimes it's easier to Google the problem rather than trying a million regexes in a row!

# Try out the examples below to learn what the specific symbols do:
grep("^a", test.strings)
grep("^q", test.strings)
grep("tuv$", test.strings)
grep("tuv\\>", test.strings)
grep("[[:alpha:]]", test.strings)
grep("[[:digit:]]", test.strings)
grep("ABCDEFG", test.strings)
grep("ABCDEFG", test.strings, ignore.case = TRUE)


# 13. Trying out another regular expression function

# grepl() is another regex function in R. What is the main difference between grep() and grepl()?
grep(pattern = "abc", x = test.strings) # this says 'find the pattern "abc" in the variable called test.strings'
grepl(pattern = "abc", x = test.strings) # this says 'find the pattern "abc" in the variable called test.strings'

# Create a new vector of strings
test.strings2 <- c("abc", "aaa", "aaaaaaaa", "bbb", "abab", "baaa", "")

# Perform pattern searches
grepl("a", test.strings2)
grepl("a?", test.strings2)
grepl("a+", test.strings2)
grepl("ab*", test.strings2)
grepl(".", test.strings2)
grepl("[ab]{1,3}", test.strings2)
grepl("(ab){1,3}", test.strings2) # how is [ab] different than (ab)?


# 14. Practicing regular expression with a larger data set.

# To practice regular expressions, it's handy to have a big data set to play with that's already set up for this sort of thing. 
# Some examples below require the 'oz' data set from the 'languageR' package'

# Load the oz data (the languageR package must already be installed and loaded for this command to work)
data(oz)

# The oz object is a vector of strings (information in the form of characters)
class(oz)

# Let's figure out how many times the pattern "Dorothy" appears in the oz vector:

# You could do this with grep()... How?
dorothy.locs.grep <- grep("Dorothy", oz)
# Check the results:
dorothy.locs.grep

# How about grepl() ?
dorothy.locs.grepl <- grepl("Dorothy", oz)
# Check the results:
dorothy.locs.grepl

# Compare the results - they're not really readable by humans.
# What is the structure of the grepl() result compared to the grep() result? What does each result contain?

# Think about how long each result variable is. Use the command length() to check: 

length(dorothy.locs.grep)
length(dorothy.locs.grepl)

#How can you summarize each of them in a useful way?
?which
length(which(dorothy.locs.grepl))
sum(dorothy.locs.grepl) # Why does sum() give the same result as which()?


# 15. Use regular expression to filter superhero names in the Marvel data set 

# Let's say we want to investigate just the characters whose superhero names include -man (Wonderwoman, Spiderman etc.). 
# This is a little tricky, because the pattern "man" is just part of these superheroes' names, it is not a unique value in the column, nor a level of the factor variable. 
# How would you use regular expressions to pick out just the superheroes with 'man' in their names?

# First, save the pattern that you want to use:
pattern <- "man\\>"

# Then test it on just one string "spiderman" to see if it works. If it doesn't, try again!
grep(pattern, "spiderman")

# When you're happy with your pattern, try it out on the full list of superhero names
# Remember, you just want the column that contains the character names
# You can do this by referencing the column name: dataset[,c("COLUMN")]
# Or by referencing the location of the column: dataset[,2]
superheroes <- data[,c("name")] # add in the column reference you want here
superheroes <- data$name # add in the column reference you want here

grep(pattern, superheroes)

# It's probably easier to save the output from grep (numeric indices) as a variable
man.locs <- grep(pattern, superheroes)


# 16. Use regular expression to filter other superhero attributes in the Marvel data set 

# We need to *apply* the regular expression results to the whole data set, keeping only things that match. 
# We already know how to do this with levels of a factor.
# For example, this command keeps only the "blue eyes" level of the "EYES" factor
data[data$EYES == "Blue Eyes",]

# We can use regular expressions the same way, by including the grepl() command inside the [] square brackets

# What data will this command pull out? Make a prediction before you run it.
View(data[grepl("Steve", data$name), ])

# What about this one?
View(data[grep("bl", data$EYE),])

# Probably that wasn't what you expected. 
# Search the grep() documentation to learn how to make the command ignore whether the string is in upper or lower case letters.
View(data[grep("bl", data$EYE, ...),])

# Apply your grep command for 'man' to the superhero as a whole, and use View() to look over the result:
View(...)

# Any problems with the results you get?

# Try to overcome the following potential issues by editing your regex pattern:

# - What if their name has 'man' somewhere else, not just at the end? (like 'Natalia Romanova")
# - What if you want to keep characters whose name ends in 'woman', but not ones whose name ends in 'man'?
# - What else might cause a problem?


# 17. How to use regular expressions with tidyverse:

summ <- data %>% 
  filter(grepl("man\\>", name)) %>%
  filter(ID != "Public Identity") %>%
  group_by(SEX, ALIGN) %>%
  summarize(char_n = n(),
            mean = mean(APPEARANCES, na.rm=T),
            name_list=paste(name, collapse=', '))
