require_relative '..\Classes\Model.rb'
require_relative '..\Classes\Unit.rb'
require_relative '..\Classes\Weapon2.rb'
require_relative 'Dice.rb'

def RollShootingHits(charger,shooter,wep,mode,range,moved,logfile)
	## First things first, just check if we are out of range
	wep_range = wep.getRange(mode)
	if wep_range < range
		return 0.0
	end
	mortals = 0
	hits = 0
	to_hit = shooter.getBS.to_i
	shots = RollDice(wep.getShots(mode))
	
	
	logfile.puts "#{wep.getID} fires #{shots} shots"
	
	## Check if in rapid fire range and fire double shots
	if (wep_range / 2) >= range && wep.getType(mode) == 'Rapid Fire'
		shots = shots * 2
		logfile.puts "The firing range of #{range} is less than half of #{wep.getID}'s range of #{range} so it fires double the shots for a total of #{shots}"
	end
	
	if model.hasRule('Fire Twice - Stationary') == true && moved == false
		logfile.puts "#{shooter.getName} can shoot twice if they don't move, we will just double the shots instead of rolling twice"
		shots = shots * 2
	end
	
	if wep.hasRule(mode,'Autohit') == true
		hits = shots
		logfile.puts "#{weapon.getID}'s shots hit automatically for a total of #{hits} hits"
		return [shots,0,0,0,0]
	end

	
	## RollDice for the shots
	rolls = Array.new(shots) {rand(1..6)}
	logfile.puts "#{shooter.getName} rolls #{rolls}"
	### Reroll Shooting
	puts shooter.getRules().grep(/Reroll/)
	
	if (shooter.getRules().grep(/Reroll/).size + wep.getRules(mode).grep(/Reroll/).size) > 0 && rolls.count{ |n| n < to_hit} > 0
		rolls = RerollShootingHits(shooter, charger, wep, mode, rolls, to_hit, logfile)
	end
	
	### Check Special Rules from firer that modify ability to hit
	if moved && weapon.getType(firetype) == 'Heavy' && model.hasRule('Move and Fire') == false
		logfile.puts "#{weapon.getID} is heavy and so takes a -1 penalty for moving and firing"
		modifier = modifier + 1
	end
	if target.hasRule('Hard to Hit - Shooting')
		logfile.puts "Attacks targetting #{target.getName} take a -1 penalty to hit"
		modifier = modifier + 1
	end
	if model.hasRule('AA - 1') && target.hasRule('Fly')
		logfile.puts "#{weapon.getName} gets +1 to hit when targetting models with the 'Fly' rule"
		modifier = modifier - 1
	end
	if model.hasRule('Anti-Ground') && target.hasRule('Fly') == false
		logfile.puts "#{weapon.getName} gets +1 to hit when targetting models withput the 'Fly' rule"
		modifier = modifier - 1
	end
	if weapon.hasRule(firetype, 'AA Only') && target.hasRule('Fly')
		modifier = modifier - 1
		logfile.puts "#{weapon.getName} takes a -1 penalty to hit when targetting models with the 'Fly' rule"
	elsif weapon.hasRule(firetype, 'AA Only') && target.hasRule('Fly') == false
		logfile.puts "#{weapon.getName} gets +1 to hit when targetting models with the 'Fly' rule"
		modifier = modifier + 1
	end
	
	logfile
	hits = rolls.count{|x| x >= to_hit }
	
	#Weapons with the autohit rule just hit automatically
	
	logfile.puts "#{shooter.getName} needs #{to_hit} to hit, for a total of #{hits} hits"
	
	
	##Count sixes and fives in case other rules use them, eventually add possibility of self wounding with plasma
	sixes = rolls.count(6)
	fives = rolls.count(5)
	self_wounds = 0
	return hits, sixes, fives, mortals, self_wounds
end

