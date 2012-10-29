Planet Express.rb
=================

Description
-----------

Planet Express, Inc. is an intergalactic email delivery <strike>company</strike>
lib built in Ruby. Is meant to be used with Silverpop mailing system, to provide
an easy way to send emails. We're using it with Rails 3 apps.

> "Our crew is replaceable. Your <strike>package</strike> email isn't."

Features
--------

- Send emails using Silverpop.

### Examples

You only need three things, the package, the destination and the data.
Then create a new deliver, prepare the ship and deliver it!

```
require 'planet_express'

recipient  = 'mariozaizar@gmail.com'
package_id = 1807752
cargo      = { bill_float_test_body: "<h1>Good news everyone!</h1><img src='http://goo.gl/XazeH'>" }

job = PlanetExpress::Delivery.new
request   = job.prepare package_id, recipient, cargo
response  = job.deliver!
```

### Configuration

```
job.configure do |config|
  config.gateway_url = 'https://transact3.silverpop.com/XTMail'
end
```

Installation
------------

Add this line to your application's Gemfile `gem 'planet_express'` and then
execute `bundle install`. Or install it yourself as: `gem install planet_express`.

Silverpop API
-------------

Check this file: [doc/silverpop_api.md](./doc/silverpop_api.md)

Contributing
------------

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

**@MarioZaizar**
