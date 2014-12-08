require 'rubygems'
require 'bundler'
 
ENV['RACK_ENV'] ||= 'development'
Bundler.setup
Bundler.require(:default, ENV['RACK_ENV'].to_sym) unless ENV['RACK_ENV'].nil?
 
SINATRA_ROOT = File.join(File.dirname(__FILE__), '..')
require File.join(SINATRA_ROOT, 'app')