class ExpensesController < ApplicationController

    def show
        @expense = Expense.find(params[:id])
    end

    def new
        # byebug
        if flash[:attendees]
            @arr_of_objs = []

            # byebug 
            flash[:attendees].each {|attendance|

                emptyObj = {
                            :id => nil,
                            :name => nil
                            }

                emptyObj[:id] = attendance["id"]
                emptyObj[:name] = User.find(attendance["user_id"]).name
            
            @arr_of_objs << emptyObj
            } 
           
            #  can't figure out how to create an expense form using collection_select 
            @expense =Expense.new
        
        else 
            @expense =Expense.new
        end
        
    end

    def create
        @expense = Expense.create(expense_params)
        if @expense.valid?
            redirect_back fallback_location: events_path
        else
            flash[:errors] = @expense.errors.full_messages
            flash[:attributes] = @expense.attributes
            redirect_to new_expense_path
        end
    end

    def destroy 
        @expense = Expense.find(params[:id])
        @expense.destroy
        redirect_back fallback_location: "/user"
    end

    private
 
    def expense_params
        params.require(:expense).permit(:description, :cost, :attendance_id)
    end
end
