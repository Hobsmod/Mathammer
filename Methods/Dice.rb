

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
	reroll_rules = attacker.rules.grep(/Reroll/)+ weapon.rules[mode].grep(/Reroll/)
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
		##logfile.puts "#{attacker.name} gets to reroll all their misses and now rolled #{rolls}"
		
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
		
		##logfile.puts "#{attacker.name} gets to reroll all their ones and a single miss, now they rolled #{rolls}"
		
	elsif reroll_what.include?('1') == true
		
		rolls = RerollOnes(rolls)
		
		##logfile.puts "#{attacker.name} gets to reroll all their 1's and now rolled #{rolls}"
		
	elsif reroll_what.include?('Single') == true
		tot_mod = 0
		rolls.each_index do |n|
			if	
				rolls[n] < to_suceed && tot_mod < 1
				rolls[n] = rand(1..6)
				tot_mod = 1
			end
		end
		##logfile.puts "#{attacker.name} gets to reroll a single miss, now they rolled #{rolls}"
	end
	
	
	return rolls
end


def RerollShootingHits(attacker, defender, weapon,mode, rolls, to_suceed, logfile)
	reroll_what = Array.new()
	reroll_rules = attacker.rules.grep(/Reroll/) + weapon.rules[mode].grep(/Reroll/)
	unless defender.hasKeyword('Character') == true
		reroll_rules.delete_if {|rule| rule.match(/Duelist/)}
	end
	
	reroll_rules.each do |rule|
		rule_split = rule.split(' - ')
		if (rule_split[-2] == 'Hits' or rule_split[-2] == 'All') &&
			(rule_split[-3] == 'Shooting' or rule_split[-3] == 'All')
			
			reroll_what.push(rule_split[-1])
			
		end
		
		if rule[-1] == 'Forgefather' && (weapon.name =~ /Flame/ or weapon.name =~ /Melta/ or weapon.name == 'Gauntlet of the Forge')
			reroll_what.push('All')
		end
	end
	
	
	if reroll_what.include?('All') == true
		
		rolls = RerollAll(rolls, to_suceed)
		##logfile.puts "#{attacker.name} gets to reroll all their misses and now rolled #{rolls}"
		
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
		
		##logfile.puts "#{attacker.name} gets to reroll all their ones and a single miss, now they rolled #{rolls}"
		
	elsif reroll_what.include?('1') == true
		
		rolls = RerollOnes(rolls)
		
		##logfile.puts "#{attacker.name} gets to reroll all their 1's and now rolled #{rolls}"
		
	elsif reroll_what.include?('Single') == true
		tot_mod = 0
		rolls.each_index do |n|
			if	
				rolls[n] < to_suceed && tot_mod < 1
				rolls[n] = rand(1..6)
				tot_mod = 1
			end
		end
		##logfile.puts "#{attacker.name} gets to reroll a single miss, now they rolled #{rolls}"
	end
	
	
	return rolls
end

def CalcRerollFightHits(attacker, defender, weapon,mode, attacks, to_suceed, logfile)
	reroll_what = Array.new()
	reroll_rules = attacker.rules.grep(/Reroll/)
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
	
	to_succeed = to_succeed.to_f
	if reroll_what.include?('All') == true
		
		to_suceed = to_suceed + ((1.0 - to_succeed) * to_succeed)
		##logfile.puts "#{attacker.name} gets to reroll all their misses and now rolled #{rolls}"
		
	elsif reroll_what.include?('Single') == true && reroll_what.include?('1') == true
		
		
		misses_not_ones = attacks.to_f * (1.0 - (to_succeed + (1.0 / 6.0)))
		if misses_not_ones > 1
			misses_not_ones = 1
		end
		
		
		##logfile.puts "#{attacker.name} gets to reroll all their ones and a single miss, now they rolled #{rolls}"
		
	elsif reroll_what.include?('1') == true
		
		rolls = RerollOnes(rolls)
		
		##logfile.puts "#{attacker.name} gets to reroll all their 1's and now rolled #{rolls}"
		
	elsif reroll_what.include?('Single') == true
		tot_mod = 0
		rolls.each_index do |n|
			if	
				rolls[n] < to_suceed && tot_mod < 1
				rolls[n] = rand(1..6)
				tot_mod = 1
			end
		end
		##logfile.puts "#{attacker.name} gets to reroll a single miss, now they rolled #{rolls}"
	end
	
	
	return rolls
end



