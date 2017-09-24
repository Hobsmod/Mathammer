require_relative '..\Classes\Model.rb'
require_relative '..\Classes\Unit.rb'
require_relative '..\Classes\Weapon2.rb'
require_relative 'Dice.rb'



def CalcHits(attacker,defender,weapon,mode)
	attacks = CalcDiceAvg(attacker.getA).to_f
	ws = attacker.getWS
	shots = CalcDiceAvg(weapon.getShots(mode)).to_f
	attacks = attacks + shots
	puts "#{attacker.getName} has #{attacks} attacks, and gets #{shots} bonus attacks from his weapon #{weapon.getID} in #{mode} mode."
	

	if attacker.getRules.select{|s| s.match('Duelist - Hits')}.length > 0 && target.hasKeyword('Character')
		attacks = attacks + 1.0
	end
	
	
	
	modifier = 1.0
	
	if weapon.hasRule(mode,'Unwieldy')
		modifier = modifier - 1.0
		puts "#{attacker.getName}'s #{weapon.getID} is unwieldy so he has a -1 to hit"
	end
	
	prob = (6.0 - (ws - modifier)) / 6.0
	
	
	if weapon.hasRule(mode, 'Reroll - Hits - All') or attacker.hasRule('Reroll - All - Hits - All') or attacker.hasRule('Reroll - Fight - Hits - All')
		prob = prob + ((1 - prob) * prob)
		puts "#{attacker.getName} gets to reroll all their misses"
	elsif (attacker.hasRule('Duelist - Hits') or attacker.hasRule('Duelist - Hits - All')) && defender.hasKeyword('Character')
		prob = prob + ((1 - prob) * prob)
		puts "#{attacker.getName} gets to reroll all their misses"
	elsif weapon.hasRule(mode, 'Reroll - Hits - 1') or attacker.hasRule('Reroll - All - Hits - 1') or attacker.hasRule('Reroll - Fight - Hits - 1')
		prob = prob +((1 / 6) * prob)
		puts "#{attacker.getName} gets to reroll all their 1's"
	end
	puts "With a WS of #{ws} and a modifier of #{modifier - 1} #{attacker.getName} has a #{prob} chance of hitting"
	hits = prob * attacks
	puts "He gets #{hits} hits"

	return hits
end

