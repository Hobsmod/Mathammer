require_relative '..\Classes\Model.rb'
require_relative '..\Classes\Unit.rb'
require_relative '..\Classes\Weapon.rb'
require_relative 'Dice.rb'



def CalcHits(attacker,target,weapon,mode,logfile)
	attacks = CalcDiceAvg(attacker.stats['A']).to_f
	ws = attacker.stats['WS']
	shots = CalcDiceAvg(weapon.getShots(mode)).to_f
	attacks = attacks + shots
	#logfile.puts "#{attacker.name} has #{attacks} attacks, and gets #{shots} bonus attacks from his weapon #{weapon.name} in #{mode} mode."
	
	### Calculate Extra Attacks for Duelist and Charging
	if (attacker.rules().grep(/Duelist - Attacks/).size + weapon.rules[mode].grep(/Duelist - Attacks/).size) > 0 && target.hasKeyword('Character')
		duelist_array = attacker.rules().grep(/Duelist - Attacks/) + weapon.rules[mode].grep(/Duelist - Attacks/)
		bonus_attacks = Array.new()
		rolled_bonus_attacks = Array.new()
		duelist_array.each do |rule|
			split_rule = rule.split(' - ')
			bonus_attacks.push(split_rule[-1])
		end
		bonus_attacks.each do |n|
			rolled_bonus_attacks.push(CalcDiceAvg(n))
		end
		#logfile.puts "#{attacker.name}'s abilities and weapons give them #{bonus_attacks} extra attacks against characters for a total of #{rolled_bonus_attacks}"
		attacks = attacks + rolled_bonus_attacks.inject(0){|sum,x| sum + x }
	end
			
	
	## Calculate Modifiers
	modifier = 1.0
	
	if weapon.hasRule?(mode,'Unwieldy')
		modifier = modifier - 1.0
		#logfile.puts "#{attacker.name}'s #{weapon.name} is unwieldy so he has a -1 to hit"
	end
	
	if target.hasRule?('Hard to Hit - Fight - 1')
		modifier = modifier - 1.0
		#logfile.puts "#{attacker.name}'s #{weapon.name} is unwieldy so he has a -1 to hit"
	end
	
	## Calculate Prob
	prob = (6.0 - (ws - modifier)) / 6.0
	
	
	# Begin to Calculate Rerolls
	### Determine what we are rerolling
	reroll_what = Array.new()
	reroll_rules = attacker.rules.grep(/Reroll/)
	reroll_rules = reroll_rules + weapon.rules[mode].grep(/Reroll/)
	unless target.hasKeyword('Character') == true
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
		
		prob = prob + ((1.0 - prob) * prob)
		#logfile.puts "#{attacker.name} gets to reroll all their misses making the new probability #{prob}"
		
	elsif reroll_what.include?('Single') == true && reroll_what.include?('1') == true
		
		total_ones = attacks * (1.0 / 6.0)
		misses_not_ones = attacks.to_f * (1.0 - (prob + (1.0 / 6.0)))
		if misses_not_ones > 1
			misses_not_ones = 1
		end
		hits = attacks * prob
		hits = hits + (total_ones * prob)
		hits = hits + (misses_not_ones * prob)
		
		#logfile.puts "#{attacker.name} gets to reroll all their ones and a single miss, giving them a total of  #{hits}"
		return hits
		
	elsif reroll_what.include?('1') == true
		
		
		prob = prob + (prob * (1.0 / 6.0))
		
		#logfile.puts "#{attacker.name} gets to reroll all their 1's making the new probability of hitting #{prob}"
		
	elsif reroll_what.include?('Single') == true
		
		misses = attacks.to_f * (1.0 - to_succeed)
		if misses> 1
			misses = 1
		end
		
		hits = (prob * attacks) + (misses * prob)
		#logfile.puts "#{attacker.name} gets to reroll a single miss so they git #{hits} hits"
		return hits
	end
	
	

	hits = prob * attacks
	#logfile.puts "He gets #{hits} hits"

	return hits
end

