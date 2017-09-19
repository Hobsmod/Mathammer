require_relative 'ShootingMethods.rb'
require_relative 'ShootingAtTarget.rb'

def ShootingAtDist(unit, gear_hash, target, distance)
	range = distance
	
	#Pick the lowest movement in the Unit
	move = 100
	unit.getModels.each do |model|
		m = model.getM()
		if m < move
			move = m
		end
	end
	
	range_move = distance + move
	range_advance = distance + move + 3
	
	dmg_stationary = ShootingAtTarget(unit, gear_hash, target, range, false)
	dmg_move = ShootingAtTarget(unit, gear_hash, target, range_move, true)
	dmg_advance = ShootingAtTarget(unit, gear_hash, target, range_advance, true)
	
	dmg_array = [dmg_advance, dmg_move, dmg_stationary]
	dmg_array.uniq
	dmg = dmg_array.max
	return dmg
end

def FindRanges(unit, gear_hash)
	
	##Ranges to test
	ranges = Array.new()
	unit.getModels.each do |model|
		model.getGear.each do |gear|
			if gear_hash[gear]
				weapon = gear_hash[gear]
				weapon.getFiretypes.each do |firetype|
					range = weapon.getRange(firetype)
					ranges.push(range)
					if weapon.getType(firetype) == RapidFire or weapon.hasRule(firetype,'Melta')
						ranges.push(range / 2)
					end
				end
			end
		end
	end
	ranges = ranges.uniq
	return ranges
end
	
	