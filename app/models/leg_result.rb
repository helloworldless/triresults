class LegResult
  include Mongoid::Document
  field :secs, type: Float

  embedded_in :entrant

  # validate: true here didn't work ; appr needs to be val_pres_of
  embeds_one :event, as: :parent
  
  validates_presence_of :event

  def calc_ave
    # subclasses will calc event-specific average(s)
  end

  after_initialize do |doc|
    calc_ave
  end

  # doesn't do anything
  # after_update do |doc|
  #   if entrant
  #     entrant.update_total self
  #   end
  # end

  #needed per instructions
  def secs= value
    self[:secs] = value #self.secs = value
    calc_ave
    if entrant
      entrant.update_total self
    end
  end

end
