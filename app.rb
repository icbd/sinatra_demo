# frozen_string_literal: true

require 'sinatra'
require 'rack/cors'

class App < Sinatra::Application
  use Rack::Cors do |cors_self|
    cors_self.allow do |allow_resources|
      allow_resources.origins /http:\/\/localhost\S*/
      allow_resources.resource '*', headers: :any, methods: [:get, :post, :put, :options]
    end
  end

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

  get '/dashboard' do
    send_file 'views/dashboard.html'
  end

  post '/books' do
    { request_body: request.body.read, response_at: (Time.now.to_f * 1000).to_i }.to_json
  end
end
