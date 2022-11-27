class SlotSerializer < BaseSerializer
  attributes :id, :start_time, :end_time, :total_capacity

  attribute :slots_collection do |object|
    object.SlotDetailsSerializer.new(object.slot_details.order(id: :asc))
  end
end