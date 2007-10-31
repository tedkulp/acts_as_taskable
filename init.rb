# Include hook code here
require 'acts_as_taskable'
ActiveRecord::Base.send(:include, Hedgehoglab::Rails::Taskable)
