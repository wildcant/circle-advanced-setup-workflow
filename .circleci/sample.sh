#!/bin/bash

JSON=$(yarn build --filter='...[HEAD^]' --dry-run=json) | jq 'select(.)'
echo $JSON