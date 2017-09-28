require_relative '..\Classes\Model.rb'
require_relative '..\Classes\Unit.rb'
require_relative '..\Classes\Weapon2.rb'
require_relative 'Dice.rb'


def RollShootingWounds(hits,shooter,target,weapon,mode,range,logfile)
	if weapon.getRange(mode) < range
		return 0.0
	end
	
	str = weapon.getS(mode)
	tough = target.getT.to_i
	wounds = 0
	mortals = hits[3]
	self_wounds = hits[4]
	hits = hits[0]
	
	combined_rules = shooter.getRules() + weapon.getRules(mode)
	
	if (combined_rules.grep(/Rend - Shooting - Autohit/).size > 0 ) && hits[1] > 0 
		logfile.puts "#{shooter.getName} generates an extra hit for every six they rolled, and they rolled #{hits[1]} sixes"
		hits = hits + hits[1]
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
	
	logfile.puts "#{target.getName} has a toughness of #{tough} so #{shooter.getName} needs #{to_wound}'s to wound"
	
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
	#logfile.puts  "#{shooter.getName} rolled #{rolls}"
	if combined_rules.grep(/Rerolls/).size > 0 && rolls.count{ |n| n < to_wound} > 0
		rolls = RerollShootingWounds(shooter, target, weapon, mode, rolls, to_wound, logfile)
	end
	

	##### Handle Mortal Wounds caused by rolling 6's
	

	sixes = rolls.count(6)
	
	if weapon.getRules(mode).select{|rule| rule.match(/Rend - Shooting - Mortal Wounds/)}.length > 0 && sixes > 0
		rule_array = weapon.getRules(mode).select{|rule| rule.match(/Rend - Shooting - Mortal Wounds/)}[0].split(' - ')
		
		if sixes >= 1
			#logfile.puts "#{rolls}"
			#logfile.puts "#{shooter.getName} rolled #{sixes} 6's each of which does #{rule_array[-1]} mortal wounds"
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
	
	if shooter.getRules().select{|rule| rule.match(/Rend - Shooting - Mortal Wounds/)}.length > 0 && sixes > 0
		rule_array = shooter.getRules().select{|rule| rule.match(/Rend - Shooting - Mortal Wounds/)}[0].split(' - ')
		if sixes >= 1
			#logfile.puts "#{shooter.getName} rolled #{sixes} 6's each of which does #{rule_array[-1]} mortal wounds"
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
	
	
	### prepare array to return
	sixes = rolls.count(6)
	fives = rolls.count(5)
	rolls.delete_if {|x| x < to_wound}
	wounds_6s_5s = [rolls.size,sixes,fives,mortals,self_wounds]
	return wounds_6s_5s
end
