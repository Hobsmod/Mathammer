require_relative '..\Model.rb'
require_relative '..\Unit.rb'
require_relative '..\Weapon.rb'



def OptMeleeWeapon(defender,target)
	average = 0.0
	attacker.getModels.each do |model|
		model.getGear.each do |gear|
			gear.getFiretypes