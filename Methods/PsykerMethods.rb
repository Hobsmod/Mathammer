require_relative 'Dice.rb'


def CastPowersWithDenier(caster,denier,range)
	self_mortals = 0
	mortals = 0
	
	## Get the number of casts, denials and respective bonuses
	casts = caster.getRules.grep(/Psyker - \d/).map!{ |n| n[-1]}.max.to_i
	if casts == nil
		casts = 0
	end
	denials = denier.getRules.grep(/Deny - \d/).map!{ |n| n[-1]}.max.to_i
	if denials == nil
		denials = 0
	end
	cast_bonus = caster.getRules.grep(/Psyker - Bonus - \d/).map!{ |n| n[-1]}.max.to_i
	if cast_bonus == nil
		cast_bonus = 0
	end
	deny_bonus = denier.getRules.grep(/Deny - Bonus - \d/).map!{ |n| n[-1]}.max.to_i
	if deny_bonus == nil
		deny_bonus = 0
	end
	
	
	puts "Casts: #{casts}, Denials: #{denials}, Caster Bonus: #{cast_bonus}, Deny Bonus #{deny_bonus}"
	caster.getPowers.each do |power|
		power.getFiretypes.each do |mode|
			# Get the Power Warp Charge
			charge = power.getType(mode)[-1].to_i
			test = [ rand(1..6), rand(1..6) ]
			puts "#{caster.getName} tries to cast #{power.getID} and rolled #{test}" 
			
			### Reroll the test if the psycker has the relevant rule
			if (test.inject(:+) + cast_bonus) < charge && caster.hasRule('Psyker - Reroll')
				test = [ rand(1..6), rand(1..6) ]
				puts "#{caster.getName} gets to reroll failed psychic tests and now rolled #{test} + #{cast_bonus}"
			end
			
			if (test.inject(:+) + cast_bonus) < charge
				puts "That's not high enough to cast this power"
				next
			end
			
			### Check if caster suffered perils of the warp
			if test == [1,1] or test == [6,6]
				d3 = rand(1..3)
				self_mortals = self_mortals + d3
				puts "#{caster.getName} suffers peril of the warp and takes #{d3} mortal wounds"
			end
			
			
			## Attempt to deny
			if denials.to_i > 0 
				deny_test = [rand(1..6), rand(1..6)]
				if (deny_test.inject(:+) + deny_bonus) > (test.inject(:+) + cast_bonus)
					puts "#{denier.getName} attempts to deny and rolls #{deny_test} + #{deny_bonus}, which suceeds"
					next
				else
					puts "#{denier.getName} attempts to deny and rolls #{deny_test} + #{deny_bonus}, which fails"
				end
				denials = denials - 1
			end
			
			if power.getType(mode) =~ /Buff/
				power.getRules(mode).grep(/Psychic - Add Rule/).each do |string|
					rule = string.split(' - ')[2..-1].join(' - ')
					puts "#{power.getID} gives #{caster.getName} the #{rule} special rule"
					caster.addRule(rule)
				end
	
				power.getRules(mode).grep(/Psychic - Add Stat/).each do |string|
					rule = string.split(' - ')
					puts "#{power.getID} increases #{caster.getName}'s #{rule[-2]} by #{rule[-1]}"
					caster.modStat(rule[-2],rule[-1].to_i)
				end
			end
			
			if power.getType(mode) =~ /Attack/ && power.getRange(mode) >= range
				power.getRules(mode).grep(/Mortals/).each do |string|
					rule = string.split(' - ')
					mortals = mortals + RollDice(rule[-1])
				end
			end
			
		end
	end
	
	return mortals, self_mortals
end