// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

// app/javascript/application.js

import { Application } from "stimulus";
import { definitionsFromContext } from "stimulus/webpack-helpers";
import "@hotwired/turbo-rails";
import "controllers";
import "@primer/octicons"

const application = Application.start();
const context = require.context("controllers", true, /\.js$/);
application.load(definitionsFromContext(context));
