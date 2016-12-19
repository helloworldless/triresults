class Event
  include Mongoid::Document
  field :o, as: :order, type: Integer
  field :n, as: :name, type: String
  field :d, as: :distance, type: Float
  field :u, as: :units, type: String

  # embedded_in :race, polymorphic: true
  embedded_in :leg_result, polymorphic: true # why was this commented out?
  embedded_in :parent, polymorphic: true, touch: true

  validates_presence_of :name, :order

  def meters
    
    m_hash = Hash.new
    m_hash['yards'] = 0.9144 # yards to meters
    m_hash['miles'] = 1609.344 # miles to meters
    m_hash['kilometers'] = 1000

    case self.units
      when "miles" then return self.distance * m_hash[self.units]
      when "yards" then return self.distance * m_hash[self.units]
      when "kilometers" then return self.distance * m_hash[self.units]
      when "meters" then return self.distance
      else return nil # raise "meters method is mi2m or mi2mi only" 
    end 
  end

  def miles

    mi_hash = Hash.new
    mi_hash['meters'] = 0.000621371 # meters to miles
    mi_hash['kilometers'] = 0.621371 # kilometers to miles
    mi_hash['yards'] = 0.000568182 # yards to miles

    case self.units
      when "meters" then return self.distance * mi_hash[self.units]
      when "kilometers" then return self.distance * mi_hash[self.units]
      when "yards" then return self.distance * mi_hash[self.units]
      when "miles" then return self.distance
      else return nil # raise "miles method is m2mi or mi2mi only" 
    end 
  end

end
