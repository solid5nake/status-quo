module StatusQuo
  class Notifier < ActionMailer::Base
    layout "notifier"
    default from: "rubydev5@bidmath.com"

    def event_notice(email, event)
      @title = "StatusQuo Event Notice"
      @event = event
      mail(to: email, subject: "Status Quo - Event Notice", content_type: "text/html")
    end

  end
end
