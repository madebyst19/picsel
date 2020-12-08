class InquiryMailer < ApplicationMailer

    def received_email(inquiry)
      @inquiry = inquiry
      mail(:to => ENV["SEND_MAIL"], :from => inquiry.email, :subject => 'お問い合わせを承りました')
    end
end
