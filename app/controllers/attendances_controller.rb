class AttendancesController < ApplicationController

    def create
        @attendance = Attendance.new(attendance_params)
        # byebug
        if @attendance.save
            redirect_to user_path(session[:user_id])
        else
            flash[:errors] = @attendance.errors.full_messages 
            redirect_to user_path(session[:user_id])
        end 
    end 

    def destroy
        @attendance = Attendance.find(params[:id])
        @attendance.event.unfinish
        @attendance.destroy
        redirect_to user_path(session[:user_id])
    end

    private
    
    def attendance_params
        params.require(:attendance).permit(:event_id, :user_id)
     
    end 
end
