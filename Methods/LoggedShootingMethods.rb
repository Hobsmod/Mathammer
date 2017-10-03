require_relative '..\Classes\Model.rb'
require_relative '..\Classes\Unit.rb'
require_relative '..\Classes\Weapon.rb'
require_relative 'Dice.rb'

def RollShootingHits(target,shooter,wep,mode,range,moved,logfile)
	## First things first, just check if we are out of range
	wep_range = wep.getRange(mode)
	if wep_range < range
		return 0.0
	end
	mortals = 0
	hits = 0
	to_hit = shooter.stats['BS'].to_i
	shots = RollDice(wep.getShots(mode))
	self_wounds = 0
	
	logfile.puts "#{wep.name} fires #{shots} shots"
	
	## Check if in rapid fire range and fire double shots
	if (wep_range / 2) >= range && wep.getType(mode) == 'Rapid Fire'
		shots = shots * 2
		logfile.puts "The firing range of #{range} is less than half of #{wep.name}'s range of #{range} so it fires double the shots for a total of #{shots}"
	end
	
	if shooter.hasRule?('Fire Twice - Stationary') == true && moved == false
		logfile.puts "#{shooter.name} can shoot twice if they don't move, we will just double the shots instead of rolling twice"
		shots = shots * 2
	end
	
	if wep.hasRule?(mode,'Autohit') == true
		hits = shots
		logfile.puts "#{wep.name}'s shots hit automatically for a total of #{hits} hits"
		return [shots,0,0,0,0]
	end

	
	## RollDice for the shots
	rolls = Array.new(shots) {rand(1..6)}
	logfile.puts "#{shooter.name} rolls #{rolls}"
	### Reroll Shooting

	
	if (shooter.rules.grep(/Reroll/).size + wep.rules[mode].grep(/Reroll/).size) > 0 && rolls.count{ |n| n < to_hit} > 0
		rolls = RerollShootingHits(shooter, target, wep, mode, rolls, to_hit, logfile)
	end
	
	### Check Special Rules from firer that modify ability to hit
	if moved && wep.getType(mode) == 'Heavy' && shooter.hasRule?('Move and Fire') == false
		logfile.puts "#{wep.name} is heavy and so takes a -1 penalty for moving and firing"
		modifier = modifier + 1
	end
	if target.hasRule?('Hard to Hit - Shooting')
		logfile.puts "Attacks targetting #{target.name} take a -1 penalty to hit"
		modifier = modifier + 1
	end
	if shooter.hasRule?('AA - 1') && target.hasRule?('Fly')
		logfile.puts "#{wep.name} gets +1 to hit when targetting shooters with the 'Fly' rule"
		modifier = modifier - 1
	end
	if shooter.hasRule?('Anti-Ground') && target.hasRule?('Fly') == false
		logfile.puts "#{wep.name} gets +1 to hit when targetting shooters withput the 'Fly' rule"
		modifier = modifier - 1
	end
	if wep.hasRule?(mode, 'AA Only') && target.hasRule?('Fly')
		modifier = modifier - 1
		logfile.puts "#{wep.name} takes a -1 penalty to hit when targetting shooters with the 'Fly' rule"
	elsif wep.hasRule?(mode, 'AA Only') && target.hasRule?('Fly') == false
		logfile.puts "#{wep.name} gets +1 to hit when targetting shooters with the 'Fly' rule"
		modifier = modifier + 1
	end
	
	
	hits = rolls.count{|x| x >= to_hit }
	
	#Weapons with the autohit rule just hit automatically
	
	logfile.puts "#{shooter.name} needs #{to_hit} to hit, for a total of #{hits} hits"
	
	#### Count 1's for plasma overheating
	if wep.hasRule?(mode,'Overheat') && rolls.include?(1)
		self_wounds = shooter.stats['W']
		logfile.puts "#{shooter.name}'s #{wep.name} overheated doing #{self_wounds} wounds to them" 
	end
	
	##Count sixes and fives in case other rules use them, eventually add possibility of self wounding with plasma
	sixes = rolls.count(6)
	fives = rolls.count(5)

	return hits, sixes, fives, mortals, self_wounds
