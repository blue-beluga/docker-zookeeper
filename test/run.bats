#!/usr/bin/env bats

setup() {
  docker history "$REGISTRY/$REPOSITORY:$TAG" >/dev/null 2>&1
  export IMG="$REGISTRY/$REPOSITORY:$TAG"
}

@test "the image does not have the Java JDK installed" {
  run docker run --rm --entrypoint=/bin/sh $IMG -c "which javac"
  [ $status -eq 1 ]
}

@test "the image has the Java JRE installed" {
  run docker run --rm --entrypoint=/bin/sh $IMG -c "which java"
  [ $status -eq 0 ]
}

@test "the image has a disk size under 130MB" {
  run docker images $IMG
  echo 'status:' $status
  echo 'output:' $output
  size="$(echo ${lines[1]} | awk -F '   *' '{ print int($5) }')"
  echo 'size:' $size
  [ "$status" -eq 0 ]
  [ $size -lt 130 ]
}

@test "the timezone is set to UTC" {
  run docker run --rm $IMG date +%Z
  [ $status -eq 0 ]
  [ "$output" = "UTC" ]
}

@test "that /var/cache/apk is empty" {
  run docker run --rm $IMG sh -c "ls -1 /var/cache/apk | wc -l"
  [ $status -eq 0 ]
}

@test "that the root password is disabled" {
  run docker run --user nobody $IMG su
  [ $status -eq 1 ]
}