def RollHits(attacker,defender,weapon,mode, charged)

	attacks = RollDice(attacker.getA).to_i
	
	to_hit = attacker.getWS.to_i
	shots = RollDice(weapon.getShots(mode)).to_i
	attacks = attacks + shots
	hits = 0
	mortals = 0
	self_wounds = 0
	puts "#{attacker.getName} has #{attacks} attacks, and gets #{shots} bonus attacks from his weapon" 
	
	if attacker.hasRule('Duelist - Attacks - 1') && defender.hasKeyword('Character')
		attacks = attacks + 1
		"#{attacker.getName} gets one bonus attack because he is fighting a character"
	end
	
	if weapon.getRules(mode).select{|rule| rule.match(/Charge - Attacks/)}.length > 0 && charged == true 
		rule_array = weapon.getRules(mode).select{|rule| rule.match(/Charge - Attacks/)}[0].split(' - ')

		bonus = RollDice(rule_array[-1])
		attacks = attacks + bonus
		puts "#{attacker.getName}'s weapon gives him #{bonus} additional attacks when charging"	
	end
	
	if attacker.getRules().select{|rule| rule.match(/Charge - Attacks/)}.length > 0 && charged == true 
		rule_array = weapon.getRules(mode).select{|rule| rule.match(/Charge - Attacks/)}[0].split(' - ')

		bonus = RollDice(rule_array[-1])
		attacks = attacks + bonus
		puts "#{attacker.getName}'s abilities gives him #{bonus} additional attacks when charging"	
	end
	
	# Roll the Dice
	rolls = Array.new(attacks) {rand(1..6)}
	rerolls = Array.new()
	puts "#{attacker.getName}'s rolls to hit are #{rolls} "
	# Reroll failed hits
	if weapon.hasRule(mode, 'Reroll - Hits - All') or attacker.hasRule('Reroll - All - Hits - All') or attacker.hasRule('Reroll - Fight - Hits - All')
		rolls.each do |n|
			if to_hit > n
				n = rand(1..6)
				rerolls.push(n)
			else 
				rerolls.push(n)
			end
		end
		puts "#{attacker.getName} gets to reroll all their misses and now rolled #{rerolls}"
	elsif attacker.hasRule('Duelist - Reroll - Hits') && defender.hasKeyword('Character')
		rolls.each do |n|
			if to_hit > n
				n = rand(1..6)
				rerolls.push(n)
			else 
				rerolls.push(n)
			end
		end
		puts "#{attacker.getName} gets to reroll all their misses and now rolled #{rerolls}"
	elsif weapon.hasRule(mode, 'Reroll - Hits - 1') or attacker.hasRule('Reroll - All - Hits - 1') or attacker.hasRule('Reroll - Fight - Hits - 1')
		rolls.each do |n|
			if to_hit > n
				n = rand(1..6)
				rerolls.push(n)
			else 
				rerolls.push(n)
			end
		end
		puts "#{attacker.getName} gets to reroll all their 1's and now rolled #{rolls}"
	else 
		rerolls = rolls
	end
	
	sixes = rolls.count(6)
	
	
	if (weapon.hasRule(mode, 'Rend - Fight - Extra Attack') or attacker.hasRule('Rend - Fight - Extra Attack') == true) && sixes > 0 
		puts "#{attacker.getName} generates an additional attack for every natural six, they rolled #{rolls} giving them #{sixes} more attack"
		extra_rolls = Array.new(sixes) {rand(1..6)}
		extra_rerolls = Array.new()
		puts "Those extra attacks rolled #{extra_rolls}"
		if weapon.hasRule(mode, 'Reroll - Hits - All') or attacker.hasRule('Reroll - All - Hits - All') or attacker.hasRule('Reroll - Fight - Hits - All')
			extra_rolls.each do |n|
				if to_hit > n
					n = rand(1..6)
					rerolls.push(n)
				else
					extra_rerolls.push(n)
				end
				
			end
			puts "#{attacker.getName} gets to reroll misses even for extra attacks leaving #{extra_rerolls}"
		elsif attacker.hasRule('Duelist - Reroll - Hits') && defender.hasKeyword('Character')
			extra_rolls.each do |n|
				if to_hit > n
					n = rand(1..6)
					rerolls.push(n)
				else
					extra_rerolls.push(n)
				end
				
			end
		puts "#{attacker.getName} gets to reroll misses even for extra attacks leaving #{extra_rerolls}"
		elsif weapon.hasRule(mode, 'Reroll - Hits - 1') or attacker.hasRule('Reroll - All - Hits - 1') or attacker.hasRule('Reroll - Fight - Hits - 1')
			extra_rolls.each do |n|
				if n == 1
					n = rand(1..6)
					rerolls.push(n)
				else
				extra_rerolls.push(n)
				end
			end
			puts "#{attacker.getName} gets to reroll all their 1's, even for extra attacks, and now rolled #{extra_rerolls}"
		end
		extra_rerolls.each do |r|
			rerolls.push(r)
		end
		puts "Extra rolls and main rolls are now merged to give #{rolls}"
	end
	
	## Remove all Natural 1s
	rolls.delete_if {|x| x == 1}
	puts "All ones fail and are removed leaving #{rolls}"
	# Apply modifiers
	sixes = rolls.count(6)
	fives = rolls.count(5)
	if weapon.hasRule(mode,'Unwieldy')
		rolls.each do |n|
			n = n - 1
		end
	end
	
	
	
	
	
	puts "after modifiers the results are #{rolls}"
	puts "#{attacker.getName} needs #{to_hit} to hit"
	rolls.delete_if {|x| x < to_hit}
	hits_6s_5s = [rolls.size,sixes,fives,mortals,self_wounds]
	return hits_6s_5s
