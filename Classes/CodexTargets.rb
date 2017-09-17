
### Create the Codex Targets Class
class CodexTarget
	def initialize(codex, name)
		statline = codex[name].getStats	
		rules = codex[name].getRules
		
		
		@toughness = statline['T']
		@save = codex[name].getSv()
		@wounds = statline['W']
		
		
		### Grab the best invulnerable save
		invulns = rules.grep(/Invulnerable/)
		best_invul = 7
		unless invulns.to_a.empty?
			invulns.each do |invul|
				if invul[-1].to_i < best_invul
					best_invul = invul[-1].to_i
				end
			end
		end
		@invul = best_invul
		
		##Make array of FNP saves
		feel_no_pain = rules.grep(/FNP/)
		@fnp = Array.new
		feel_no_pain.each do |pain|
			@fnp.push(pain[-1])
		end

		##Make array that contains all other defensively relevant rules
		@defensive_rules = Array.new
		@defensive_rules.push(rules.grep(/Hard to Hit/))
		@defensive_rules.push(rules.grep(/Fly/))
		@defensive_rules.push(rules.grep(/Reroll - Saves/))
	end
	
	def getT()
		@toughness
	end
	
	def getSv()
		@save
	end
	
	def getW()
		@wounds
	end
	
	def getInvuln()
		@invul
	end
	
	def getFNP()
		@fnp
	end
	
	def getRules
		@defensive_rules
	end
	
	def hasRule(rule)
		if @defensive_rules.include? rule
			return true
		else
			return false
		end
	end

end

def checkIdentical(value1, value2)
	if value1.getFNP.sort != value2.getFNP.sort
		
		return false
	elsif value1.getInvuln != value2.getInvuln
		
		return false
	elsif value1.getSv != value2.getSv
		
		return false
	elsif value1.getT != value2.getT
		
		return false
	elsif value1.getW != value2.getW
		
		return false
	elsif value1.getRules.sort != value2.getRules.sort
		
		return false
	else
		return true
	end
end

def UniqueTargets (targets)
	uniq_targets = targets
	uniq_targets.each do |key1, value1|
		uniq_targets.each do |key2, value2|
			if key1 != key2 && checkIdentical(value1, value2)
				#puts "#{key1} was defensively identical to #{key2} and so was deleted"
				uniq_targets.delete(key1)
				break
			end
		end
	end
	
	return uniq_targets
		
end