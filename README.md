# Hadoop Lab

This repository contains **Apache Hadoop concepts and examples** implemented in **Java**.  
Each topic is organized into its own folder with a Java example file and a README for explanations.

## Structure

### Hadoop Core
- [Input & Output Formats](./hadoop_core/InputOutput/README.md)
- [Serialization](./hadoop_core/Serialization/README.md)
- [Writable Interface](./hadoop_core/Writable/README.md)
- [Compression](./hadoop_core/Compression/README.md)

### HDFS
- [Basics](./hdfs/Basics/README.md)
- [Replication](./hdfs/Replication/README.md)
- [Permissions](./hdfs/Permissions/README.md)
- [High Availability (HA)](./hdfs/HA/README.md)

### MapReduce
- [Word Count](./mapreduce/WordCount/README.md)
- [Combiners](./mapreduce/Combiners/README.md)
- [Partitioners](./mapreduce/Partitioners/README.md)
- [Secondary Sort](./mapreduce/SecondarySort/README.md)
- [Counters](./mapreduce/Counters/README.md)
- [Joins](./mapreduce/Joins/README.md)

### YARN
- [Basics](./yarn/Basics/README.md)
- [Scheduling](./yarn/Scheduling/README.md)
- [Applications](./yarn/Applications/README.md)

### [FAQ](./FAQ.md)

## Setup

Run:

```bash
./setup.sh
```

### What This Script Does

- Verifies that **Java** is installed
- Checks for required **Hadoop environment variables**
- installs Hadoop automatically if it isn't found locally


## How to Use

1. Navigate to a topic folder
2. Read the `README.md` for that topic
3. Inspect or implement the corresponding `.java` example
4. Compile and run using `javac` or `hadoop jar`


## Notes

- All examples are **educational**
- Designed to work with **local** or **pseudo-distributed** Hadoop setups