def RollHits(attacker,target,weapon,mode, charged, logfile)

	attacks = RollDice(attacker.stats['A']).to_i
	to_hit = attacker.stats['WS'].to_i
	shots = RollDice(weapon.getShots(mode)).to_i
	attacks = attacks + shots
	hits = 0
	mortals = Array.new()
	self_wounds = 0
	#logfile.puts "#{attacker.name} has #{RollDice(attacker.stats['A']).to_i} attacks, and gets #{shots} bonus attacks from his weapon" 
	
	## Calculate extra attacks for duelist
	if (attacker.rules.grep(/Duelist - Attacks/).size + weapon.rules[mode].grep(/Duelist - Attacks/).size) > 0 && target.hasKeyword('Character')
		duelist_array = attacker.rules().grep(/Duelist - Attacks/) + weapon.rules[mode].grep(/Duelist - Attacks/)
		bonus_attacks = Array.new()
		rolled_bonus_attacks = Array.new()
		duelist_array.each do |rule|
			split_rule = rule.split(' - ')
			bonus_attacks.push(split_rule[-1])
		end
		bonus_attacks.each do |n|
			rolled_bonus_attacks.push(RollDice(n))
		end
		#logfile.puts "#{attacker.name}'s abilities and weapons give them #{bonus_attacks} extra attacks against characters for a total of #{rolled_bonus_attacks}"
		attacks = attacks + rolled_bonus_attacks.inject(0){|sum,x| sum + x }
	end
			
	if (attacker.rules().grep(/Charge - Attacks/).size + weapon.rules[mode].grep(/Charge - Attacks/).size) > 0 && charged == true
		duelist_array = attacker.rules().grep(/Charge - Attacks/) + weapon.rules[mode].grep(/Charge - Attacks/)
		bonus_attacks = Array.new()
		rolled_bonus_attacks = Array.new()
		duelist_array.each do |rule|
			split_rule = rule.split(' - ')
			bonus_attacks.push(split_rule[-1])
		end
		bonus_attacks.each do |n|
			rolled_bonus_attacks.push(RollDice(n))
		end
		#logfile.puts "#{attacker.name}'s abilities and weapons give them #{bonus_attacks} extra attacks when charging for a total of: #{rolled_bonus_attacks}"
		attacks = attacks + rolled_bonus_attacks.inject(0){|sum,x| sum + x }
	end
	
	
	# Roll the Dice
	rolls = Array.new(attacks) {rand(1..6).to_i}
	#logfile.puts "#{attacker.name}'s rolls to hit are #{rolls} "
	
	# Reroll failed hits

	if (attacker.rules().grep(/Reroll/).size + weapon.rules[mode].grep(/Reroll/).size) > 0 && rolls.count{ |n| n < to_hit} > 0
		rolls = RerollFightHits(attacker, target, weapon, mode, rolls, to_hit, logfile)
	end
	
	

	
	sixes = rolls.count(6)
	
	# check if those rolls generate any additional attacks
	extra_rolls = Array.new()
	if (weapon.hasRule?(mode, 'Rend - Fight - Extra Attack') or attacker.hasRule?('Rend - Fight - Extra Attack') == true) && sixes > 0 
		#logfile.puts "#{attacker.name} generates an additional attack for every natural six, they rolled #{rolls} giving them #{sixes} more attacks"
		rend_rolls = Array.new(sixes) {rand(1..6)}
		extra_rolls = extra_rolls + rend_rolls
		#logfile.puts "Those extra attacks rolled #{extra_rolls}"
	end
	if extra_rolls.size > 0 && rolls.count{ |n| n < to_hit} > 0 && (attacker.rules().grep(/Reroll/).size + weapon.rules[mode].grep(/Reroll/).size) > 0
		extra_rolls = RerollFightHits(attacker,target,weapon,mode,extra_rolls,to_hit,logfile)
	end
	
	
	
	rolls = rolls + extra_rolls
	
	### Count Natural 5's and 6's
	sixes = rolls.count(6)
	fives = rolls.count(5)
	
	
	
	### Calculate Modifiers
	modifier = 0
	
	
	if weapon.hasRule?(mode, 'Unwieldy')
		#logfile.puts "#{weapon.name} has a -1 to hit in combat"
		modifier = modifier - 1
	end
	
	if target.hasRule?('Hard to Hit - Fight - 1')
		#logfile.puts "Attacks targetting #{target.name} in combat have a -1 to hit"
		modifier = modifier - 1
	end
	
	if attacker.hasRule?('Add - All - Hits - 1') or attacker.hasRule?('Add - Fight - Hits - 1') or attacker.hasRule?('Add - All - All - 1')
		#logfile.puts "#{attacker.name} add's 1 to their hit rolls in Close combat"
		modifier = modifier + 1
	end
	
	if attacker.rules.grep(/Modifier/).size> 0
		
		attacker.rules.grep(/Modifier/).each do |rule|
			string = rule.split(' - ')
			if (string[-2] == 'Hits' or string[-2] == 'All') &&
				(string[-3] == 'Fight' or string[-3] == 'All')
				#logfile.puts "#{attacker.rules}"
				modifier = modifier + string[-1].to_i
				#logfile.puts "#{attacker.name} has a rule which gives them a #{string[-1]} modifier to hit"
			end
		end
	end
			
	if rolls.include?('1') == true && modifer =! 0
		rolls.delete_if {|x| x == 1}
		#logfile.puts "All ones fail and are removed leaving #{rolls}"
	end
	# Apply modifiers
	
	if modifier != 0
		rolls.delete_if{|x| x == 1}
		#logfile.puts "Natural 1's are removed leaving #{rolls}"
		rolls.map!{|x| x + modifier}
		#logfile.puts "After modifiers the rolls are #{rolls}"
	end
	
	
	
		
	rolls.delete_if {|x| x < to_hit}
	#logfile.puts "#{attacker.name} needs #{to_hit} to hit resulting in #{rolls.size} hits"
	
	hits_6s_5s = [rolls.size,sixes,fives,mortals,self_wounds]
	return hits_6s_5s
