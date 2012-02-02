* Create specs for QueueItems - easy
* Create specs for ScheduledQueue - easy
* Support schedule options of: - medium
** run_times > 1
** every x period
* Instead of monkey patching IronWorker::Base.schedule we should implement an IronWorker::TestService and have IronWorker.service return that. - hard
* Create a more dynamic response system. Right now it is basically just hardcoded. - easy
