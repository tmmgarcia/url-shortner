namespace :populate do
  desc "This task populates the array of available path using the worker"
  task available_path_list: :environment do
    puts 'Task started'
    PathPopulateWorker.new.perform
    puts 'Task finished'
  end
end
