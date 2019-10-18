---
title       : Getting Started
subtitle    : R-Ladies El Paso
author      : Elise Bell
job         : 
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## Welcome!

Today we will
- learn about R and RStudio [^1]
- load some data
- examine and manipulate the data







[^1]: h/t to Mine Cetinkaya-Rundel for slideshow inspiration (http://rpubs.com/minebocek/rladies-dplyr-tidyr)

--- .class #id 

## R and RStudio

- **R** is the programming language
- **RStudio** is an environment that makes using R easier
- Free and open-source!

## Getting started

- Install R: https://cran.r-project.org/

- Install RStudio: https://www.rstudio.com/products/RStudio/#Desktop

--- .class #id 

## Anatomy of RStudio

- Left: Console
    - Text on top at launch: version of R that you’re running
    - Below that is the prompt
- Upper right: Workspace and command history
- Lower right: Plots, access to files, help, packages, data viewer

--- .class #id 

## What version am I using?

- The version of R is in the text that pops up in the Console when you start RStudio

- To find out the version of RStudio go to Help > About RStudio

- It's good practice to keep both R and RStudio up to date

--- .class #id 

## R packages

- Packages are the fundamental units of reproducible R code. They include reusable R
functions, the documentation that describes how to use them, and (often) sample data.
(From: http://r-pkgs.had.co.nz)

- Install these packages by running the following in the Console:

```r
install.packages("readr")
install.packages("tidyr")
install.packages("dplyr")
install.packages("ggplot2")
```

- Then, load the packages by running the following:

```r
library(readr)
library(tidyr)
library(dplyr)
#library(ggplot2)
```
    
--- .class #id 

# Keeping track of your code

## Two options: R Script or R Markdown

- Do not just type code in the Console, it's error prone (especially typo prone!) and hard to keep track of

- Use one of the two following options:
  + R Script: File -> New File -> R Script
  + R Markdown: File -> New File -> R Markdown

--- .class #id 

## R Script

- Type your code in the R Script

- Use cursor + Run or highlight + Run

- Shortcut for Run button: Command + Enter

- Use `#` for comments

--- .class #id 

## R Markdown

- R Markdown is an authoring format that enables easy creation of dynamic 
documents, presentations, and reports from R. 

- R Markdown documents are fully **reproducible** (they can be 
automatically regenerated whenever underlying R code or data changes).

- Code goes in code 'chunks'

- Comments can go in the chunks with `#` or just as plain text outside the chunks

Source: http://rmarkdown.rstudio.com/

--- .class #id

## Where are you?


```r
# Find working directory
getwd()
```

```
## [1] "/Users/elisebell1/Documents/GitHub/rladies-ep-intro"
```

```r
# Change working directory
setwd("~/Documents/GitHub/rladies-ep-intro/")
# Check
#getwd()
# What is in your working directory?
list.files()
```

```
## [1] "assets"                 "index.html"            
## [3] "index.md"               "index.Rmd"             
## [5] "libraries"              "marvel-wikia-data.csv" 
## [7] "marvel-wikia-data1.csv" "movies.csv"            
## [9] "StarWars.csv"
```


--- .class #id 

## Loading data

Comic book characters (FiveThirtyEight https://fivethirtyeight.com/features/women-in-comic-books/)


```r
data <- read.csv("marvel-wikia-data1.csv")
# You can download the data from https://github.com/fivethirtyeight/
# data/blob/master/comic-characters/marvel-wikia-data.csv
names(data)
```

```
##  [1] "name"             "urlslug"          "ID"              
##  [4] "ALIGN"            "EYE"              "HAIR"            
##  [7] "SEX"              "GSM"              "ALIVE"           
## [10] "APPEARANCES"      "FIRST.APPEARANCE" "Year"
```

# Other ways to load data

- `read.csv()` converts character vectors into factors, which you may or may not want

- You can also use File --> Import Dataset

<!-- - (What's a character vector? What's a factor?) -->

--- .class #id 

## Viewing your data

Click the name of the data frame in the Environment (top right)

Use the `str()` function to compactly display the internal **str**ucture of an R object


```r
str(data)
```

```
## 'data.frame':	16376 obs. of  12 variables:
##  $ name            : Factor w/ 16376 levels "'Spinner (Earth-616)",..: 13958 2331 16000 6775 14711 1579 12352 6555 13214 7687 ...
##  $ urlslug         : Factor w/ 16376 levels "\\/%22Spider-Girl%22_(Mutant\\/Spider_Clone)_(Earth-616)",..: 13956 2331 16000 6775 14709 1579 12351 6555 13213 7687 ...
##  $ ID              : Factor w/ 5 levels "","Known to Authorities Identity",..: 5 4 4 4 3 4 4 4 4 4 ...
##  $ ALIGN           : Factor w/ 4 levels "","Bad Characters",..: 3 3 4 3 3 3 3 3 4 3 ...
##  $ EYE             : Factor w/ 25 levels "","Amber Eyes",..: 11 5 5 5 5 5 6 6 6 5 ...
##  $ HAIR            : Factor w/ 26 levels "","Auburn Hair",..: 8 25 4 4 5 15 8 8 8 5 ...
##  $ SEX             : Factor w/ 5 levels "","Agender Characters",..: 5 5 5 5 5 5 5 5 5 5 ...
##  $ GSM             : Factor w/ 7 levels "","Bisexual Characters",..: 1 1 1 1 1 1 1 1 1 1 ...
##  $ ALIVE           : Factor w/ 3 levels "","Deceased Characters",..: 3 3 3 3 3 3 3 3 3 3 ...
##  $ APPEARANCES     : int  4043 3360 3061 2961 2258 2255 2072 2017 1955 1934 ...
##  $ FIRST.APPEARANCE: Factor w/ 833 levels "","1-Apr","1-Aug",..: 226 554 752 572 675 683 683 627 797 683 ...
##  $ Year            : int  1962 1941 1974 1963 1950 1961 1961 1962 1963 1961 ...
```

--- .class #id 

## Viewing your data

Use the `glimpse()` function to see all variables and the data in them

```r
glimpse(data)
```

```
## Observations: 16,376
## Variables: 12
## $ name             <fct> Spider-Man (Peter Parker), Captain America (Ste…
## $ urlslug          <fct> \/Spider-Man_(Peter_Parker), \/Captain_America_…
## $ ID               <fct> Secret Identity, Public Identity, Public Identi…
## $ ALIGN            <fct> Good Characters, Good Characters, Neutral Chara…
## $ EYE              <fct> Hazel Eyes, Blue Eyes, Blue Eyes, Blue Eyes, Bl…
## $ HAIR             <fct> Brown Hair, White Hair, Black Hair, Black Hair,…
## $ SEX              <fct> Male Characters, Male Characters, Male Characte…
## $ GSM              <fct> , , , , , , , , , , , , , , , , , , , , , , , , 
## $ ALIVE            <fct> Living Characters, Living Characters, Living Ch…
## $ APPEARANCES      <int> 4043, 3360, 3061, 2961, 2258, 2255, 2072, 2017,…
## $ FIRST.APPEARANCE <fct> Aug-62, Mar-41, Oct-74, Mar-63, Nov-50, Nov-61,…
## $ Year             <int> 1962, 1941, 1974, 1963, 1950, 1961, 1961, 1962,…
```

You can also use `View()` to open the data frame in the viewer

```r
View(data)
```

--- .class #id 

## Tidy data
- In **tidy data**
    1. Each variable forms a column
    2. Each observation forms a row
    3. Each type of observational unit forms a table

- **Messy data** is any other other arrangement of the data
  - `tidyr` package is helpful for converting messy data to tidy data

- We'll start with some tidy data

--- .class #id 

## Data manipulation

- Using base R functions

- Using the `tidyr` and `dplyr` packages < our focus today

--- .class #id 

## Verbs of `dplyr`

The `dplyr` package is based on the concepts of functions as verbs that 
manipulate data frames:

- `filter()`: pick rows matching criteria
- `select()`: pick columns by name 
- `rename()`: rename specific columns
- `arrange()`: reorder rows 
- `mutate()`: add new variables
- `transmute()`: create new data frame with variables
- `sample_n()` / `sample_frac()`: randomly sample rows
- `summarize()`: reduce variables to values

--- .class #id 

## `dplyr` rules

- First argument is a data frame
- Subsequent arguments say what to do with data frame
- Always returns a data frame 
- Avoid modify in place

--- .class #id 

## Filter rows with `filter()`

- Select a subset of rows in a data frame.
- Easily filter for many conditions at once.

Filter for 'good' characters


```r
data %>%
  filter(ALIGN == "Good Characters") %>%
  head() # just show the first 6 rows
```

```
##                                  name
## 1           Spider-Man (Peter Parker)
## 2     Captain America (Steven Rogers)
## 3 Iron Man (Anthony \\"Tony\\" Stark)
## 4                 Thor (Thor Odinson)
## 5          Benjamin Grimm (Earth-616)
## 6           Reed Richards (Earth-616)
##                                  urlslug               ID           ALIGN
## 1           \\/Spider-Man_(Peter_Parker)  Secret Identity Good Characters
## 2     \\/Captain_America_(Steven_Rogers)  Public Identity Good Characters
## 3 \\/Iron_Man_(Anthony_%22Tony%22_Stark)  Public Identity Good Characters
## 4                 \\/Thor_(Thor_Odinson) No Dual Identity Good Characters
## 5          \\/Benjamin_Grimm_(Earth-616)  Public Identity Good Characters
## 6           \\/Reed_Richards_(Earth-616)  Public Identity Good Characters
##          EYE       HAIR             SEX GSM             ALIVE APPEARANCES
## 1 Hazel Eyes Brown Hair Male Characters     Living Characters        4043
## 2  Blue Eyes White Hair Male Characters     Living Characters        3360
## 3  Blue Eyes Black Hair Male Characters     Living Characters        2961
## 4  Blue Eyes Blond Hair Male Characters     Living Characters        2258
## 5  Blue Eyes    No Hair Male Characters     Living Characters        2255
## 6 Brown Eyes Brown Hair Male Characters     Living Characters        2072
##   FIRST.APPEARANCE Year
## 1           Aug-62 1962
## 2           Mar-41 1941
## 3           Mar-63 1963
## 4           Nov-50 1950
## 5           Nov-61 1961
## 6           Nov-61 1961
```

--- .class #id 

## Filter rows with `filter()`

- Select a subset of rows in a data frame.
- Easily filter for many conditions at once.

Filter for 'good' characters introduced after 2000


```r
data %>%
  filter(ALIGN == "Good Characters", Year > 2000) %>%
  head() # just show the first 6 rows
```

```
##                           name                         urlslug
## 1       Maria Hill (Earth-616)       \\/Maria_Hill_(Earth-616)
## 2     Laura Kinney (Earth-616)     \\/Laura_Kinney_(Earth-616)
## 3   Santo Vaccarro (Earth-616)   \\/Santo_Vaccarro_(Earth-616)
## 4      Megan Gwynn (Earth-616)      \\/Megan_Gwynn_(Earth-616)
## 5     Hope Summers (Earth-616)     \\/Hope_Summers_(Earth-616)
## 6 Victor Borkowski (Earth-616) \\/Victor_Borkowski_(Earth-616)
##                 ID           ALIGN            EYE       HAIR
## 1 No Dual Identity Good Characters     Brown Eyes Black Hair
## 2  Secret Identity Good Characters     Green Eyes Black Hair
## 3  Secret Identity Good Characters     White Eyes    No Hair
## 4  Public Identity Good Characters Black Eyeballs  Pink Hair
## 5  Secret Identity Good Characters     Green Eyes   Red Hair
## 6  Secret Identity Good Characters     Brown Eyes Black Hair
##                 SEX                   GSM             ALIVE APPEARANCES
## 1 Female Characters                       Living Characters         325
## 2 Female Characters                       Living Characters         265
## 3   Male Characters                       Living Characters         238
## 4 Female Characters                       Living Characters         229
## 5 Female Characters                       Living Characters         200
## 6   Male Characters Homosexual Characters Living Characters         184
##   FIRST.APPEARANCE Year
## 1            5-Apr 2005
## 2            4-Feb 2004
## 3            3-Sep 2003
## 4            4-Nov 2004
## 5            8-Jan 2008
## 6            3-Aug 2003
```

--- .class #id 

## Commonly used logical operators in R 

operator    | definition
------------|--------------------------
`<`         | less than
`<=`        |	less than or equal to
`>`         | greater than
`>=`        |	greater than or equal to
`==`        |	exactly equal to
`!=`        |	not equal to
x &#124; y     | `x` OR `y`
`x & y`     | `x` AND `y`

--- .class #id 

## Commonly used logical operators in R 

operator     | definition
-------------|--------------------------
`is.na(x)`   | test if `x` is `NA`
`!is.na(x)`  | test if `x` is not `NA`
`x %in% y`   | test if `x` is in `y`
`!(x %in% y)`| test if `x` is not in `y`
`!x`         | not `x`

--- .class #id 

## Real data is messy

Careful data scientists clean up their data first!

- You may need to do some text parsing to clarify your data
    + `Good Characters` can be `good`
    + `Bad Characters` can be `bad`
    + `Neutral Characters` can be `neutral`
  
- New R package: `stringr`

--- .class #id 

## Install and load: `stringr`


```r
#Install
install.packages("stringr")
# load package
library(stringr)
```

- Package reference: Most R packages come with a vignette that describes in detail what each function does and how to use them, they're incredibly useful resources (in addition to other worked out examples on the web) https://cran.r-project.org/web/packages/stringr/vignettes/stringr.html

--- .class #id 

## `rename()` specific columns 

Correct typos and rename to make variable names shorter and/or more informative


```r
# Original names
names(data)
```

```
##  [1] "name"             "urlslug"          "ID"              
##  [4] "ALIGN"            "EYE"              "HAIR"            
##  [7] "SEX"              "GSM"              "ALIVE"           
## [10] "APPEARANCES"      "FIRST.APPEARANCE" "Year"
```

```r
# Rename `ALIGN` to `align`
data <- data %>%
  rename(align = ALIGN)

# Outside of the tidyverse, you can also do this:
oldnames <- names(data)
names(data) <- tolower(oldnames)
```

--- .class #id 

## Replace variables with `str_replace()` and add new variables with `mutate()` 
 

```r
data <- data %>%
  mutate(align = str_replace(align, "Good Characters", "good")) %>%
  mutate(align = str_replace(align, "Bad Characters", "bad")) %>%
  mutate(align = str_replace(align, "Neutral Characters", "neutral"))
```

- Note that we're overwriting existing data and columns, so be careful!
    + But remember, it's easy to revert if you make a mistake since we didn't touch the raw data, we can always reload it and start over

--- .class #id 

## Check before you move on 


```r
data %>%
  group_by(align) %>%
  summarize(count = n())
```

```
## # A tibble: 4 x 2
##   align   count
##   <chr>   <int>
## 1 ""       2812
## 2 bad      6720
## 3 good     4636
## 4 neutral  2208
```

--- .class #id 

## Check before you move on 


```r
# You can also count using the `count()` function
data %>%
  group_by(align) %>%
  count()
```

```
## # A tibble: 4 x 2
## # Groups:   align [4]
##   align       n
##   <chr>   <int>
## 1 ""       2812
## 2 bad      6720
## 3 good     4636
## 4 neutral  2208
```

--- .class #id 

## Summary statistics

We can use the same format for calculating other summary statistics


```r
data %>%
  group_by(sex) %>%
  summarize(mean_appearances = mean(appearances, na.rm = TRUE), 
            median_appearances = median(appearances, na.rm = TRUE))
```

```
## # A tibble: 5 x 3
##   sex                    mean_appearances median_appearances
##   <fct>                             <dbl>              <dbl>
## 1 ""                                 4.43                2  
## 2 Agender Characters                19.7                 9.5
## 3 Female Characters                 20.3                 4  
## 4 Genderfluid Characters           282.                282. 
## 5 Male Characters                   16.8                 3
```

--- .class #id 

## `slice()` for certain row numbers 


```r
# First five
data %>%
  slice(1:5)
```

```
##                                    name
## 1             Spider-Man (Peter Parker)
## 2       Captain America (Steven Rogers)
## 3 Wolverine (James \\"Logan\\" Howlett)
## 4   Iron Man (Anthony \\"Tony\\" Stark)
## 5                   Thor (Thor Odinson)
##                                    urlslug               id   align
## 1             \\/Spider-Man_(Peter_Parker)  Secret Identity    good
## 2       \\/Captain_America_(Steven_Rogers)  Public Identity    good
## 3 \\/Wolverine_(James_%22Logan%22_Howlett)  Public Identity neutral
## 4   \\/Iron_Man_(Anthony_%22Tony%22_Stark)  Public Identity    good
## 5                   \\/Thor_(Thor_Odinson) No Dual Identity    good
##          eye       hair             sex gsm             alive appearances
## 1 Hazel Eyes Brown Hair Male Characters     Living Characters        4043
## 2  Blue Eyes White Hair Male Characters     Living Characters        3360
## 3  Blue Eyes Black Hair Male Characters     Living Characters        3061
## 4  Blue Eyes Black Hair Male Characters     Living Characters        2961
## 5  Blue Eyes Blond Hair Male Characters     Living Characters        2258
##   first.appearance year
## 1           Aug-62 1962
## 2           Mar-41 1941
## 3           Oct-74 1974
## 4           Mar-63 1963
## 5           Nov-50 1950
```

```r
# Last five
last_row <- nrow(data)
data %>%
  slice((last_row-4):last_row)
```

```
##                              name                              urlslug
## 1              Ru'ach (Earth-616)              \\/Ru%27ach_(Earth-616)
## 2 Thane (Thanos' son) (Earth-616) \\/Thane_(Thanos%27_son)_(Earth-616)
## 3   Tinkerer (Skrull) (Earth-616)     \\/Tinkerer_(Skrull)_(Earth-616)
## 4  TK421 (Spiderling) (Earth-616)    \\/TK421_(Spiderling)_(Earth-616)
## 5           Yologarch (Earth-616)             \\/Yologarch_(Earth-616)
##                 id   align        eye    hair             sex gsm
## 1 No Dual Identity     bad Green Eyes No Hair Male Characters    
## 2 No Dual Identity    good  Blue Eyes    Bald Male Characters    
## 3  Secret Identity     bad Black Eyes    Bald Male Characters    
## 4  Secret Identity neutral                    Male Characters    
## 5                      bad                                       
##               alive appearances first.appearance year
## 1 Living Characters          NA                    NA
## 2 Living Characters          NA                    NA
## 3 Living Characters          NA                    NA
## 4 Living Characters          NA                    NA
## 5 Living Characters          NA                    NA
```

--- .class #id 

## `select()` 


```r
# Include only specific variables
data %>%
  select(align, sex) %>%
  table()
```

```
##          sex
## align          Agender Characters Female Characters Genderfluid Characters
##            232                  2               684                      0
##   bad      386                 20               976                      0
##   good     122                 10              1537                      1
##   neutral  114                 13               640                      1
##          sex
## align     Male Characters
##                      1894
##   bad                5338
##   good               2966
##   neutral            1440
```

--- .class #id 

## `select()` 

```r
# Exclude variable (column)
# data %>%
#   select(-eye)

# To keep only certain levels of a factor (and get rid of empty levels)
data %>%
  select(sex, align) %>%
  table()
```

```
##                         align
## sex                            bad good neutral
##                           232  386  122     114
##   Agender Characters        2   20   10      13
##   Female Characters       684  976 1537     640
##   Genderfluid Characters    0    0    1       1
##   Male Characters        1894 5338 2966    1440
```

--- .class #id 

## `select()` 

```r
data %>%
  select(sex, align) %>%
  filter(sex != "", align != "") %>%
  droplevels() %>%
  table()
```

```
##                         align
## sex                       bad good neutral
##   Agender Characters       20   10      13
##   Female Characters       976 1537     640
##   Genderfluid Characters    0    1       1
##   Male Characters        5338 2966    1440
```

--- .class #id 

## `summarize()` in a new data frame with new calculated variables


```r
data.summ <- data %>%
  filter(sex != "", align != "") %>%
  group_by(sex, year, align) %>%
  summarize(n = n()) %>%
  mutate(perc.sex = n / sum(n))
```

--- .class #id

## `summarize()` by decade


```r
# Write a function to round years to their decade
get_decade = function(year){ return(floor(year / 10) * 10) }

# Re-do data.summ 
data.summ <- data %>%
  filter(sex != "", align != "") %>%
  mutate(decade = get_decade(year)) %>%
  group_by(sex, decade, align) %>%
  summarize(n = n())
```

--- .class #id 

## Select rows with `sample_n()` or `sample_frac()` 


```r
# `sample_n()`: randomly sample 5 observations
data_n5 <- data %>%
  sample_n(5, replace = FALSE)
dim(data_n5)
```

```
## [1]  5 12
```

```r
# `sample_frac()`: randomly sample 20% of observations
data_perc20 <-data %>%
  sample_frac(0.2, replace = FALSE)
dim(data_perc20)
```

```
## [1] 3275   12
```

--- .class #id

## Simple plotting

```r
# load ggplot2
library(ggplot2)

decade.plot <- data %>%
  mutate(decade=get_decade(year)) %>%
  filter(sex != "", align != "") %>%
  ggplot(aes(x=decade, fill=sex)) + geom_bar()
```

--- .class #id 


```r
decade.plot
```

![plot of chunk decade-plot](assets/fig/decade-plot-1.png)

--- .class #id 

## More `dplyr` resources

- Visit https://cran.r-project.org/web/packages/dplyr/vignettes/introduction.html for the package vignette.

- Refer to the `dplyr` [cheatsheet](https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf).

--- .class #id 

## Basic R syntax

For when not working with `dplyr`

- Refer to a variable in a dataset as `data$name`
- Access any element in a dataframe using square brackets


```r
data[1,5] # row 1, column 5
```

```
## [1] Hazel Eyes
## 25 Levels:  Amber Eyes Black Eyeballs Black Eyes Blue Eyes ... Yellow Eyes
```
    
- For all observations in row 1: `data[1, ]`
- For all observations in column 5: `data[, 5]`

Other things to learn: how to make a dataframe, how to add rows/columns

--- .class #id 

## Want more R? 

- Resources for learning R:
    - [Coursera](https://www.coursera.org/)
    - [DataCamp](https://www.datacamp.com/)
    - Many many online demos, resources, examples, as well as books

- Debugging R errors:
    - Read the error!
    - [StackOverflow](http://stackoverflow.com/)

- Keeping up with what's new in R land:
    - [R-bloggers](http://www.r-bloggers.com/)
    - Twitter: #rstats
    
