module StatusQuo
  class Notifier < ActionMailer::Base
    layout "status_quo/notifier"
    default from: "rubydev5@bidmath.com"

    def event_notice(email, event)
      @title = "Event Notice"
      @event = event
      @recipient = email
      mail(to: email, subject: "Status Quo - Event Notice", content_type: "text/html")
    end

  end
end
