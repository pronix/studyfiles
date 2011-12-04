class Ltree < ActiveRecord::Migration
  def up
    cmd = "psql --username=#{ActiveRecord::Base.connection.instance_variable_get(:@config)[:username]} -W -f `pg_config --sharedir`/contrib/ltree.sql #{ActiveRecord::Base.connection.instance_variable_get(:@config)[:database]}"
    puts cmd
    result = system(cmd)
    raise "Require install postgresql-contrib" unless result
    update "ALTER TABLE \"folders\" ADD \"path\" LTREE NOT NULL DEFAULT 'Top'"
  end

  def down
    update "ALTER TABLE \"folders\" DROP \"path\""
    cmd = "psql --username=#{ActiveRecord::Base.connection.instance_variable_get(:@config)[:username]} -W -f `pg_config --sharedir`/contrib/uninstall_ltree.sql #{ActiveRecord::Base.connection.instance_variable_get(:@config)[:database]}"
    puts cmd
    result = system(cmd)
    raise "Require install postgresql-contrib" unless result
  end
end