end


def CalcWounds(hits,attacker,target,weapon,mode,logfile)
	user_str = CalcDiceAvg(attacker.stats['S']).to_f
	tough = CalcDiceAvg(target.stats['T']).to_f
	str = 0.0
	str_add = Array.new()
	str_mult = 1.0
	
	if weapon.stats[mode]['S'][0] == '*'
		if RollDice(weapon.stats[mode]['S'][1..-1]).to_i > str_mult
			str_mult = RollDice(weapon.stats[mode]['S'][1..-1]).to_i
		end
		#logfile.puts "#{attacker.name} has a strength of #{user_str} and his weapon multiples his strength by  #{ weapon.stats[mode]['S'][1]}"
	elsif
		bonus = RollDice(weapon.stats[mode]['S'][1..-1]).to_i
		str_add.push(bonus)
		#logfile.puts "#{attacker.name}'s #{weapon.name} increases his strength by  #{bonus}"
	else
		#logfile.puts "Don't know what to do with weapon strength of #{weapon.stats[mode]['S'][0]}"
		abort
	end

	
	if weapon.rules[mode].select{|rule| rule.match(/Duelist - Strength/)}.length > 0 && target.hasKeyword('Character')
		rule_array = weapon.rules[mode].select{|rule| rule.match(/Duelist - Strength/)}[0].split(' - ')
		duel_bonus = rule_array[-1]
		if duel_bonus[0] == '*'
			mult = RollDice(duel_bonus[1..-1])
			if mult > str_mult
				str_mult = mult
			end
			#logfile.puts "#{weapon.name} multiplies #{attacker.name}'s strength by  #{mult} when fighting characters"
		elsif duel_bonus
			bonus = RollDice(duel_bonus)
			str_add.push(bonus)
			#logfile.puts "#{attacker.name}'s #{weapon.name} increases his strength by  #{bonus}"
		else
			#logfile.puts "Don't know what to do with weapon strength of #{getS(mode)[0]}"
			abort
		end	
	end
	
	
	if attacker.rules().select{|rule| rule.match(/Duelist - Strength/)}.length > 0 && target.hasKeyword('Character')
		rule_array = attacker.rules().select{|rule| rule.match(/Duelist - Strength/)}[0].split(' - ')
		duel_bonus = rule_array[-1]
		if duel_bonus[0] == '*'
			bonus = RollDice(duel_bonus[1..-1])
			if bonus > str_mult
				str_mult = bonus
			end
			#logfile.puts "#{attacker.name} multiples his strength by  #{str_mult} when fighting characters"
		elsif duel_bonus
			bonus = RollDice(duel_bonus)
			str_add.push(bonus)
			#logfile.puts "#{attacker.name}'s abilities increase strength by  #{bonus} when fighting a character"
		else
			#logfile.puts "Don't know what to do with weapon strength of #{duel_bonus}"
			abort
		end	
	end
	
	
	
	if weapon.stats[mode]['S'][0] != '*'
		bonus = CalcDiceAvg(weapon.stats[mode]['S'][1..-1]).to_f
		str = user_str + bonus
		#logfile.puts "#{attacker.name}'s #{weapon.name} increases their strength by #{bonus}, for  a total of #{str}"
	end
	
	str = user_str * str_mult.to_i
	if str_mult.to_i > 1	
		#logfile.puts "#{attacker.name()} has a strength of #{user_str} which is multiplied by #{str_mult} for a total of #{str}"
	end
	str_add.each do |add|
		str = str + add.to_i
	end
	if str_add.size > 0
		#logfile.puts "The following modifiers are added to strength #{str_add} for a final strength of #{str}"
	end
	
	
	if str >= (tough * 2)
		prob = 5.0 / 6.0
	elsif str > tough 
		prob = 4.0 / 6.0
	elsif str == tough
		prob = 3.0 / 6.0
	elsif str < tough 
		prob = 2.0 / 6.0 
	else
		prob = 1.0 / 6.0
	end
	
	
	#logfile.puts "#{attacker.name} has an effective strength of #{str} and his target has a toughness of #{tough}, giving a #{prob} chance of wounding" 
	if weapon.hasRule?(mode, 'Reroll - Wounds - All') or attacker.hasRule?('Reroll - All - Wounds - All') or attacker.hasRule?('Reroll - Fight - Wounds - All')
		prob = prob + ((1 - prob) * prob)
		#logfile.puts "#{attacker.name} can reroll wounds so their chances improve to #{prob}"
	elsif weapon.hasRule?(mode, 'Reroll - Wounds - 1') or attacker.hasRule?('Reroll - All - Wounds - 1') or attacker.hasRule?('Reroll - Fight - Wounds - 1')
		prob = prob +((1 / 6) * prob)
		#logfile.puts "#{attacker.name} can reroll 1's to wound so their chances improve to #{prob}"
	end
	wounds = prob * hits
	#logfile.puts "#{attacker.name} causes #{wounds} wounds"
	return wounds
