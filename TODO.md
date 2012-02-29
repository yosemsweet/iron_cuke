Todo
====

* *Testing*
 * Create spec for TestService - easy and critical
 * Create specs for QueueItems - easy
 * Create specs for ScheduledQueue - easy
 * Create specs for generators 
 * Create specs for cucumber step and support files
* *Schedule*
 * Support schedule options of: - medium
  * run_times > 1
  * every x period
 * Ensure chronological execution order
* *Queue*
 * Support recursive options for queue
 * Support timeout options for queue
  * Set an error/timeout mode
 * Return error response if a worker queues a worker of same class and recursive isn't set to true
* Exceptions and errors
 * Log instead of puts
 * Provide a callback hook
* *Being a good gem
 * Better generators and options for time mocking (iron_cuke:install, iron_cuke:install --timecop, iron_cuke:install --time-warp, etc)
 * RDocs
 * Travis CI
  * Rails 3, 3.1, 3.2
  * MRI 1.9.1, 1.9.2, 1.9.3
  * JRuby
  * REE
  * Rubinius
 * Wiki with details examples
 * Samples of how to use Rack::Test to make requests via workers in test environment 




Notes
=====

* Needs to work with cucumber (rspec later)
* Run jobs locally
* We don't need to run them asynchronously although it is awesome if they are.
* Scheduled events should fire when the timecop time says they should
* Rspec integration test not needed, just unit test