end


def CalcWounds(hits,attacker,target,weapon,mode)
	user_str = CalcDiceAvg(attacker.getS).to_f
	tough = CalcDiceAvg(target.getT).to_f
	
	str = 0.0
	if weapon.getS(mode)[0] == '*'
		str = user_str + CalcDiceAvg(weapon.getS(mode)[1..-1]).to_f
	elsif weapon.getS(mode)[0]
		puts weapon.getS(mode)[1]
		str = user_str * weapon.getS(mode)[1].to_i
	else
		puts "Don't know what to do with weapon strength of #{weapon.getS(mode)[0]}"
		abort
	end

	tough = target.getT.to_f
	
	if attacker.hasRule('Duelist - Strength - 1') && target.hasKeyword('Character')
		str = str + 1
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
	
	if weapon.hasRule(mode, 'Reroll - Wounds - All') or attacker.hasRule('Reroll - All - Wounds - All') or attacker.hasRule('Reroll - Fight - Wounds - All')
		prob = prob + ((1 - prob) * prob)
	elsif weapon.hasRule(mode, 'Reroll - Wounds - 1') or attacker.hasRule('Reroll - All - Wounds - 1') or attacker.hasRule('Reroll - Fight - Wounds - 1')
		prob = prob +((1 / 6) * prob)
	end
	wounds = prob * hits
	return wounds
end

