#
#  Execute "rake db:setup" to initiate the database
#
unless Rails.env.production?
  connection = ActiveRecord::Base.connection
  connection.tables.each do |table|
    connection.execute("TRUNCATE #{table}") unless table == "schema_migrations"
  end

  sql = File.read('db/rtb4free_demo_base.sql')
  statements = sql.split(/;$/)
  statements.pop

  ActiveRecord::Base.transaction do
    statements.each do |statement|
      connection.execute(statement) if statement.to_s=~/^INSERT/
    end
  end
end
