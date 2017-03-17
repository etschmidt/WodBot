class Wod < ApplicationRecord

  def initialize
    @wod_type = WOD_TYPES.sample
    @time = time
    @pull = PULLS.sample
		@run = RUNS.sample
		@sit = SIT.sample
		@jump = JUMPS.sample
		@light = LIGHTS.sample
		@heavy = HEAVYS.sample
  # @pull2 = PULLS.sample
	#	@run2 = RUNS.sample
	#	@sit2 = SIT.sample
	#	@jump2 = JUMPS.sample
	#	@light2 = LIGHTS.sample
	#	@heavy2 = HEAVYS.sample

  end


WOD_TYPES = ["AMRAP", "EMOM", "RFT"]
PULLS = ["StrPullup", "StrHSPU", "BMU", "RMU", "dip", "RopeClimb", "KipPullup", 
				 "KipPullup", "T2B", "C2B"]
RUNS = ["CalRow", "4xDU"]
SITS = ["Situp", "KBS", "KBSn", "KBC", "GHD", "Slamball"]
JUMPS = ["BJ", "BBJ", "BJO", "BBJO", "Pistol", "Lunge", "Burpee", "Wallball"]
LIGHTS = ["OHP", "C&P", "SDLHP", "Snatch", "HS", "PS", "HPS", "Thruster", "OHS"]
HEAVYS = ["BS", "FS", "DL", "PJ", "PP", "Clean", "HC", "PC", "HPC", "C&J"]


# the time limits for AMRAP and EMOM
  def time
    unless @wod_type == "RFT"
      return rand(7..21)
    else
      return ""
    end
  end

# selects movements from categories
  def movements
    @movements = [@pull, @run, @sit, @jump, @light, @heavy].shuffle
    @movement1 = @movements.at(0)
    @movement2 = @movements.at(1)
    @movement3 = @movements.at(2)
    @movement4 = @movements.at(3)
  end

# if one of the movemnts is a light BB, then the heavy BB defaults to that weight as well
  def weight(movement)
  	if ["KBS", "KBSn", "KBC"].include? movement
  		return rand(1, 1.5, 2) + "pd"
  	elsif LIGHTS.include? movement
  	  return  rand(5..9) * 15
  	elsif HEAVYS.include? movement
  		return rand(8..15) * 15
  	else
  		return ""
  	end
  end
  	   	 
  def weights
  	@weight1 = weight(@movement1)
  	@weight2 = weight(@movement2)
  	@weight3 = weight(@movement3)
  	@weight4 = weight(@movement4)
  end

# number of reps for each movement
  def reps
    if @wod_type == "AMRAP"
    	@rounds = ""
      @reps1 = rand(3..20)
      @reps2 = rand(3..20)
      @reps3 = rand(3..20) 
      @reps4 = rand(3..20)
    elsif @wod_type == "RFT"
    	@rounds = rand(1..7)
      @reps1 = rand(3..20)
      @reps2 = rand(3..20)
      @reps3 = rand(3..20) 
      @reps4 = rand(3..20)
    else 
    	@rounds = ""
      @reps1 = rand(1..5)
      @reps2 = rand(1..5)
    end
  end

  def print_wod
		if @wod_type == "EMOM"  	
    	"#{@wod_type}#{@time}\n" +
    	"#{@reps1}" + "#{@movement1}" + "#{@weight1}\n" +
    	"#{@reps2}" + "#{@movement2}" + "#{@weight2}\n"
    else
    	"#{@rounds}#{@wod_type}#{@time}\n" +
    	"#{@reps1}" + "#{@movement1}" + "#{@weight1}\n" +
    	"#{@reps2}" + "#{@movement2}" + "#{@weight2}\n" +
    	"#{@reps3}" + "#{@movement3}" + "#{@weight3}\n" +
    	"#{@reps4}" + "#{@movement4}" + "#{@weight4}\n"
    end
  end

end