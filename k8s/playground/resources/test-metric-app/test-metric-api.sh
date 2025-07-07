#!/bin/bash

for i in $(seq 1 10000); do
  curl -s "http://localhost:7070/api/cpu?index=10"
done
