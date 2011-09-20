class CreateTables < ActiveRecord::Migration
  def change
    execute "DROP TABLE IF EXISTS users"
    execute "DROP TABLE IF EXISTS documents"
    execute "DROP TABLE IF EXISTS messages"
    execute "DROP TABLE IF EXISTS universities"
    execute "DROP TABLE IF EXISTS sections"
    execute "DROP TABLE IF EXISTS subjects"
    execute "DROP TABLE IF EXISTS folders"
    execute "DROP TABLE IF EXISTS university_subjects"
    execute "DROP TABLE IF EXISTS subject_folders"
    execute "DROP TABLE IF EXISTS subject_documents"
    execute "DROP TABLE IF EXISTS delayed_jobs"
    create_table :users do |t|
      t.timestamps
    end
    create_table :documents do |t|
      t.integer :raiting
      t.timestamps
    end
    create_table :messages do |t|
      t.integer :user_id
      t.text :text
      t.integer :from_user_id
      t.timestamps
    end
    create_table :universities do |t|
      t.string :name
      t.string :abbreviation
      t.string :city
      t.timestamps
    end
    create_table :sections do |t|
      t.string :name
      t.timestamps
    end
    create_table :subjects do |t|
      t.string :name
      t.string :abbreviation
      t.integer :section_id
      t.timestamps
    end
    create_table :folders do |t|
      t.string :name
      t.text :description
      t.integer :user_id
      t.timestamps
    end
    #отношение университетов и предметов
    create_table :university_subjects, :id => false do |t|
      t.integer :university_id
      t.integer :subject_id
    end

    #отношение предметов и папок
    create_table :subject_folders, :id => false do |t|
      t.integer :folder_id
      t.integer :subject_id
    end

    #отношение предметов и файлов
    create_table :subject_documents, :id => false do |t|
      t.integer :document_id
      t.integer :subject_id
    end
    create_table :delayed_jobs, :force => true do |table|
      table.integer  :priority, :default => 0      # Allows some jobs to jump to the front of the queue
      table.integer  :attempts, :default => 0      # Provides for retries, but still fail eventually.
      table.text     :handler                      # YAML-encoded string of the object that will do work
      table.text     :last_error                   # reason for last failure (See Note below)
      table.datetime :run_at                       # When to run. Could be Time.zone.now for immediately, or sometime in the future.
      table.datetime :locked_at                    # Set when a client is working on this object
      table.datetime :failed_at                    # Set when all retries have failed (actually, by default, the record is deleted instead)
      table.string   :locked_by                    # Who is working on this object (if locked)
      table.timestamps
    end
  end
end
