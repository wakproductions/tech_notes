## Disable the annoying IRB autocomplete

```
Reline.autocompletion = IRB.conf[:USE_AUTOCOMPLETE] = false
```
~/.irbrc
```
`IRB.conf[:USE_AUTOCOMPLETE] = false`
```

# Update the version of bundler

```
bundle update --bundler
```



## Change the Logger to STDOUT

```ruby
ActiveRecord::Base.logger = Logger.new(STDOUT)
```
## How to find Rails process ID to kill it

```
stonknotes (main)$ lsof -i :3666
COMMAND PID    USER   FD   TYPE  DEVICE SIZE/OFF NODE NAME
ruby    702 wkotzan   14u  IPv6 1841179      0t0  TCP ip6-localhost:3666->ip6-localhost:33056 (ESTABLISHED)

$ kill -9 702
```



## Ruby $ global variables

* $: (Dollar Colon) is basically a shorthand version of $LOAD_PATH. $: contains an array of paths that your script will search through when using require.
* $" lists the files loaded on $: 
* $0 (Dollar Zero) contains the name of the ruby program being run. This is typically the script name.
* $* (Dollar Splat) is basically shorthand for ARGV. $* contains the command line arguments that were passed to the script.
* $? (Dollar Question Mark) returns the exit status of the last child process to finish.
* $$ (Dollar Dollar) returns the process number of the program currently being ran.
* $~ (Dollar Tilde) contains the MatchData from the previous successful pattern match.
* $1, $2, $3, $4 etc represent the content of the previous successful pattern match.
* $& (Dollar Ampersand) contains the matched string from the previous successful pattern match.
* $+ (Dollar Plus) contains the last match from the previous successful pattern match.
* $` (Dollar Backtick) contains the string before the actual matched string of the previous successful pattern match.
* $’ (Dollar Apostrophe) contains the string after the actual matched string of the previous successful pattern match.
* $! (Dollar Bang) contains the Exception that was passed to raise.
* $@ (Dollar At Symbol) contains the backtrace for the last Exception raised.


http://viedma.tumblr.com/post/37155305475/ruby-global-variables

## Nokogiri install on the mac

`gem install nokogiri -- --with-xml2-include=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.11.sdk/usr/include/libxml2 --use-system-libraries`

## Regex

https://bneijt.nl/pr/ruby-regular-expressions/

## Convert Float to String with 2 Decimal Places

'%.2f' % number

## Pretty Print

Hash:
```
require 'pp'
pp myhash
```

JSON:
```
JSON.pretty_generate(my_hash_or_array)
```

# Hotwire Resources

[GoRails - How to use Hotwire](https://www.youtube.com/watch?v=Qp6sxgjA-xY&feature=emb_logo)

# Url Helpers

`Rails.application.routes.url_helpers.users_path`

# Quit generating rspec helpers




# Logging in Ruby on Rails

https://www.honeybadger.io/blog/ruby-logger-lograge/
Most of the benefits of Logger we’ve seen so far can all be used along with Rails apps. The Rails version of Logger is just a simple extension of Ruby’s native class.

Apart from that, Rails also adds a nice feature to allow devs to broadcast their logs to multiple loggers. Thus, if you want to work with more than one logging library, you can do so within Rails logger:

```ruby
custom_logger = Logger.new(STDOUT)
Rails.logger.extend(ActiveSupport::Logger.broadcast(custom_logger))
This can also be useful when you need some intelligence regarding the places your logs should go. Some parts of your app may need logs in different locations or different formats.
```