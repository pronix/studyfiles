class AddLtreeType < ActiveRecord::Migration
  def self.up
    cmd = "psql -f `pg_config --sharedir`/contrib/ltree.sql #{ActiveRecord::Base.connection.instance_variable_get(:@config)[:database]}"
    puts cmd
    result = system(cmd)
    raise "Bad exit" unless result
    execute "ALTER TABLE \"documents\" ADD \"path\" LTREE NOT NULL DEFAULT 'Top'"
  end

  def self.down
    execute "ALTER TABLE \"documents\" DROP \"path\""
    cmd = "psql -f `pg_config --sharedir`/contrib/uninstall_ltree.sql #{ActiveRecord::Base.connection.instance_variable_get(:@config)[:database]}"
    puts cmd
    result = system(cmd)
    raise "Bad exit" unless result
  end
end
