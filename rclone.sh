set -e

region=${region:-"ap-seoul-1"}
config() {

    : "${access_key_id:=$1}"
    : "${secret_access_key:=$2}"

    if [[ -z "$ocid_tenancy" ]]; then
        export ocid_tenancy=$(oci os ns get-metadata --query 'data."default-s3-compartment-id"' --raw-output)
    fi

    if [[ -z "$namespace_bucket" ]]; then
        export namespace_bucket=$(oci os ns get | jq -r '.data')
    fi

    rclone config create "oci-${region}-${namespace_bucket}" s3 provider=Other access_key_id=$access_key_id secret_access_key=$secret_access_key region=$region endpoint=${namespace_bucket}.compat.objectstorage.$region.oraclecloud.com
}
list() {
    remote=${profile:-$1}
    path=${path:-$2}
    rclone lsf $remote:$path
}

$@
