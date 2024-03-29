# Command line reference
https://github.com/sidekiq/sidekiq/wiki/API

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

### Monitor

https://gist.github.com/ngsmrk/4ad439143622a46b8a5b
```ruby
stats = Sidekiq::Stats.new

stats.queues

stats.enqueued

stats.processed

stats.failed

scheduled_queue = Sidekiq::ScheduledSet.new
scheduled_queue.select
    scheduled.map do |job|
      p job
end

retry_queue = Sidekiq::RetrySet.new

default_queue = Sidekiq::Queue.new("default")

default_queue.each do |job|
	class_arg = job.args[0].split('-').select { | arg  | arg.match(' !ruby/class')  }[0]
	puts class_arg.split[1].gsub '\'', '' unless class_arg.nil?
end

ds = Sidekiq:::DeadSet.new

```

# Monitor Workers
```ruby
@current_job_payloads ||= Sidekiq::WorkSet.new.flat_map { |_pid, _thread_id, work| work['payload'] }
```

# Current Jobs

```ruby
  def current_job_payloads
    @current_job_payloads ||= Sidekiq::Workers.new.flat_map { |_pid, _thread_id, work| work['payload'] }
  end

  def all_job_ids
    current_job_payloads.map do |payload|
      ph = JSON.parse(payload)
      job_id = ph.dig('args', 0, 'job_id')

      job_class = ph.dig('args', 0, 'job_class')

      # Extract the user ID
      arguments = ph.dig('args', 0, 'arguments')&.reduce { |r, h| r.merge(h) }
      user_global_id = arguments.dig('user', '_aj_globalid')
      user = GlobalID::Locator.locate(user_global_id)

      file_name = arguments['file_name']
      file_path = "/#{File.join(CreatePdfJob::EXPORTS_DIR, file_name)}"

      status = :starting
      message = status.to_s.capitalize

      # TODO: fill out with missing and more accurate fields from JobStatusType
      { job_id:, job_class:, file_name:, file_path:, message:, status:, user_id: user&.user_id }
    end



    def enqueued_jobs
      all_jobs =
        Sidekiq::Queue
          .new
          .map do |q|
          args = q.item.dig('args', 0)
          arguments = args['arguments'].map(&:to_a).flatten(1).to_h
          user = GlobalID::Locator.locate(arguments['user'])

          {
            job_id: args['job_id'],
            job_class: args['job_class'],
            file_name: arguments['file_name'],
            status: :starting,
            user_id: user&.user_id,
            enqueued_at: q['enqueued_at']
          }
        end

      return all_jobs unless user_id.present?

      all_jobs.select { |j| j[:user_id].to_s == user_id.to_s }
    end

```