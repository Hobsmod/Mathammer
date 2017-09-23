require_relative 'Melee Methods.rb'


def Duel(wep_hash,charger,defender,iterations)
###each of these is a unit
	charger = charger.getModels[0]
	defender = defender.getModels[0]
	## get all stats
	atk_wep = OptMeleeWeapon(charger,defender)[0]
	atk_mode= OptMeleeWeapon(charger,defender)[1]
	atk_wounds = charger.getW()
	def_wep = OptMeleeWeapon(defender,charger)[0]
	def_mode = OptMeleeWeapon(defender,charger)[1]
	def_wounds = defender.getW


	defender_victories = 0
	attacker_victories = 0
	
	(1..iterations).each do
		dmg_to_charger = 0
		dmg_to_defender = 0
		rounds = 0
		until dmg_to_defender >= def_wounds or dmg_to_charger >= atk_wounds
			if rounds == 0
				dmg_to_defender = dmg_to_charger + RollMeleeWeapon(charger,defender,atk_wep,atk_mode,true)
			else
				dmg_to_defender = dmg_to_charger + RollMeleeWeapon(charger,defender,atk_wep,atk_mode,false)
			end
			dmg_to_charger = dmg_to_charger + RollMeleeWeapon(defender,charger,def_wep,def_mode,false)
		end
		if dmg_to_defender >= def_wounds
			#puts "#{charger.getName} won!"
			attacker_victories = attacker_victories + 1.0
		elsif dmg_to_charger >= atk_wounds
			defender_victories = defender_victories + 1.0
			#puts "#{defender.getName} won!"
		end
	end

	odds = attacker_victories / iterations

	#puts "#{charger.getName()} won #{attacker_victories} times"
	#puts "#{defender.getName()} won #{defender_victories} times"
	return odds
end
		
		
	
	