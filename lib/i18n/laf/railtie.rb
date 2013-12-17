# coding: utf-8
require "rails"

module I18n::LaF
  class Railtie < Rails::Railtie
    rake_tasks do
      load File.expand_path('../../tasks/laf.rake', __FILE__)
    end
  end
end
