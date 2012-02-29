iron_cuke
=========

A small gem to help you mock out [IronWorker](http://iron.io) while using cucumber. iron_cuke provides a set of steps and Cucumber world objects you can use to simulate IronWorker while running cucumber tests, thereby saving time *and* money.

Help
----

* The [iron_cuke github page](https://github.com/yosemsweet/iron_cuke/) is the best place to start for documentation/help. Eventually I hope to have a wiki in place but that may take a while.
* [Patches and bugs](https://github.com/yosemsweet/iron_cuke/issues) at github issues
* RDoc - there is no rdoc archive for iron_cuke. This is on the todo list for iron_cuke.

Installation
------------

iron_cuke is a Rails 3 gem. It is currently tested against Rails 3.1 and should work with Rails 3.2 and 3.0

Include the gem in your Gemfile within the :test group:

```ruby
group :test do
  gem 'iron_cuke'
end
```

I'm assuming you also have cucumber-rails and iron_worker gems installed, if not iron_cuke won't do you much good:

```ruby
  gem 'cucumber-rails', :group => :test
  gem 'iron_worker'
```
Now run:

```ruby
bundle install
rails generate iron_cuke
```


Basic Usage
-----------

Create and schedule/queue workers as normal. You can run your workers in one of three ways.

1. Use the `"When iron cuke runs"` step.
2. Use the `@iron_cuke` tag for your scenario - this will run IronCuke after every step (NOTE: This doesn't work if you have a scenario with a background)
3. Manually invoke it via `IronCuke.run`

How Does it Work?
-----------------

###IronCuke module###

The IronCuke module encapsulates access to IronCuke::ScheduledQueue and IronCuke::Queue
We monkey patch IronWorker.service to adjust the implementation of schedule and queue to use IronCuke::TestService instead.

*Functions*
* run - runs all workers according to options passed in. Defaults to using time == Time.now and priority == 0 which should run all queued workers and all scheduled workers scheduled to run before or at now. Higher priority items execute before lower priority ones.
* queue - takes a worker and priority options (equivalent to IronWorker service) and adds them to a worker queue to be executed the next time run is called. Priority defaults to 0.
* schedule - takes a worker and schedule parameters (equivalent to IronWorker service). Adds the worker into the hash at time. returns an array response equivalent to posting to iron worker. The response includes a scheduled_task_id identifying the scheduled worker
* clear - clears everything queued or scheduled

###IronCuke::TestService###

The IronCuke::TestService is an alternative (and very minimal) implementation of the IronWorker.service. Basically instead of doing all the interesting IronWorker goodness to package your workers and run them on the cloud it fakes doing all that and instead puts them in incredibly boring and simple hash like objects.

###IronCuke::QueueItem###

QueueItems wrap your workers in the various internal queues. Basically they allow me to keep track of the options the worker was queued with.

###IronCuke::ScheduledQueue and IronCuke::Queue###

These are hash like modules that extend the base IronCuke interface. They provide the schedule and queue management functionality.

Contribute
----------

Got awesome ideas or want to knock off an item on the TODO list?

* Fork the project.
* Test drive your feature addition or bug fix.  Specs make all the difference here.
* Commit, do not mess with Rakefile or version.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

Gem started by Yosem Sweet and released (whatever that means) under the MIT license