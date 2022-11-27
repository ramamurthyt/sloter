class SlotsController < ApplicationController
    include ErrorHandler

  def create
    slot =  Slot.new(create_params)
    if slot.save
      return success_response(slot)
    else
      return error_response(slot)
    end
  end

  private

  def create_params
    params.require(:data)
      .permit(
        :start_time,
        :end_time,
        :total_capacity)
  end

  def error_response(task)
    render json: {
      errors: format_activerecord_errors(task.errors)
    },
    status: :unprocessable_entity
  end

  def success_response(task, status = 200)
    render json: SlotSerializer.new(slot).
    serializable_hash,
    status: status
  end
  

 
end