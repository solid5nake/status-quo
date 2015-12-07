namespace :status_quo do
  desc "Update network stats"
  task :confirm, [:begin_date, :end_date] => :environment do |t, args|
    begin_date = args[:begin_date] ? Date.parse(args[:begin_date]) : Date.today
    end_date = args[:end_date] ? Date.parse(args[:end_date]) : begin_date
    begin_date.upto(end_date) do |date|
      StatusQuo.confirm! date
    end
  end
end