end

def RollWounds(hits,attacker,target,weapon,mode,charged,logfile)
	user_str = RollDice(attacker.stats['S']).to_i
	tough = target.stats['T'].to_i
	wounds = 0
	mortals = hits[3]
	#logfile.puts mortals
	self_wounds = hits[4]
	hits = hits[0]
	
	combined_rules = attacker.rules() + weapon.rules[mode]
	
	if (combined_rules.grep(/Rend - Autohit/).size > 0 ) && hits[1] > 0 
		#logfile.puts "#{attacker.name} generates an extra hit for every six they rolled, and they rolled #{hits[1]} sixes"
		hits = hits + hits[1]
	end
	
	
	# Because of the way order of operations works in warhammer we query each rule to get a 
	# multiplier and an array of modifers to add and then perform the operations in order

	
	str_mult = 1
	str_add = Array.new()
	
	
	###adjust strength based on weapon
	if weapon.stats[mode]['S'][0] == '*'
		if RollDice(weapon.stats[mode]['S'][1..-1]).to_i > str_mult
			str_mult = RollDice(weapon.stats[mode]['S'][1..-1]).to_i
		end
		#logfile.puts "#{attacker.name} has a strength of #{user_str} and his weapon multiples his strength by  #{ weapon.stats[mode]['S'][1]}"
	elsif
		bonus = RollDice(weapon.stats[mode]['S'][1..-1]).to_i
		str_add.push(bonus)
		#logfile.puts "#{attacker.name}'s #{weapon.name} increases his strength by  #{bonus}"
	else
		#logfile.puts "Don't know what to do with weapon strength of #{getS(mode)[0]}"
		abort
	end

	##### Check for bonuses to strength from fighting a character
	
	if weapon.rules[mode].select{|rule| rule.match(/Duelist - Strength/)}.length > 0 && target.hasKeyword('Character')
		rule_array = weapon.rules[mode].select{|rule| rule.match(/Duelist - Strength/)}[0].split(' - ')
		duel_bonus = rule_array[-1]
		if duel_bonus[0] == '*'
			mult = RollDice(duel_bonus[1..-1])
			if mult > str_mult
				str_mult = mult
			end
			#logfile.puts "#{weapon.name} multiplies #{attacker.name}'s strength by  #{mult} when fighting characters"
		elsif duel_bonus
			bonus = RollDice(duel_bonus)
			str_add.push(bonus)
			#logfile.puts "#{attacker.name}'s #{weapon.name} increases his strength by  #{bonus}"
		else
			#logfile.puts "Don't know what to do with weapon strength of #{getS(mode)[0]}"
			abort
		end	
	end
	
	
	if attacker.rules().select{|rule| rule.match(/Duelist - Strength/)}.length > 0 && target.hasKeyword('Character')
		rule_array = attacker.rules().select{|rule| rule.match(/Duelist - Strength/)}[0].split(' - ')
		duel_bonus = rule_array[-1]
		if duel_bonus[0] == '*'
			bonus = RollDice(duel_bonus[1..-1])
			if bonus > str_mult
				str_mult = bonus
			end
			#logfile.puts "#{attacker.name} multiples his strength by  #{str_mult} when fighting characters"
		elsif duel_bonus
			bonus = RollDice(duel_bonus)
			str_add.push(bonus)
			#logfile.puts "#{attacker.name}'s abilities increase strength by  #{bonus} when fighting a character"
		else
			#logfile.puts "Don't know what to do with weapon strength of #{duel_bonus}"
			abort
		end	
	end
	
	##### Check for Bonuses to strength when charging
	
	if weapon.rules[mode].select{|rule| rule.match(/Charge - Strength/)}.length > 0 && charged == true 
		rule_array = weapon.rules[mode].select{|rule| rule.match(/Charge - Strength/)}[0].split(' - ')
		charge_bonus = rule_array[-1]
		if charge_bonus[0] == '*'
			mult = RollDice(charge_bonus[1..-1])
			if mult > str_mult
				str_mult = mult
			end
			#logfile.puts "#{attacker.name}'s weapon multiplies his strength when charging by #{charge_bonus}"
		elsif charge_bonus
			bonuse = RollDice(charge_bonus)
			str_add.push(bonus)
			#logfile.puts "#{attacker.name}'s weapon adds #{bonus} to his strength when charging"
		else
			#logfile.puts "Don't know what to do with weapon strength of #{charge_bonus}"
			abort
		end	
	end
	
	if (attacker.rules().select{|rule| rule.match(/Charge - Strength/)}.length > 0 && charged== true) 
		rule_array = attacker.rules().select{|rule| rule.match(/Charge - Strength/)}[0].split(' - ')
		charge_bonus = RollDice(rule_array[-1])
		if charge_bonus[0] == '*'
			mult = RollDice(charge_bonus[1..-1])
			if mult > str_mult
				str_mult = mult
			end
			#logfile.puts "#{attacker.name} has an ability that multiplies his strength when charging by #{charge_bonus}"
		elsif charge_bonus
			bonuse = RollDice(charge_bonus)
			str_add.push(bonus)
			#logfile.puts "#{attacker.name} has an ability that adds #{bonus} to his strength when charging"
		else
			#logfile.puts "Don't know what to do with weapon strength of #{charge_bonus}"
			abort
		end	
	end
	
	str = user_str * str_mult.to_i
	if str_mult.to_i > 1	
		#logfile.puts "#{attacker.name()} has a strength of #{user_str} which is multiplied by #{str_mult} for a total of #{str}"
	end
	str_add.each do |add|
		str = str + add.to_i
	end
	if str_add.size > 0
		#logfile.puts "The following modifiers are added to strength #{str_add} for a final strength of #{str}"
	end
		
	
	if str >= (tough * 2)
		to_wound = 2
	elsif str > tough 
		to_wound = 3
	elsif str == tough
		to_wound = 4
	elsif str <= (tough / 2)
		to_wound = 6
	else
		to_wound = 5
	end
	
	#logfile.puts "#{target.name} has a toughness of #{tough} so #{attacker.name} needs #{to_wound}'s to wound"
	
	## Check Poison
	if (combined_rules.grep(/Poison/).size > 0 ) && target.hasKeyword('Vehicle') == false
		poison_val = 7
		poison_rules = combined_rules.grep(/Poison/)
		poison_rules.each do |rule|
			if poison_val > rule[-1].to_i
				poison_val = rule[-1].to_i
			end
		end
		to_wound = poison_val
		#logfile.puts "However, #{attacker.name} always wounds on #{to_wound} unless targetting vehicles"
	end
	
	### Roll & Reroll
	
	
	rolls = Array.new(hits) {rand(1..6)}
	#logfile.puts  "#{attacker.name} rolled #{rolls}"
	if (attacker.rules().grep(/Reroll/).size + weapon.rules[mode].grep(/Reroll/).size) > 0 && rolls.count{ |n| n < to_wound} > 0
		rolls = RerollFightWounds(attacker, target, weapon, mode, rolls, to_wound, logfile)
	end
	

	##### Handle Mortal Wounds caused by rolling 6's
	

	sixes = rolls.count(6)
	
	if weapon.rules[mode].select{|rule| rule.match(/Rend - Mortal Wounds/)}.length > 0 && sixes > 0
		rule_array = weapon.rules[mode].select{|rule| rule.match(/Rend - Mortal Wounds/)}[0].split(' - ')
		
		if sixes >= 1
			#logfile.puts "#{rolls}"
			#logfile.puts "#{attacker.name} rolled #{sixes} 6's each of which does #{rule_array[-1]} mortal wounds"
			mortal_array = Array.new()
			(1..sixes).each do
				bonus = RollDice(rule_array[-1])
				mortal_array.push(bonus)
			end
			#logfile.puts "This causes #{mortal_array} mortal wounds"
			mortals = mortals + mortal_array
		end
		if rule_array.include? 'Replace'
			rolls.delete_if {|x| x == 6}
			#logfile.puts "Sixes that cause mortal wounds are removed leaving #{rolls}"
		end
	end
	
	if attacker.rules().select{|rule| rule.match(/Rend - Mortal Wounds/)}.length > 0 && sixes > 0
		rule_array = attacker.rules().select{|rule| rule.match(/Rend - Mortal Wounds/)}[0].split(' - ')
		if sixes >= 1
			#logfile.puts "#{attacker.name} rolled #{sixes} 6's each of which does #{rule_array[-1]} mortal wounds"
			(1..sixes).each do
				bonus = RollDice(rule_array[-1])
				mortal_array.push(bonus)
			end
			#logfile.puts "This causes #{mortal_array} mortal wounds"
			mortals = mortals + mortal_array
		end
		if rule_array.include? 'Replace'
			rolls.delete_if {|x| x == 6}
			#logfile.puts "Sixes that cause mortal wounds are removed leaving #{rolls}"
		end
	end
	
	modifier = 0
	
	if attacker.rules.grep(/Modifier/).size> 0
		attacker.rules.grep(/Modifier/).each do |rule|
			string = rule.split(' - ')
			if (string[-2] == 'Wounds' or string[-2] == 'All') &&
				(string[-3] == 'Fight' or string[-3] == 'All')
				
				modifier = modifier + string[-1].to_i
				#logfile.puts "#{attacker.name} has a rule which gives them a #{string[-1]} modifier to wound"
			end
		end
	end

	
	if modifier != 0
		rolls.delete_if{|x| x == 1}
		#logfile.puts "Natural 1's are removed leaving #{rolls}"
		rolls.map!{|x| x + modifier}
		#logfile.puts "After modifiers the rolls are #{rolls}"
	end
	
	
	### prepare array to return
	sixes = rolls.count(6)
	fives = rolls.count(5)
	rolls.delete_if {|x| x < to_wound}
	wounds_6s_5s = [rolls.size,sixes,fives,mortals,self_wounds]
	return wounds_6s_5s
