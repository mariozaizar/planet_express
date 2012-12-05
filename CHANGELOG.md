Changelog
=========

### 0.0.8
- Removing log4r and use Rails.logger instead (fix for isssue #1)

### 0.0.7
- If Rails.logger exists use it, if not switch to log4r.

### 0.0.6
- Start using log4r instead of Logger.new (now logs are namespaced)
- Minor changes to README and documentation. Added Changelog and silverpop api.
- Adding name spaced exceptions to handle custom errors.

### 0.0.5
- Start using job.configure { } to change the Silverpop gateway url.
- Start using Pry instead of IRB.
- Start using Awesome Print instead of inspect.

### 0.0.4
- Minor changes to README and documentation.

### 0.0.3
- First usable version. Seems to be working.

### 0.0.2
- Adding a few clasess, still a mess.

### 0.0.1
- Empty gem using bundler's boilerplate.

TODO
----

- Include Yard for documentation http://yardoc.org
- Let change the gateway from the Class, instead from the instance
