class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :authentication , only: %i[show edit update destroy ]
  before_action :validate_post , only: %i[create ]
  # GET /posts or /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1 or /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
    @post.user_id=Integer(params[:id])
    @user=User.find(Integer(params[:id]))
  end

  # GET /posts/1/edit
  def edit


  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)
    @user=User.find(Integer(post_params[:user_id]))

    respond_to do |format|
      if @post.save
        format.html { redirect_to @user, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update

    @user=User.find(@post.user_id)
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @user, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @user=@post.user
    @post.destroy
    respond_to do |format|
      format.html { redirect_to @user, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def authentication
      respond_to do |format|
      if @post  && session[:user_id]==@post.user_id
        return true
      else
        redirect_to main_path, alert: "Please login with right user."
        return false
        end
      end
    end

    def validate_post
      @post = Post.new(post_params) 
      respond_to do |format|
      if session[:user_id]==@post.user_id
        return true
      else
        redirect_to main_path, alert: "Please login with right user."
        return false
        end
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:msg, :user_id, :date)
    end
end
