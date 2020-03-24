class BooksController < ApplicationController
  before_action :authenticate_user!

  def new
  end

  def index #投稿一覧ページ
    @book = Book.new
    @books = Book.all
    @users = User.all
    @user = current_user
  end

  def create #Book一覧ページ
    @book = Book.new(book_params)
    @user = current_user
    @books = Book.all
    @book.user_id = current_user.id
    if  @book.save
      flash[:create] = "Book was successfully created."
      redirect_to book_path(@book.id)
    else
      render "index"
    end
  end

  def show #投稿確認ページ
    @book = Book.find(params[:id])
    @booker = Book.new
    @user = @book.user
  end

  def edit #投稿確認ページ
    @book = Book.find(params[:id])
    if @book.user != current_user
      redirect_to books_path
    end
  end

  def update #投稿編集ページ
    @book = Book.find(params[:id])
    if  @book.update(book_params)
      flash[:update] = "Book was successfully updated."
      redirect_to book_path(@book.id)
    else
      render "edit"
    end
  end

  def destroy #投稿確認ページ
    @book = Book.find(params[:id])
    if @book.destroy
      flash[:destroy] = "Book was successfully destroyed."
      redirect_to books_path
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
