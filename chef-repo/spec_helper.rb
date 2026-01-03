require 'chefspec'
require 'chefspec/berkshelf'

RSpec.configure do |config|
  config.cookbook_path = ['cookbooks']
  config.platform = 'ubuntu'
  config.version = '20.04'
end