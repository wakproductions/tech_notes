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

## Show returned headers

-i flag
```
curl -i https://username:password@my-store.myshopify.com/admin/inventory_items.json
HTTP/1.1 403 Forbidden
Server: nginx
Date: Fri, 04 May 2018 13:56:47 GMT
Content-Type: application/json; charset=utf-8
Transfer-Encoding: chunked
Connection: keep-alive
Vary: Accept-Encoding
X-Sorting-Hat-PodId: 43
X-Sorting-Hat-PodId-Cached: 0
X-Sorting-Hat-ShopId: 369360940
X-Sorting-Hat-Section: pod
X-Sorting-Hat-ShopId-Cached: 0
Vary: Accept-Encoding
Referrer-Policy: origin-when-cross-origin
X-Frame-Options: DENY
X-ShopId: 369360940
X-ShardId: 43
X-Stats-UserId: 0
X-Stats-ApiClientId: 2293620
X-Stats-ApiPermissionId: 37819908140
HTTP_X_SHOPIFY_SHOP_API_CALL_LIMIT: 1/40
X-Shopify-Shop-Api-Call-Limit: 1/40
Strict-Transport-Security: max-age=7889238
X-Request-Id: dc2a8f80-9960-403e-95ac-7f48151a0b32
Content-Security-Policy: default-src 'self' data: blob: 'unsafe-inline' 'unsafe-eval' https://* shopify-pos://*; block-all-mixed-content; child-src 'self' https://* shopify-pos://*; connect-src 'self' wss://* https://*; script-src https://cdn.shopify.com https://checkout.shopifycs.com https://js-agent.newrelic.com https://bam.nr-data.net https://dme0ih8comzn4.cloudfront.net https://api.stripe.com https://mpsnare.iesnare.com https://appcenter.intuit.com https://www.paypal.com https://maps.googleapis.com https://stats.g.doubleclick.net https://www.google-analytics.com https://visitors.shopify.com https://v.shopify.com https://widget.intercom.io https://js.intercomcdn.com 'self' 'unsafe-inline' 'unsafe-eval'; upgrade-insecure-requests; report-uri /csp-report?source%5Baction%5D=index&source%5Bapp%5D=Shopify&source%5Bcontroller%5D=admin%2Finventory_items&source%5Bsection%5D=admin_api&source%5Buuid%5D=dc2a8f80-9960-403e-95ac-7f48151a0b32
X-Content-Type-Options: nosniff
X-Download-Options: noopen
X-Permitted-Cross-Domain-Policies: none
X-XSS-Protection: 1; mode=block; report=/xss-report?source%5Baction%5D=index&source%5Bapp%5D=Shopify&source%5Bcontroller%5D=admin%2Finventory_items&source%5Bsection%5D=admin_api&source%5Buuid%5D=dc2a8f80-9960-403e-95ac-7f48151a0b32
X-Dc: chi2,gcp-us-east1
Via: 1.1 google
Alt-Svc: clear

{"errors":"[API] This action requires merchant approval for read_inventory scope."}
```

## Send JSON Request

```
curl -d 

```
