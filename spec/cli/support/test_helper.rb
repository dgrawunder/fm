module CliTestHelper

  def run_command *args
    FmCli::Cli.start(args)
  end

  def expect_to_print_success_message
    expect_to_print :success
  end

  def expect_to_print_failure_message
    expect_to_print :failure
  end

  def expect_to_print_errors
    expect_to_print :errors
  end

  def expect_to_print subject
    expect_any_instance_of(FmCli::Stdio).to receive("print_#{subject}")
  end
end