end




def CalcSaves(wounds, attacker, target, weapon, firetype,logfile)
	
	ap = CalcDiceAvg(weapon.stats[firetype]['AP']).to_f
	save = target.stats['Sv'].to_f
	invuln = target.getInvuln.to_f
	mod_save = save - ap 
	#logfile.puts "#{attacker.name}'s #{weapon.name} has an AP of #{ap} so #{target.name}'s save of #{save} becomes #{mod_save}"
	if mod_save > invuln
		mod_save = invuln
		#logfile.puts "#{target.name}'s invulnerable save of #{invuln} is better, so they will use that instead"
	end
	if mod_save >= 7.0
		prob = 1.0
		stdev = 0.0
	else
		prob = (mod_save - 1) / 6
	end
	
	#logfile.puts "#{target.name} has a #{prob} chance of failing their save"
	failed_saves = wounds * prob
	#logfile.puts "#{target.name} failed #{failed_saves} saves"
	return failed_saves
	
end


def RollSaves(wounds, attacker, target, weapon, mode,charged,logfile)
	ap = RollDice(weapon.stats[mode]['AP']).to_i
	save = target.stats['Sv'].to_i
	invuln = target.getInvuln.to_i
	mortals = wounds[3]
	self_wound = wounds[4]
	norm_saves = wounds[0]
	fives = 0
	modifier = 0 
	
	mod_save = save - ap 
	#logfile.puts "#{target.name} has a save of #{save}+, but #{attacker.name}'s #{weapon.name} has an AP of #{ap} so the modified save is #{mod_save}+"
	if mod_save > invuln
		unless attacker.hasRule?('Null Zone') == true
			mod_save = invuln
			#logfile.puts "#{target.name}'s Invulnerable save of #{invuln}+ is higher so he will use that instead"
		else
			#logfile.puts "#{attacker.name} has the Null Zone ability so no invulnerable save may be used"
		end
		
		### Check for modifiers to invulnerable saves
		if target.rules.grep(/Modifier - Invulnerable/).size > 0 && attacker.hasRule?('Null Zone') == false
			target.rules.grep(/Modifier - Invulnerable/).each do |rule|
				rule_arr = rule.split(' - ')
				if rule_arr[-2] == 'All' or rule_arr[-2] == 'Fight'
					modifier = modifier + rule_arr[-1].to_i
					#logfile.puts "#{target.name} gets to add 1 to their invulnerable saving throws"
				end
			end
		end
		
	end
	
	
	if attacker.rules().select{|rule| rule.match(/Rend - Damage/)}.length > 0 
		rule_array = attacker.rules().select{|rule| rule.match(/Rend - Damage/)}[0].split(' - ')
		#logfile.puts "#{attacker.name}rolled #{wounds[1]} 6's to wound, these do extra damage and will be saved seperately"
		norm_saves = norm_saves - wounds[1]
		rend_rolls = Array.new(wounds[1]) {rand(1..6)}
		#logfile.puts "#{target.name} rolls #{rend_rolls}"
		rend_rolls.delete_if {|x| x >= mod_save}
		rends = rend_roll.size
		#logfile.puts "#{target.name} failed  #{rends} rolls that do extra damage"
	end
	
	if weapon.rules[mode].select{|rule| rule.match(/Rend - Damage/)}.length > 0
		rule_array = weapon.rules[mode].select{|rule| rule.match(/Rend - Damage/)}[0].split(' - ')
		#logfile.puts "#{attacker.name} rolled #{wounds[1]} 6's to wound, these do extra damage and will be saved seperately"
		norm_saves = norm_saves - wounds[1]
		rend_rolls = Array.new(wounds[1]) {rand(1..6)}
		#logfile.puts "#{target.name} rolls #{rend_rolls}"
		rend_rolls.delete_if {|x| x >= mod_save}
		rends = rend_rolls.size
		#logfile.puts "#{target.name} failed  #{rends} rolls that do extra damage"
	end
	
	
	
	
	
	rolls = Array.new(norm_saves) {rand(1..6)}
	#logfile.puts "#{target.name} rolls #{rolls} for their saves"
	if modifier != 0
		rolls.map!{|x| x + modifier}
		#logfile.puts "After modifiers the rolls are #{rolls}"
	end
	
	fails = rolls.count {|x| x < mod_save}
	#logfile.puts "This results in #{fails} failed saves"
	
	rolls.delete_if {|x| x >= mod_save}
	failed_6s_5s = [rolls.size,rends,fives,mortals,self_wound]

	return failed_6s_5s
	
