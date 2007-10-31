# ActsAsTaskable
module Hedgehoglab
  module Rails
    module Taskable #:nodoc:

      def self.included(base)
        base.extend ClassMethods  
      end

      module ClassMethods
        def acts_as_taskable
          has_many :tasks, :as => :taskable, :dependent => :destroy, :order => 'created_at ASC'
          include Hedgehoglab::Rails::Taskable::InstanceMethods
          extend Hedgehoglab::Rails::Taskable::SingletonMethods
        end
      end
      
      # This module contains class methods
      module SingletonMethods
        
        # Method to find tasks for a particular user
        def find_tasks_by_user(user) 
          taskable = ActiveRecord::Base.send(:class_name_of_active_record_descendant, self).to_s
          
          Task.find(:all,
            :conditions => ["user_id = ? and taskable_type = ?", user.id, taskable],
            :order => "created_at DESC"
          )
        end
      end
      
      # This module contains instance methods
      module InstanceMethods
        
        # Method to add a task to any object
        def add_task(task)
          tasks << task
        end
      end
      
    end
  end
end
