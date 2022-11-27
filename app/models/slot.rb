class Slot < ApplicationRecord
  before_create :create_slot_details
  has_many :slot_details

  validates :total_capacity, :start_time, :end_time, presence: true
  validate :dates_checking

  def dates_checking
    if start_time
      begin
        Time.parse(start_time)
      rescue Exception => e
        errors.add(:start_time, e.message)
      end
      if start_time <= Time.now
        errors.add(:start_time, "Should not be past time")
      end
    end
    if end_time
      begin 
        Time.parse(end_time)
      rescue Exception => e
        errors.add(:end_time, e.message)
      end
      if end_time <= Time.now
        errors.add(:end_time, "Should not be past time")
      end
    end

    if start_time >= end_time
      errors.add(:end_time, "must be after start time")
    end
  end

  def create_slot_details
    total_slot_time = ((end_time - start_time)/60).to_i
    slots = (15..total_slot_time).step(15).collect{ |x| x }
    slot_collection = []
    exceeding_capacities = total_capacity - slots.size
    start_time = self.start_time
    slots.each do |_slot|
      slot_collection << {start_time: start_time, end_time: start_time + 15, capacity: 1}
      start_time += 15
    end
    exceeding_capacities.times.each_with_index do |_capacity, index|
      slots[-index - 1].slot_collection[:capacity] += 1
    end
    slot_collection.each { |slot| slot.slot_details << slot }
  end
  true
end