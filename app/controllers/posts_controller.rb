class PostsController < ApplicationController
	
	before_action :find_post, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
	before_action :authenticate_user!, except: [:index, :show]

	def index
		@posts = Post.order("created_at DESC")
		@jumbotron = true
	end

	def new
		@post = current_user.posts.build
		@jumbotron = false
	end

	def create
		@post = current_user.posts.build(post_params)
		if @post.save
			redirect_to @post, notice: "貼文已建立"
		else
			render "new", alert: "貼文建立失敗"
		end
	end

	def show
		@comment = Comment.new
		@jumbotron = false

		if @post.comments.blank?
      @avg_comment = 0
    else
      @avg_comment = @post.comments.average(:rating).round(2)
    end
	end

	def edit
		@jumbotron = false
	end

	def update
		if @post.update(post_params)
			redirect_to @post, notice: "貼文已修改好"
		else
			render "edit", alert: "貼文修改失敗"
		end
	end

	def destroy
		@post.destroy
		redirect_to posts_path, alert: "貼文已刪除!"
	end

	def upvote
		@post.upvote_by current_user
		redirect_to post_path(@post)
	end

	def downvote
		@post.downvote_by current_user
		redirect_to post_path(@post)
	end

	private

	def post_params
		params.require(:post).permit(:title, :link, :description, :rating, :image)
	end

	def find_post
		@post = Post.find(params[:id])
	end

end
