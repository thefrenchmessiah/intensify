class InquiriesController < ApplicationController
  before_action :set_inquiry, only: %i[show destroy]

  def index
    @inquiries = Inquiry.all
    @owner_inquiries = Inquiry.where(owner_id: current_user.id)
    @client_inquiries = Inquiry.where(client_id: current_user.id)
  end

  def show
    @emotion = Emotion.find(params[:emotion_id])
    @inquiry = Inquiry.find(params[:id])
  end

  def new
    @emotion = Emotion.find(params[:emotion_id])
    @inquiry = Inquiry.new
  end

  def create
    @emotion = Emotion.find(params[:emotion_id])
    @inquiry = Inquiry.new(inquiries_params)
    if @inquiry.save
      redirect_to emotion_inquiry_path(@emotion, @inquiry)
    else
      render :new
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @inquiry.destroy
    redirect_to user_path(@user), notice: 'Inquiry was successfully destroyed.'
  end

  private

  def set_inquiry
    @inquiry = Inquiry.find(params[:id])
  end

  def inquiries_params
    params.require(:inquiry).permit(:message, :client_id, :owner_id, :emotion_id)
  end
end