def RollWounds(hits,attacker,target,weapon,mode,charged)
	user_str = RollDice(attacker.getS).to_i
	tough = target.getT.to_i
	wounds = 0
	mortals = hits[3]
	self_wounds = hits[4]
	
	# Because of the way order of operations works in warhammer we query each rule to get a 
	# multiplier and an array of modifers to add and then perform the operations in order

	
	str_mult = 1
	str_add = Array.new()
	
	
	###adjust strength based on weapon
	if weapon.getS(mode)[0] == '*'
		if RollDice(weapon.getS(mode)[1..-1]).to_i > str_mult
			str_mult = RollDice(weapon.getS(mode)[1..-1]).to_i
		end
		puts "#{attacker.getName} has a strength of #{user_str} and his weapon multiples his strength by  #{ weapon.getS(mode)[1]}"
	elsif
		bonus = RollDice(weapon.getS(mode)[1..-1]).to_i
		str_add.push(bonus)
		puts "#{attacker.getName}'s increases his strength by  #{bonus}"
	else
		puts "Don't know what to do with weapon strength of #{weapon.getS(mode)[0]}"
		abort
	end

	##### Check for bonuses to strength from fighting a character
	
	if weapon.getRules(mode).select{|rule| rule.match(/Duelist - Strength/)}.length > 0 && target.hasKeyword('Character')
		rule_array = weapon.getRules(mode).select{|rule| rule.match(/Duelist - Strength/)}[0].split(' - ')
		duel_bonus = rule_array[-1]
		puts duel_bonus
		if duel_bonus[0] == '*'
			mult = RollDice(duel_bonus[1..-1])
			if mult > str_mult
				str_mult = mult
			end
			puts "#{attacker.getName} has a strength of #{user_str} and his weapon multiples his strength by  #{ weapon.getS(mode)[1]}"
		elsif duel_bonus
			bonus = RollDice(duel_bonus)
			str_add.push(bonus)
			puts "#{attacker.getName}'s increases his strength by  #{bonus}"
		else
			puts "Don't know what to do with weapon strength of #{weapon.getS(mode)[0]}"
			abort
		end	
	end
	
	
	if attacker.getRules().select{|rule| rule.match(/Duelist - Strength/)}.length > 0 && target.hasKeyword('Character')
		rule_array = attacker.getRules().select{|rule| rule.match(/Duelist - Strength/)}[0].split(' - ')
		duel_bonus = rule_array[-1]
		puts duel_bonus
		if duel_bonus[0] == '*'
			bonus = RollDice(duel_bonus[1..-1])
			if bonus > str_mult
				str_mult = bonus
			end
			puts "#{attacker.getName}'s weapon multiples his strength by  #{bonus}"
		elsif duel_bonus
			bonus = RollDice(duel_bonus)
			str_add.push(bonus)
			puts "#{attacker.getName}'s increases his strength by  #{bonus}"
		else
			puts "Don't know what to do with weapon strength of #{duel_bonus}"
			abort
		end	
	end
	
	##### Check for Bonuses to strength when charging
	
	if weapon.getRules(mode).select{|rule| rule.match(/Charge - Strength/)}.length > 0 && charged == true 
		rule_array = weapon.getRules(mode).select{|rule| rule.match(/Charge - Strength/)}[0].split(' - ')
		charge_bonus = rule_array[-1]
		puts duel_bonus
		if charge_bonus[0] == '*'
			mult = RollDice(charge_bonus[1..-1])
			if mult > str_mult
				str_mult = mult
			end
			puts "#{attacker.getName}'s weapon multiplies his strength when charging by #{charge_bonus}"
		elsif charge_bonus
			bonuse = RollDice(charge_bonus)
			str_add.push(bonus)
			puts "#{attacker.getName}'s weapon adds #{bonus} to his strength when charging"
		else
			puts "Don't know what to do with weapon strength of #{charge_bonus}"
			abort
		end	
	end
	
	if attacker.getRules().select{|rule| rule.match(/Charge - Strength/)}.length > 0 && charged == true 
		rule_array = attacker.getRules().select{|rule| rule.match(/Charge - Strength/)}[0].split(' - ')
		charge_bonus = RollDice(rule_array[-1])
		if charge_bonus[0] == '*'
			mult = RollDice(charge_bonus[1..-1])
			if mult > str_mult
				str_mult = mult
			end
			puts "#{attacker.getName} has an ability that multiplies his strength when charging by #{charge_bonus}"
		elsif charge_bonus
			bonuse = RollDice(charge_bonus)
			str_add.push(bonus)
			puts "#{attacker.getName} has an ability that adds #{bonus} to his strength when charging"
		else
			puts "Don't know what to do with weapon strength of #{charge_bonus}"
			abort
		end	
	end
	
	str = user_str * str_mult.to_i
	puts "#{attacker.getName()} has a strength of #{user_str} which is multiplied by #{str_mult} for a total of #{str}"
	str_add.each do |add|
		str = str + add.to_i
	end
	puts "The following modifiers are added to strength #{str_add} for a final strength of #{str}"
		
	
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
	
	puts "#{target.getName} has a toughness of #{tough} so #{attacker.getName} needs #{to_wound}'s to wound"
	rolls = Array.new(hits[0]) {rand(1..6)}
	puts  "#{attacker.getName} rolled #{rolls}"
	if weapon.hasRule(mode, 'Reroll - Wounds - All') or attacker.hasRule('Reroll - All - Wounds - All') or attacker.hasRule('Reroll - Fight - Wounds - All')
		rolls.each do |n|
			if to_wound <= n
				n = rand(1..6)
			end
		end
		puts "#{attacker.getName} gets to reroll all failed wounds so now they have #{rolls}"
	elsif weapon.hasRule(mode,'Duelist - Reroll - Wounds') == true && target.hasKeyword('Character') == true
		rolls.each do |n|
			if to_wound <= n
				n = rand(1..6)
			end
		end
	elsif weapon.hasRule(mode, 'Reroll - Wounds - 1') or attacker.hasRule('Reroll - All - Wounds - 1') or attacker.hasRule('Reroll - Fight - Wounds - 1')
		rolls.each do |n|
			if n == 1
				n = rand(1..6)
			end
		end
		puts "#{attacker.getName} gets to reroll 1's so now they have #{rolls}"
	end
	

	##### Handle Mortal Wounds caused by rolling 6's
	

	sixes = rolls.count(6)
	
	if weapon.getRules(mode).select{|rule| rule.match(/Rend - Mortal Wounds/)}.length > 0
		rule_array = weapon.getRules(mode).select{|rule| rule.match(/Rend - Mortal Wounds/)}[0].split(' - ')
		
		if sixes >= 1
			puts "#{rolls}"
			puts "#{attacker.getName} rolled #{sixes} 6's each of which does #{rule_array[-1]} mortal wounds"
			(1..sixes).each do
				bonus = RollDice(rule_array[-1])
				mortals = mortals + bonus
			end
		end
		puts "#{sixes} sixes caused #{mortals} mortal wounds"
		if rule_array.include? 'Replace'
			rolls.delete_if {|x| x == 6}
			puts "Sixes that cause mortal wounds are removed leaving #{rolls}"
		end
	end
	
	if attacker.getRules().select{|rule| rule.match(/Rend - Mortal Wounds/)}.length > 0
		rule_array = attacker.getRules().select{|rule| rule.match(/Rend - Mortal Wounds/)}[0].split(' - ')
		if sixes >= 1
			puts "#{attacker.getName} rolled #{sixes} 6's each of which does #{rule_array[-1]} mortal wounds"
			1..sixes.each do
				bonus = RollDice(rule_array[-1])
				mortals = mortals + bonus
			end
		end
		if rule_array.include? 'Replace'
			rolls.delete_if {|x| x == 6}
			puts "Sixes that cause mortal wounds are removed leaving #{rolls}"
		end
	end
	
	### prepare array to return
	sixes = rolls.count(6)
	fives = rolls.count(5)
	rolls.delete_if {|x| x < to_wound}
	wounds_6s_5s = [rolls.size,sixes,fives,mortals,self_wounds]
	return wounds_6s_5s
