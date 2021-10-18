# bq2mysql
Move out from BigQuery to MySQL
## Limitation
- Since gsutil support `gs://` and `s3://` schema only, it is better to use `rclone` as a cloud agnostic solution 
  - `InvalidUrlError: Unrecognized scheme "https".`
