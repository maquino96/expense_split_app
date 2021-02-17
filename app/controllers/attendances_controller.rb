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

    private
    
    def attendance_params
        params.require(:attendance).permit(:event_id, :user_id)
     
    end 
end
