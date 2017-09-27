

def CalcDiceAvg(value)

	if value == 'D3'
		return 2
	elsif value == 'D6'
		return 3.5
	elsif value == '2D6'
		return 7
	elsif value == '2D3'
		return 4
	elsif value =='-D3'
		return -2
	elsif value =='3D6'
		return 10.5
	elsif value == '3D3'
		return 6
	elsif value == '4D6'
		return 14
	elsif value == '4D3'
		return 8
	elsif value == '6+D3'
		return 8
	else
		return value.to_f
	end
end

def RollDice(value)
	if value == 'D3'
		return rand(1..3).to_i
		puts "Matches D3"
	elsif value == 'D6'
		return rand(1..6).to_i
	elsif value == '2D6'
		dice1 = rand(1..6).to_i
		dice2 = rand(1..6).to_i
		return dice1 + dice2
	elsif value == '2D3'
		dice1 = rand(1..3).to_i
		dice2 = rand(1..3).to_i
		return dice1 + dice2
	elsif value == '-D3'
		dice = rand(1..3).to_i * -1
		return dice
	elsif value == '3D6'
		dice1 = rand(1..6).to_i
		dice2 = rand(1..6).to_i
		dice3 = rand(1..6).to_i
		return dice1 + dice2 + dice3
	elsif value == '3D3'
		dice1 = rand(1..3).to_i
		dice2 = rand(1..3).to_i
		dice3 = rand(1..3).to_i
		return dice1 + dice2 + dice3
	elsif value == '4D6'
		dice1 = rand(1..6).to_i
		dice2 = rand(1..6).to_i
		dice3 = rand(1..6).to_i
		dice4 = rand(1..6).to_i
		return dice1 + dice2 + dice3 + dice4
	elsif value == '4D3'
		dice1 = rand(1..3).to_i
		dice2 = rand(1..3).to_i
		dice3 = rand(1..3).to_i
		dice4 = rand(1..3).to_i
		return dice1 + dice2 + dice3 + dice4
	elsif value == '6+D3'
		return 6 + rand(1..3).to_i
	else
		return value.to_i
	end
end



def RerollFightHits(attacker, defender, weapon,mode, rolls, to_suceed, logfile)
	reroll_what = Array.new()
	reroll_rules = attacker.getRules.grep(/Reroll/)
	reroll_rules = reroll_rules + weapon.getRules(mode).grep(/Reroll/)
	unless defender.hasKeyword('Character') == true
		reroll_rules.delete_if {|rule| rule.match(/Duelist/)}
	end
	
	reroll_rules.each do |rule|
		rule_split = rule.split(' - ')
		if (rule_split[-2] == 'Hits' or rule_split[-2] == 'All') &&
			(rule_split[-3] == 'Fight' or rule_split[-3] == 'All')
			
			reroll_what.push(rule_split[-1])
			
		end
	end
	
	
	if reroll_what.include?('All') == true
		
		rolls = RerollAll(rolls, to_suceed)
		logfile.puts "#{attacker.getName} gets to reroll all their misses and now rolled #{rolls}"
		
	elsif reroll_what.include?('Single') == true && reroll_what.include?('1') == true
		
		tot_mod = 0
		rolls.each_index do |n|
			if rolls[n].to_i == 1
				rolls[n] = rand(1..6)
			elsif	
				rolls[n] < to_suceed && tot_mod < 1
				rolls[n] = rand(1..6)
				tot_mod = 1
			end
		end
		
		logfile.puts "#{attacker.getName} gets to reroll all their ones and a single miss, now they rolled #{rolls}"
		
	elsif reroll_what.include?('1') == true
		
		rolls = RerollOnes(rolls)
		
		logfile.puts "#{attacker.getName} gets to reroll all their 1's and now rolled #{rolls}"
		
	elsif reroll_what.include?('Single') == true
		tot_mod = 0
		rolls.each_index do |n|
			if	
				rolls[n] < to_suceed && tot_mod < 1
				rolls[n] = rand(1..6)
				tot_mod = 1
			end
		end
		logfile.puts "#{attacker.getName} gets to reroll a single miss, now they rolled #{rolls}"
	end
	
	
	return rolls
end



def RerollFightWounds(attacker, defender, weapon, mode, rolls, to_suceed,logfile)
	reroll_what = Array.new()
	reroll_rules = attacker.getRules.grep(/Reroll/)
	reroll_rules = reroll_rules + weapon.getRules(mode).grep(/Reroll/)
	
	unless defender.hasKeyword('Character') == true
		reroll_rules.delete_if {|rule| rule.match(/Duelist/) }
	end
	
	
	reroll_rules.each do |rule|
		rule_split = rule.split(' - ')
		if (rule_split[-2] == 'Wounds' or rule_split[-2] == 'All') &&
			(rule_split[-3] == 'Fight' or rule_split[-3] == 'All')
			
			reroll_what.push(rule_split[-1])
			
		end
	end
	

	if reroll_what.include?('All')
		rolls = RerollAll(rolls, to_suceed)
		logfile.puts "#{attacker.getName} gets to reroll all dice that didn't wound and now rolled #{rolls}"
		
	elsif reroll_what.include?('Single') && reroll_what.include?('1')
		
		tot_mod = 0
		rolls.each_index do |n|
			if rolls[n].to_i == 1
				rolls[n] = rand(1..6)
			elsif	
				rolls[n] < to_suceed && tot_mod < 1
				rolls[n] = rand(1..6)
				tot_mod = 1
			end
		end
		
	logfile.puts "#{attacker.getName} gets to reroll all 1's and a single failed wound roll, now they rolled #{rolls}"
	
	elsif reroll_what.include?('1')
		
		rolls = RerollOnes(rolls)
		logfile.puts "#{attacker.getName} gets to reroll all 1's producing #{rolls}"
		
	elsif reroll_what.include?('Single')
		
		tot_mod = 0
		rolls.each_index do |n|
			if	
				rolls[n] < to_suceed && tot_mod < 1
				rolls[n] = rand(1..6)
				tot_mod = 1
			end
		end
		
		logfile.puts "#{attacker.getName} gets to reroll a single attempt to wound producing: #{rolls}"
	end
	
	return rolls
end



def RerollAll(rolls, to_suceed)
	rolls = rolls.map! { |r| r < to_suceed ? rand(1..6) : r}
	return rolls
end

def RerollOnes(rolls)
	rolls = rolls.map! { |r| r == 1 ? rand(1..6) : r}
	return rolls
end

	
	
	
	
	
	
	
	
	
	
	
	
	
	