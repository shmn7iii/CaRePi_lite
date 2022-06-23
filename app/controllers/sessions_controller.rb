class SessionsController < ApplicationController
  require 'net/http'

  def new
    student_number = params[:student_number]

    if student_number.nil?
      response_bad_request('Student Number is required')
      return
    end

    # User取得、存在なければ作成
    @user ||= User.find_by(student_number:) || User.create(student_number:)

    # 入退室をトグル
    @user.toggle!(:entry)

    # Slackにメッセージを送信
    send_slack(@user.entry)

    response_success('session', 'new', @user)
  end

  private

  def send_slack(_entry)
    message = if _entry
                "#{@user.student_number} #{@user.name} が入室しました"
              else
                "#{@user.student_number} #{@user.name} が退室しました"
              end

    uri = URI.parse(ENV['SLACK_WEBHOOK_URL'])
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = uri.scheme === 'https'
    params = { text: message }
    headers = { 'Content-Type' => 'application/json' }
    response = http.post(uri.path, params.to_json, headers)
  end
end
