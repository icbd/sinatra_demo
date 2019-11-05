# frozen_string_literal: true

require 'bundler/setup'
require './app'

App.run! port: 3000, handler_name: :puma
