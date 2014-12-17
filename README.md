LWMD: LightWeight Membership Directory
====

[![Gitter](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/PittsburghTriClub/lwmd?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

lightweight membership directory for our Tri Club. Maybe useful for anyone else with a small membership and annual dues, and needs virtual membership cards

[Rails 4](http://rubyonrails.org/), [Ruby 2](https://www.ruby-lang.org/en/),
[Semantic UI](http://semantic-ui.com/), [PostgreSQL](http://www.postgresql.org/)

### Setup
Being perfectly honest here - you're gonna want a Mac for this. Most of this
has some Windows support but it's rough. Linux users are way cool.

You will need a version of ruby. [RVM](http://rvm.io/) is a good way to go.
And you'll also need [git](http://git-scm.com/). [Homebrew](http://brew.sh/) is the easiest way to get it.
We're running on PostgreSQL for a database which means you'll need it locally.
I've tried using SQLite locally and Postgres for production and it's not easy.
Postgres isn't too hard to manage. There's a homebrew package, or [Postgres.app](http://postgresapp.com/)
is dead simple to install, although it seems to have bugs every few versions.

Once you have the project set up locally, run `bundle install`. Everything
should be set up for you. To get sample data into the app for testing locally,
run `rake seed_members`. To launch the server, enter `rails s`. If all goes
well, you should be able to browse to `http://localhost:3000`

### Contributing
* Clone the repository locally: `git clone git@github.com:PittsburghTriClub/lwmd.git`
* Make your changes locally
* Please add tests if you add functionality
* Submit a [pull request](https://github.com/PittsburghTriClub/lwmd/pulls)
