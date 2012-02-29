Todo
----

* *Testing*
** Create spec for TestService - easy and critical
** Create specs for QueueItems - easy
** Create specs for ScheduledQueue - easy
* *Schedule*
** Support schedule options of: - medium
*** run_times > 1
*** every x period
** Ensure chronological execution order
* *Queue*
** Support recursive options for queue
** Support timeout options for queue
*** Set an error/timeout mode
** Return error response if a worker queues a worker of same class and recursive isn't set to true
* Exceptions and errors
** Log instead of puts
** Provide a callback hook
* *Being a good gem
** Better generators and options for time mocking (iron_cuke:install, iron_cuke:install --timecop, iron_cuke:install --time-warp, etc)
** RDocs
** Travis CI
*** Rails 3, 3.1, 3.2
*** MRI 1.9.1, 1.9.2, 1.9.3
*** JRuby
*** REE
*** Rubinius
** Wiki with details examples
** Samples of how to use Rack::Test to make requests via workers in test environment 




Notes
-----

* Needs to work with cucumber (rspec later)
* Run jobs locally
* We don't need to run them asynchronously although it is awesome if they are.
* Scheduled events should fire when the timecop time says they should
* Rspec integration test not needed, just unit test

Basic model
-----------

IronCuke module encapsulates access to IronCuke::ScheduledQueue and IronCuke::Queue

*Scheduled Workers*
ScheduledQueue - A hash where an array of workers is keyed by the time they run.

*Functions*
run - runs all workers according to options passed in. Defaults to using time == Time.now and priority == 0 which should run all queued workers and all scheduled workers scheduled to run before or at now. Higher priority items execute before lower priority ones.
queue - takes a worker and priority options (equivalent to IronWorker service) and adds them to a worker queue to be executed the next time run is called. Priority defaults to 0.
schedule - takes a worker and schedule parameters (equivalent to IronWorker service). Adds the worker into the hash at time. returns an array response equivalent to posting to iron worker. The response includes a scheduled_task_id identifying the scheduled worker
queue - 
cancel - takes scheduled_task_id and removes from schedule

*Workers*
stub worker.schedule to write to scheduled workers
stub IronWorker.service.cancel_schedule to delegate to ScheduledWorkerQueue
