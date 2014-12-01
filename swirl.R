####1
mydf<-read.csv(path2csv, stringsAsFactors=FALSE)

dim(mydf)

library(dplyr)

packageVersion("dplyr")

cran <- tbl_df(mydf)

rm("mydf")

cran

?select

select(cran, ip_id, package, country)

5:20

select(cran,r_arch:country)

select(cran,country:r_arch)

cran

select(cran,-time)

-(5:20)
#select para columnas
select(cran, -(X:size))
#filter para filas

filter(cran,package=="swirl")

filter(cran, r_version == "3.1.1", country == "US") 

filter(cran, r_version <= "3.0.2", country == "IN")

filter(cran,  country=="US" | country == "IN")

filter(cran,size>100500,r_os=="linux-gnu")

filter(cran, !is.na(r_version))

cran2<-select(cran,size:ip_id)
##arrange ordenar filas
arrange(cran2,ip_id)

arrange(cran2,desc(ip_id))#descendiente

arrange(cran2, package, ip_id)

arrange(cran2, country, desc(r_version), ip_id)

cran3<-select(cran,ip_id,package,size)

mutate(cran3, size_mb = size / 2^20)

mutate(cran3, size_mb = size / 2^20, size_gb=size_mb/2^10)

mutate(cran3, correct_size=size+1000)

summarize(cran, avg_bytes = mean(size))

#####2

library(dplyr)

cran<-tbl_df(mydf)

cran

?group_by

by_package<-group_by(cran,package)

summarize(by_package, mean(size))

pack_sum<-select(by_package, #sumamarize(by_package
        count=n(),
        unique=n_distinct(ip_id),
        countries= n_distinct(country),
        avg_bytes= mean(size))

quantile(pack_sum$count, probs=0.99)

top_counts<-filter(pack_sum,count>679)

 head(top_counts,20)

arrange(top_counts,desc(count))

quantile(pack_sum$unique, probs=0.99)

top_unique<-filter(pack_sum,unique>465)

arrange(top_unique,desc(unique))

cran %>%
  select(ip_id,country,package,size) %>%
        print
        
cran %>%
  select(ip_id, country, package, size) %>%
  mutate(size_mb = size / 2^20) %>%
  filter(size_mb <= 0.5) %>%
  arrange(desc(size_mb))
  
#######3

library(tidyr)

##caracteristicas de tidy data
Variables are stored in both rows and columns
A single observational unit is stored in multiple tables
Multiple variables are stored in one column
Multiple types of observational units are stored in the same table
Column headers are values, not variable names

gather(students,sex,count,-grade)

res<-gather(students2,sex_class,count,-grade)

separate(res,sex_class,c("sex","class"))

students2 %>%
  gather(sex_class ,count ,-grade ) %>%
  separate( sex_class, c("sex", "class")) %>%
  print
  
students3 %>%
  gather(class,grade,class1:class5,na.rm=TRUE) %>%
  print

students3 %>%
gather(class, grade, class1:class5, na.rm = TRUE) %>%
spread(test, grade)

students3 %>%
gather(class, grade, class1:class5, na.rm = TRUE) %>%
spread(test, grade) %>%
mutate(class = extract_numeric(class))

student_info <- students4 %>%
select(id, name, sex) %>%
unique()


gradebook <- students4 %>%
select(id, class, midterm, final)

passed <- passed %>% mutate(status = "passed")

failed <- failed %>%
mutate(status = "failed")

rbind_list(passed, failed) 

sat1 <- select(sat, -contains("total"))
sat1 <- gather(sat1, column, count, -score_range)
sat1 <- separate(sat1, column, c("part", "sex"))
sat1
by_part <- group_by(sat1, part, sex)
sat2 <- mutate(by_part,
total = sum(count),
prop = count / total)


  
