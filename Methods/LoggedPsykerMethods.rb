require_relative 'Dice.rb'


def CastPowersWithDenier(caster,denier,range,logfile)
	perils = Array.new()
	mortals = Array.new()
	
	## Get the number of casts, denials and respective bonuses
	casts = caster.rules.grep(/Psyker - \d/).map!{ |n| n[-1]}.max.to_i
	if casts == nil
		casts = 0
	end
	denials = denier.rules.grep(/Deny - \d/).map!{ |n| n[-1]}.max.to_i
	if denials == nil
		denials = 0
	end
	cast_bonus = caster.rules.grep(/Psyker - Bonus - \d/).map!{ |n| n[-1]}.max.to_i
	if cast_bonus == nil
		cast_bonus = 0
	end
	deny_bonus = denier.rules.grep(/Deny - Bonus - \d/).map!{ |n| n[-1]}.max.to_i
	if deny_bonus == nil
		deny_bonus = 0
	end
	
	
	logfile.puts "Casts: #{casts}, Denials: #{denials}, Caster Bonus: #{cast_bonus}, Deny Bonus #{deny_bonus}"
	caster.getPowers.each do |power|
		power.getFiretypes.each do |mode|
			if casts <= 0
				next
			end
			# Get the Power Warp Charge
			charge = power.getType(mode)[-1].to_i
			test = [ rand(1..6), rand(1..6) ]
			logfile.puts "#{caster.name} tries to cast #{power.name} and rolled #{test}" 
			
			### Reroll the test if the psycker has the relevant rule
			if (test.inject(:+) + cast_bonus) < charge && caster.hasRule?('Psyker - Reroll')
				test = [ rand(1..6), rand(1..6) ]
				logfile.puts "#{caster.name} gets to reroll failed psychic tests and now rolled #{test} + #{cast_bonus}"
			end
			
			### Check if caster suffered perils of the warp
			if test == [1,1] or test == [6,6]
				d3 = rand(1..3)
				perils.push(d3)
				logfile.puts "#{caster.name} suffers peril of the warp and takes #{d3} mortal wounds"
			end
			
			
			if (test.inject(:+) + cast_bonus) < charge
				logfile.puts "That's not high enough to cast this power"
				next
			end
			

			
			## Attempt to deny
			if denials.to_i > 0 
				deny_test = [rand(1..6), rand(1..6)]
				if (deny_test.inject(:+) + deny_bonus) > (test.inject(:+) + cast_bonus)
					logfile.puts "#{denier.name} attempts to deny and rolls #{deny_test} + #{deny_bonus}, which suceeds"
					next
				else
					logfile.puts "#{denier.name} attempts to deny and rolls #{deny_test} + #{deny_bonus}, which fails"
				end
				denials = denials - 1
			end
			
			
			
			### Resolve the effects of the power
			if power.getType(mode) =~ /Buff/
				power.rules[mode].grep(/Add Rule/).each do |string|
					rule = string.split(' - ')
					rule_text = rule[3..-1].join(' - ')
					logfile.puts "#{power.name} gives #{caster.name} the #{rule_text} special rule for #{rule[2]} rounds"
					caster.addRuleModifier(rule[2], rule_text)
				end
	
				power.rules[mode].grep(/Add Stat/).each do |string|
					rule = string.split(' - ')
					logfile.puts "#{power.name} increases #{caster.name}'s #{rule[-2]} by #{rule[-1]} for #{rule[-3]} rounds"
					caster.addStatModifier(rule[-3],rule[-2],rule[-1].to_i)
				end
			end
			
			
			if power.getType(mode) =~ /Debuff/
				power.rules[mode].grep(/Add Rule/).each do |string|
					rule = string.split(' - ')
					rule_text = rule[3..-1].join(' - ')
					logfile.puts "#{power.name} gives #{denier.name} the #{rule_text} special rule for #{rule[2]} rounds"
					denier.addRuleModifier(rule[2], rule_text)
				end
	
				power.rules[mode].grep(/Add Stat/).each do |string|
					rule = string.split(' - ')
					logfile.puts "#{power.name} increases #{denier.name}'s #{rule[-2]} by #{rule[-1]} for #{rule[-3]} rounds"
					denier.addStatModifier(rule[-3],rule[-2],rule[-1].to_i)
				end
			end
			
			
			if power.getType(mode) =~ /Smite/ && power.getRange(mode) >= range
				power.rules[mode].grep(/Overcast/).each do |string|
					rule = string.split(' - ')
					
					if (test.inject(:+) + cast_bonus) > rule[1].to_i
						dmg = RollDice(rule[-2])
						mortals.push(dmg)
						logfile.puts "#{power.name} was overcast and so it does #{rule[-2]} damage for a total of #{dmg}"
					else 
						dmg = RollDice(rule[-1])
						mortals.push(dmg)
						logfile.puts "#{power.name} does #{rule[-1]} mortal wounds for a total of #{dmg}" 
					end
				end
				
				power.rules[mode].grep(/Mortals/).each do |string|
					unless string =~ /Overcast/ or string =~ /Keyword/
						rule = string.split(' - ')
						dmg = RollDice(rule[-1])
						mortals.push(dmg)
						logfile.puts "#{power.name} does #{rule[-1]} mortal wounds for a total of #{dmg}" 
					end
					
					if string =~ /Keyword/
						rule = string.split(' - ')
						
						if denier.hasKeyword?(rule[1])
							dmg = RollDice(rule[-2])
						else
							dmg = RollDice(rule[-1])
						end
						
						mortals.push(dmg)
						logfile.puts "#{power.name} does #{dmg} mortal wounds" 
					end
				end
			end
			
			if power.getType(mode) =~ /Trait/ && power.getRange(mode) >= range
				power.rules[mode].grep(/Trait - Test/).each do |string|
					rule = string.split(' - ')
					target_trait = denier.stats[rule[2]].to_i
					d = rule[3][-1].to_i
					rolls = Array.new(rule[4].to_i) {rand(1..d)}
					suceeds = rolls.count{|x| x > target_trait}
					dmg = Array.new(suceeds) {RollDice(rule[-1])}
					if rule[-2] == 'Mortals'
						logfile.puts "#{power.name} causes #{rule[-1]} mortal wound(s) for each roll higher than the targets #{rule[2]}. The Rolls are #{rolls} for a total of #{dmg} mortal wounds"
						mortals = mortals + dmg
					end
				end
				
				### When adding something to a trait and comparing the results
				power.rules[mode].grep(/Trait - Compare/).each do |string|
					rule = string.split(' - ')
					trait = rule[2]
					d = rule[3][-1].to_i
					cast_ld = caster.stats[trait].to_i
					denier_ld = denier.stats[trait].to_i
					caster_roll = rand(1..d)
					denier_roll = rand(1..d)
					dmg = RollDice(rule[-2])
					tie_dmg = RollDice(rule[-1])
					if (cast_ld + caster_roll) > (denier_ld + denier_roll)
						logfile.puts "The Caster's leadership of #{cast_ld} + a d6 roll of #{caster_roll} is greater than the target's leadership of #{denier_ld} + #{denier_roll} so #{denier.name} takes #{dmg} mortal wounds" 
						mortals.push(dmg)
					elsif (cast_ld + caster_roll) == (denier_ld + denier_roll)
						logfile.puts "The Caster's leadership of #{cast_ld} + a d6 roll of #{caster_roll} ties the targets leadership of #{denier_ld} + #{denier_roll} so #{denier.name} takes #{tie_dmg} mortal wounds" 
						mortals.push(tie_dmg)
					elsif (cast_ld + caster_roll) < (denier_ld + denier_roll)
						logfile.puts "The Caster's leadership of #{cast_ld} + a d6 roll of #{caster_roll} is less than the target's leadership of #{denier_ld} + #{denier_roll} so #{denier.name} takes no damage" 
					end
				end
				
				power.rules[mode].grep(/Trait - Subtract/).each do |string|
					rule = string.split(' - ')
					trait = denier.stats[rule[2]]
					d = rule[3][-1].to_i
					roll = RollDice(rule[3])
					dmg = RollDice(rule[-1])
					
					if (trait - roll) < 0
						wounds = (trait - roll) * -1
						logfile.puts "The target takes  mortal wounds equal to it's movement (#{trait}) minus #{rule[3]} (#{roll}), for a total of  #{wounds} damage"
						mortals.push(wounds)
					elsif (trait - roll) >= 0
						logfile.puts "The target takes mortal wounds equal to it's movement (#{trait}) minus #{rule[3]} (#{roll}), for a total of  0 damage"
					end
				end
				
				
			end
			
			
			
			casts = casts - 1 
			
		end
	end
	
	#### Check if caster or denier has rule that halves incoming damaged
	if denier.hasRule?('Damage - Halved') == true && mortals.size > 0
		mortals.map! { |r| r ? (r.to_f / 2).ceil : r}
		logfile.puts "#{denier.name} halves all damage (rounding up) so he only takes #{mortals} mortal wounds"
	end
	
	if caster.hasRule?('Damage - Halved') == true && perils.size > 0
		perils.map! { |r| r ? (r.to_f / 2).ceil : r}
		logfile.puts "#{caster.name} halves all damage (rounding up) so he only takes #{mortals} mortal wounds"
	end
	
	tot_mortals = mortals.inject(:+).to_i
	tot_perils = perils.inject(:+).to_i
	
	### Take FNP saves for mortal wounds
	if denier.getFNP().any?	&& tot_mortals >= 1
		denier.getFNP().each do |fnp|
			logfile.puts "#{denier.name} has a 'Feel No Pain' ability that lets them ignores wounds on a #{fnp.to_i}+"
			rolls = Array.new(tot_mortals) {rand (1..6)}
			logfile.puts "#{denier.name} rolls #{rolls}"
			rolls.delete_if {|x| x >= fnp}
			tot_mortals = rolls.size
		end
	end
	
	if caster.getFNP().any?	&& tot_perils >= 1
		caster.getFNP().each do |fnp|
			logfile.puts "#{caster.name} has a 'Feel No Pain' ability that lets them ignores wounds on a #{fnp.to_i}+"
			rolls = Array.new(tot_perils) {rand (1..6)}
			logfile.puts "#{caster.name} rolls #{rolls}"
			rolls.delete_if {|x| x >= fnp}
			tot_perils = rolls.size
		end
	end
	
	return tot_mortals, tot_perils
end