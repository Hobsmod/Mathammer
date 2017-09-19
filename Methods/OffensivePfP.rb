require_relative 'ShootingAtDist.rb'
require 'descriptive_statistics'

def OffensivePfP(codex, gear_hash, defender, attackers, distances)
	#defender is a unit
	# attackers is a hash of all attacking models
	# distances is an array
	models = defender.getModels
	targets = Hash.new
	target_count = Hash.new
	uniq_targets = Hash.new
	multiple = 'Blank'
	tot_wounds = 0.0
	
	### Some Complicated crap incase we ever need to handle mixed units
	if defender.getSize > 1
		### If there is more than one model in the unit build a hash to give us the model name and number
		models.each do |model|
			name = model.getName()
			tot_wounds = tot_wounds + model.getW()
			if targets[name]
				target_count[name] = target_count[name] + 1
			else
				targets[name] = CodexTarget.new(codex, name)
				target_count[name] = 1
			end
		end
		uniq_targets = UniqueTargets(targets)
		if uniq_targets.size > 1
			multiple = true
		end
	else
		models.each do |model|
			name = model.getName()
			tot_wounds = tot_wounds + model.getW()
			puts name
			uniq_targets[name] = CodexTarget.new(codex, name)
			multiple = false
		end
	end
	
	##Generate hash of arrays of pfp for each distance
	pfp_hash = Hash.new {|h,k| h[k] = Array.new }
	
	uniq_targets.each do |key, target_1|
		defender_cost = defender.getCost()
		attackers.each do |key, attacker|
			attacker_cost = attacker.getCost() 
			distances.each do |distance|
				dmg = ShootingAtDist(attacker, gear_hash, target_1, distance)
				if dmg > 0.0
					prc_dimin = dmg / tot_wounds
					if prc_dimin > 1.0
						prc_dimin = 1.0
					end
					pfp = (defender_cost * prc_dimin) / attacker_cost
					if pfp > 0.01
						pfp_hash[distance] << pfp
					end
				end
			end
		end
	end
	
	pfp_avg_hash =  Hash.new
	pfp_hash.each do |key, value|
		mean = value.mean
		pfp_avg_hash[key] = mean
	end
	return pfp_avg_hash						
end			