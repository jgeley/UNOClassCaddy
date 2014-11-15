json.array!(@uno_classes) do |uno_class|
  json.extract! uno_class, :department, :course, :section, :startTime, :endTime, :days, :location, :instructor, :sessionId
  json.url uno_class_url(uno_class, format: :json)
end