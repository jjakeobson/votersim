class Politician
  attr_accessor :name, :party

  def initialize(name, party)
    @name = name
    @party = party
  end

  def name_of
    return @name
  end

end

@politicians = []

def create_politician(name, party)
  #create a Politician/Voter with the parameters
  @politicians << Politician.new(name, party)
end

def update_party(name,update_party_to)

end
create_politician("jim", "r")
p @politicians


#update_party("jim", "d")