end

def RollShootingWounds(hits,target,shooter,weapon,mode,range,logfile)
	if weapon.getRange(mode) < range
		return 0.0
	end
	### hits that is passed to function is an array that contains [#of hits,#of sixes rolled,#of 5's rolled,#ofmortal wounds,#of self wounds]
	str = RollDice(weapon.getS(mode))
	tough = target.stats['T'].to_i
	wounds = 0
	mortals = hits[3]
	self_wounds = hits[4]
	hits = hits[0]
	user_str = 0
	combined_rules = shooter.rules + weapon.rules[mode]
	
	if (combined_rules.grep(/Rend - Shooting - Autohit/).size > 0 ) && hits[1] > 0 
		logfile.puts "#{shooter.name} generates an extra hit for every six they rolled, and they rolled #{hits[1]} sixes"
		hits = hits + hits[1]
	end
	
	###adjust strength based on weapon
	if weapon.getS(mode)[0] == '*'
		str_mult = RollDice(weapon.getS(mode)[1..-1]).to_i
		user_str = shooter.stats['S']
		str = user_str * str_mult
		logfile.puts "#{shooter.name} has a strength of #{user_str} and his weapon multiples his strength by  #{ weapon.getS(mode)[1]} for a total of #{str}"
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
	
	logfile.puts "#{target.name} has #{tough} toughness, and #{weapon.name} has #{str} strength, so it wounds on #{to_wound}'s"
	
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
		logfile.puts "However, #{shooter.name} always wounds on #{to_wound} unless targetting vehicles"
	end
	
	rolls = Array.new(hits) {rand(1..6)}
	logfile.puts  "#{shooter.name} rolled #{rolls}"
	if combined_rules.grep(/Rerolls/).size > 0 && rolls.count{ |n| n < to_wound} > 0
		rolls = RerollShootingWounds(shooter, target, weapon, mode, rolls, to_wound, logfile)
	end
	

	##### Handle Mortal Wounds caused by rolling 6's
	

	sixes = rolls.count(6)
	
	if weapon.rules[mode].select{|rule| rule.match(/Rend - Shooting - Mortal Wounds/)}.length > 0 && sixes > 0
		rule_array = weapon.rules[mode].select{|rule| rule.match(/Rend - Shooting - Mortal Wounds/)}[0].split(' - ')
		
		if sixes >= 1
			logfile.puts "#{rolls}"
			logfile.puts "#{shooter.name} rolled #{sixes} 6's each of which does #{rule_array[-1]} mortal wounds"
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
	
	if shooter.rules.select{|rule| rule.match(/Rend - Shooting - Mortal Wounds/)}.length > 0 && sixes > 0
		rule_array = shooter.rules.select{|rule| rule.match(/Rend - Shooting - Mortal Wounds/)}[0].split(' - ')
		if sixes >= 1
			logfile.puts "#{shooter.name} rolled #{sixes} 6's each of which does #{rule_array[-1]} mortal wounds"
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
	logfile.puts "#{weapon.name} caused #{wounds} wounds"
	wounds_6s_5s = [wounds,sixes,fives,mortals,self_wounds]
	return wounds_6s_5s
end


