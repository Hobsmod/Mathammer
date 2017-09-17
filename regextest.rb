require_relative 'Methods\LoadFromCSV'
require_relative 'Methods\ShootingAtTarget'
require 'yaml'
require_relative 'Classes\Unit.rb'
require_relative 'Classes\CodexEntry.rb'
require_relative 'Classes\CodexTargets.rb'
require 'time'
start_time = Time.now

codex = YAML.load(File.read('F:\Mathammer\Codices\SpaceMarineCodex.yml')) 

codex.each do |key, value|
	names

targets = Hash.new
name.each do |name|
	targets[name] = CodexTarget.new(codex,name)
end

targets.each do |key, value|
	t = value.getT
	sv = value.getSv
	w = value.getW
	fnp = value.getFNP
	invul = value.getInvuln
	def_rules = value.getRules
	puts "#{key}, #{t}, #{sv}, #{w}, #{fnp}, #{invul}, #{rules}"
end



	




uniq_targets = UniqueTargets(targets)
puts uniq_targets

				