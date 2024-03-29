# -*- coding: utf-8 -*-
class CreateTables < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.string :name
      t.timestamps
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
