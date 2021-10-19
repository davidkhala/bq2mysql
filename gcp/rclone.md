please use interactive way on a non-headless machine equipped with a browser to do auth
Or you have you setup service account

`rclone config`
- specify
    - anonymous = false
    - location: the region code
- no need to specify
    - token: auto-generated after browser auth
    - project number
    - object_acl: use the default "private"
    - bucket_acl: use the default "private"

`rclone sync` will delete data in destination while not exist in source!
In another words, it will overwrite the entire target with source than appending data.
Please consider safer command `rclone copy`
