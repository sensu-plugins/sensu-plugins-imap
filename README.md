## Sensu-Plugins-imap

[![Build Status](https://travis-ci.org/sensu-plugins/sensu-plugins-imap.svg?branch=master)](https://travis-ci.org/sensu-plugins/sensu-plugins-imap)
[![Gem Version](https://badge.fury.io/rb/sensu-plugins-imap.svg)](http://badge.fury.io/rb/sensu-plugins-imap)
[![Code Climate](https://codeclimate.com/github/sensu-plugins/sensu-plugins-imap/badges/gpa.svg)](https://codeclimate.com/github/sensu-plugins/sensu-plugins-imap)
[![Test Coverage](https://codeclimate.com/github/sensu-plugins/sensu-plugins-imap/badges/coverage.svg)](https://codeclimate.com/github/sensu-plugins/sensu-plugins-imap)
[![Dependency Status](https://gemnasium.com/sensu-plugins/sensu-plugins-imap.svg)](https://gemnasium.com/sensu-plugins/sensu-plugins-imap)

## Functionality

## Files
 * bin/check-imap

## Usage

## Installation

Add the public key (if you haven’t already) as a trusted certificate

```
gem cert --add <(curl -Ls https://raw.githubusercontent.com/sensu-plugins/sensu-plugins.github.io/master/certs/sensu-plugins.pem)
gem install sensu-plugins-imap -P MediumSecurity
```

You can also download the key from /certs/ within each repository.

#### Rubygems

`gem install sensu-plugins-imap`

#### Bundler

Add *sensu-plugins-disk-checks* to your Gemfile and run `bundle install` or `bundle update`

#### Chef

Using the Sensu **sensu_gem** LWRP
```
sensu_gem 'sensu-plugins-imap' do
  options('--prerelease')
  version '0.0.1'
end
```

Using the Chef **gem_package** resource
```
gem_package 'sensu-plugins-imap' do
  options('--prerelease')
  version '0.0.1'
end
```

## Notes
