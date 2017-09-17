require_relative 'Methods\LoadFromCSV'


def ShootingByThreatBubble(unit, target)
	gear_hash = LoadWeapons('F:\Mathammer\weapons.csv')
	
	### Figure out what the relevant ranges are
	ranges = Array.new
	unit.getModels.each do |model|
		model.getGear.each do |weapon|
			range = weapon.getRange()
			ranges.push range
			if weapon.getType() = 'Rapid Fire'
				rf_range = model.getM() + (range / 2)
				ranges.push
			end
			if ranges.get
	
	
end