class AbstractsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_abstract, only: [:show, :edit, :update, :destroy]
  before_action :validate_user, only: [:show, :edit, :update, :destroy]

  def index
    @user = current_user
    @abstracts = @user.abstracts.order(created_at: 'desc')
  end

  def new
    @abstract = Abstract.new
  end

  def show

  end

  def edit

  end

  def create
    @abstract = Abstract.new(abstract_params)
    @abstract.user_id = current_user.id
    if @abstract.save
      redirect_to @abstract, notice: 'あぶすとを投稿しました'
    else
      render :new, alert: 'あぶすとの投稿に失敗しました'
    end
  end

  def update
    if @abstract.update(abstract_params)
      redirect_to @abstract, notice: 'あぶすとを更新しました'
    else
      render :edit, alert: 'あぶすとの更新に失敗しました'
    end
  end

  def destroy
    if @abstract.destroy
      redirect_to root_path, notice: 'あぶすとを削除しました'
    else
      redirect_to root_path, notice: 'あぶすとの削除に失敗しました'
    end
  end

  private

  def find_abstract
    @abstract = Abstract.find(params[:id])
  end

  # Strong Parameter
  def abstract_params
    params.require(:abstract).permit(:title, :author, :doi, :body)
  end

  # 他のユーザーのあぶすとにはアクセスできないようにする
  def validate_user
    if @abstract.user != current_user
      redirect_to root_path
    end
  end
end
