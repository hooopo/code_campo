task :cron => :environment do
  Process.fork do
    EventMachine::run do
      EventMachine::PeriodicTimer.new(5) do
        Tag.recount
        Rails.logger.info "cron run at #{Time.now.to_s(:db)}"
      end
    end
  end
end