def RollShootingWounds(hits,target,shooter,weapon,mode,range,logfile)
	if weapon.getRange(mode) < range
		return 0.0
	end
	### hits that is passed to function is an array that contains [#of hits,#of sixes rolled,#of 5's rolled,#ofmortal wounds,#of self wounds]
	str = RollDice(weapon.getS(mode))
	tough = target.getT.to_i
	wounds = 0
	mortals = hits[3]
	self_wounds = hits[4]
	hits = hits[0]
	user_str = 0
	combined_rules = shooter.getRules() + weapon.getRules(mode)
	
	if (combined_rules.grep(/Rend - Shooting - Autohit/).size > 0 ) && hits[1] > 0 
		logfile.puts "#{shooter.getName} generates an extra hit for every six they rolled, and they rolled #{hits[1]} sixes"
		hits = hits + hits[1]
	end
	
	###adjust strength based on weapon
	if weapon.getS(mode)[0] == '*'
		str_mult = RollDice(weapon.getS(mode)[1..-1]).to_i
		user_str = shooter.getS
		str = user_str * str_mult
		logfile.puts "#{shooter.getName} has a strength of #{user_str} and his weapon multiples his strength by  #{ weapon.getS(mode)[1]} for a total of #{str}"
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
	
	logfile.puts "#{target.getName} has #{tough} toughness, and #{weapon.getID} has #{str} strenghth, so it wounds on #{to_wound}'s"
	
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
		logfile.puts "However, #{shooter.getName} always wounds on #{to_wound} unless targetting vehicles"
	end
	
	rolls = Array.new(hits) {rand(1..6)}
	logfile.puts  "#{shooter.getName} rolled #{rolls}"
	if combined_rules.grep(/Rerolls/).size > 0 && rolls.count{ |n| n < to_wound} > 0
		rolls = RerollShootingWounds(shooter, target, weapon, mode, rolls, to_wound, logfile)
	end
	

	##### Handle Mortal Wounds caused by rolling 6's
	

	sixes = rolls.count(6)
	
	if weapon.getRules(mode).select{|rule| rule.match(/Rend - Shooting - Mortal Wounds/)}.length > 0 && sixes > 0
		rule_array = weapon.getRules(mode).select{|rule| rule.match(/Rend - Shooting - Mortal Wounds/)}[0].split(' - ')
		
		if sixes >= 1
			logfile.puts "#{rolls}"
			logfile.puts "#{shooter.getName} rolled #{sixes} 6's each of which does #{rule_array[-1]} mortal wounds"
			mortal_array = Array.new()
			(1..sixes).each do
				bonus = RollDice(rule_array[-1])
				mortal_array.push(bonus)
			end
			logfile.puts "This causes #{mortal_array} mortal wounds"
			mortals = mortals + mortal_array
		end
		if rule_array.include? 'Replace'
			rolls.delete_if {|x| x == 6}
			logfile.puts "Sixes that cause mortal wounds are removed leaving #{rolls}"
		end
	end
	
	if shooter.getRules().select{|rule| rule.match(/Rend - Shooting - Mortal Wounds/)}.length > 0 && sixes > 0
		rule_array = shooter.getRules().select{|rule| rule.match(/Rend - Shooting - Mortal Wounds/)}[0].split(' - ')
		if sixes >= 1
			logfile.puts "#{shooter.getName} rolled #{sixes} 6's each of which does #{rule_array[-1]} mortal wounds"
			(1..sixes).each do
				bonus = RollDice(rule_array[-1])
				mortal_array.push(bonus)
			end
			logfile.puts "This causes #{mortal_array} mortal wounds"
			mortals = mortals + mortal_array
		end
		if rule_array.include? 'Replace'
			rolls.delete_if {|x| x == 6}
			logfile.puts "Sixes that cause mortal wounds are removed leaving #{rolls}"
		end
	end
	
	
	### prepare array to return
	sixes = rolls.count(6)
	fives = rolls.count(5)
	wounds = rolls.count {|x| x >= to_wound}
	logfile.puts "#{weapon.getID} caused #{wounds} wounds"
	wounds_6s_5s = [wounds,sixes,fives,mortals,self_wounds]
	return wounds_6s_5s
end


def RollShootingSaves(wounds, target, shooter, weapon, mode, range, logfile)
	if weapon.getRange(mode) < range
		return 0.0
	end
	ap = RollDice(weapon.getAP(mode)).to_i
	save = target.getSv.to_i
	invuln = target.getInvuln.to_i
	mortals = wounds[3]
	self_wound = wounds[4]
	norm_saves = wounds[0]
	fives = 0
	rends = 0
	
	mod_save = save - ap 
	logfile.puts "#{target.getName} has a save of #{save}+, but #{weapon.getID} has an AP of #{ap} so the modified save is #{mod_save}+"
	
	if mod_save > invuln
		mod_save = invuln
		logfile.puts "#{target.getName}'s Invulnerable save of #{invuln}+ is higher so he will use that instead"
	end
	
	
	if shooter.getRules().select{|rule| rule.match(/Rend - Shooting - Damage/)}.length > 0 
		rule_array = shooter.getRules().select{|rule| rule.match(/Rend - Shooting - Damage/)}[0].split(' - ')
		logfile.puts "#{shooter.getName}rolled #{wounds[1]} 6's to wound, these do extra damage and will be saved seperately"
		norm_saves = norm_saves - wounds[1]
		rend_rolls = Array.new(wounds[1]) {rand(1..6)}
		logfile.puts "#{target.getName} rolls #{rend_rolls}"
		rend_rolls.delete_if {|x| x >= mod_save}
		rends = rend_roll.size
		logfile.puts "#{target.getName} failed  #{rends} rolls that do extra damage"
	end
	
	if weapon.getRules(mode).select{|rule| rule.match(/Rend - Shooting - Damage/)}.length > 0
		rule_array = weapon.getRules(mode).select{|rule| rule.match(/Rend - Shooting - Damage/)}[0].split(' - ')
		logfile.puts "#{shooter.getName} rolled #{wounds[1]} 6's to wound, these do extra damage and will be saved seperately"
		norm_saves = norm_saves - wounds[1]
		rend_rolls = Array.new(wounds[1]) {rand(1..6)}
		logfile.puts "#{target.getName} rolls #{rend_rolls}"
		rend_rolls.delete_if {|x| x >= mod_save}
		rends = rend_rolls.size
		logfile.puts "#{target.getName} failed  #{rends} rolls that do extra damage"
	end
	
	
	
	rolls = Array.new(norm_saves) {rand(1..6)}
	fails = rolls.count {|x| x < mod_save}
	logfile.puts "#{target.getName} rolls #{rolls}, resulting in #{fails} failed saves"
	
	
	
	failed_6s_5s = [fails,rends,fives,mortals,self_wound]
	return failed_6s_5s
	
