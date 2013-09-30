# ClearMigrations

Clears out old migrations from a Rails project.

No one wants old and crusty migrations hanging around forever, cramping your project's style. When you're ready to cut the chord, this gem lets you do it cleanly. 

## Installation

Add this line to your application's Gemfile and execute bundle to install:

    gem 'clear_migrations'


## Usage

(**READ AND UNDERSTAND** - The ClearMigrations gem attempts to make things as easy as possible, but **clearing migrations should not be approached lightly!**)

There's not much that can go wrong when you run it in your local environment, but any collaborators and existing deployments **must have their schemas up to date** before pulling from a repo in which migrations have been cleared, otherwise pending migrations will be cleared from their project before they have a chance to run them...

Once you're sure everyone is synced to latest schema, run the rake task provided:

    rake db:clear_migrations

That's all you have to do on your own project. When the current set of changes are pulled to other repos, they will receive a single migration file that will do the following:

 

## Credits

Code mostly stolen from [simplificator/flatten_migrations](https://github.com/simplificator/flatten_migrations), though does things differently.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
