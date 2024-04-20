namespace :broadcast do
  task start: :environment do
    loop do
      Item.find_each &:touch

      sleep 1
    end
  end
end
