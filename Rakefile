# require_relative "./config/environment.rb"
# require 'active_record'
# require_relative './db/migrate'
# require_relative './db/seeds'
# require "bundler/gem_tasks"

# namespace :db do
#   task :migrate do
#     ActiveRecord::MigrationContext.new('./db/migrate').migrate
#   end

#   task :seed do
#     load './db/seeds.rb'
#   end
# end


# require_relative 'config/environment.rb' 
# require 'active_record'
# require_relative 'db/migrate'

# namespace :db do
#   desc 'Migrate the database'
#   task :migrate do
#     ActiveRecord::MigrationContext.new('db/migrate').migrate
#   end

#   desc 'Seed the database'
#   task :seed do
#     load 'db/seeds.rb'
#   end
# end

# task default: 'db:migrate'

# require 'active_record'
# require_relative 'config/environment'

# namespace :db do
#   desc 'Migrate the database'
#   task :migrate do
#     ActiveRecord::Tasks::DatabaseTasks.migrate
#   end

#   desc 'Seed the database'
#   task :seed do
#     load 'db/seeds.rb'
#   end
# end

# task default: ['db:migrate']


require 'active_record'
require_relative 'config/environment.rb'

namespace :db do
  desc 'Create the database'
  task :create do
    ActiveRecord::Tasks::DatabaseTasks.create_all
  end

  desc 'Drop the database'
  task :drop do
    ActiveRecord::Tasks::DatabaseTasks.drop_all
  end

  desc 'Migrate the database'
  task :migrate do
    ActiveRecord::Tasks::DatabaseTasks.migrate
  end

  desc 'Rollback the last migration'
  task :rollback do
    ActiveRecord::Tasks::DatabaseTasks.rollback
  end

  desc 'Seed the database'
  task :seed do
    ActiveRecord::Tasks::DatabaseTasks.seed
  end
end

task :environment do
  require_relative 'config/environment'
end
