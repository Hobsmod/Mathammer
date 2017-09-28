require_relative '..\Classes\Model.rb'
require_relative '..\Classes\Unit.rb'
require_relative '..\Classes\Weapon2.rb'
require_relative 'Dice.rb'
require_relative 'LoggedShootingMethods.rb'

def RollOverwatchHits(charger,shooter,wep,mode,range,logfile)
	## First things first, just check if we are out of range
	wep_range = wep.getRange(mode)
	if wep_range < range
		return 0.0
	end
	mortals = 0
	hits = 0
	to_hit = 6
	shots = RollDice(wep.getShots(mode))
	
	
	logfile.puts "#{wep.getID} fires #{shots} shots"
	
	## Check if in rapid fire range and fire double shots
	if (wep_range / 2) >= range && wep.getType(mode) == 'Rapid Fire'
		shots = shots * 2
		logfile.puts "The firing range of #{range} is less than half of #{wep.getID}'s range of #{range} so it fires double the shots for a total of #{shots}"
	end
	#Weapons with the autohit rule just hit automatically
	if wep.hasRule(mode,'Autohit') == true
		hits = shots
		logfile.puts "#{weapon.getID}'s shots hit automatically for a total of #{hits} hits"
	end
	
	## RollDice for the shots
	rolls = Array.new(shots) {rand(1..6)}
	logfile.puts "#{shooter.getName} rolls #{rolls}"
	### Reroll Shooting
	puts shooter.getRules().grep(/Reroll/)
	
	if (shooter.getRules().grep(/Reroll/).size + wep.getRules(mode).grep(/Reroll/).size) > 0 && rolls.count{ |n| n < to_hit} > 0
		rolls = RerollShootingHits(shooter, charger, wep, mode, rolls, to_hit, logfile)
	end
	
	
	
	
	hits = rolls.count{|x| x >= to_hit }
	logfile.puts "#{shooter.getName} needs #{to_hit} to hit, for a total of #{hits} hits"
	
	
	##Count sixes and fives in case other rules use them, eventually add possibility of self wounding with plasma
	sixes = rolls.count(6)
	fives = rolls.count(5)
	self_wounds = 0
	return hits, sixes, fives, mortals, self_wounds
end


def CalcOverwatchHits(target,shooter,weapon,mode,range,logfile)
	
	wep_range = weapon.getRange(mode)
	## Before anything else check if we are in range
	if range > wep_range
		return 0.0
	end 
	
	## We hit on 6's regardless of BS
	to_hit = 6.0
	modifier = 1.0
	### Insert Abilities allowing you to hit on other rolls here

	shots = CalcDiceAvg(weapon.getShots(mode)).to_f
	
	logfile.puts "#{shooter.getName}'s #{weapon.getID} fires #{shots} shots"
	if weapon.getType(mode) == 'Rapid Fire' && (wep_range / 2) >= range
		shots = shots * 2.0
		logfile.puts "Twice the shots when rapid firing for a total of #{shots}"
	end
	
	prob = (6 - (to_hit - modifier)) / 6
	
	# Begin to Calculate Rerolls
	### Determine what we are rerolling
	reroll_what = Array.new()
	reroll_rules = shooter.getRules.grep(/Reroll/)
	reroll_rules = reroll_rules + weapon.getRules(mode).grep(/Reroll/)
	unless target.hasKeyword('Character') == true
		reroll_rules.delete_if {|rule| rule.match(/Duelist/)}
	end
	puts reroll_rules
	reroll_rules.each do |rule|
		rule_split = rule.split(' - ')
		if (rule_split[-2] == 'Hits' or rule_split[-2] == 'All') &&
			(rule_split[-3] == 'Shooting' or rule_split[-3] == 'All')
			reroll_what.push(rule_split[-1])	
		end
	end
	
	puts reroll_what
	if reroll_what.include?('All') == true
		
		prob = prob + ((1.0 - prob) * prob)
		logfile.puts "#{shooter.getName} gets to reroll all their misses making the new probability #{prob}"
		
	elsif reroll_what.include?('Single') == true && reroll_what.include?('1') == true
		
		total_ones = shots * (1.0 / 6.0)
		misses_not_ones = shots.to_f * (1.0 - (prob + (1.0 / 6.0)))
		if misses_not_ones > 1
			misses_not_ones = 1
		end
		hits = shots * prob
		hits = hits + (total_ones * prob)
		hits = hits + (misses_not_ones * prob)
		
		logfile.puts "#{shooter.getName} gets to reroll all their ones and a single miss, giving them a total of  #{hits}"
		return hits
		
	elsif reroll_what.include?('1') == true
		
		
		prob = prob + (prob * (1.0 / 6.0))
		
		logfile.puts "#{shooter.getName} gets to reroll all their 1's making the new probability of hitting #{prob}"
		
	elsif reroll_what.include?('Single') == true
		
		misses = shots.to_f * (1.0 - to_succeed)
		if misses> 1
			misses = 1
		end
		
		hits = (prob * shots) + (misses * prob)
		logfile.puts "#{shooter.getName} gets to reroll a single miss so they git #{hits} hits"
		return hits
	end
	
	puts prob
	puts shots
	hits = prob * shots
	logfile.puts "He gets #{hits} hits"

	return hits
