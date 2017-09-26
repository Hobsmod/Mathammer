require_relative 'Logged Melee Methods.rb'


def Duel(wep_hash,charger,defender,iterations,logfile)
###each of these is a unit
	
	charger = charger.getModels[0]
	defender = defender.getModels[0]
	logfile.puts "----------------#{charger.getName} Charges #{defender.getName}--------------------------"
	## get all stats
	atk_arry = OptMeleeWeapon(charger,defender,logfile)
	atk_wep = atk_arry[0]
	atk_mode= atk_arry[1]
	atk_wounds = charger.getW()
	def_arry = OptMeleeWeapon(defender,charger,logfile)
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
				logfile.puts "                  Roll Initital Charge!                             "
				dmg_to_defender = dmg_to_defender + RollMeleeWeapon(charger,defender,atk_wep,atk_mode,true,logfile)
				logfile.puts "#{defender.getName} has #{def_wounds - dmg_to_defender} wounds left"
					if dmg_to_defender >= def_wounds
						logfile.puts "#{charger.getName} won!"
						attacker_victories = attacker_victories + 1.0
						break
					end
			else
				logfile.puts "                   Roll Chargers Round #{round} Attacks                  "
				dmg_to_defender = dmg_to_defender + RollMeleeWeapon(charger,defender,atk_wep,atk_mode,false,logfile)
				"#{defender.getName} has #{def_wounds - dmg_to_defender} wounds left"
				if dmg_to_defender >= def_wounds
					logfile.puts "#{charger.getName} won!"
					attacker_victories = attacker_victories + 1.0
					break
				end
			end
			logfile.puts "                        Roll Defenders round #{round} Attacks                  "
			dmg_to_charger = dmg_to_charger + RollMeleeWeapon(defender,charger,def_wep,def_mode,false,logfile)
			logfile.puts "#{charger.getName} has #{atk_wounds - dmg_to_charger} wounds left"
			if dmg_to_charger >= atk_wounds
				logfile.puts "#{defender.getName} won!"
				defender_victories = defender_victories + 1.0
			break
			end
			if round == 20
				logfile.puts "It was a draw after 20 rounds"
				attacker_victories = attacker_victories + 0.5
				defender_victories = defender_victories + 0.5
			break
			end
		end	
	end

	odds = attacker_victories / iterations

	#logfile.puts "#{charger.getName()} won #{attacker_victories} times"
	#logfile.puts "#{defender.getName()} won #{defender_victories} times"
	return odds
end
		
		
	
	