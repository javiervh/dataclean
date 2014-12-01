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