def RollShootingSaves(wounds, target, shooter, weapon, mode, range, logfile)
	if weapon.getRange(mode) < range
		return 0.0
	end
	ap = RollDice(weapon.getAP(mode)).to_i
	save = target.stats['Sv'].to_i
	invuln = target.getInvuln.to_i
	mortals = wounds[3]
	self_wound = wounds[4]
	norm_saves = wounds[0]
	fives = 0
	rends = 0
	
	mod_save = save - ap 
	logfile.puts "#{target.name} has a save of #{save}+, but #{weapon.name} has an AP of #{ap} so the modified save is #{mod_save}+"
	
	if mod_save > invuln
		mod_save = invuln
		logfile.puts "#{target.name}'s Invulnerable save of #{invuln}+ is higher so he will use that instead"
	end
	
	
	if shooter.rules.select{|rule| rule.match(/Rend - Shooting - Damage/)}.length > 0 
		rule_array = shooter.getRules().select{|rule| rule.match(/Rend - Shooting - Damage/)}[0].split(' - ')
		logfile.puts "#{shooter.name}rolled #{wounds[1]} 6's to wound, these do extra damage and will be saved seperately"
		norm_saves = norm_saves - wounds[1]
		rend_rolls = Array.new(wounds[1]) {rand(1..6)}
		logfile.puts "#{target.name} rolls #{rend_rolls}"
		rend_rolls.delete_if {|x| x >= mod_save}
		rends = rend_roll.size
		logfile.puts "#{target.name} failed  #{rends} rolls that do extra damage"
	end
	
	if weapon.rules[mode].select{|rule| rule.match(/Rend - Shooting - Damage/)}.length > 0
		rule_array = weapon.rules[mode].select{|rule| rule.match(/Rend - Shooting - Damage/)}[0].split(' - ')
		logfile.puts "#{shooter.name} rolled #{wounds[1]} 6's to wound, these do extra damage and will be saved seperately"
		norm_saves = norm_saves - wounds[1]
		rend_rolls = Array.new(wounds[1]) {rand(1..6)}
		logfile.puts "#{target.name} rolls #{rend_rolls}"
		rend_rolls.delete_if {|x| x >= mod_save}
		rends = rend_rolls.size
		logfile.puts "#{target.name} failed  #{rends} rolls that do extra damage"
	end
	
	
	
	rolls = Array.new(norm_saves) {rand(1..6)}
	fails = rolls.count {|x| x < mod_save}
	logfile.puts "#{target.name} rolls #{rolls}, resulting in #{fails} failed saves"
	
	
	
	failed_6s_5s = [fails,rends,fives,mortals,self_wound]
	return failed_6s_5s
	
end


