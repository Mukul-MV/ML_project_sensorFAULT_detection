import pymongo
import pandas as pd
import json
from sensor.config import mongo_client

# Provide the mongodb localhost url to connect python to mongodb.
client = pymongo.MongoClient("mongodb://localhost:27017/neurolabDB")

DATALINK = "/config/workspace/aps_failure_training_set1.csv"
DATABASE_NAME = 'aps'
COLLECTION_NAME = 'sensor'

if __name__ == "__main__":
    df = pd.read_csv(DATALINK)
    print(f"row aand column : {df.shape}")
    
    # convert data in json to drop in MongoDB
    df.reset_index(drop = True,inplace=True)

# df.T yani data frame transpose
    json_records = list(json.loads(df.T.to_json()).values())
    print(json_records[0])

    mongo_client[DATABASE_NAME][COLLECTION_NAME].insert_many(json_records)




