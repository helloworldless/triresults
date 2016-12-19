class BikeResult < LegResult

  field :mph, type: Float

  # removing - done in parent class
  # def secs= value
  #   self[:secs] = value
  #   #self.secs = value #doesnt work
  #   calc_ave
  # end

  def calc_ave
    if event && secs
      miles = event.miles
      self.mph = miles.nil? ? nil : miles / secs * 3600.0
    end
  end

end