class SessionsController < ApplicationController
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

    message = if @user.entry
                "#{@user.student_number} #{@user.name} が入室しました"
              else
                "#{@user.student_number} #{@user.name} が退室しました"
              end

    response_success('session', 'new', message)
  end
end
