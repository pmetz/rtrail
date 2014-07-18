#!/usr/bin/env ruby

require 'rubygems'
require 'sinatra/base'
require 'sinatra/reloader'
require 'yajl'

# Mock TestRail web application
class TestApp < Sinatra::Base
  set :root, File.dirname(__FILE__)

  configure do
    register Sinatra::Reloader
  end

  helpers do
    def parse(params)
      path = ''
      query = {}
      params.each do |key, value|
        if key.start_with?("/api/v2")
          path = key.gsub('/api/v2/', '')
        else
          query[key] = value
        end
      end
      return path, query
    end
  end

  get '/index.php' do
    # FIXME: Handle query (used for suite_id, section_id etc.)
    path, query = parse(params)
    begin
      yajl(path.to_sym)
    rescue => ex
      halt 400, yajl(:error, :locals => {:error => ex.message})
    end
  end

  post '/index.php' do
    path, query = parse(params)
    data = Yajl::Parser.parse(request.body.read)
    begin
      yajl(path.to_sym, :locals => data)
    rescue => ex
      halt 400, yajl(:error, :locals => {:error => ex.message})
    end
  end
end

if __FILE__ == $0
  TestApp.run! :port => 8080
end

