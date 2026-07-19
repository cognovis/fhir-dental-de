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

# Do not force -tx n/a. This IG has ValueSet compose.include.filter entries
# (OPS descendent-of, SNOMED is-a). With -tx n/a, IG Publisher 2.2.x NPEs in
# ValueSetValidator.checkFilterValue (TerminologyClientContext.getAddress()
# because "tc" is null). Omitting -tx uses the publisher default
# (https://tx.fhir.org), matching CI. Pass -tx explicitly to override.
$JAVA -jar "$PUBLISHER_JAR" -ig . "$@"
