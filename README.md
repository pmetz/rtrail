RTrail
======

[![Build Status](https://travis-ci.org/a-e/rtrail.svg?branch=master)](https://travis-ci.org/a-e/rtrail)
[![Coverage Status](https://coveralls.io/repos/a-e/rtrail/badge.png)](https://coveralls.io/r/a-e/rtrail)

Ruby object wrapper for the [TestRail][1] [API v2][2]

Please use the [issue tracker][3] to report bugs or request improvements, and
[fork this repository][4] if you'd like to hack on it.


[1]: http://www.gurock.com/testrail/ "TestRail Homepage"
[2]: http://docs.gurock.com/testrail-api2/start "TestRail API v2 docs"

[3]: https://github.com/a-e/rtrail/issues "RTrail Issue Tracker"
[4]: https://github.com/a-e/rtrail/fork "Fork RTrail on Github"

Installation
------------

Run from a console:

    $ gem install rtrail

Or add to your `Gemfile` before a `bundle install`:

    gem 'rtrail'



Overview
--------

RTrail provides a hierarchy of Ruby objects, mirroring the data structure
within TestRail. Here's a rough look:

- Project(s)
    - Plan(s)
    - Suite(s)
        - Case(s)
        - Section(s)
    - Run(s)
        - Test(s)
            - Result(s)

Within RTrail, each of these things are modeled by a class, with a common base
class known as `Entity`.


Usage
-----

The top-level interface is through `RTrail::API`; simply provide your TestRail
server's hostname, username and password:

    > api = RTrail::API.new("http://example.com/", "epierce", "myPa$$w0rd")

Some convenience methods are provided; for example:

    # Get a list of all Projects
    > api.projects
    => [#<RTrail::Project ...>, ..., #<RTrail::Project ...>]

    # Get a single Project by name
    > api.project("Web Applications")
    => #<RTrail::Project ...>

    # Get a Suite within a Project
    > api.suite("Web Applications", "Storefront")
    => #<RTrail::Suite ...>

Each Entity type provides wrappers for some of the API methods you're likely to
use; for instance:

    > project = api.project("Web Applications")
    > project.suites        # GET /get_suites/<project_id>
    > project.plans         # GET /get_plans/<project_id>
    > project.runs          # GET /get_runs/<project_id>

    > project.runs.count
    => 4

    > project.runs.each { |run| run.id }
    => [103, 104, 119, 127]

    > run = project.runs.first

    > run.completed?
    => true
    > run.summary
    => "103: Website Login [completed 2014-07-16 21:45:08 UTC]


Development
-----------

To contribute, please [fork this repository](https://github.com/a-e/rtrail/fork),
develop your code and write spec tests that cover it, commit to your fork
and submit a pull request with your changes.


References
----------

- TestRail homepage: http://www.gurock.com/testrail/
- Another TestRail Ruby client: https://github.com/krobi64/testrail
- Official TestRail API examples: https://github.com/gurock/testrail-api
- TestRail API v2 docs: http://docs.gurock.com/testrail-api2/start


License
-------

MIT License.

