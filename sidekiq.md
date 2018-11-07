## Check what's in queue

```ruby
require 'sidekiq/api'
Sidekiq::Queue.new('sidekiq_low').size

```