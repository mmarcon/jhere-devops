endpoints=(sizes regions images "account/keys")
for i in "${endpoints[@]}"; do
    url=`printf "https://api.digitalocean.com/v2/%s" $i`
    curl -X "GET" -H "Authorization: Bearer $DO_API_TOKEN" $url | python -mjson.tool
done
