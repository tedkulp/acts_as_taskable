class Task < ActiveRecord::Base
  belongs_to :taskable, :polymorphic => true
  
  # NOTE: Tasks belong to a user
  belongs_to :user
  
end