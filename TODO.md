* Create specs for QueueItems - easy
* Create specs for ScheduledQueue - easy
* Create spec for TestService - easy and critical
* Support schedule options of: - medium
** run_times > 1
** every x period
* Instead of creating a bunch of mixins we should implement an IronWorker::TestService and have IronWorker.service return that. - hard
* Create a more dynamic response system. Right now it is basically just hardcoded. - easy
* Set up generators to create an iron_cuke.rb in cucumber features/support if present
* Implement cancel_schedule
* Implement schedules via TestService
* Implement Queueing system
** Base.queue options (priority and recursive)




Development Notes and Todos:
----------------------------
Needs to work with cucumber and rspec

Notes
Run jobs locally
We don't need to run them asynchronously although it is awesome if they are.
Scheduled events should fire when the timecop time says they should
Initial pass can have a cucumber step for all jobs complete - this should not stick around for long though. ALternative is to have the ScheduledWorkerQueue run after every step
Rspec integration test not needed, just unit test

Basic model

IronCuke module encapsulates access to ScheduledWorkerQueue

Scheduled Workers:
ScheduledWorkerQueue - A hash where each worker is keyed by the time they run.
Functions
run - runs all workers before current time (should this be run_with_time?)
schedule - takes a worker and schedule parameters (equivalent to IronWorker service). Adds the worker into the hash at time. returns an array response equivalent to posting to iron worker. The response includes a scheduled_task_id identifying the scheduled worker
cancel - takes scheduled_task_id and removes from schedule

Workers
stub worker.schedule to write to scheduled workers
stub IronWorker.service.cancel_schedule to delegate to ScheduledWorkerQueue
