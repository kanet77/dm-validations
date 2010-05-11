require 'dm-core/spec/setup'
require 'dm-core/spec/lib/adapter_helpers'

require 'dm-validations'
require 'dm-types'
require 'dm-migrations'

SPEC_ROOT = Pathname(__FILE__).dirname
Pathname.glob((SPEC_ROOT + 'fixtures/**/*.rb').to_s).each { |file| require file }
Pathname.glob((SPEC_ROOT + 'integration/shared/**/*.rb').to_s).each { |file| require file }

DataMapper::Spec.setup

Spec::Runner.configure do |config|
  config.extend(DataMapper::Spec::Adapters::Helpers)
end