end

def CalcDamage(felt_wounds, attacker, target, weapon, mode,logfile)
	if felt_wounds == 0
		puts "#{attacker.name}'s weapon did 0 damage"
		return 0.0
	end
	sv = target.stats['Sv']
	fnp = target.getFNP()

	d = CalcDiceAvg(weapon.stats[mode]['D'])
	
	wounds = target.stats['W'].to_f

	## Increase damage for grav weapons
	if sv >= 3 && weapon.hasRule?(mode, 'Grav')
		d = 2
	end
	
	dmg = d * felt_wounds
	
	if target.getFNP().any?
		target.getFNP().each do |fnp|
			prob = (fnp.to_f - 1.0) / 6.0
			dmg = dmg.to_f * prob
		end
	end


	#Calculate Final Damage
	if dmg >= wounds && weapon.hasRule?(mode, 'Overflow') == false
		dmg = wounds
	end
	
	#logfile.puts "#{weapon.name} in #{mode} mode would do #{dmg} wounds on average"
	return dmg
	
end

def RollDamage(felt_wounds, attacker, target, weapon, mode,charged,logfile)
	mortals = felt_wounds[3]
	sv = target.stats['Sv']
	fnp = target.getFNP()
	tot_wounds = 0
	if felt_wounds[0] > 0 
		#logfile.puts "Each of #{attacker.name}'s Attacks do #{weapon.getD(mode)} damage"
	end
	if mortals.size > 0
		#logfile.puts "There are also #{mortals} mortal wounds"
	end
	
	if attacker.rules().select{|rule| rule.match(/Impact - Mortal Wounds/)}.length > 0 && charged == true
		rule_array = attacker.rules().select{|rule| rule.match(/Impact - Mortal Wounds/)}[0].split(' - ')
		#logfile.puts "#{attacker.name} does #{rule_array[2]} additional mortal wounds on a #{rule_array[3]} when charging"
		impact_rolls = Array.new(RollDice(rule_array[2])) {rand(1..6).to_i}
		#logfile.puts "#{attacker.name} rolled #{impact_rolls}"
		impact_rolls.delete_if {|x| x < rule_array[3].to_i}
		#logfile.puts "This caused #{impact_rolls.size} mortal wounds!"
		mortals.push(impact_rolls.size)
	end
	dmg_rolls = Array.new()
	dmg_rolls = dmg_rolls + mortals
	
	if attacker.rules().select{|rule| rule.match(/Rend - Damage/)}.length > 0 && charged == true
		rule_array = attacker.rules().select{|rule| rule.match(/Rend - Damage/)}[0].split(' - ')
		#logfile.puts "#{attacker.name} does #{rule_array[2]} damage for each of their #{felt_wounds[1]} unsaved wound rolls of six" 
		rend_rolls = Array.new(felt_wounds[1]) {RollDice(rule_array[2])}
		#logfile.puts "This does a total of #{rend_rolls} damage"
		mortals.push(rend_rolls)
	end
		
		
	
	(1..felt_wounds[0]).each do 
		d = (RollDice(weapon.getD(mode)))
		if sv >= 3 && weapon.hasRule?(mode, 'Grav') == true
			d = 2
		end
		if weapon.rules[mode].grep(/Duelist - Damage/).size > 0 && target.hasKeyword('Character') == true
			duel_rule = weapon.rules[mode].grep(/Duelist - Damage/)
			d = RollDice(duel_rule[0].split(' - ')[-1])
		end
		dmg_rolls.push(d)
	end
	
	if (weapon.hasRule?(mode,'Damage - Psyker - 1') or attacker.hasRule?('Damage - Psyker - 1')) && target.hasKeyword('Psyker') == true
		dmg_rolls.map!{ |d| d + 1 }
		#logfile.puts "This weapon does  1 extra damage to psykers giving a total of #{dmg_rolls}"
	end
	if felt_wounds[0] > 0 
		#logfile.puts "#{attacker.name}'s Attacks do #{dmg_rolls} respectively"
	end
	
	
	if target.hasRule?('Damage - Halved') == true && dmg_rolls.size > 0
			dmg_rolls = dmg_rolls.map! { |r| r ? (r.to_f / 2).ceil : r}
		#logfile.puts "#{target.name} halves all damage (rounding up) so he only takes #{dmg_rolls}"
	end
	if (target.rules.grep(/Damage - Reduced - Fight/).size + target.rules.grep(/Damage - Reduced - All/).size) > 0 && dmg_rolls.size > 0
		dmg_rule = target.rules.grep(/Damage - Reduced - Fight/)
		dmg_rule = dmg_rule + target.rules.grep(/Damage - Reduced - All/)
		dmg_rolls.each_index do |n|
			amt_redu = RollDice(dmg_rule[0].split(' - ')[-1])
			if (dmg_rolls[n] - amt_redu) > 0
				dmg_rolls[n] = dmg_rolls[n] - amt_redu
			else
				dmg_rolls[n] = 1
			end
		end
		#logfile.puts "All damage to #{target.name} is reduced by #{dmg_rule[0].split(' - ')[-1]} leaving #{dmg_rolls}"
	end
	
	tot_wounds = dmg_rolls.inject(:+).to_i
	

	wounds = target.stats['W'].to_f

	## Roll FNP
	if target.getFNP().any?	
		target.getFNP().each do |fnp|
			#logfile.puts "#{target.name} has a 'Feel No Pain' ability that lets them ignores wounds on a #{fnp.to_i}+"
			rolls = Array.new(tot_wounds) {rand (1..6)}
			#logfile.puts "#{target.name} rolls #{rolls}"
			rolls.delete_if {|x| x >= fnp}
			
			tot_wounds = rolls.size
		end
		
	end

	
	#Calculate Final Damage
	if tot_wounds >= wounds && weapon.hasRule?(mode, 'Overflow') == false
		tot_wounds = wounds
		#logfile.puts "#{target.name} only has #{wounds} wounds to lose"
	end
	
	
	
	
	
	#logfile.puts "#{target.name} takes #{tot_wounds} wounds"
	
	tot_wounds
	return tot_wounds
	
