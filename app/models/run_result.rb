class RunResult < LegResult

  field :mmile, as: :minute_mile, type: Float

  # removing - done in parent class
  # def secs= value
  #   self[:secs] = value
  #   #self.secs = value #doesnt work
  #   calc_ave
  # end

  def calc_ave
    if event && secs
      miles = event.miles
      self.mmile = miles.nil? ? nil : ((secs / miles) * (1 / 60.0))
    end
  end

end