class Point

  attr_accessor :longitude, :latitude

  def initialize(lon=nil,lat=nil)
      @longitude = lon
      @latitude = lat
  end

  def mongoize
    hash = {}
    hash[:type] = "Point"
    hash[:coordinates] = [@longitude, @latitude]
    return hash
  end

  def self.mongoize object
    case object
      when nil then return nil
      when Hash then return object
      when Point then
        hash = {}
        hash[:type] = "Point"
        hash[:coordinates] = []
        hash[:coordinates][0] = object.longitude
        hash[:coordinates][1] = object.latitude
        return hash
    end
  end

  def self.demongoize hash
    if !hash
      return nil
    else
      longitude = hash[:coordinates][0]
      latitude = hash[:coordinates][1]
      Point.new(longitude, latitude)
    end
  end

  def self.evolve object
    case object
      when nil then return nil
      when Hash then return object
      when Point then
        hash = {}
        hash[:type] = "Point"
        hash[:coordinates] = []
        hash[:coordinates][0] = object.longitude
        hash[:coordinates][1] = object.latitude
        return hash
    end
  end

end