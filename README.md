# Rails Turbo 8 refresh brodcast overriding manual visits issue

This is a stock Rails 7.1.3.2 app to demonstrate a race condition with Turbo 8 refreshes and regular user clicks through the application.
It's rather easy to observe when there is a consistent stream of refreshes generated and user navigates through the pages steadily.

## Replicate the issue

Redis server is required to be running on localhost for Action Cable.

```sh
git clone git@github.com:klevo/rails-turbo-refresh-click-hijack.git
cd rails-turbo-refresh-click-hijack

# bundle install and database init (seed data included)
bin/setup

# Terminal tab 1: launch the rails app
bin/rails s

# Terminal tab 2: generates updates to items in the DB
bin/rake broadcast:start
```

Visit `http://localhost:3000` in your the browser and open JavaScript console. All turbo visists are logged into the console.

With the above rake task running, the Items in the database are all touched every second, generating turbo refreshes. 

Click back and forth between item details and item index. Observe that every few click (sometimes up to 20),
your navigation will be overriden by a turbo refresh coming for the page that you're on, that arrived right after your click.
Meaning instead of navigating to a new location, you stay on the current page.

## Video of the issue

https://github.com/klevo/rails-turbo-refresh-click-hijack/assets/32981/43088386-f63b-4fd3-ab6d-de62e79d361c

* At the end you can observe I click on "Show this item" of the item named "Two", yet I remain on the index page. You can notice the desired page blinked in and out for a few microseconds too.
* The cause is visible in the console: The second to last turbo visit to `/items/2` is my user initiated action.
* The following (last) entry in the console is the turbo refresh of the current `/items` page that just arrived (you can see the Updated at times changed from from :05 to :06). This refresh essentially hijacked my click and resulted in me staying on the index page.

## Project initialized by

```sh
rails new --asset-pipeline=propshaft --database=sqlite3 --css=tailwind rails-turbo-refresh-click-hijack

cd rails-turbo-refresh-click-hijack

rails g scaffold Item name:string
```
