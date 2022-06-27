set :output, 'log/crontab.log'
ENV.each { |k, v| env(k, v) }
rails_env = ENV['RAILS_ENV'] || :development
set :environment, rails_env

every '0 15 * * *' do
  rake 'carepi:leaveall'
end
