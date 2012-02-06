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

