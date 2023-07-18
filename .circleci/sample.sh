content=`yarn build --filter=...[origin/main] --dry-run=json`
# the following lines are required for multi line json
content="${content//'%'/'%25'}"
content="${content//$'\n'/'%0A'}"
content="${content//$'\r'/'%0D'}"
echo "::set-output name=result::$content"