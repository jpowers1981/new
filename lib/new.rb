require 'active_support/core_ext/hash/deep_merge'
require 'active_support/core_ext/hash/keys'
require 'active_support/core_ext/object/deep_dup'
require 'active_support/core_ext/string/inflections'
require 'date'
require 'tmpdir'
require 'yaml'

class New; end
# modules
require 'new/dsl'
require 'new/interpolate'
require 'new/version'

# classes
require 'new/cli'
require 'new/project'
require 'new/template'
require 'new/task'

class New
  CONFIG_FILE = '.new'
  GLOBAL_CONFIG_FILE = File.expand_path("~/#{CONFIG_FILE}")

  def self.global_config
    YAML.load(File.read(GLOBAL_CONFIG_FILE)).deep_symbolize_keys
  end

  def self.version
    YAML.load(File.read(File.dirname(__FILE__) + '/../.new'))['version']
  end

  def self.tasks
  end

  def self.templates
  end
end


# class New
#   VERSION = '0.0.1'
#   DEFAULT_DIR = File.expand_path('../..', __FILE__)
#   CUSTOM_DIR = File.expand_path('~/.new')
#   TASKS_DIR_NAME = 'tasks'
#   TEMPLATES_DIR_NAME = 'templates'
#   CONFIG_FILE = '.new'

#   # List all the available tasks
#   #
#   def self.tasks
#     custom_tasks | default_tasks
#   end

#   # List all the available templates
#   #
#   def self.templates
#     custom_templates | default_templates
#   end

#   def self.default_templates
#     @default_templates ||= get_list TEMPLATES_DIR_NAME, :default
#   end

#   def self.custom_templates
#     @custom_templates ||= get_list TEMPLATES_DIR_NAME, :custom
#   end

#   def self.default_tasks
#     @default_tasks ||= get_list TASKS_DIR_NAME, :default
#   end

#   def self.custom_tasks
#     @custom_tasks ||= get_list TASKS_DIR_NAME, :custom
#   end

#   def self.custom_config
#     @custom_config ||= YAML.load(File.open(File.join(CUSTOM_DIR, CONFIG_FILE))).deep_symbolize_keys! rescue {}
#   end

# private

#   def self.get_list dir, filter
#     case filter
#     when :default
#       Dir[File.join(DEFAULT_DIR, dir, '**')]
#     when :custom
#       Dir[File.join(CUSTOM_DIR, dir, '**')]
#     end.map{ |d| File.basename(d).to_sym }
#   end
# end

# # core
# require 'new/core'

# # modules
# require 'new/dsl'
# require 'new/interpolate'
# require 'new/version'

# # classes
# require 'new/cli'
# require 'new/project'
# require 'new/template'
# require 'new/task'

# class New
#   extend New::Dsl
# end
