namespace :carepi do
  desc '全員を退室'
  task leaveall: :environment do |_task, _args|
    User.all.each { |u| u.update!(entry: false) }
  end
end
