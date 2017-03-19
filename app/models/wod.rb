class Wod < ApplicationRecord

  def initialize
    @wod_type = WOD_TYPES.sample
    @time = time
    @rounds = rounds
    @pull = PULLS.sample
		@run = RUNS.sample
		@sit = SITS.sample
		@jump = JUMPS.sample
		@light = LIGHTS.sample
		@heavy = HEAVYS.sample
    @movements = movements
    @movement1 = @movements.at(0)
    @movement2 = @movements.at(1)
    @movement3 = @movements.at(2)
    @movement4 = @movements.at(3)
    @weight1 = weight(@movement1)
    @weight2 = weight(@movement2)
    @weight3 = weight(@movement3)
    @weight4 = weight(@movement4)
    @reps1 = reps(@movement1)
    @reps2 = reps(@movement2)
    @reps3 = reps(@movement3)
    @reps4 = reps(@movement4)
    @set1 = "#{@reps1} #{@movement1} #{@weight1}"
    @set2 = "#{@reps2} #{@movement2} #{@weight2}"
    @set3 = "#{@reps3} #{@movement3} #{@weight3}"
    @set4 = "#{@reps4} #{@movement4} #{@weight4}"
    @pull2 = PULLS.sample
		@run2 = RUNS.sample
		@sit2 = SITS.sample
		@jump2 = JUMPS.sample
	 	@light2 = LIGHTS.sample
	  @heavy2 = HEAVYS.sample

  end


WOD_TYPES = ["AMRAP", "EMOM", "RFT"]
PULLS = ["StrPullups", "StrHSPU", "BMU", "RMU", "Dips", "RopeClimbs", "KipPullups", 
				 "KipPullups", "T2B", "C2B"]
RUNS = ["CalRow", "DU"]
SITS = ["Situps", "KBS", "KBSn", "KBC", "GHD", "Slamballs"]
JUMPS = ["BJ", "BBJ", "BJO", "BBJO", "Pistols", "Lunges", "Burpees", "Wallballs"]
LIGHTS = ["OHP", "C&P", "SDLHP", "Snatches", "HS", "PS", "HPS", "Thrusters", "OHS"]
HEAVYS = ["BS", "FS", "DL", "PJ", "PP", "Cleans", "HC", "PC", "HPC", "C&J"]


# the time limits for AMRAP and EMOM
  def time
    unless @wod_type == "RFT"
      return rand(7..21)
    else
      return ""
    end
  end

  def rounds
    if @wod_type == "RFT"
      return rand(1..7)
    end
  end

# selects movements from categories
  def movements
    return [@pull, @run, @sit, @jump, @light, @heavy].shuffle
  end

# if one of the movemnts is a light BB, then the heavy BB defaults to that weight as well
  def weight(movement)
  	if ["KBS", "KBSn", "KBC"].include? movement
  		return ["1", "1.5", "2"].sample + "pd"
  	elsif LIGHTS.include? movement
  	  return (rand(5..9) * 15).to_s + "#"
  	elsif HEAVYS.include? movement
  		return (rand(8..15) * 15).to_s + "#"
  	else
  		return ""
  	end
  end

# number of reps for each movement
  def reps(movement)
    if @wod_type == "EMOM"
      if movement == "DU"
        return rand(2..6) * 4
      else
        return rand(2..6)
      end
    else
      if movement == "DU"
        return rand(3..21) * 4
      else
        return rand(3..21)
      end
    end
  end

  def number_of_sets
    return rand(3..8)
  end

  def print_wod
		if @wod_type == "EMOM"  	
    	"#{@wod_type} #{@time}:\n" +
    	"#{@set1}\n" +
      "#{@set2}\n"
    else
    	"#{@rounds}#{@wod_type}#{@time}:\n" +
      "#{@set1}\n" +
      "#{@set2}\n" +
      "#{@set3}\n" +
      "#{@set4}\n"
    end
  end

end