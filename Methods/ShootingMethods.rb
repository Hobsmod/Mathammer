

def CalcHits(model, weapon, firetype, target, range, auras, moved, advanced)
	
	### Check if weapon is allowed to fire at all
	if range > weapon.getRange(firetype)
		return [0.0, 0.0]
	end
	
	if advanced && weapon.getType(firetype) != 'Assault'
		return [0.0, 0.0]
	end
	
	shots = weapon.getShots(firetype)
	##Get shots and check if the weapon auto hits
	if shots == 'D6'
		shots = 3.5
		stdev1 = 1.7
	elsif shots == 'D3'
		shots = 2.0
		stdev1 = 0.8
	elsif shots == '2D3'
		shots = 4.0
		stdev1 = 1.1
	elsif shots == '2D6'
		shots = 7
		stdev1 = 2.4
	else
		shots = shots.to_f
		stdev1 = 0.0
	end
	
	
	
	if weapon.getType(firetype) == 'Rapid Fire' && (weapon.getRange(firetype) / 2) >= range
		shots = shots * 2
		if stdev1
			stdev1 = stdev1 * 2
		end
	end
	
	if weapon.hasRule(firetype, 'Autohit')
		hits_array = [shots, stdev1]
		return hits_array
	end
	
	##Now that we are actually shooting get the models BS
	bs = model.getBS.to_f
	modifier = -1
	
	
	### Check Special Rules that Modify the number of shots
	if model.hasRule('Firestorm') == true && moved == false
		shots = shots * 2
	end

	### Check Special Rules from firer that modify ability to hit
	if moved && weapon.getType(firetype) == 'Heavy' && model.hasRule('Move and Fire') == false
		modifier = modifier + 1
	end
	if target.hasRule('Hard to Hit')
		modifier = modifier + 1
	end
	if model.hasRule('AA - 1') && target.hasRule('Fly')
		modifier = modifier - 1
	end
	if model.hasRule('Anti-Ground') && target.hasRule('Fly') == false
		modifier = modifier - 1
	end
	if advanced && weapon.getType(firetype) == 'Heavy' && model.hasRule('Move and Fire') == false
		modifier = modifier + 1
	end
	if weapon.hasRule(firetype, 'AA Only') && target.hasRule('Fly')
		modifier = modifier - 1
	elsif weapon.hasRule(firetype, 'AA Only') && target.hasRule('Fly') == false
		modifier = modifier + 1
	end
	### Check Special Rules from target that modify ability to get hit
		## Add this later
	
	
	## Calculate number of hits
	prob = (6.0 - (bs + modifier.to_f)) / 6.0
	var = shots * prob * (1.0 - prob)
	stdev2 = Math.sqrt(var)
	hits = shots * prob
	
	stdev0 = Math.sqrt((stdev1 ** 2.0) + (stdev2 ** 2.0))
	hits_array = [hits, stdev0]
	
	return hits_array
	
end

def CalcWounds(hits, weapon, firetype, target, range, auras)
	if hits == 0.0
		return [0.0, 0.0]
	end
	
	str = weapon.getS(firetype).to_f
	tough = target.getT.to_f
	
	if str >= (tough * 2)
		wound_prob = 5.0 / 6.0
	elsif str > tough 
		wound_prob = 4.0 / 6.0
	elsif str == tough
		wound_prob = 3.0 / 6.0
	elsif str =< (tough / 2)
		wound_prob = 1.0 / 6.0 
	else
		wound_prob = 2.0 / 6.0
	end
	
	var = hits * wound_prob * (1.0 - wound_prob)
	stdev = Math.sqrt(var)
	saves = hits * wound_prob
	saves_array = [saves, stdev]
	return saves_array
	
end


def CalcSaves(wounds, weapon, firetype, target, range,  cover, auras)
	if wounds == 0.0
		return [0.0, 0.0]
	end
	
	ap = weapon.getAP(firetype).to_f
	save = target.getSv.to_f
	invuln = target.getInvuln.to_f
	
	### add FNP stuff later
	
	mod_save = save - ap 
	
	if mod_save > invuln
		mod_save = invuln
	end
	if mod_save >= 7.0
		prob_unsave = 1.0
		stdev = 0.0
	else
		prob_unsave = (mod_save - 1) / 6
		var = wounds * prob_unsave * (1.0 - prob_unsave)
		#puts weapon.getID, var, save, ap, mod_save
		stdev = Math.sqrt(var)
	end
	
	
	felt_wounds = wounds * prob_unsave
	felt_wounds_array = [felt_wounds, stdev]
	return felt_wounds_array
	
end


def CalcDamage(felt_wounds, weapon, firetype, target, range, auras)
	if felt_wounds == 0.0
		return [0.0, 0.0]
	end
	save = target.getSv.to_f
	d = weapon.getD(firetype)
	
	if weapon.hasRule(firetype,'Melta') && range <= (weapon.getRange(firetype) / 2)
		d = 4.47
		stdev = 1.4
	elsif d == 'D3'
		d = 2
		stdev = 1
	elsif d == 'D6'
		d = 3.5
		stdev = 1.709
	end
	
	wounds = target.getW.to_f

	## Increase damage for grav weapons
	if save >= 3 && weapon.hasRule(firetype, 'Grav')
		d = 2
	end


	#Calculate Final Damage
	if d >= wounds
		d = wounds
	end
	dmg_caused = d * felt_wounds
	dmg_array = [dmg_caused, 0.0]
	#puts dmg_caused
	return dmg_array
	
end


