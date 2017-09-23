require_relative '..\Classes\Model.rb'
require_relative '..\Classes\Unit.rb'
require_relative '..\Classes\Weapon.rb'
require_relative 'Dice.rb'



def CalcHits(attacker,defender,weapon,mode)
	attacks = CalcDiceAvg(attacker.getA).to_f
	ws = attacker.getWS
	shots = CalcDiceAvg(weapon.getShots(mode)).to_f
	attacks = attacks + shots
	#puts "#{attacker.getName} has #{attacks} attacks, and gets #{shots} bonus attacks from his weapon 
	#{weapon.getID} in #{mode}, mode."
	
	if attacker.hasRule('Duelist - Attacks - 1')
		attacks = attacks + 1.0
		
	end
	
	modifier = 1.0
	
	if weapon.hasRule(mode,'Unwieldy')
		modifier = modifier - 1.0
		#puts "#{attacker.getName}'s #{weapon.getID} is unwieldy so he has a -1 to hit"
	end
	
	prob = (6.0 - (ws - modifier)) / 6.0
	
	
	if weapon.hasRule(mode, 'Reroll - Hits - All') or attacker.hasRule('Reroll - All - Hits - All') or attacker.hasRule('Reroll - Fight - Hits - All')
		prob = prob + ((1 - prob) * prob)
		#puts "#{attacker.getName} gets to reroll all their misses"
	elsif (attacker.hasRule('Duelist - Hits') or attacker.hasRule('Duelist - Hits - All')) && defender.hasKeyword('Character')
		prob = prob + ((1 - prob) * prob)
		#puts "#{attacker.getName} gets to reroll all their misses"
	elsif weapon.hasRule(mode, 'Reroll - Hits - 1') or attacker.hasRule('Reroll - All - Hits - 1') or attacker.hasRule('Reroll - Fight - Hits - 1')
		prob = prob +((1 / 6) * prob)
		#puts "#{attacker.getName} gets to reroll all their 1's"
	end
	#puts "With a WS of #{ws} and a modifier of #{modifier - 1} #{attacker.getName} has a #{prob} chance of hitting"
	hits = prob * attacks
	#puts "He gets #{hits} hits"
	return hits
end

def RollHits(attacker,defender,weapon,mode, charged)
	attacks = RollDice(attacker.getA).to_i
	to_hit = attacker.getWS.to_i
	shots = RollDice(weapon.getShots(mode)).to_i
	attacks = attacks + shots
	hits = 0
	#puts "#{attacker.getName} has #{attacks} attacks, and gets #{shots} bonus attacks from his weapon" 
	
	if attacker.hasRule('Duelist - Attacks - 1') && defender.hasKeyword('Character')
		attacks = attacks + 1
		"#{attacker.getName} gets one bonus attack because he is fighting a character"
	end
	
	# Roll the Dice
	rolls = Array.new(attacks) {rand(1...6)}
	#puts "#{attacker.getName}'s rolls to hit are #{rolls} "
	# Reroll failed hits
	if weapon.hasRule(mode, 'Reroll - Hits - All') or attacker.hasRule('Reroll - All - Hits - All') or attacker.hasRule('Reroll - Fight - Hits - All')
		rolls.each do |n|
			if to_hit >= n
				n = rand(1...6)
			end
		end
		#puts "#{attacker.getName} gets to reroll all their misses and now rolled #{rolls}"
	elsif (attacker.hasRule('Duelist - Hits') or attacker.hasRule('Duelist - Hits - All')) && defender.hasKeyword('Character')
		rolls.each do |n|
			if to_hit >= n
				n = rand(1...6)
			end
		end
		#puts "#{attacker.getName} gets to reroll all their misses and now rolled #{rolls}"
	elsif weapon.hasRule(mode, 'Reroll - Hits - 1') or attacker.hasRule('Reroll - All - Hits - 1') or attacker.hasRule('Reroll - Fight - Hits - 1')
		rolls.each do |n|
			if n == 1
				n = rand(1..6)
			end
		end
		#puts "#{attacker.getName} gets to reroll all their 1's and now rolled #{rolls}"
	end
	
	
	## Remove all Natural 1s
	rolls.delete_if {|x| x == 1}
	#puts "All ones fail and are removed leaving #{rolls}"
	# Apply modifiers
	if weapon.hasRule(mode,'Unwieldy')
		rolls.each do |n|
			n = n - 1
		end
	end
	#puts "after modifiers the results are #{rolls}"
	#puts "#{attacker.getName} needs #{to_hit} to hit"
	rolls.delete_if {|x| x < to_hit}

	return rolls.size
end


