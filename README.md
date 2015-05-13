## Sensu-Plugins-pingdom

[![Build Status](https://travis-ci.org/sensu-plugins/sensu-plugins-pingdom.svg?branch=master)](https://travis-ci.org/sensu-plugins/sensu-plugins-pingdom)
[![Gem Version](https://badge.fury.io/rb/sensu-plugins-pingdom.svg)](http://badge.fury.io/rb/sensu-plugins-pingdom)
[![Code Climate](https://codeclimate.com/github/sensu-plugins/sensu-plugins-pingdom/badges/gpa.svg)](https://codeclimate.com/github/sensu-plugins/sensu-plugins-pingdom)
[![Test Coverage](https://codeclimate.com/github/sensu-plugins/sensu-plugins-pingdom/badges/coverage.svg)](https://codeclimate.com/github/sensu-plugins/sensu-plugins-pingdom)
[![Dependency Status](https://gemnasium.com/sensu-plugins/sensu-plugins-pingdom.svg)](https://gemnasium.com/sensu-plugins/sensu-plugins-pingdom)
[ ![Codeship Status for sensu-plugins/sensu-plugins-pingdom](https://codeship.com/projects/df105a20-db4b-0132-445b-5ad94843e341/status?branch=master)](https://codeship.com/projects/79591)

## Functionality

## Files
 * bin/check-pingdom-aggregates
 * bin/check-pingdom-credits

## Usage

## Installation

Add the public key (if you haven’t already) as a trusted certificate

```
gem cert --add <(curl -Ls https://raw.githubusercontent.com/sensu-plugins/sensu-plugins.github.io/master/certs/sensu-plugins.pem)
gem install sensu-plugins-pingdom -P MediumSecurity
```

You can also download the key from /certs/ within each repository.

#### Rubygems

`gem install sensu-plugins-pingdom`

#### Bundler

Add *sensu-plugins-disk-checks* to your Gemfile and run `bundle install` or `bundle update`

#### Chef

Using the Sensu **sensu_gem** LWRP
```
sensu_gem 'sensu-plugins-pingdom' do
  options('--prerelease')
  version '0.0.1'
end
```

Using the Chef **gem_package** resource
```
gem_package 'sensu-plugins-pingdom' do
  options('--prerelease')
  version '0.0.1'
end
```

## Notes
