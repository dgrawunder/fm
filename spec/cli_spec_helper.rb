require './app/cli/setup'

RSpec.configure do |config|

  config.before(:each, type: :cli) do

    #stubing all print methods to suppress output
    FmCli::Stdio.instance_methods.grep(/print/) do |method|
      allow_any_instance_of(FmCli::Stdio).to receive(method)
    end
  end

  config.include CliTestHelper, type: :cli
end