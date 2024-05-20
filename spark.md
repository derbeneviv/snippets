# print all loaded classes in pyspark

## spark-submit
https://support.hpe.com/hpesc/public/docDisplay?docId=sf000078706en_us&docLocale=en_US&page=index.html  
```
spark-submit --conf "spark.executor.extraJavaOptions=-verbose:class"  --conf "spark.driver.extraJavaOptions=-verbose:class"
```

## pyspark:
```
.config("spark.driver.extraJavaOptions", "-verbose:class")
.config("spark.executor.extraJavaOptions", "-verbose:class")
```
