namespace :consumers do
  desc 'generate a new API Consumer'
  task create: :environment do
    consumer = ApiConsumer.create!(
      name: ENV['NAME'],
      ip_address: ENV['IP'],
      project_id: Project.find_by_name(ENV['PROJECT']).id
    )
    puts "token: #{ consumer.token }"
  end
end
