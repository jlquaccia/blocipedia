class Amount
  def self.default
    15_00
  end


  def self.premium
    default + 500
  end
end