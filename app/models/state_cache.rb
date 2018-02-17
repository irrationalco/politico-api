class StateCache < ApplicationRecord
  def self.as_projection
    all.map(&:to_projection)
  end

  def to_projection
    Projection.new do |r|
      r.pan = pan
      r.pconv = pconv
      r.pes = pes
      r.ph = ph
      r.pmc = pmc
      r.pmor = pmor
      r.pna = pna
      r.ppm = ppm
      r.prd = prd
      r.pri = pri
      r.psd = psd
      r.psm = psm
      r.pt = pt
      r.pvem = pvem
      r.total_votes = total_votes
      r.state_code = state_code
      r.election_type = election_type
      r.year = year
      r.id = id
    end
  end
end
