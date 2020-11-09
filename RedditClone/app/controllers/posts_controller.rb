class PostsController < ApplicationController

    def new
        @post = Post.new
        render :new
    end

    def create
        @post = Post.new(post_params)
        if @post.save
            redirect_to post_url(@post)
        else
            flash[:errors] = @post.errors.full_messages
            render :new
        end
    end

    def show
        @post = Post.find_by(id: params[:id])

        render :show
    end

    def edit
        @post = Post.find_by(id: params[:id])

        render :edit
    end

    def update
        @post = Post.find_by(id: params[:id])

        if @post.update(post_params)
            redirect_to post_url(@post)
        else
            flash[:errors] = @post.errors.full_messages
            render :edit
        end
    end

    def destroy
        @post = current_user.posts.find_by(id: params[:id])
        if @post
            @post.destroy
            redirect_to posts_url
        else
            flash[:errors] = ["Post does not belong to user"]
            redirect_to user_url(current_user)
        end
    end

    private
    def post_params
        params.require(:post).permit(:title,:url,:content,:sub_id,:author_id)
    end
end
