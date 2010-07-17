class LogMailer < ActionMailer::Base
  

  def contact(sub, message, sender)
    subject    sub
    recipients 'dyi@hoana.com'
    from       sender
    sent_on    Time.now
    
    body       message
  end

  def sent_with_csv(sub, sender, to)
    subject    sub
    recipients to
    from       sender
    sent_on    Time.now
    body       "this is the log file from hoanalog"

    attachment :content_type => "text/html",
               :body => File.read("/home/dan/projects/hoanalog/logs.csv"),
               :filename => File.basename("/home/dan/projects/hoanalog/logs.csv")

  end
end
