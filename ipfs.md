## Wrap Directory Object
```
# ipfs add -w /share_content/greenspudtrades/2017-07-27_How_to_Download_and_Hoard_Youtube_Videos_on_Your_Hard_Drive_thumbnail.png
added QmQbfTcsfF83xAZmwgKSArmequ59NyLNaxnwPKJaEEg5zX 2017-07-27_How_to_Download_and_Hoard_Youtube_Videos_on_Your_Hard_Drive_thumbnail.png
added QmWsJYdJGjBqNazdwWhgpBW1jNLpJU5Uwo1NL1oFZJQwhs 
```



## Add Via Ruby API
```
c = IPFS::Client.new(host: 'http://ipfs', port: 5001)
r = IPFS::Commands::Add.call(c, f)
=> #<IPFS::Content::Link:0x0000556c175b7fb0 @hashcode="QmbFMke1KXqnYyBBWxB74N4c5SBnJMVAiMNRcGu6x1AwQH", @name="textfile2.txt", @size="6">

f = File.open('/share_content/textfile2.txt')
=> #<File:/share_content/textfile2.txt>

r = IPFS::Commands::Add.call(c, f)
=> #<IPFS::Content::Link:0x0000556c18981258 @hashcode="QmXgx2vad4W1P5nBwQmmcWNCpgEhFkWhqo4SmGXw4Vferq", @name="textfile2.txt", @size="38">
r.hashcode
=> "QmXgx2vad4W1P5nBwQmmcWNCpgEhFkWhqo4SmGXw4Vferq"

```


## Drop Ruby Object Via API

```
[39] pry(main)> IPFS::Commands::PinRm.(c, "QmXgx2vad4W1P5nBwQmmcWNCpgEhFkWhqo4SmGXw4Vferq", recursive: "1")
=> #<HTTP::Response/1.1 200 OK {"Access-Control-Allow-Headers"=>"X-Stream-Output, X-Chunked-Output, X-Content-Length", "Access-Control-Expose-Headers"=>"X-Stream-Output, X-Chunked-Output, X-Content-Length", "Content-Type"=>"application/json", "Server"=>"go-ipfs/0.4.13", "Trailer"=>"X-Stream-Error", "Vary"=>"Origin", "Date"=>"Thu, 05 Apr 2018 04:09:17 GMT", "Connection"=>"close", "Transfer-Encoding"=>"chunked"}>
```

### Using CURL
curl -F "file=@/share_content/textfile.txt" "http://localhost:5001/api/v0/add"


## Peer Count

ipfs swarm peers | wc -l