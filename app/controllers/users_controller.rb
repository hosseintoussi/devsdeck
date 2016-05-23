class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def index
    @users = User.all
  end

  def show
    @cards = current_user.cards.order('created_at')
    @total_cards = @cards.size
    @latest_card = @cards.last
    @liked = current_user.find_voted_items.sort_by { |like| like.created_at }
    @total_liked = @liked.size
    @latest_like = @liked.last
  end

  def update
    @user.update(user_params)
    redirect_to action: 'show', id: current_user.id
  end

  def edit
  end

  private

  def set_user
    @user = User.find(params[:id] || params[:user_id])
  end

  def user_params
    params.require(:user).permit(:name, :description)
  end
end