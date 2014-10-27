require 'net/smtp'
require 'iconv'

def send_email(from, from_alias, to, to_alias, subject, content)
  subject_n = Iconv.conv('utf-8','gbk',subject)
  msg = <<MESSAGE_END
From: #{from_alias} <#{from}>
To: #{to_alias} <#{to}>
MIME-Version: 1.0
Content-type: text/html;charset=utf-8
Subject: #{subject_n}

#{content}
MESSAGE_END
	Net::SMTP.start('smtp.qq.com', 25, 'qq.com', #{qq_num}, #{passwd}, :login) do |smtp| #此处配置发送服务器及账户
  	smtp.send_message msg, from, to
  end
end
