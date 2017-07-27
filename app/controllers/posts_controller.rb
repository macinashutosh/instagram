class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
    @user=current_user
    
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
    check_notification
  end

  # GET /posts/1/edit
  def edit
  end

  def check_notification
      posts = Post.where(user_id: current_user.id).pluck(:id)
       notifications = Like.where(post_id: posts)
      notifications += Comment.where(post_id: posts)
      notifications += Followmapping.where(celeb_id: current_user.id)
      notifications.sort_by! &:created_at
      notifications.reverse!
    notification = Notification.where(user_id: current_user.id).first
    if notification.nil?
        Notification.create(user_id: current_user.id)
    else
        if notification.created_at < notifications.first.created_at
              notification.destroy  
        else  
              notification.destroy  
              Notification.create(user_id: current_user.id)
        end
    end
  end
  
  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user_id=current_user.id
    respond_to do |format|
      if @post.save
        format.html { redirect_to '/home/index', notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params

      params.require(:post).permit(:user_id, :content,:image)
    end
end
