task :cron => :environment do
  Tag.recount
  Rails.logger.info "cron run at #{Time.now.to_s(:db)}"
end
