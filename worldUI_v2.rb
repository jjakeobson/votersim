class World_Ui
  #this class interacts with the user and calls the methods of the
  #world class to perfom the actions requested.
  @world

  def main_menu
    # When user types "L" call the list method
    # When user types "C" prompt for v||p and call create
    input_cluvq = get_answer("Menu: What would you like to do?", "(C)reate,
                  (L)ist, (U)pdate, (V)ote, or (Q)uit", w%[c l u v q])
      case input_cluvq
        when "c"
          input_pv = get_answer("What would you like to create?", "(P)olitician or (V)oter", w%[p v])
          puts "Enter name: "
          name = gets.chomp
          if input_pv == "p"
            party = get_answer("What is your party?", "(D)emocrat or (R)epublican", w%[d r])
            world.create_politician(name, party)
          else
            politics = get_answer("What are your politics? ", "(L)iberal, (C)onservative, (T)ea Party, (S)ocialist, or (N)eutral", w%[l c t s n])
            world.create_voter(name, politics)
          end
        when "l"
          puts "Here is your requested list:"
          world.list(z)
        when "u"
          type = get_answer("Who would you like to update?", "(P)oliticians or (V)oters", w%[v p])
          world.list(type)
          print "Name: "
          name = gets.chomp.downcase
          person = find(name)
          if person
              while anything_else == "y"
                if person.is_a? Politician
                   update_politician = get_answer("What would you like to change?", "(N)ame or (P)arty", w%[n p]) #var saves n or p
                   if update_politician == "p"
                     update_party_to = get_answer("What party would you like to change to?", "(R)epublican or (D)emocrat", w%[r d])
                    world.update_party(name, update_party_to)
                  elsif update_politician == "n"
                    print "What is your new name: "
                    update_name_to = gets.chomp.downcase
                    world.update_name(name, update_name_to)
                  end
                elsif person.is_a? Voter
                    update_voter = get_answer("What would you like to change?", "(N)ame or (P)olitics", w%[n p])
                    if update_voter == politics
                      update_politics_to = get_answer("What politics would you like to change to?", "(T)ea Party, (C)onservative, (N)eutral, (L)iberal, or (S)ocialist ", w%[t c n l s])
                      world.update_politics(name)
                   elsif update_voter == name
                     print "What is your new name: "
                     update_name_to = gets.chomp.downcase
                     world.update_name(name)
                   end
                 end
                   anything_else = get_answer("Would you like to update anything else?", "(Y)es or (N)o", w%[y n])
              end
          else
            person doesnt exist
            type a person that does exist or back to menu
          end

        when "v"
          #simulate the voting process / signify program end / show winner / show how close?
          puts ""
        when "q"
          #quits the program
          puts ""
        else
          puts "Please choose an option from the menu."

        end

      end
  end
  def get_answer(prompt, choice, valid)
    is_valid = false
    while !is_valid
      puts prompt
      puts choice
      answer = gets.chomp.downcase
      is_valid = true if valid.contains? answer
      puts "Please enter a menu selection " if !is_valid
    end
    return answer
  end

end
