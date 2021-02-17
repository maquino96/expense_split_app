class UsersController < ApplicationController

    skip_before_action :authorized, only: [:login, :handle_login, :new, :create]

    def login
    end

    def handle_login
        @user = User.find_by(name: params[:login_username])
        if @user ## && @user.authenticate(params[:login_password])
            session[:user_id] = @user.id
            # session[:class_name] = @user.class.name
            redirect_to user_path(@user)
        else
            flash[:errors] = ["Incorrect Username or Password"]
            redirect_to login_path
        end
    end


    def logout
        logout_user
        redirect_to login_path
    end

    
    def index
        @users = User.all
     end
 
     def show
         @user = User.find(session[:user_id])
     end
 
     def new
         if flash[:attributes]
             @user = User.new(flash[:attributes])
         else
             @user = User.new
         end
     end
 
     def create
        
         @user = User.create(user_params)
         if @user.valid?
             redirect_to user_path(@user)
         else
             flash[:errors] = @user.errors.full_messages
             flash[:attributes] = @user.attributes
             redirect_to new_user_path
         end
     end
 
     def edit
         @user = User.find(params[:id])
     end
 
     def update
         @user = User.find(params[:id])
         if @user.update(user_params)
             redirect_to user_path(@user)
         else
             flash[:errors] = @user.errors.full_messages
             redirect_to edit_user_path(@user)
         end
     end
 
     def destroy
         @user = User.find(params[:id])
         @user.destroy
         redirect_to users_path
     end
 
 
 
     private
 
     def user_params
         params.require(:user).permit(:name)
     end


end
