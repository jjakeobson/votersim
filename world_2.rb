class Voter
  attr_accessor :name, :politics

  def initialize(name, politics)
    @name = name
    @politics = politics
  end
  #returns a formatted string voter information
  def get_info
    @output = "Voter, #{@name}, #{@politics}"
  end
end

class Politician    #JRD1017 added votes
  attr_accessor :name, :party, :votes

  def initialize(name, party)
    @name = name
    @party = party
    @votes = 0
  end

  #returns a formatted string politician information
  def get_info
    @output = "Politician, #{@name}, #{@party}"
  end



end

class World
  #this class performs all the actions for the simulation and hold
  #all of the players and results

    attr_accessor :voters, :politicians, :total_votes

    def initialize    #JRD1017 added to init instance vars
      @voters = []        #array of voter objects
      @politicians = []   #array of politician objects
      @total_votes = {}   #hash containing politician:  votes
    end

    def create_politician(name, party)
      #create a Politician/Voter with the parameters
      @politicians << Politician.new(name, party)
    end

    def create_voter(name, politics)
      #create a Politician/Voter with the parameters
      @voters = Voter.new(name, politics)
    end

    def update_name(name, update_name_to)

    end

    def update_party(name, update_party_to)

    end

    def update_politics(name)

    end

    def update_voter

    end


    def testdata #JRD1017
      #A method to generate an array of voters and of politicians for testing

      #create an array of voters from a file with a list of random names
      politics = %w[t c n l s]
      File.open("voters.txt") do |file|
          file.each_line do |line|
            name = line.chomp.strip
            @voters << Voter.new(name, politics[rand(4)])
          end
      end
      #puts the array for testing
      puts "Voters from file"
      puts
      @voters.each do |voter|
        puts "#{voter.name}|  |#{voter.politics}|"
      end

      #create a small array of politicians manually
      @politicians << Politician.new("Donald Trump", "r")
      @politicians << Politician.new("Jeb Bush", "r")
      @politicians << Politician.new("Hillary Clinton", "d")
      @politicians << Politician.new("Bernie Sanders", "d")

      p @politicians

    end
    def print_list(list)
      list.each do |person|
        puts person.get_info
      end
    end

    def list(type)
      if type == "p"
        print_list(@politicians)
      elsif type == "v"
        print_list(@voters)
      else
        print_list(@politicians)
        print_list(@voters)
      end
    end


    def election  #JRD1017 original version

      #This hash contains the probability of a voter with given politics
      #voting democrat. If a random number(1,100) is less than this the voter
      #voted democrat else republican.

      vote_prob = {"t" => 10, "c" => 25, "n" => 50, "l" => 75, "s" => 90}

      #sort the politicians into arrays of democrats and republicans
      democrats = []
      republicans = []
      @politicians.each do |candidate|
        candidate.votes = 0                   #clear the vote count
        if candidate.party == "d"
          democrats << candidate
        else
          republicans << candidate
        end
      end

      #get the number of candidates in each party
      num_dem = democrats.length
      num_rep = republicans.length

      #for each voter simulate voting and record the total in the politician object
      @voters.each do |voter|
        if rand(1..100) <= vote_prob[voter.politics]
          democrats[rand(0..(num_dem - 1))].votes += 1  #pick a random dem and record vote
        else
          republicans[rand(0..(num_rep - 1))].votes += 1 #otherwise vote goes to random rep
        end
      end

      @total_votes.clear                      #remove any old results
      puts "Election Results:"
      puts

      @politicians.each do |candidate|        #generate hash and politician votes
        candidate.votes += 1                  #cadidates always vote for themselves
        @total_votes[candidate.name] = candidate.votes
        puts "#{candidate.name} has #{candidate.votes} votes."
      end

    end

    def find_person(name)
      #returns if found, and type of person + name
      #returns false if not currently in list
      if @politicians.include?(name) || @voters.include?(name)
        return name, true
      else
        return false
        puts "Person not found."
      end
    end

    def go_back
      #go back in the menu
    end
end

my_world = World.new
my_world.testdata
my_world.election
my_world.list("p")
my_world.list("v")
my_world.list("")
