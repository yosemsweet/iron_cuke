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

    group :test do
      gem "iron_cuke"
    end

I'm assuming you also have cucumber-rails and iron_worker gems installed, if not iron_cuke won't do you much good:

    gem "cucumber-rails", :group => :test
    gem "iron_worker"
  
Now run:
  
    bundle install
    rails generate iron_cuke


Basic Usage
-----------

Create and schedule/queue workers as normal. 

Contribute
----------

* Fork the project.
* Test drive your feature addition or bug fix.  Specs make all the difference here.
* Commit, do not mess with Rakefile, version, or ChangeLog.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

Gem developed by Yosem Sweet and released (whenever that is) under the MIT license