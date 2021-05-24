class Message < ApplicationRecord

  enum result: {result_ok: 1, result_wait: 2, result_ng: 3, result_ignore: 4}

  def call
    sid = Rails.application.credentials.dig(:twilio, :sid)
    token = Rails.application.credentials.dig(:twilio, :token)
    client = Twilio::REST::Client.new sid, token

    first_message = '自動告白サービス。こくはくのゆくえです'
    second_message = "#{to_name}様。#{from_name}様よりメッセージがございます"
    confirm_message = 'この告白にオーケーの場合は1を。。もう一度考える場合は2を。。。ごめんなさいの場合は3を入力してください'
    action = Rails.application.routes.url_helpers.message_url(id)
    voice = male? ? 'Polly.Takumi' : 'Polly.Mizuki'

    msg = Twilio::TwiML::VoiceResponse.new do |r|
      r.say(voice: 'Alice', language: 'ja-JP', message: first_message)
      r.pause(length: 1)
      r.say(voice: 'Alice', language: 'ja-JP', message: second_message)
      r.pause(length: 2)
      r.say(voice: 'Polly.Takumi',  language: 'ja-JP', message: message)
      r.pause(length: 1)
      r.gather(action: action, method: 'POST', numDigits: 1) do |g|
        g.say(voice: 'Alice', language: 'ja-JP', message: confirm_message)
      end
    end
    tel = "+81#{phone_number.gsub('-', '').gsub(/\A0/, '')}"

    call = client.calls.create(
      twiml: msg.to_s,
      to: tel,
      from: '+16783298211'
    )
  end
end
