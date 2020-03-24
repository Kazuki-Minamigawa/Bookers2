class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :index, :edit]

  def top
  end

  def home
  end

  def show #マイページ
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end

  def index #User一覧ページ
    @users = User.all
    @book = Book.new
    @user = current_user
  end

  def edit #プロフィール編集ページ
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to user_path(current_user.id)
    end
  end

  def update #プロフィール編集ページ
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:update] = "Your profile was successfully updated."
      redirect_to user_path(@user.id)
    else
      render "edit"
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
