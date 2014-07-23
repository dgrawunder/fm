module CliTestHelper

  def run_command *args
    FmCli::Cli.start(args)
  end

  def expect_to_print_success_message
    expect_any_instance_of(FmCli::Stdio).to receive(:print_success)
  end

  def expect_to_print subject
    expect_any_instance_of(FmCli::Stdio).to receive("print_#{subject}")
  end
end