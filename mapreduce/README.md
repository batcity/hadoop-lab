# Hadoop Mapreduce:

Hadoop Mapreduce is a software framework that lets users process massive datasets by splitting up work across several machines (commodity hardware) reliably

main points to expand on:

- mapreduce is obsolete - replaced by spark
- idea is to colocate data and processing in the same machine, to avoid network transfers - but this is no longer a problem coz modern data centers can transfer data at dizzying speeds - which is probably what made it obsolete
- map tasks and reduce tasks
- sort happens before reduce i think , but does it happen all the time - gotta find and add more deets on the sort tasks