end


def RollShootingDamage(felt_wounds, target, shooter, weapon, mode,range,logfile)
	if weapon.getRange(mode) < range
		return 0.0
	end
	mortals = felt_wounds[3]
	sv = target.getSv()
	fnp = target.getFNP()
	tot_wounds = 0
	if felt_wounds[0] > 0 
		logfile.puts "Each of #{weapon.getID}'s attacks do #{weapon.getD(mode)} damage"
	end
	if mortals.size > 0
		logfile.puts "There are also #{mortals} mortal wounds"
	end
	

	dmg_rolls = Array.new()
	
	if shooter.getRules().select{|rule| rule.match(/Rend - Shooting - Damage/)}.length > 0 
		rule_array = shooter.getRules().select{|rule| rule.match(/Rend - Shooting - Damage/)}[0].split(' - ')
		logfile.puts "#{shooter.getName} does #{rule_array[2]} damage for each of their #{felt_wounds[1]} unsaved wound rolls of six" 
		rend_rolls = Array.new(felt_wounds[1]) {RollDice(rule_array[2])}
		logfile.puts "This does a total of #{rend_rolls} damage"
		mortals.push(rend_rolls)
	end
		
		
	
	(1..felt_wounds[0]).each do 
		d = (RollDice(weapon.getD(mode)))
		if weapon.getRules(mode).grep(/Duelist - Shooting - Damage/).size > 0 && target.hasKeyword('Character') == true
			duel_rule = weapon.getRules(mode).grep(/Duelist - Shooting - Damage/)
			d = RollDice(duel_rule[0].split(' - ')[-1])
		end
		dmg_rolls.push(d)
	end
	
	if (weapon.hasRule(mode,'Damage - Psyker - 1') or shooter.hasRule('Damage - Psyker - 1')) && target.hasKeyword('Psyker') == true
		dmg_rolls.map!{ |d| d + 1 }
		logfile.puts "This weapon does  1 extra damage to psykers giving a total of #{dmg_rolls}"
	end
	
	if felt_wounds[0] > 0 
		logfile.puts "#{shooter.getName}'s Attacks do #{dmg_rolls} respectively"
	end
	
	
	if target.hasRule('Damage - Halved') == true && dmg_rolls.size > 0
			dmg_rolls = dmg_rolls.map! { |r| r ? (r.to_f / 2).ceil : r}
		logfile.puts "#{target.getName} halves all damage (rounding up) so he only takes #{dmg_rolls}"
	end
	
	if (target.getRules.grep(/Damage - Reduced - Shooting/).size + target.getRules.grep(/Damage - Reduced - All/).size) > 0 && dmg_rolls.size > 0
		dmg_rule = target.getRules.grep(/Damage - Reduced - Shooting/)
		dmg_rule = dmg_rule + target.getRules.grep(/Damage - Reduced - All/)
		dmg_rolls.each_index do |n|
			amt_redu = RollDice(dmg_rule[0].split(' - ')[-1])
			if (dmg_rolls[n] - amt_redu) > 0
				dmg_rolls[n] = dmg_rolls[n] - amt_redu
			else
				dmg_rolls[n] = 1
			end
		end
		logfile.puts "All damage to #{target.getName} is reduced by #{dmg_rule[0].split(' - ')[-1]} leaving #{dmg_rolls}"
	end
	
	tot_wounds = dmg_rolls.inject(:+).to_i
	wounds = target.getW.to_f

	## Roll FNP
	if target.getFNP().any?	
		target.getFNP().each do |fnp|
			logfile.puts "#{target.getName} has a 'Feel No Pain' ability that lets them ignores wounds on a #{fnp.to_i}+"
			rolls = Array.new(tot_wounds) {rand (1..6)}
			logfile.puts "#{target.getName} rolls #{rolls}"
			rolls.delete_if {|x| x >= fnp}
			
			tot_wounds = rolls.size
		end
		
	end

	
	
	logfile.puts "#{target.getName} takes #{tot_wounds} wounds"
	
	tot_wounds
	return tot_wounds
	
end
