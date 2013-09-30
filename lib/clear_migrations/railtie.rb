require "rails"

module ClearMigrations
  class Railtie < ::Rails::Railtie
  
    config.before_configuration do
        
    end

    rake_tasks do
      load "clear_migrations/tasks.rake"
    end
    
    private
    
    
  end
end