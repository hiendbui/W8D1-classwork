class SubsController < ApplicationController

    before_action :require_logged_in!, only:[:new, :create, :edit, :update]
    def index
        @subs = Sub.all 
        render :index
    end

    def new 
        @sub = Sub.new 
        render :new 
    end

    def create
        @sub = Sub.new(sub_params)
        @sub.moderator_id = @current_user.id 
        if @sub.save 
            redirect_to sub_url(@sub.id)
        else
            flash[:errors] = @sub.errors.full_messages 
            redirect_to user_url(@current_user.id)
        end
    end

    def show 
        @sub = Sub.find_by(id:params[:id])
        if @sub 
            render :show
        else
            flash[:errors] = ["Sub does not exist"]
        end
    end

    def edit
        @sub = Sub.find_by(id:params[:id])
        render :edit
    end

    def update
        @sub = Sub.find_by(id:params[:id])

        if @sub.update(sub_params)
            redirect_to sub_url(@sub.id)
        else
            flash[:errors] = @sub.errors.full_messages
            render :edit
        end
    end



    private 
    def sub_params
        params.require(:sub).permit(:title, :description)
    end


end
