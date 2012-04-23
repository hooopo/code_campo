task :cron => :environment do
  EventMachine::run do
    EventMachine::PeriodicTimer.new(1.hour) do
      Tag.recount
      Rails.logger.info "cron run at #{Time.now.to_s(:db)}"
    end
  end
end
