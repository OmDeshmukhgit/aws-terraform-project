"""
Lambda function triggered by S3 bucket notifications (ObjectCreated / ObjectRemoved).

For every event record it logs:
  - the event type (created / removed, and the specific sub-type)
  - the bucket name
  - the object key and size
  - the timestamp of the operation

Logs go to CloudWatch Logs (the log group created for this function). This
gives you a simple, queryable audit trail of every put/delete on the bucket
without needing to enable full S3 access logging or CloudTrail data events.
"""

import json
import logging

logger = logging.getLogger()
logger.setLevel(logging.INFO)


def handler(event, context):
    records = event.get("Records", [])
    logger.info("Received %d S3 event record(s)", len(records))

    for record in records:
        event_name = record.get("eventName", "Unknown")
        event_time = record.get("eventTime", "Unknown")
        s3_info = record.get("s3", {})
        bucket_name = s3_info.get("bucket", {}).get("name", "Unknown")
        object_info = s3_info.get("object", {})
        object_key = object_info.get("key", "Unknown")
        object_size = object_info.get("size", 0)

        log_entry = {
            "event_name": event_name,
            "event_time": event_time,
            "bucket": bucket_name,
            "object_key": object_key,
            "object_size_bytes": object_size,
        }

        logger.info("S3 operation tracked: %s", json.dumps(log_entry))

    return {
        "statusCode": 200,
        "body": json.dumps({"records_processed": len(records)}),
    }
