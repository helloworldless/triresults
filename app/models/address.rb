class Address
  # include Mongoid::Document
  # field :city, type: String
  # field :state, type: String
  # field :location, as: :loc, type: Point

  attr_accessor :city, :state, :location
  alias :loc :location
  alias :loc= :location=

  def initialize (city=nil, state=nil, loc=Point.new)
    @city = city
    @state = state
    @location = loc
  end

  def mongoize
    hash = {}
    hash[:city] = @city
    hash[:state] = @state

    point_hash = {}
    point_hash = Point.mongoize(@location) # @location # no, must be hash, not Point
    # point_hash[:type] = "Point"
    # point_hash[:coordinates] = [@location.coordinates[0], @location.coordinates[1]]

    hash[:loc] = point_hash

    return hash
  end

  def self.mongoize object
    case object
      when nil then return nil
      when Hash then return object
      when Address then
        hash = {}
        hash[:city] = object.city
        hash[:state] = object.state
        hash[:loc] = Point.mongoize(object.location) # object.location # no, must be hash, not Point
        return hash
    end
  end

  def self.demongoize hash
    if !hash
      return nil
    else
      city = hash[:city]
      state = hash[:state]
      location = Point.demongoize(hash[:location]) || Point.demongoize(hash[:loc])
      Address.new(city, state, location)
    end
  end

  def self.evolve object
    case object
      when nil then return nil
      when Hash then return object
      when Address then
        hash = {}
        hash[:city] = object.city
        hash[:state] = object.state
        hash[:loc] = Point.mongoize(object.location)
        return hash
    end
  end
end