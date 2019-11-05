# frozen_string_literal: true

require 'sinatra'

class App < Sinatra::Application
  $counter ||= 0
  get '/' do
    $counter += 1
    Rack::Utils.escape_html "#{self}  /index -- $counter:#{$counter}"
  end

  get '/sleep' do
    thread = Thread.new { sleep 5 }
    thread.join

    $counter += 100
    Rack::Utils.escape_html "#{self}  /sleep -- $counter:#{$counter}"
  end
end