end

def CalcShootingWounds(hits,shooter,target,weapon,mode,logfile)
	tough = CalcDiceAvg(target.getT).to_f
	str = CalcDiceAvg(weapon.getS(mode))
	prob = 0.0
	
	
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
	
	
	logfile.puts "#{shooter.getName} has an effective strength of #{str} and his target has a toughness of #{tough}, giving a #{prob} chance of wounding" 
	if weapon.hasRule(mode, 'Reroll - Wounds - All') or shooter.hasRule('Reroll - All - Wounds - All') or shooter.hasRule('Reroll - Fight - Wounds - All')
		prob = prob + ((1 - prob) * prob)
		logfile.puts "#{shooter.getName} can reroll wounds so their chances improve to #{prob}"
	elsif weapon.hasRule(mode, 'Reroll - Wounds - 1') or shooter.hasRule('Reroll - All - Wounds - 1') or shooter.hasRule('Reroll - Fight - Wounds - 1')
		prob = prob +((1 / 6) * prob)
		logfile.puts "#{shooter.getName} can reroll 1's to wound so their chances improve to #{prob}"
	end
	wounds = prob * hits
	logfile.puts "#{shooter.getName} causes #{wounds} wounds"
	return wounds
end

def CalcShootingSaves(wounds, shooter, target, weapon, mode,logfile)
	if wounds == 0.0
		return 0.0
	end
	ap = CalcDiceAvg(weapon.getAP(mode)).to_f
	save = target.getSv.to_f
	invuln = target.getInvuln.to_f
	mod_save = save - ap 
	logfile.puts "#{shooter.getName}'s #{weapon.getID} has an AP of #{ap} so #{target.getName}'s save of #{save} becomes #{mod_save}"
	if mod_save > invuln
		mod_save = invuln
		logfile.puts "#{target.getName}'s invulnerable save of #{invuln} is better, so they will use that instead"
	end
	if mod_save >= 7.0
		prob = 1.0
		stdev = 0.0
	else
		prob = (mod_save - 1) / 6
	end
	
	logfile.puts "#{target.getName} has a #{prob} chance of failing their save"
	failed_saves = wounds * prob
	logfile.puts "#{target.getName} failed #{failed_saves} saves"
	return failed_saves
	
end

def CalcShootingDamage(felt_wounds, attacker, target, weapon, mode,logfile)
	if felt_wounds == 0
		return 0.0
	end
	sv = target.getSv()
	fnp = target.getFNP()
	d = CalcDiceAvg(weapon.getD(mode))
	wounds = target.getW.to_f

	## Increase damage for grav weapons
	if sv >= 3 && weapon.hasRule(mode, 'Grav')
		unless d > 2
			d = 2
		end
	end
	if target.hasRule('Damage - Halved')
		d = (d / 2).ceil
	end
	if target.hasRule('Damage - Reduced - 1')
		d = d - 1
		if d < 1 
			d = 1
		end
	end
	
	dmg = felt_wounds * d
	if target.getFNP().any?
		target.getFNP().each do |fnp|
			prob = (fnp - 1) / 6
			dmg = dmg * prob
		end
	end


	#Calculate Final Damage
	if dmg >= wounds && weapon.hasRule(mode, 'Overflow') == false
		dmg = wounds
	end
	
	logfile.puts "#{weapon.getID} in #{mode} mode would do #{dmg} wounds on average"
	return dmg
	
