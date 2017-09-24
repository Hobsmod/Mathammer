require_relative 'Melee Methods.rb'


def Duel(wep_hash,charger,defender,iterations)
###each of these is a unit
	
	charger = charger.getModels[0]
	defender = defender.getModels[0]
	puts "----------------#{charger.getName} Charges #{defender.getName}--------------------------"
	## get all stats
	atk_arry = OptMeleeWeapon(charger,defender)
	atk_wep = atk_arry[0]
	atk_mode= atk_arry[1]
	atk_wounds = charger.getW()
	def_arry = OptMeleeWeapon(defender,charger)
	def_wep = def_arry[0]
	def_mode = def_arry[1]
	def_wounds = defender.getW


	defender_victories = 0
	attacker_victories = 0
	
	(1..iterations).each do
		dmg_to_charger = 0
		dmg_to_defender = 0
		rounds = 20
		(1..rounds).each do |round|
			if round == 1
				puts "                  Roll Initital Charge!                             "
				dmg_to_defender = dmg_to_defender + RollMeleeWeapon(charger,defender,atk_wep,atk_mode,true)
					if dmg_to_defender >= def_wounds
						puts "#{charger.getName} won!"
						attacker_victories = attacker_victories + 1.0
						break
					end
			else
				puts "                   Roll Chargers Round #{round} Attacks                  "
				dmg_to_defender = dmg_to_defender + RollMeleeWeapon(charger,defender,atk_wep,atk_mode,false)
				if dmg_to_defender >= def_wounds
					puts "#{charger.getName} won!"
					attacker_victories = attacker_victories + 1.0
					break
				end
			end
			puts "                        Roll Defenders round #{round} Attacks                  "
			dmg_to_charger = dmg_to_charger + RollMeleeWeapon(defender,charger,def_wep,def_mode,false)
			if dmg_to_charger >= atk_wounds
				puts "#{defender.getName} won!"
				defender_victories = defender_victories + 1.0
			break
			end
			if round == 20
				puts "It was a draw after 20 rounds"
				attacker_victories = attacker_victories + 0.5
				defender_victories = defender_victories + 0.5
			break
			end
		end	
	end

	odds = attacker_victories / iterations

	#puts "#{charger.getName()} won #{attacker_victories} times"
	#puts "#{defender.getName()} won #{defender_victories} times"
	return odds
end
		
		
	
	