def RerollFightWounds(attacker, defender, weapon, mode, rolls, to_suceed,logfile)
	reroll_what = Array.new()
	reroll_rules = attacker.rules.grep(/Reroll/) + weapon.rules[mode].grep(/Reroll/)

	
	unless defender.hasKeyword('Character') == true
		reroll_rules.delete_if {|rule| rule.match(/Duelist/) }
	end
	
	
	reroll_rules.each do |rule|
		rule_split = rule.split(' - ')
		if (rule_split[-2] == 'Wounds' or rule_split[-2] == 'All') &&
			(rule_split[-3] == 'Fight' or rule_split[-3] == 'All')
			
			reroll_what.push(rule_split[-1])
			
		end
		if rule[-1] == 'Forgefather' && (weapon.name =~ /Flame/ or weapon.name =~ /Melta/ or weapon.name == 'Gauntlet of the Forge')
			reroll_what.push('All')
		end
	end
	

	if reroll_what.include?('All')
		rolls = RerollAll(rolls, to_suceed)
		##logfile.puts "#{attacker.name} gets to reroll all dice that didn't wound and now rolled #{rolls}"
		
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
		
	##logfile.puts "#{attacker.name} gets to reroll all 1's and a single failed wound roll, now they rolled #{rolls}"
	
	elsif reroll_what.include?('1')
		
		rolls = RerollOnes(rolls)
		##logfile.puts "#{attacker.name} gets to reroll all 1's producing #{rolls}"
		
	elsif reroll_what.include?('Single')
		
		tot_mod = 0
		rolls.each_index do |n|
			if	
				rolls[n] < to_suceed && tot_mod < 1
				rolls[n] = rand(1..6)
				tot_mod = 1
			end
		end
		
		##logfile.puts "#{attacker.name} gets to reroll a single attempt to wound producing: #{rolls}"
	end
	
	return rolls
end


def RerollShootingWounds(attacker, defender, weapon, mode, rolls, to_suceed, logfile)
	reroll_what = Array.new()
	reroll_rules = attacker.rules.grep(/Reroll/)
	reroll_rules = reroll_rules + weapon.getRules(mode).grep(/Reroll/)
	
	unless defender.hasKeyword('Character') == true
		reroll_rules.delete_if {|rule| rule.match(/Duelist/) }
	end
	
	
	reroll_rules.each do |rule|
		rule_split = rule.split(' - ')
		if (rule_split[-2] == 'Wounds' or rule_split[-2] == 'All') &&
			(rule_split[-3] == 'Shooting' or rule_split[-3] == 'All')
			
			reroll_what.push(rule_split[-1])
			
		end
	end
	

	if reroll_what.include?('All')
		rolls = RerollAll(rolls, to_suceed)
		##logfile.puts "#{attacker.name} gets to reroll all dice that didn't wound and now rolled #{rolls}"
		
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
		
	##logfile.puts "#{attacker.name} gets to reroll all 1's and a single failed wound roll, now they rolled #{rolls}"
	
	elsif reroll_what.include?('1')
		
		rolls = RerollOnes(rolls)
		##logfile.puts "#{attacker.name} gets to reroll all 1's producing #{rolls}"
		
	elsif reroll_what.include?('Single')
		
		tot_mod = 0
		rolls.each_index do |n|
			if	
				rolls[n] < to_suceed && tot_mod < 1
				rolls[n] = rand(1..6)
				tot_mod = 1
			end
		end
		
		##logfile.puts "#{attacker.name} gets to reroll a single attempt to wound producing: #{rolls}"
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

def RerollSaves(attacker, defender, rolls, save, invuln, logfile)
	reroll_what = Array.new{}
	if attacker.rules.grep(/Reroll - Invulnerable - Success/).size > 0 && invuln? == true
		reroll_what.push('Success')
	end
	
	if defender.rules.grep(/Reroll - Saves - All/).size > 0
		defender.rules.grep(/Reroll - Saves - All/).each do |rule|
			reroll_what.push(rule.split(' - ')[-1])
		end
	end
	
	if defender.rules.grep(/Reroll - Saves - Invulnerable/).size > 0 && invuln? == true
		defender.rules.grep(/Reroll - Saves - Invulnerable/).each do |rule|
			reroll_what.push(rule.split(' - ')[-1])
		end
	end
	
	rolls2 = Array.new()
	
	if reroll_what.include?('Success')
		rolls2 = Array.new(rolls.count{|x| x >= save})
		rolls.delete_if{|x| x < save}
		##logfile.puts "#{attacker.name} forces sucessful saves to be rerolled"
	end
	
	if reroll_what.include?('All')
		rolls = RerollAll(rolls, save)
		##logfile.puts "{defender.name} gets to reroll all failed saves"
		
	elsif reroll_what.include?('Single') && reroll_what.include?('1')
		
		tot_mod = 0
		rolls.each_index do |n|
			if rolls[n].to_i == 1
				rolls[n] = rand(1..6)
			elsif	
				rolls[n] < save && tot_mod < 1
				rolls[n] = rand(1..6)
				tot_mod = 1
			end
		end
		
	##logfile.puts "#{defender.name} gets to reroll all 1's and a single failed save"
	
	elsif reroll_what.include?('1')
		
		rolls = RerollOnes(rolls)
		##logfile.puts "#{defender.name} gets to reroll all 1's "
		
	elsif reroll_what.include?('Single')
		
		tot_mod = 0
		rolls.each_index do |n|
			if	
				rolls[n] < save && tot_mod < 1
				rolls[n] = rand(1..6)
				tot_mod = 1
			end
		end
		
		##logfile.puts "#{defender.name} gets to reroll a single save"
	end
	
	rolls = rolls + rolls2
	#logfile.puts "After rerolls the save rolls are #{rolls}"
	
	
	return rolls
	
end	
	
	
	
	
	
	
	
	
	
	
	
	
	