end




def CalcSaves(wounds, attacker, target, weapon, firetype)
	
	ap = CalcDiceAvg(weapon.getAP(firetype)).to_f
	save = target.getSv.to_f
	invuln = target.getInvuln.to_f
	
	mod_save = save - ap 
	
	if mod_save > invuln
		mod_save = invuln
	end
	if mod_save >= 7.0
		prob = 1.0
		stdev = 0.0
	else
		prob = (mod_save - 1) / 6
	end
	
	
	failed_saves = wounds * prob
	return failed_saves
	
end


def RollSaves(wounds, attacker, target, weapon, firetype,charged)
	ap = RollDice(weapon.getAP(firetype)).to_i
	save = target.getSv.to_i
	invuln = target.getInvuln.to_i
	mortals = wounds[3]
	self_wound = wounds[4]
	
	mod_save = save - ap 
	puts "#{target.getName} has a save of #{save}+, but #{attacker.getName}'s #{weapon.getID} has an AP of #{ap} so the modified save is #{mod_save}+"
	
	
	if mod_save > invuln
		mod_save = invuln
		puts "#{target.getName}'s Invulnerable save of #{invuln}+ is higher so he will use that instead"
	end
	rolls = Array.new(wounds[0]) {rand(1..6)}
	puts "#{target.getName} rolls #{rolls}"
	
	sixes = rolls.count(6)
	fives = rolls.count(5)
	rolls.delete_if {|x| x >= mod_save}
	
	failed_6s_5s = [rolls.size,sixes,fives,mortals,self_wound]

	return failed_6s_5s
	
end