def CalcWounds(hits,attacker,target,weapon,mode)
	user_str = CalcDiceAvg(attacker.getS).to_f
	tough = CalcDiceAvg(target.getT).to_f
	
	str = 0.0
	if weapon.getS(mode)[0] == '+'
		str = user_str + CalcDiceAvg(weapon.getS(mode)[1..-1]).to_f
	elsif weapon.getS(mode)[0]
		#puts weapon.getS(mode)[1]
		str = user_str * weapon.getS(mode)[1].to_i
	else
		#puts "Don't know what to do with weapon strength of #{weapon.getS(mode)[0]}"
		abort
	end

	tough = target.getT.to_f
	
	if attacker.hasRule('Duelist - Strength - 1')
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
	if weapon.getS(mode)[0] = '+'
		wep_str = RollDice(weapon.getS(mode)[1..-1]).to_i
		str = user_str + wep_str
		#puts "#{attacker.getName} has a strength of #{user_str} and his weapon adds #{wep_str}, for a total of #{str}"
	elsif weapon.getS(mode)[0]
		str = user_str * weapon.getS(mode)[1]
		#puts "#{attacker.getName} has a strength of #{user_str} and his weapon multiplys his strength by  #{ weapon.getS(mode)[1]}, for a total of #{str}"
	else
		#puts "Don't know what to do with weapon strength of #{weapon.getS(mode)[0]}"
		abort
	end
	
	tough = target.getT.to_i
	
	wounds = 0
	if attacker.hasRule('Duelist - Strength - 1') or attacker.hasRule('Charge - Strength - 1')
		str = str + 1
	end
	rolls = Array.new(hits[0]) {rand(1...6)}
	
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
	
	#puts "#{target.getName} has a toughness of #{tough} so #{attacker.getName} needs #{to_wound}'s to wound"
	rolls = Array.new(hits) {rand(1...6)}
	#puts  "#{attacker.getName} rolled #{rolls}"
	if weapon.hasRule(mode, 'Reroll - Wounds - All') or attacker.hasRule('Reroll - All - Wounds - All') or attacker.hasRule('Reroll - Fight - Wounds - All')
		rolls.each do |n|
			if to_wound <= n
				n = rand(1...6)
			end
		end
		#puts "#{attacker.getName} gets to reroll all failed wounds so now they have #{rolls}"
	elsif weapon.hasRule(mode, 'Reroll - Wounds - 1') or attacker.hasRule('Reroll - All - Wounds - 1') or attacker.hasRule('Reroll - Fight - Wounds - 1')
		rolls.each do |n|
			if n == 1
				n = rand(1...6)
			end
		end
		#puts "#{attacker.getName} gets to reroll 1's so now they have #{rolls}"
	end
	
	
	rolls.each do |n|
		if n >= to_wound
			wounds = wounds + 1
		end
	end
	return wounds
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
	
	
	mod_save = save - ap 
	#puts "#{target.getName} has a save of #{save}+, but #{attacker.getName}'s #{weapon.getID} has an AP of #{ap} so the modified save is #{mod_save}+"
	
	
	if mod_save > invuln
		mod_save = invuln
		#puts "#{target.getName}'s Invulnerable save of #{invuln}+ is higher so he will use that instead"
	end
	rolls = Array.new(wounds) {rand(1...6)}
	#puts "#{target.getName} rolls #{rolls}"
	
	rolls.delete_if {|x| x >= mod_save}
	return rolls.size
	
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
	if felt_wounds == 0
		return 0.0
	end
	sv = target.getSv()
	fnp = target.getFNP()
	tot_wounds = 0
	## Roll a damage dice for each wound
	#puts "Each of #{attacker.getName} Attacks do #{weapon.getD(firetype)} damage"
	(1..felt_wounds).each do 
		d = RollDice(weapon.getD(firetype))
		if sv >= 3 && weapon.hasRule(firetype, 'Grav')
			d = 2
		end
		if target.hasRule('Damage - Halved') == true
			d = (d.to_f / 2.0).round
			#puts "#{target.getName} halves all damage"
		end
		tot_wounds = tot_wounds + d
	end
	#puts "#{target.getName} takes #{tot_wounds} wounds"

	wounds = target.getW.to_f

	## Roll FNP
	if target.getFNP().any?
		#puts "#{target.name} has a Feel no Pain variant"
		
		target.getFNP().each do |fnp|
			#puts "#{target.name} ignores wounds on a #{fnp}+"
			rolls = Array.new(tot_wounds) {rand (1..6)}
			#puts "#{target.name} rolles #{rolls}"
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
	#puts "#{attacker.getName} got #{hits} hits"
	wounds = RollWounds(hits,attacker,target,weapon,mode,charged)
	#puts "#{attacker.getName} got #{wounds} wounds"
	saves = RollSaves(wounds, attacker, target, weapon, mode,charged)
	#puts "#{target.getName} failed #{saves} saves"
	dmg = RollDamage(saves, attacker, target, weapon, mode,charged)
	#puts "#{target.getName} took #{dmg} damage"
	return dmg
end

def OptMeleeWeapon(attacker,target)
	average = 0.0
	weapon = ''
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
	##puts "#The Optimal Weapon for #{attacker.getName} is #{weapon.getID}"
	return [weapon, firetype]
end		