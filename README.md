# Rails Turbo 8 refresh brodcast overriding manual visits issue

## Replicate the issue

```sh
# Initialize database together with seed data
bin/setup

# Terminal tab 1
bin/rails s

# Terminal tab 2
bin/rake broadcast:start
```

In the browser, open JavaScript console.

Now visit `http://localhost:3000` and click back and forth between item details and item index. Observe that every few click,
your click will be overriden by a turbo refresh coming for the page that you're on, that happened just before your click and
new page having a chance to be rendered.

## TODO:

- [ ] Add seed

## Project initialized by

```sh
rails new --asset-pipeline=propshaft --database=sqlite3 --css=tailwind rails-turbo-refresh-issue

cd rails-turbo-refresh-issue

rails g scaffold Item name:string
rails db:migrate
```