def CalcDamage(felt_wounds, attacker, target, weapon, firetype)
	if felt_wounds == 0
		return 0.0
	end
	sv = target.getSv()
	fnp = target.getFNP()

	d = CalcDiceAvg(weapon.getD(firetype))

	
	
	wounds = target.getW.to_f

	## Increase damage for grav weapons
	if sv >= 3 && weapon.hasRule(firetype, 'Grav')
		d = 2
	end
	dmg = d * felt_wounds
	felt_wounds = felt_wounds * d
	if target.getFNP().any?
		target.getFNP().each do |fnp|
			prob = (fnp - 1) / 6
			dmg = dmg * prob
		end
	end


	#Calculate Final Damage
	if dmg >= wounds && weapon.hasRule(firetype, 'Overflow') == false
		dmg = wounds
	end
	
	
	return dmg
	
end

def RollDamage(felt_wounds, attacker, target, weapon, firetype,charged)
	
	sv = target.getSv()
	fnp = target.getFNP()
	tot_wounds = 0
	## Roll a damage dice for each wound
	puts "Each of #{attacker.getName} Attacks do #{weapon.getD(firetype)} damage"
	dmg_rolls = Array.new()
	(1..felt_wounds[0]).each do 
		d = (RollDice(weapon.getD(firetype)))
		if sv >= 3 && weapon.hasRule(firetype, 'Grav')
			d = 2
		end
		dmg_rolls.push(d)
	end
	
	puts "#{attacker.getName}'s Attacks do #{dmg_rolls} respectively"
	if target.hasRule('Damage - Halved') == true && dmg_rolls.size > 0
			(0..dmg_rolls.size).each do |n|
				dmg_rolls[n] = (dmg_rolls[n].to_i / 2).ceil
			end
		puts "#{target.getName} halves all damage (rounding up) so he only takes #{dmg_rolls}"
	end
	
	tot_wounds = dmg_rolls.inject(:+).to_i
	puts "#{target.getName} takes #{tot_wounds} wounds"

	wounds = target.getW.to_f

	## Roll FNP
	if target.getFNP().any?
		puts "#{target.name} has a Feel no Pain variant"
		
		target.getFNP().each do |fnp|
			puts "#{target.name} ignores wounds on a #{fnp}+"
			rolls = Array.new(tot_wounds) {rand (1..6)}
			puts "#{target.name} rolls #{rolls}"
			rolls.delete_if {|x| x >= fnp}
			
			tot_wounds = rolls.size
		end
		
	end

	
	#Calculate Final Damage
	if tot_wounds >= wounds && weapon.hasRule(firetype, 'Overflow') == false
		tot_wounds = wounds
	end

	return tot_wounds
	
end

def RollMeleeWeapon(attacker,target,weapon,mode,charged)
	hits = RollHits(attacker,target,weapon,mode,charged)
	puts "#{attacker.getName} got #{hits[0]} hits"
	wounds = RollWounds(hits,attacker,target,weapon,mode,charged)
	puts "#{attacker.getName} got #{wounds[0]} wounds"
	saves = RollSaves(wounds, attacker, target, weapon, mode,charged)
	puts "#{target.getName} failed #{saves[0]} saves"
	dmg = RollDamage(saves, attacker, target, weapon, mode,charged)
	return dmg
end

def OptMeleeWeapon(attacker,target)
	average = 0.0
	weapon = ''
	puts "Calculating Average Damage for each of #{attacker.getName}'s weapons when fighting #{target.getName}"
	firetype = ''
	attacker.getGear.each do |gear|
		gear.getFiretypes.each do |mode|
			unless gear.getType(mode) == 'Melee'
				next
			end
			hits = CalcHits(attacker,target,gear,mode)
			wounds = CalcWounds(hits,attacker,target,gear,mode)
			fail_saves = CalcSaves(wounds,attacker,target,gear,mode)
			damage = CalcDamage(fail_saves,attacker,target,gear,mode)
			if damage > average
				average = damage
				weapon = gear
				firetype = mode
			end
		end
	end

	puts "#The Optimal Weapon for #{attacker.getName} is #{weapon.getID}"
	return [weapon, firetype]
end		