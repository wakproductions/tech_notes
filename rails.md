## Change the Logger to STDOUT

```ruby
ActiveRecord::Base.logger = Logger.new(STDOUT)
```