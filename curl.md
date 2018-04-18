Get request

## Download file
curl -o website https://domain.com
curl -O https://domain.com/file.zip

## Header Only
curl -I http://domain.com

## Header and response (verbose)
curl -i http://domain.com

## Post with parameters
curl -F "p1=value1" -F "p2=value2" "http://myurl.com/program"
-or-
curl -d “firstname=Bob” -d “lastname=Jones” http://echo.httpkit.com

-F sets the content type to multipart/form-data. When paired with the @ you can send files

## Set Request Method
curl -X POST echo.httpkit.com
curl -X DELETE echo.httpkit.com

## Set Headers
curl -H “Content-Type: text/json” -H “Accept: application/json"
curl -H “Authorization: OAuth 2c4418dksjd” http://echo.httpkit.com

## Request body
Use the -d flag
You can read from a file using @
curl -X POST -H ‘Content-Type: application/json’ -d @example.json echo.httpkit.com

from a file example:
curl --data "@/path/to/filename" http://...