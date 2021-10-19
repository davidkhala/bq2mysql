set -e

config() {

    if [[ -z "$region" ]]; then
        export region=$(curl -s http://169.254.169.254/opc/v1/instance/ | jq -r '.region')
    fi

    if [[ -z "$ocid_tenancy" ]]; then
        export ocid_tenancy=$(oci os ns get-metadata --query 'data."default-s3-compartment-id"' --raw-output)
    fi

    if [[ -z "$namespace_bucket" ]]; then
        export namespace_bucket=$(oci os ns get | jq -r '.data')
    fi


    rclone config create "OCI-bucket-${namespace_bucket}" S3 [provider Other] [$access_key_id $secret_access_key] [endpoint ${namespace_bucket}.compat.objectstorage.$REGION.oraclecloud.com]

#   sudo tee ~/.rclone.conf << EOF
# [OCI-bucket-${namespace_bucket}]
# type = s3
# provider = Other
# env_auth = false
# access_key_id = <ACCESS KEY>
# secret_access_key = <SECRET KEY>
# endpoint = <NAMESPACE>.compat.objectstorage.<REGION>.oraclecloud.com
# EOF
    

}

$@
