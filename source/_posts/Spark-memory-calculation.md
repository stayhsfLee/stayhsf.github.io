---
layout: posts
title: Spark Memory Calculation
date: 2021-03-13 14:56:48
tags: spark
categories:
- bigdata
- spark
---

## Why the spark use `1408Mi` in memoru in default?

Formula: `MemoryRequest(1Gi) + Max(MemoryRequest * MemoryOverheadFactor, MinMenoryOverhead(384Mi)) = 1408
Mi`

All the memory configuration of `driver` and `executor` is managed by class `SparkConf`.