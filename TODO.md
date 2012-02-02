* Create specs for QueueItems
* Create specs for ScheduledQueue
* Support schedule options of:
** run_times > 1
** every x period
* Instead of monkey patching IronWorker::Base.schedule we should implement an IronWorker::TestService and have IronWorker.service return that.
