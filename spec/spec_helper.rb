require 'rails/all'
require 'lol_dba'

ENV["RAILS_ENV"] ||= 'test'

ActiveRecord::Base.establish_connection(
  :adapter  => "sqlite3",
  :database => ":memory:"
)

module Rails
  def self.root
    "spec/fixtures/"
  end
end
Dir.glob("#{Rails.root}/app/models/*.rb").sort.each { |file| require_dependency file }

ActiveRecord::Schema.verbose = false
load 'fixtures/schema.rb'

root_dir = File.dirname(__FILE__)

#add current dir to the load path
$:.unshift('.')
RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.allow_message_expectations_on_nil = true
    mocks.verify_partial_doubles = true
  end
  config.disable_monkey_patching!
end
