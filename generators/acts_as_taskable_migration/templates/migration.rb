class ActsAsTaskableMigration < ActiveRecord::Migration
  def self.up
    create_table :tasks, :force => true do |t|
      t.string    :title, :limit => 150, :default => ''
      t.text      :description, :default => ''
      t.datetime  :due_by
      t.boolean   :completed, :null => false, :default => false
      t.integer   :taskable_id, :default => 0, :null => false
      t.string    :taskable_type, :limit => 25, :default => '', :null => false
      t.integer   :user_id, :default => 0, :null => false
      t.timestamps
    end

    add_index "tasks", ["user_id"], :name => "fk_tasks_user"
  end

  def self.down
    remove_index "fk_tasks_user"
    drop_table :tasks
  end
end
