class Placing
  attr_accessor :name, :place

  def initialize(name=nil, place=nil)
    @name = name
    @place = place
  end

  def mongoize
    hash = {}
    hash[:name] = @name
    hash[:place] = @place
    return hash
  end

  def self.mongoize object
    case object
      when nil then return nil
      when Hash then return object
      when Placing then
        hash = {}
        hash[:name] = object.name
        hash[:place] = object.place
        return hash
    end
  end

  def self.demongoize object
    case object
      when nil then return nil
      when Placing then return object
      when Hash then
        return Placing.new(object[:name], object[:place])
    end
  end

  def self.evolve object
    case object
    when nil then return nil
    when Hash then return object
    when Placing then
      hash = {}
      hash[:name] = object.name
      hash[:place] = object.place
      return hash
    end
  end
end