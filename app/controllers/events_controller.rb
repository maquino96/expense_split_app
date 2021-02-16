class EventsController < ApplicationController

    def index
        @events = Event.all
     end
 
     def show
         @event = Event.find(params[:id])
         @expense = Expense.new 
         @attendance_id = Attendance.find_by(user_id: session[:user_id], event: @event).id
        #  byebug 
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
             redirect_to event_path(@event)
         else
             flash[:errors] = @event.errors.full_messages
             flash[:attributes] = @event.attributes
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
         redirect_to events_path
     end
 
     private
 
     def event_params
         params.require(:event).permit(:name, :date, :complete)
     end

end
