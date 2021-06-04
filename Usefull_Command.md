## log size show
```
dbcc sqlperf("logspace")
```
## showing count page 
```
set statistics io on
```
## Create Index 
```
create index IX_Reports_TotalCost on Reports (totalcost desc)
```
## Findout table or proc info 
exec sp_help Reports