end


def CalcOverwatch(charger,shooter,wep,mode,range,logfile)
		overwatch_hits = CalcOverwatchHits(charger,shooter,wep,mode,range, logfile)
		puts "#{wep.getID} causes #{overwatch_hits} hits"
		overwatch_wounds =  CalcShootingWounds(overwatch_hits,charger,shooter,wep,mode,logfile)
		puts "#{wep.getID} causes #{overwatch_wounds} wounds"
		unsaved = CalcShootingSaves(overwatch_wounds, charger, shooter, wep, mode,logfile)
		puts "#{wep.getID} causes #{unsaved} unsaved wounds"
		dmg = CalcShootingDamage(unsaved, charger, shooter, wep, mode,logfile)
		puts "#{wep.getID} causes #{dmg} damage"
		return dmg
end

def OptOverwatch(charger,shooter,range,logfile)


	main_dmg = 0.0
	pistol_dmg = 0.0
	grenade_dmg = 0.0
	type = ''
	
	## Calculate the best damage to use
	shooter.getRangedWeapons.each do |weapon|
		type = 'Blank'
		weapon_dmg = 0.0
		combi_dmg = 0.0
		
		### Calculate the best firing mode to use
		weapon.getFiretypes.each do |mode|
			dmg = CalcOverwatch(charger,shooter,weapon,mode,range,logfile)
			if dmg > weapon_dmg && weapon.hasRule(mode,'Combi') == false
				weapon_dmg = dmg
				type = weapon.getType(mode)
			elsif weapon.hasRule(mode ,'Combi') == true
				combi_dmg = combi_dmg + dmg
			end	 
		end
		
		#If the damage from firing both combi modes at once is higher use that
		if combi_dmg > weapon_dmg 
			weapon_dmg = combi_dmg
		end
		
		if type == 'Pistol' && weapon_dmg > pistol_dmg
			pistol_dmg = weapon_dmg
		elsif type == 'Grenade' && weapon_dmg > grenade_dmg
			grenade_dmg = weapon_dmg
		else
			main_dmg = main_dmg + weapon_dmg
		end	
	end
	
	logfile.puts "Pistol Damage is #{pistol_dmg}, Grenade Damage is #{grenade_dmg}, Main Damage is #{main_dmg}"
	if pistol_dmg > main_dmg && pistol_dmg > grenade_dmg
		type = 'Pistol'
		logfile.puts "#{shooter.getName} should use their Pistol"
	elsif grenade_dmg > main_dmg
		type = 'Grenade'
		logfile.puts "#{shooter.getName} should use a grenade"
	else
		type = 'All'
		logfile.puts "#{shooter.getName} will fire all their weapons that are not pistols or grenades"
	end
	return type
end


def FireOverwatch(charger,shooter,range,logfile)
	fire_what = OptOverwatch(charger,shooter,range,logfile)
	puts fire_what
	weapons_to_fire = Array.new()
	if fire_what == 'All'
		weapons_to_fire = shooter.getRangedWeapons
		weapons_to_fire.delete_if {|wep| wep.getType(nil) == 'Pistol'}
		weapons_to_fire.delete_if {|wep| wep.getType(nil) == 'Grenade'}
	end
	if fire_what =='Grenade'
		weapons = shooter.getRangedWeapons
		weapons_to_fire.delete_if {|wep| wep.getType(nil) != 'Grenade'}
	end
	if fire_what == 'Pistol'
		weapons = shooter.getRangedWeapons
		weapons_to_fire.delete_if {|wep| wep.getType(nil) != 'Pistol'}
	end
	puts "#{weapons_to_fire}"
	
	weapons_to_fire.each do |wep|
		wep.getFiretypes.each do |mode|
			hits = RollOverwatchHits(charger,shooter,wep,mode,range,logfile)
			wounds = RollShootingWounds(hits,charger,shooter,wep,mode,range,logfile)
			failed = RollShootingSaves(wounds,charger,shooter,wep,mode, range, logfile)
			damage = RollShootingDamage(failed,charger,shooter,wep,mode,range,logfile)
		end
	end
end