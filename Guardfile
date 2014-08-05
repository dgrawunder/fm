# A sample Guardfile
# More info at https://github.com/guard/guard#readme

notification :notifysend, t: 1000

guard :rspec, cmd: 'bundle exec rspec', failed_mode: :none, notification: true do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^app/(.+)\.rb$})                   { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^app/cli/interactions(.+)\.rb$})   { 'spec/cli/commands' }
  watch('spec/spec_helper.rb')                { "spec" }

  watch(%r{^spec/support/(.+)\.rb$})          { "spec" }
end

