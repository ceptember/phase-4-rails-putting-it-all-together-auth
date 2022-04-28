class UsersController < ApplicationController
    def create
        user = User.create!(user_params)
        session[:user_id] = user.id 
        render json: user, status: :created 
   rescue ActiveRecord::RecordInvalid => invalid 
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity 
    end

    def show
         current_user = User.find_by(id: session[:user_id])
         if current_user
            render json: current_user, status: :created
         else 
            render json: {error: "unauthorized"}, status: :unauthorized
         end 
    end 


    private

    def user_params
        params.permit(:username, :image_url, :bio, :password, :password_confirmation)
    end

end
