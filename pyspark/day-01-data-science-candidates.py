from pyspark.sql import SparkSession
from pyspark.sql.functions import col, countDistinct

# Create Spark session
spark = SparkSession.builder.appName("DataScienceCandidates").getOrCreate()

# Sample data
data = [
    (123, "Python"),
    (123, "Tableau"),
    (123, "PostgreSQL"),
    (234, "R"),
    (234, "PowerBI"),
    (234, "SQL Server"),
    (345, "Python"),
    (345, "Tableau")
]

columns = ["candidate_id", "skill"]

# Create DataFrame
df = spark.createDataFrame(data, columns)

# Logic
result = (
    df.filter(col("skill").isin("Python", "Tableau", "PostgreSQL"))
      .groupBy("candidate_id")
      .agg(countDistinct("skill").alias("skill_count"))
      .filter(col("skill_count") == 3)
      .select("candidate_id")
      .orderBy("candidate_id")
)

result.show()
