# ClearMigrations

Clears out old migrations from a Rails project.

No one wants old and crusty migrations hanging around forever, cramping your project's style. When you're ready to cut the cord, this gem lets you do it cleanly. 

## Installation

Add this line to your application's Gemfile and execute bundle to install:

    gem 'clear_migrations'


## Usage

(**READ AND UNDERSTAND** - The clear_migrations gem attempts to make things as easy as possible, but **clearing migrations should not be approached lightly!**)

There's not much that can go wrong when you run it in your local environment, but any collaborators and existing deployments **must have their schemas up to date** before pulling from a repo in which migrations have been cleared, otherwise pending migrations will be cleared from their project before they have a chance to run them...

Once you're sure everyone is synced to latest schema, run the rake task provided:

    rake db:clear_migrations

That's all you have to do on your own project. When the current set of changes are pulled to other repos, they will receive a single `XXX_reset.rb` migration file that will do the following:

 - Clear the schema_migrations table on projects instances where migrations have previously been run."
 - Invoke db:schema:load on projects where migrations have not been run (i.e. no records in schema_migrations)."
 

## Just to be Clear...

 - clear\_migrations is non-destructive in so far as that it will only call `db:schema:load` if it is run, or its generated migration file is run, on a project which has an empty schema_migrations table. This will only happen if it's a new project that hasn't had `db:migrate` called on it OR if the table has been cleared out by another person/process. In the latter case, using clear\_migrations means `db:schema:load` WILL be invoked and your data WILL be destroyed. 


## Credits

Code mostly stolen from [simplificator/flatten_migrations](https://github.com/simplificator/flatten_migrations), though this does things differently.


