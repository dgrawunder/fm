require 'cli_spec_helper'

describe FmCli::Cli, type: :cli do

  describe 'version' do

    it 'should print version' do
      expect_any_instance_of(FmCli::Stdio).to receive("print") do |message|
        expect(message).to include Fm.version
      end

      run_command 'version'
    end
  end
end