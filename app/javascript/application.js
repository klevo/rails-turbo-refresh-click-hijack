// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

addEventListener("turbo:before-visit", (event) => {
  console.debug("turbo:before-visit", event.detail)
})
