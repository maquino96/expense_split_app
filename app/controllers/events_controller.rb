class EventsController < ApplicationController

     def index
        @events = Event.all
     end
 
     def show
         if Event.find_by(id: params[:id])
            @event = Event.find(params[:id])
         else
            redirect_to user_path(session[:user_id])
            return 
         end
         @expense = Expense.new 
         if Attendance.find_by(user_id: session[:user_id], event: @event)
            @attendance_id = Attendance.find_by(user_id: session[:user_id], event: @event).id 
         else 
            redirect_to user_path(session[:user_id])
         end 
         flash[:attendees] = @event.attendances 
     end
 
     def new
         if flash[:attributes]
             @event = Event.new(flash[:attributes])
         else
             @event = Event.new
         end
     end
 
     def create
         @event = Event.create(event_params)
         if @event.valid?
             Attendance.create(event: @event, user_id: session[:user_id])
             redirect_to event_path(@event)
         else
             flash[:errors] = @event.errors.full_messages
            #  flash[:attributes] = @event.attributes
             redirect_to new_event_path
         end
     end
 
     def edit
         @event = Event.find(params[:id])
     end
 
     def update
         @event = Event.find(params[:id])
         if @event.update(event_params)
             redirect_to event_path(@event)
         else
             flash[:errors] = @event.errors.full_messages
             redirect_to edit_event_path(@event)
         end
     end
 
     def destroy
         @event = Event.find(params[:id])
         @event.destroy
         redirect_to user_path
     end

     def complete
        @event = Event.find(params[:id])
        @event.finish
        redirect_back fallback_location: events_path
     end

     def undo_complete
        @event = Event.find(params[:id])
        @event.unfinish
        redirect_back fallback_location: events_path
     end 

     def join
        if flash[:user]
            @user = User.find_by(name: params[:name])

            if @user && @user != User.find(session[:user_id])
            @events = @user.events.select {|event| event.complete == false && !User.find(session[:user_id]).events.include?(event)} 
            @attendance = Attendance.new
            else 
                flash[:errors] = ['User cannot be queried please try again']
                redirect_back fallback_location: user_path(session[:user_id])
            end 
        end 
     end 

     
 
     private
 
     def event_params
         params.require(:event).permit(:name, :date, :complete)
     end

end
