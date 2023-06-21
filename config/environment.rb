require 'active_record'

 
ENV["RACK_ENV"] ||= "development"
require 'bundler/setup'
Bundler.require(:default, ENV["RACK_ENV"])

ActiveRecord::Base.logger = Logger.new(STDOUT)
ActiveRecord::Base.logger.level = :info



require_relative '../app/models/patient'
require_relative '../app/models/doctor'
require_relative '../app/models/appointment'



