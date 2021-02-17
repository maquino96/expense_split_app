class AttendancesController < ApplicationController

    def create
        @attendance = Attendance.create(attendance_params)
        # byebug
        redirect_to user_path(session[:user_id])
    end 

    private
    
    def attendance_params
        params.require(:attendance).permit(:event_id, :user_id)
    end 
end
