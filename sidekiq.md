### Check what's in queue

```ruby
require 'sidekiq/api'
Sidekiq::Queue.new('sidekiq_low').size

```

### Run Sidekiq

https://github.com/mperham/sidekiq/wiki/Active-Job
```ruby
bundle exec sidekiq -q default -q mailers
```