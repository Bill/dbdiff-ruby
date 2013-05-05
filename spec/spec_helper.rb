require 'ruby-debug'

# require 'simplecov'
# SimpleCov.start do
#   add_group "DBDiff", "./"
# end

$:.unshift(File.join( File.dirname(__FILE__), '..'))

# http://anti-pattern.com/bundler-setup-vs-bundler-require
require 'rubygems'
require 'bundler/setup'

# when we run via plain old "ruby" command instead of "rspec", this
# line tells ruby to run the examples
require 'rspec/autorun'

# This is the present file we want to test
require 'dbdiff'

# Grab all the rspec support files: utility classes, custom matchers etc.
$LOAD_PATH.unshift(*Dir[File.join( File.dirname(__FILE__), 'support/**')])

require 'spec_helper_methods'

RSpec.configure do |config|

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"

  # Use color in STDOUT
  config.color_enabled = true

  # Use color not only in STDOUT but also in pagers and files
  config.tty = true

  # Use the specified formatter
  config.formatter = :progress # :documentation :progress, :html, :textmate

  config.include SpecHelperMethods
end
