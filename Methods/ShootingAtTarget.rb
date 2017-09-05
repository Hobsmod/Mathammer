def ShootingAtTarget(unit, gear_hash, target, range, moved)
	possible_grenade_users = Hash.new{|key, value| value = Array.new}
	total_dmg = 0.0
	#begin to calculate damage for all models
	unit.getModels.each do |model|
		bs = model.getBS.to_f
		
		#set up all the damage types
		main_dmg = 0.0
		grenade_dmg = 0.0 
		pistol_dmg = 0.0 
		
		model.getGear.each do |weapon|
			if gear_hash[weapon]
				type = 'Blank'
				weapon_dmg = 0.0
				combi_dmg = 0.0
				
				#Iteratre over each of the weapons firing modes -- firetypes
				gear_hash[weapon].getFiretypes.each do |firetype|
					#grab all the relevant stats for each weapon-firetype and target
					str = gear_hash[weapon].getS(firetype).to_f
					ap = gear_hash[weapon].getAP(firetype).to_f
					d = gear_hash[weapon].getD(firetype).to_f
					shots = gear_hash[weapon].getShotsAtRange(firetype, range).to_f
					id = gear_hash[weapon].getID()
					tough = target.getT.to_f
					save = target.getSv.to_f
					invuln = target.getInvuln.to_f
					wounds = target.getW.to_f
					
					# Account for possibility of double firing
					if model.hasRule('Firestorm') == TRUE && moved == false
						shots = shots * 2
					end
					
					
					
					#calculate number of hits
					modifier = -1.0
					
					if moved && gear_hash[weapon].getType(firetype) == 'Heavy' && model.hasRule('Move and Fire') == FALSE
						modifier = modifier + 1
					end
					
					if gear_hash[weapon].hasRule(firetype,'Combi')
						modifier = modifier + 1
					end

					
					if gear_hash[weapon].hasRule(firetype, 'Autohit')
						hits = shots
					else
						hits = shots * ((6 - (bs + modifier))/6)
					end
					
					#calculate probability of wounding
					if str >= (tough * 2)
						wound_prob = 5.0 / 6.0
					elsif str > tough 
						wound_prob = 4.0 / 6.0
					elsif str == tough
						wound_prob = 3.0 / 6.0
					elsif str < tough 
						wound_prob = 2.0 / 6.0 
					else
						wound_prob = 1.0 / 6.0
					end
					# calculate number of wounds to save
					saves = hits * wound_prob
					#calculate probability of not saving
					mod_save = save - ap 
					if mod_save > invuln
						mod_save = invuln
					end
					if mod_save > 7.0
						prob_unsave = 1.0
					else
						prob_unsave = (mod_save - 1) / 6
					end
					
					felt_wounds = saves * prob_unsave
					#calculate any fnp -- later
					
					
					#calculate damage
					if save >= 3 && gear_hash[weapon].hasRule(firetype, 'Grav')
						d = 2
					end
					
					if d >= wounds
						d = wounds
					end
					dmg_caused = d * felt_wounds
					
					# IF this is the firing mode that does the most damage pass it to the 
					# weapon_damage varaiable, else if it is combi add it to the combi_damage Variable
					if dmg_caused > weapon_dmg && gear_hash[weapon].hasRule(firetype,'Combi') == FALSE
						weapon_dmg = dmg_caused
						type = gear_hash[weapon].getType(firetype)
					elsif gear_hash[weapon].hasRule(firetype ,'Combi') == TRUE
						combi_dmg = combi_dmg + dmg_caused
					end			
				end
				
				
				#check if the sum of combi modes is greater than the higher of the two modes
				if combi_dmg > weapon_dmg 
					weapon_dmg = combi_dmg
				end
				
				
				#If the weapon is of the right type, and there is not already 
				#a weapon of that type that does more damage
				if type == 'Pistol' && weapon_dmg > pistol_dmg
					pistol_dmg = weapon_dmg
				elsif type == 'Grenade' && weapon_dmg > grenade_dmg
					grenade_dmg = weapon_dmg
				else
					main_dmg = main_dmg + weapon_dmg
				end
				
				
			end	

		end
		
		#puts "Pistol Damage is #{pistol_dmg}, Grenade Damage is #{grenade_dmg}, Main Damage is #{main_dmg}"
			if pistol_dmg > main_dmg && pistol_dmg > grenade_dmg
				total_dmg = total_dmg + pistol_dmg
				#puts 'Used Pistol'
			elsif grenade_dmg > main_dmg
				possible_grenade_users[model.getID] = [grenade_dmg, main_dmg]
				#puts "may use grenade"
			else
				total_dmg = total_dmg + main_dmg
				#puts "Will just use the main guns"
			end
		
	end

	

	
	#pick the highest grenade dmg
	final_grenade_dmg = 0.0 
	grenade_user_id = 'Blank'
	possible_grenade_users.each do |key, value|
		if possible_grenade_users[key][0] >= final_grenade_dmg
			final_grenade_dmg = possible_grenade_users[key][0]
			grenade_user_id = key
		end
	end
	
	#Add the dmg from everyone who could have used a grenade but didn't
	total_dmg = total_dmg + final_grenade_dmg
	possible_grenade_users.each do |key,value|
		unless key == grenade_user_id
			#puts key
			total_dmg = total_dmg + possible_grenade_users[key][1].to_f
		end
	end
	
	#Print some nice stuff out for troubleshooting
	targeted_unit = target.getName()
	#puts "The total dmg to #{targeted_unit} was #{total_dmg} wounds"	
	
	if grenade_user_id ==! 'Blanks'
		puts "Model #{grenade_user_id} used a grenade"
	end
	return total_dmg
end		
			