def RollShootingDamage(felt_wounds, target, shooter, weapon, mode,range,logfile)
	if weapon.getRange(mode) < range
		return 0.0
	end
	mortals = felt_wounds[3]
	self_wounds = felt_wounds[4]
	sv = target.stats['Sv']
	fnp = target.getFNP()
	tot_wounds = 0
	if felt_wounds[0] > 0 
		logfile.puts "Each of #{weapon.name}'s attacks do #{weapon.getD(mode)} damage"
	end
	
	if mortals.size >= 1
		logfile.puts "There are also #{mortals} mortal wounds"
	end
	

	dmg_rolls = Array.new()
	
	if shooter.rules.select{|rule| rule.match(/Rend - Shooting - Damage/)}.length > 0 
		rule_array = shooter.getRules().select{|rule| rule.match(/Rend - Shooting - Damage/)}[0].split(' - ')
		logfile.puts "#{shooter.name} does #{rule_array[2]} damage for each of their #{felt_wounds[1]} unsaved wound rolls of six" 
		rend_rolls = Array.new(felt_wounds[1]) {RollDice(rule_array[2])}
		logfile.puts "This does a total of #{rend_rolls} damage"
		mortals.push(rend_rolls)
	end
		
		
	
	(1..felt_wounds[0]).each do 
		d = (RollDice(weapon.getD(mode)))
		if weapon.rules[mode].grep(/Duelist - Shooting - Damage/).size > 0 && target.hasKeyword('Character') == true
			duel_rule = weapon.rules[mode].grep(/Duelist - Shooting - Damage/)
			d = RollDice(duel_rule[0].split(' - ')[-1])
		end
		dmg_rolls.push(d)
	end
	
	if (weapon.hasRule?(mode,'Damage - Psyker - 1') or shooter.hasRule?('Damage - Psyker - 1')) && target.hasKeyword('Psyker') == true
		dmg_rolls.map!{ |d| d + 1 }
		logfile.puts "This weapon does  1 extra damage to psykers giving a total of #{dmg_rolls}"
	end
	
	if felt_wounds[0] > 0 
		logfile.puts "#{shooter.name}'s Attacks do #{dmg_rolls} respectively"
	end
	
	
	if target.hasRule?('Damage - Halved') == true && dmg_rolls.size > 0
			dmg_rolls = dmg_rolls.map! { |r| r ? (r.to_f / 2).ceil : r}
		logfile.puts "#{target.name} halves all damage (rounding up) so he only takes #{dmg_rolls}"
	end
	
	if (target.rules.grep(/Damage - Reduced - Shooting/).size + target.rules.grep(/Damage - Reduced - All/).size) > 0 && dmg_rolls.size > 0
		dmg_rule = target.rules.grep(/Damage - Reduced - Shooting/)
		dmg_rule = dmg_rule + target.rules.grep(/Damage - Reduced - All/)
		dmg_rolls.each_index do |n|
			amt_redu = RollDice(dmg_rule[0].split(' - ')[-1])
			if (dmg_rolls[n] - amt_redu) > 0
				dmg_rolls[n] = dmg_rolls[n] - amt_redu
			else
				dmg_rolls[n] = 1
			end
		end
		logfile.puts "All damage to #{target.name} is reduced by #{dmg_rule[0].split(' - ')[-1]} leaving #{dmg_rolls}"
	end
	
	tot_wounds = dmg_rolls.inject(:+).to_i
	wounds = target.stats['W'].to_f

	## Roll FNP
	if target.getFNP().any?	
		target.getFNP().each do |fnp|
			logfile.puts "#{target.name} has a 'Feel No Pain' ability that lets them ignores wounds on a #{fnp.to_i}+"
			rolls = Array.new(tot_wounds) {rand (1..6)}
			logfile.puts "#{target.name} rolls #{rolls}"
			rolls.delete_if {|x| x >= fnp}
			
			tot_wounds = rolls.size
		end
		
	end

	
	
	logfile.puts "#{target.name} takes #{tot_wounds} wounds"
	if self_wounds > 0 
		logfile.puts "#{shooter.name} also takes #{self_wounds} self inflicted wounds"
	end
	return tot_wounds, self_wounds
	
end


def CalcShooting(charger,shooter,wep,mode,range,moved,logfile)
		hits = CalcShootingHits(charger,shooter,wep,mode,range,moved, logfile)
		wounds = CalcShootingWounds(hits,shooter, charger,wep,mode,logfile)
		unsaved = CalcShootingSaves(wounds, shooter, charger, wep, mode,logfile)
		dmg = CalcShootingDamage(unsaved, shooter, charger, wep, mode,logfile)
		return dmg
end


def RollWeaponShooting(target,shooter,weapon,mode,range,moved,logfile)
	hits = RollShootingHits(target,shooter,weapon,mode,range,moved,logfile)
	wounds = RollShootingWounds(hits,target,shooter,weapon,mode,range,logfile)
	failed = RollShootingSaves(wounds,target,shooter,weapon,mode, range, logfile)
	damage = RollShootingDamage(failed,target,shooter,weapon,mode,range,logfile)
	return damage
end

def OptimizePistolsCC(shooter, target,logfile)
	
	opt_mode = Hash.new
	logfile.puts "----Calculating the optimal firing mode for each of #{shooter.name}'s pistols---"
	shooter.getPistols.each do |pistol|
		dmg = 0
		profile = 'blank'
		pistol.getFiretypes.each do |mode|
			mode_dmg = CalcShooting(target,shooter,pistol,mode,1,false,logfile)
			if mode_dmg >= dmg 
				dmg = mode_dmg
				profile = mode
				opt_mode[pistol] = mode
			end
		end
		
		logfile.puts "The optimal firing profile for #{pistol.name} is #{profile}"
	end	
	
	return opt_mode	
	
end		
	
