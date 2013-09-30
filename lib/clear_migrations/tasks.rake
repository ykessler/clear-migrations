
namespace :db do

  desc "Clear out old db migration files"
  task :clear_migrations do
    puts "(IMPORTANT: Make sure others run their migrations before they pull the changes you're about to make!)"
    do_migrations
    delete_migrations
    create_reset_migration
    do_migrations true
  end
  
  private
    
    def do_migrations( force = false )
      puts "Running #{force ? "new" : "pending"} migration#{force ? "" : "s"}..."
      if force then Rake::Task[ "db:migrate" ].reenable end
      Rake::Task[ "db:migrate" ].invoke
      puts "Done"
    end
    
    def delete_migrations
      puts "Deleting migration files..."
      Dir[ File.join Rails.root.to_s, "db", "migrate", "*" ].each{ |f| File.delete f }
      puts "Done"
    end
        
    def create_reset_migration
      puts "Creating reset migration..."
      timestamp = Time.now.strftime "%Y%m%d%H%M%S"
      File.open( File.join( Rails.root.to_s, "db", "migrate", "#{timestamp}_reset.rb" ), 'w' ) do |f|
        f.puts "# Establishes reset point for migrations cleared out by the clear_migrations gem."
        f.puts "class Reset < ActiveRecord::Migration"
        f.puts   "\tdef self.up\n"
        f.puts   "\t\tif ActiveRecord::Migrator.get_all_versions.empty?"
        f.puts   "\t\t\traise \"===> USE DB:SCHEMA:LOAD INSTEAD OF DB:MIGRATE \nMigrations for this project have been previously cleared out with the clear_migrations gem. \nTo create this project's database on a new system, please use db:schema:load instead of trying to run all the migrations from scratch.\n\n\""
        f.puts   "\t\telse"
        f.puts   "\t\t\texecute \"TRUNCATE schema_migrations;\""
        f.puts   "\t\tend"
        f.puts   "\tend\n"
        f.puts   "\tdef self.down\n"
        f.puts     "\t\traise ActiveRecord::IrreversibleMigration"
        f.puts   "\tend"
        f.puts "end\n"
      end      
    end

end
