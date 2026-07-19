#!/bin/bash

# Find Java
if command -v java &>/dev/null; then
  JAVA=java
elif [ -x /opt/homebrew/opt/openjdk/bin/java ]; then
  JAVA=/opt/homebrew/opt/openjdk/bin/java
else
  echo "Error: Java not found. Install via: brew install openjdk"
  exit 1
fi

PUBLISHER_JAR=input-cache/publisher.jar

if [ ! -f "$PUBLISHER_JAR" ]; then
  echo "IG Publisher not found. Run _updatePublisher.sh first."
  exit 1
fi

ARGS=("$@")
HAS_TX=false
for ARG in "${ARGS[@]}"; do
  case "$ARG" in
    -tx|--tx|-tx=*|--tx=*) HAS_TX=true ;;
  esac
done

# Prefer offline -tx n/a. Do not add ValueSet compose.include.filter entries
# without a real TX — publisher 2.2.x NPEs when tc is null (fmgt-5vw).
if [ "$HAS_TX" = false ]; then
  ARGS+=("-tx" "n/a")
fi

$JAVA -jar "$PUBLISHER_JAR" -ig . "${ARGS[@]}"
