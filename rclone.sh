set -e


list() {
    remote=${profile:-$1}
    path=${path:-$2}
    rclone lsf $remote:$path
}

$@
