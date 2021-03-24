---
layout: posts
title: Spark Functions
date: 2021-03-18 11:18:18
tags: spark
categories:
- bigdata
- spark
---

### SparkContext.textFile()

While you are in driver mode or use `./bin/spark-shell` to submit jobs to executors, there are several rules you have to obey.
1. The file path must exist both on the driver node and all executor node.
2. Based on rule 1, when you store different content in the file located at the same path both on your local node and executor node, the textFile result depends on the line number of the file content at your local node and the file content at the executor node.


## Dateset transformations

Referrence: [https://spark.apache.org/docs/3.1.1/rdd-programming-guide.html#transformations](https://spark.apache.org/docs/3.1.1/rdd-programming-guide.html#transformations)


### Dataset.createOrReplaceTempView() ~~Dataset.registerTempTable()~~

This method allows you to create a lazy view in spark and it's not cached accross the spark cluster.

If you wanna cache it, invoke method `Dataset.table().cache()` explicitly.


### Dataset.join(anotherDataset, ...)

To use this method, you have to provide three parameters.

* anotherDataset: which dataset to join with
* columns to be joined on: Seq type, if you are using Java.List type, you can use `JavaConverters.asScalaIteratorConverter(${List}.iterator()).asScala().toSeq()` to transform List to Seq.
* the join type: String type
    * left_outer
    * right_outer
    * full_outer
    * left_anti: return the result table contains records doesn't exist in anotherDataset
    * [https://jaceklaskowski.gitbooks.io/mastering-spark-sql/content/spark-sql-joins.html](https://jaceklaskowski.gitbooks.io/mastering-spark-sql/content/spark-sql-joins.html)
    * [https://jaceklaskowski.gitbooks.io/mastering-spark-sql/content/spark-sql-joins.html](https://jaceklaskowski.gitbooks.io/mastering-spark-sql/content/spark-sql-joins.html)

**Difference with `ds.joinWith`**

`ds.joinWith` is the type belongs to `Type-Preserving Joins


### Dateset.coalesce() vs Dataset.repartition() 

Before we discuss the difference between them, we should know that the cost of `repartition operation` is very expensive. You can use coalesce to minimize the data movement among the executors.

Stackoverflow answer: [https://stackoverflow.com/questions/31610971/spark-repartition-vs-coalesce](https://stackoverflow.com/questions/31610971/spark-repartition-vs-coalesce)