require_relative 'Logged Melee Methods.rb'
require_relative '../Classes/Weapon2.rb'
require_relative 'Dice.rb'

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
			
			#### Healing
			## Charger can heal every odd round but the first
			## defender heals every even round
			if round.odd? 
				if charger.hasRule('Healing - D3') == true && round > 1
					healed = RollDice('D3')
					dmg_to_charger = dmg_to_charger - healed
					if dmg_to_charger < 0
						dmg_to_charger = 0
					end
					logfile.puts "#{charger.getName} heals #{healed} wounds leaving then with #{atk_wounds - dmg_to_charger} wounds"
				end
			
		
				## If defender always fights first they go here!
				if defender.hasRule('Always Strikes First') == true && charger.hasRule('Always Strikes First') == false
					logfile.puts "                      #{defender.getName} always strikes first!                    "
					logfile.puts "                        Roll Defenders round #{round} Attacks                  "
					dmg_to_charger = dmg_to_charger + RollMeleeWeapon(defender,charger,def_wep,def_mode,false,logfile)
					logfile.puts "#{charger.getName} has #{atk_wounds - dmg_to_charger} wounds left"
					if dmg_to_charger >= atk_wounds
						logfile.puts "The defender, #{defender.getName} won!"
						defender_victories = defender_victories + 1.0
						break
					end
				end
				### Have the Charger fight for their intial round
				if round == 1
					logfile.puts "                  Roll Initital Charge!                             "
					dmg_to_defender = dmg_to_defender + RollMeleeWeapon(charger,defender,atk_wep,atk_mode,true,logfile)
					logfile.puts "#{defender.getName} has #{def_wounds - dmg_to_defender} wounds left"
					if dmg_to_defender >= def_wounds
						logfile.puts "The charger, #{charger.getName} won!"
						attacker_victories = attacker_victories + 1.0
						break
					end
				else
					logfile.puts "                   Roll Chargers Round #{round} Attacks                  "
					dmg_to_defender = dmg_to_defender + RollMeleeWeapon(charger,defender,atk_wep,atk_mode,false,logfile)
					logfile.puts "#{defender.getName} has #{def_wounds - dmg_to_defender} wounds left"
					if dmg_to_defender >= def_wounds
						logfile.puts "The charger, #{charger.getName} won!"
						attacker_victories = attacker_victories + 1.0
						break
					end
				end
			
				### IF they both get to fight first or if defender fight second defender fights here
				if defender.hasRule('Always Strikes First') == false or
					(charger.hasRule('Always Strikes First') == true &&
					defender.hasRule('Always Strikes First') == true)
				
					logfile.puts "                        Roll Defenders round #{round} Attacks                  "
					dmg_to_charger = dmg_to_charger + RollMeleeWeapon(defender,charger,def_wep,def_mode,false,logfile)
					logfile.puts "#{charger.getName} has #{atk_wounds - dmg_to_charger} wounds left"
					if dmg_to_charger >= atk_wounds
						logfile.puts "The defender, #{defender.getName} won!"
						defender_victories = defender_victories + 1.0
						break
					end
				end
			end
			
			if round.even? 
				if defender.hasRule('Healing Balms - D3')
					healed = RollDice('D3')
					dmg_to_defender = dmg_to_defender - healed
					if dmg_to_defender < 0
						dmg_to_defender = 0
					end
					logfile.puts "#{defender.getName} heals #{healed} wounds leaving then with #{def_wounds - dmg_to_defender} wounds"
				end	
			
		
				## If Attacker always fights first they go here!
				if charger.hasRule('Always Strikes First') == true && defender.hasRule('Always Strikes First') == false
					logfile.puts "                      #{charger.getName} always strikes first!                    "
					logfile.puts "                        Roll Chargers round #{round} Attacks                  "
					dmg_to_defender = dmg_to_defender + RollMeleeWeapon(charger,defender,atk_wep,atk_mode,false,logfile)
					logfile.puts "#{defender.getName} has #{def_wounds - dmg_to_defender} wounds left"
					if dmg_to_defender >= def_wounds
						logfile.puts " The Charger, #{charger.getName} won!"
						attacker_victories = attacker_victories + 1.0
						break
					end
				end
				
				
				logfile.puts "                   Roll Defenders Round #{round} Attacks                  "
				dmg_to_charger = dmg_to_charger + RollMeleeWeapon(defender,charger,def_wep,def_mode,false,logfile)
				logfile.puts"#{charger.getName} has #{atk_wounds - dmg_to_charger} wounds left"
				if dmg_to_charger >= atk_wounds
					logfile.puts "The Defender, #{defender.getName} won!"
					defender_victories = defender_victories + 1.0
					break
				end
			
			
				### If they both get to fight first or if the charger fights second, the charger fights here
				if charger.hasRule('Always Strikes First') == false or
					(charger.hasRule('Always Strikes First') == true &&
					defender.hasRule('Always Strikes First') == true)
				
					logfile.puts "                        Roll Charger's round #{round} Attacks                  "
					dmg_to_defender = dmg_to_defender + RollMeleeWeapon(charger,defender,atk_wep,atk_mode,false,logfile)
					logfile.puts "#{defender.getName} has #{def_wounds - dmg_to_defender} wounds left"
					if dmg_to_defender >= def_wounds
						logfile.puts "The Charger, #{charger.getName} won!"
						attacker_victories = attacker_victories + 1.0
						break
					end
				end
			
		
				
				
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
		
		
	
	