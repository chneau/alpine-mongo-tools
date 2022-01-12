# alpine-mongo-tools

## Use case

```bash
# dump from a database
mongodump "mongodb+srv://..." --db db --gzip --archive=`date -u +"%FT%H%MZ"`-db.archive;

# store dump to an s3 compatible storage
export file="$(ls *.archive)";
export bucket="XXX";
export contentType="application/x-compressed-tar";
export dateValue="$(date -R -u)";
export folder="database_backups/";
export stringToSign="PUT\n\n${contentType}\n${dateValue}\n/${bucket}/${folder}$file";
export s3Key="XXX";
export s3Secret="XXX";
export signature="$(echo -en ${stringToSign} | openssl sha1 -hmac ${s3Secret} -binary | base64)";
curl -X PUT -T "${file}" -H "Host: ${bucket}.XXX.XXX.com" -H "Date: ${dateValue}" -H "Content-Type: ${contentType}" -H "Authorization: AWS ${s3Key}:${signature}" "https://${bucket}.XXX.XXX.com/${folder}${file}"
```
