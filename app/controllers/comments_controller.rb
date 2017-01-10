class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :admin_check!

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(comment_params)

    @comment.save
    redirect_to user_path(params[:comment][:user_id]), notice: '正常に保存されました'

  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    comment = Comment.find_by(:user_id => params[:comment][:user_id])
    comment.text = params[:comment][:text]

    comment.save

    redirect_to user_path(params[:comment][:user_id]), notice: '正常に保存されました'

  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    if params['comment']
      @comment = Comment.find_by(:user_id => params['comment']['user_id'])
    end
    unless @comment
      Comment.find(params[:id])
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def comment_params
    params.require(:comment).permit(:text, :user_id)
  end

  def admin_check!
    unless current_user.admin
      redirect_to root_path
    end
  end
end
