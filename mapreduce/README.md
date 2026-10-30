# Hadoop Mapreduce:

Hadoop Mapreduce is a software framework that lets users process massive datasets by splitting up work across several machines (commodity hardware) reliably

Hadoop Mapreduce is essentially obsolete in the current era, Here are the reasons why: 

- It's been replaced by spark in most enterprises since spark has the capability to process data in-memory which means it can process data vastly quicker than Mapreduce. 

- Outside of processing speed, the other advantage that mapreduce had was the colocation of data and processing in the same machine, this avoided network transfers which was a main selling point when it launched in 2006 - however modern data centers transfer data at dizzying speeds so network transfer was no longer a bottleneck

Hadoop Mapreduce was based on the [Mapreduce Programming model](https://en.wikipedia.org/wiki/MapReduce)

The Mapreduce framework consists of three steps:

- Map phase -> This phase runs a user defined map function on the input data (for example convert a list of words into a bunch of word lengths)

Here the input keys k1 -> are translated to output keys k2

- Shuffle phase -> The shuffle phase moves data around in the cluster, it essentially moves groups of similar k2 keys to their own individual machine for further processing

- Reduce phase -> This phase runs massive aggregate operations on the k2 keys, the results are then finally sorted and the output is provided as a single sorted distributed dataset to the user

main points to expand on:

- map tasks, shuffle and reduce tasks -> clean this up

- sort happens before reduce i think , but does it happen all the time - gotta find and add more deets on the sort tasks - > not true reduce does sort as well, when user provides map operation they can also tell the machine to filter or sort data. Find out if users can provide custom sort functions during the reduce phase
