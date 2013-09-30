# ClearMigrations

Clears out old migrations from a Rails project.

No one wants old and crusty migrations hanging around forever, cramping your project's style. When you're ready to cut the cord, this gem lets you do it cleanly. 

## Installation

Add this line to your application's Gemfile and execute bundle to install:

    gem 'clear_migrations'


## Usage

**NOTE:** This gem is meant to be used sparingly- especially on multi-user projects. There's not much that can go wrong when you run it in your local environment, but any collaborators and existing deployments **must have their schemas up to date** before pulling from a repo in which migrations have been cleared, otherwise pending migrations will be cleared from their project before they have a chance to run them...

clear_migrations gem attempts to make things as easy as possible, but **clearing migrations should always be approached carefully.**

Once you're sure everyone is up to date on the latest schema, run the rake task provided:

    rake db:clear_migrations

This will:

 - Run all pending migrations
 - Delete all migration files from your project
 - Create a single new migration file called `XXX_reset.rb` and migrate it

The _reset migration does one of two things:

 - On systems that have previously run migrations, it clears the `schema_migrations` table, automatically becoming the first entry.
 - On new systems that don't have any `schema_migrations` records, it will raise an error if migrated, prompting the user to use `db:schema:load` instead of `db:migrate`. This is best practice anyway, and ensures that new installs always load up the full db schema without relying on the (now missing) migration trail.  

When others pull the changes, they will receive a db/migrations directory that's truncated up until the reset migration, can migrate or instantiate their db as normal.
 

## Credits

Code mostly stolen from [simplificator/flatten_migrations](https://github.com/simplificator/flatten_migrations), though this does things differently.


