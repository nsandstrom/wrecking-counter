namespace :gameround do
	desc "Play a round of Wrecking"
	task :run => :environment  do
		puts "Let's play a game"
		Interval = 1
		# round = Round.create(name: "Test round", endtime: (Time.now.utc + 5.minutes).to_s(:db), active: true )
		round = Round.order('endtime desc').first
		last_tick = Time.now
		first_update = Time.now
		until Time.now > round.endtime do
			round = Round.order('endtime desc').first
			if Time.now - last_tick >= Interval
      			last_tick += Interval
				if round.active
					teams = Team.all.includes(:stations)
					teams.each do |team|
						team.stations.each do |station|
							team.score += station.boost
						end
						team.save
					end
					# team.update(score: team.score + 1)
					# Score.create(score: team.score)
					# puts "time diff: #{round.endtime - Time.now}"
					# puts "time now: #{Time.now.utc} - endtime: #{round.endtime}"
					# puts "time left: #{Time.at(round.endtime - Time.now - 1.hour).strftime("%H:%M:%S")}"
					# round.update(active: false) if Time.now.utc > round.endtime
				end
			end
			sleep 0.01
		end
		round.update(active: false)
	end

	task :watch => :environment  do
		puts "Watching you"
		Interval = 1
		while true

			Round.where("starttime <= ?", Time.now).where("endtime >= ?", Time.now).each do |round|
				round.update(active: true)
			end

			if (active_round = Round.where(:active => true).last)
				puts "got active round"
				last_tick = Time.now
				until Time.now > active_round.endtime do
					# active_round = Round.order('endtime desc').first
					if Time.now - last_tick >= Interval
		      			last_tick += Interval
						
						teams = Team.all.includes(:stations)
						teams.each do |team|
							team.stations.each do |station|
								team.score += station.boost if (1 << (station.id - 1)) & active_round.stations == (1 << (station.id - 1))
							end
							team.save
						end
						# team.update(score: team.score + 1)
						# Score.create(score: team.score)
						# puts "time diff: #{round.endtime - Time.now}"
						# puts "time now: #{Time.now.utc} - endtime: #{round.endtime}"
						# puts "time left: #{Time.at(round.endtime - Time.now - 1.hour).strftime("%H:%M:%S")}"
						# round.update(active: false) if Time.now.utc > round.endtime
						
					end
					sleep 0.1
				end
				active_round.update(active: false)
			end
			sleep 1
			puts "no game"
			
		end
	end

end