class Schoolclass
  attr_accessor :time, :days, :location
  def initialize(time,days,location)
    @time = time
    @days = days
    @location = location
  end
  
  def toString()
    return "Time: " + time + " Days: " + days + " Location: " + location
  end
end