require "codeclimate-test-reporter"
CodeClimate::TestReporter.start
require 'coveralls'
Coveralls.wear!
require 'new'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  CodeClimate::TestReporter::Formatter,
  Coveralls::SimpleCov::Formatter,
  SimpleCov::Formatter::HTMLFormatter
]

# load sources and create symlinks to all the task folders for rspec to pickup
# only do this locally, not with ci
# TODO: still need a way to add them to guard watch list tho
unless ENV['CI']
  New.load_newfiles
  New::Source.load_sources
  New::Source.sources.each do |source_name, source|
    source.tasks.each do |task_name, task_path|
      `ln -s #{File.dirname(task_path)} spec/lib/tasks`
    end
  end
end

class Object
  def class_var var, value = nil
    if value.nil?
      self.send(:class_variable_get, :"@@#{var}")
    else
      self.send(:class_variable_set, :"@@#{var}", value)
    end
  end

  def instance_var var, value = nil
    if value.nil?
      self.send(:instance_variable_get, :"@#{var}")
    else
      self.send(:instance_variable_set, :"@#{var}", value)
    end
  end
end

def root *paths
  paths.unshift(File.expand_path(File.join(File.dirname(__FILE__), '..'))).compact.join '/'
end

# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
# The settings below are suggested to provide a good initial experience
# with RSpec, but feel free to customize to your heart's content.

  # These two settings work together to allow you to limit a spec run
  # to individual examples or groups you care about by tagging them with
  # `:focus` metadata. When nothing is tagged with `:focus`, all examples
  # get run.
  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  # Many RSpec users commonly either run the entire suite or an individual
  # file, and it's useful to allow more verbose output when running an
  # individual spec file.
  if config.files_to_run.one?
    # Use the documentation formatter for detailed output,
    # unless a formatter has already been configured
    # (e.g. via a command-line flag).
    config.default_formatter = 'doc'
  end

  # Print the 10 slowest examples and example groups at the
  # end of the spec run, to help surface which specs are running
  # particularly slow.
  config.profile_examples = 10

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = :random

  # Seed global randomization in this process using the `--seed` CLI option.
  # Setting this allows you to use `--seed` to deterministically reproduce
  # test failures related to randomization by passing the same `--seed` value
  # as the one that triggered the failure.
  Kernel.srand config.seed

  # rspec-expectations config goes here. You can use an alternate
  # assertion/expectation library such as wrong or the stdlib/minitest
  # assertions if you prefer.
  config.expect_with :rspec do |expectations|
    # Enable only the newer, non-monkey-patching expect syntax.
    # For more details, see:
    #   - http://myronmars.to/n/dev-blog/2012/06/rspecs-new-expectation-syntax
    expectations.syntax = :expect
  end

  # rspec-mocks config goes here. You can use an alternate test double
  # library (such as bogus or mocha) by changing the `mock_with` option here.
  config.mock_with :rspec do |mocks|
    # Enable only the newer, non-monkey-patching expect syntax.
    # For more details, see:
    #   - http://teaisaweso.me/blog/2013/05/27/rspecs-new-message-expectation-syntax/
    mocks.syntax = :expect

    # Prevents you from mocking or stubbing a method that does not exist on
    # a real object. This is generally recommended.
    mocks.verify_partial_doubles = true
  end

  config.before :suite do
    FileUtils.mkdir_p root('tmp')
  end

  config.after :suite do
    FileUtils.rm_rf root('tmp')
    FileUtils.rm_rf Dir[root('spec', 'lib', 'tasks', '**')]
  end

  config.before do
    stub_const 'New::HOME_DIRECTORY', root('tmp')
    stub_const 'New::DEFAULT_NEWFILE', {
      :sources => {
        :default => root('spec', 'fixtures')
      }
    }

    allow(A).to receive(:sk)
    allow(S).to receive(:ay)
  end

  config.after do
    allow(A).to receive(:sk).and_call_original
    allow(S).to receive(:ay).and_call_original
  end
end
