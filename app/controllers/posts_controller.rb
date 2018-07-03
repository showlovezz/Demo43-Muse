class PostsController < ApplicationController
	
	before_action :find_post, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, except: [:index, :show]

	def index
		@posts = Post.order("created_at DESC")
	end

	def new
		@post = current_user.posts.build
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
	end

	def edit
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

	private

	def post_params
		params.require(:post).permit(:title, :link, :description, :rating, :image)
	end

	def find_post
		@post = Post.find(params[:id])
	end

end
