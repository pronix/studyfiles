class AddLtreeType < ActiveRecord::Migration
  def self.up
    cmd = "psql --username=#{ActiveRecord::Base.connection.instance_variable_get(:@config)[:username]} -w -f `pg_config --sharedir`/contrib/ltree.sql #{ActiveRecord::Base.connection.instance_variable_get(:@config)[:database]}"
    puts cmd
    result = system(cmd)
    raise "Bad exit" unless result
    update "ALTER TABLE \"documents\" ADD \"path\" LTREE NOT NULL DEFAULT 'Top'"
  end

  def self.down
    update "ALTER TABLE \"documents\" DROP \"path\""
    cmd = "psql --username=#{ActiveRecord::Base.connection.instance_variable_get(:@config)[:username]} -w -f `pg_config --sharedir`/contrib/uninstall_ltree.sql #{ActiveRecord::Base.connection.instance_variable_get(:@config)[:database]}"
    puts cmd
    result = system(cmd)
    raise "Bad exit" unless result
  end
end
