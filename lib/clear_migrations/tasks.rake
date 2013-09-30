
namespace :db do

  desc "Clear out old db migration files"
  task :clear_migrations do
    #check_schema
    do_migrations
    delete_migrations
    create_reset_migration
    do_migrations true
  end
  
  private
  
    # NIU
    def check_schema
      schema_path = File.join "db", "schema.rb"
      begin
        File.open( File.join( Rails.root.to_s, schema_path ), 'r')
      rescue
        puts "\033[0;91mIt seems that database schema file #{schema_path} is not present.\033[0m"
        puts "Check if you have set schema format to :ruby in your configuration file."
        puts "If yes try to run \033[0;93mrake db:schema:dump.\033[0m"
        exit
      end
    end
    
    def do_migrations( force = false )
      puts "Running #{force ? "new" : "pending"} migration#{force ? "" : "s"}..."
      puts "(IMPORTANT: Make sure others run their migrations before they checkout the changes you're about to make!)"
      if force then Rake::Task[ "db:migrate" ].reenable end
      Rake::Task[ "db:migrate" ].invoke
      puts "Done"
    end
    
    def delete_migrations
      puts "Deleting existing migrations..."
      Dir[ File.join Rails.root.to_s, "db", "migrate", "*" ].each{ |f| File.delete f }
      puts "Done"
    end
        
    def create_reset_migration
      puts "Creating migration to clear schema_migrations table (if old migrations exist) or to load schema (if no migrations have been run)..."
      timestamp = Time.now.strftime "%Y%m%d%H%M%S"
      File.open( File.join( Rails.root.to_s, "db", "migrate", "#{timestamp}_reset.rb" ), 'w' ) do |f|
        f.puts "# Establishes reset point for migrations cleared out by the clear_migrations gem."
        f.puts "class Reset < ActiveRecord::Migration"
        f.puts   "\tdef self.up\n"
        f.puts   "\t\tif ActiveRecord::Migrator.get_all_versions.empty?"
        f.puts   "\t\t\tRake::Task['db:schema:load'].invoke"
        f.puts   "\t\t\texecute \"DELETE FROM schema_migrations WHERE version=#{timestamp};\""
        f.puts   "\t\telse"
        f.puts   "\t\t\texecute \"TRUNCATE schema_migrations;\""
        f.puts   "\t\tend"
        #f.puts     "\t\texecute \"INSERT INTO schema_migrations VALUES ('#{ActiveRecord::Migrator.current_version.to_s}');\""
        f.puts   "\tend\n"
        f.puts   "\tdef self.down\n"
        f.puts     "\t\traise ActiveRecord::IrreversibleMigration"
        f.puts   "\tend"
        f.puts "end\n"
      end      
    end

end
