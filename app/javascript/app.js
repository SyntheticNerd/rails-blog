// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
// Entry point for the build script in your package.json
import "./controllers"
import * as bootstrap from "bootstrap"
import { Turbo } from "@hotwired/turbo-rails"
Turbo.session.drive = false
