javac -classpath $HIVE_HOME/lib/hive-serde-0.13.0.jar:$HIVE_HOME/lib/hive-exec-0.13.0.jar:$HADOOP_HOME/hadoop-core-1.2.1.jar  Rank1.java

jar -cf Rank1.jar Rank1.class

#start hive
> hive
 
#Inside hive: add jar file
hive> add jar Rank.jar
 
#assign name to the custom function
hive> create temporary function rank as 'com.example.hive.udf.Rank';
 
#now we are ready to issue our query
hive> SELECT user, category, value
FROM (
    SELECT user, category, rank(user) as rank, value
    FROM $compTable
    WHERE user is NOT NULL AND AND ctr &gt; 0
    DISTRIBUTE BY user
    SORT BY user, value desc
) a
WHERE rank &lt; 5
ORDER BY user, rank;
