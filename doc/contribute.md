# Setup

## Install Ruby

## Ruby

Make sure that you're using the correct ruby version. We provide both
.rbenv-version and .rvmrc files just to be sure.

```
ruby --version;
ruby 1.9.3p194]
```

## Gems

Install `bundler` and all the dependencies:

```
gem install bundler;
bundle install;
```

At the end you should see:

```
$ bundle check
The Gemfile's dependencies are satisfied
```

## Tests

```
bundle exec guard
```