end

def RollMeleeWeapon(attacker,target,weapon,mode,charged,logfile)
	hits = RollHits(attacker,target,weapon,mode,charged,logfile)
	wounds = RollWounds(hits,attacker,target,weapon,mode,charged,logfile)
	#logfile.puts "#{attacker.name} got #{wounds[0]} wounds"
	saves = RollSaves(wounds, attacker, target, weapon, mode,charged,logfile)
	#logfile.puts "#{target.name} failed #{saves[0]} saves"
	dmg = RollDamage(saves, attacker, target, weapon, mode,charged,logfile)
	return dmg
end

def OptMeleeWeapon(attacker,target,logfile)
	average = 0.0
	weapon = ''
	#logfile.puts "Calculating  #{attacker.name}'s optimal weapon and weapon mode when fighting #{target.name}"
	firetype = ''
	num_melee = 0
	attacker.gear.each do |gear|
		gear.getFiretypes.each do |mode|
			if gear.getType(mode) == 'Melee'
				num_melee = num_melee + 1
			end
		end
	end
	
	if num_melee == 0
		gen_wep_hash = LoadWeapons('Methods\genericwep.csv')
		attacker.addGear(gen_wep_hash, ['Close Combat Weapon'])
		#logfile.puts "#{attacker.name} has no melee weapons so we added a Close Combat Weapon"
	end
	
	if num_melee == 1
		attacker.gear.each do |gear|
			gear.getFiretypes.each do |mode|
				unless gear.getType(mode) == 'Melee'
					next
				end
				weapon = gear
				firetype = mode
				#logfile.puts "#{attacker.name} only has one melee weapon with one attack mode so they will use #{weapon.name} in #{mode} mode "
			end
		end
	else
		attacker.gear.each do |gear|
			gear.getFiretypes.each do |mode|
				unless gear.getType(mode) == 'Melee'
					next
				end
				hits = CalcHits(attacker,target,gear,mode,logfile)
				wounds = CalcWounds(hits,attacker,target,gear,mode,logfile)
				fail_saves = CalcSaves(wounds,attacker,target,gear,mode,logfile)
				damage = CalcDamage(fail_saves,attacker,target,gear,mode,logfile)
				if damage > average
					average = damage
					weapon = gear
					firetype = mode
				end
			end
		end
		#logfile.puts "The Optimal Weapon for #{attacker.name} is #{weapon.name} in #{firetype} mode"
	end
	return [weapon, firetype]
end		