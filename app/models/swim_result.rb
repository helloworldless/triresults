class SwimResult < LegResult

  field :pace_100, type: Float

   def secs= value
    #byebug
    self[:secs] = value
    #self.secs = value
    calc_ave
    if entrant
      entrant.update_total self
    end
  end

  def calc_ave
    if event && secs
      meters = event.meters
      self.pace_100 = meters.nil? ? nil : secs * (100.0 / meters)
    end
  end

end
