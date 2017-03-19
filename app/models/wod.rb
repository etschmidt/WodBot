class Wod < ApplicationRecord

  def initialize
    @wod_type = WOD_TYPES.sample
    @time = time
    @rounds = rounds
    @pull = PULLS.first
		@run = RUNS.first
		@sit = SITS.first
		@jump = JUMPS.first
		@light = LIGHTS.first
		@heavy = HEAVYS.first
    @pull2 = PULLS.last
    @run2 = RUNS.last
    @sit2 = SITS.last
    @jump2 = JUMPS.last
    @light2 = LIGHTS.last
    @heavy2 = HEAVYS.last
    @movements = movements
    @movement1 = @movements.at(0)
    @movement2 = @movements.at(1)
    @movement3 = @movements.at(2)
    @movement4 = @movements.at(3)
    @movement5 = @movements.at(4)
    @movement6 = @movements.at(5)
    @movement7 = @movements.at(6)
    @movement8 = @movements.at(7)
    @reps1 = reps(@movement1)
    @reps2 = reps(@movement2)
    @reps3 = reps(@movement3)
    @reps4 = reps(@movement4)
    @reps5 = reps(@movement5)
    @reps6 = reps(@movement6)
    @reps7 = reps(@movement7)
    @reps8 = reps(@movement8)
    @set1 = "#{@reps1} #{@movement1}"
    @set2 = "#{@reps2} #{@movement2}"
    @set3 = "#{@reps3} #{@movement3}"
    @set4 = "#{@reps4} #{@movement4}"
    @set5 = "#{@reps5} #{@movement5}"
    @set6 = "#{@reps6} #{@movement6}"
    @set7 = "#{@reps7} #{@movement7}"
    @set8 = "#{@reps8} #{@movement8}"
    @sets = sets
    @bbweight = bbweight
    @kbweight = kbweight
    @slamweight = slamweight
    @height = height
  end


WOD_TYPES = ["AMRAP", "EMOM", "RFT"]
PULLS = ["StrPullups", "StrHSPU", "BMU", "RMU", "Dips", "RopeClimbs", "KipPullups", 
				 "KipPullups", "T2B", "C2B"].shuffle
RUNS = ["CalRow", "DU", "Run"].shuffle
SITS = ["Situps", "KBS", "KBSn", "KBC", "GHD", "Slamballs"].shuffle
JUMPS = ["BJ", "BBJ", "BJO", "BBJO", "AirSquats", "Pistols", "Lunges",
         "Burpees", "Wallballs"].shuffle
LIGHTS = ["OHP", "C&P", "SDLHP", "Snatches", "HS", "PS", "HPS", "Thrusters", "OHS"].shuffle
HEAVYS = ["BS", "FS", "DL", "PJ", "PP", "Cleans", "HC", "PC", "HPC", "C&J"].shuffle


# the time limits for AMRAP and EMOM
  def time
    unless @wod_type == "RFT"
      return rand(7..21)
    end
  end

  def rounds
    if @wod_type == "RFT"
      return rand(1..7)
    end
  end

# selects movements from categories
  def movements
    if @wod_type == "EMOM"
      return [@pull, @sit, @jump, @light, @heavy, 
            @pull2, @sit2, @jump2, @light2, @heavy2].shuffle
    else
      return [@pull, @run, @sit, @jump, @light, @heavy, 
            @pull2, @run2, @sit2, @jump2, @light2, @heavy2].shuffle
    end
  end

# if one of the movemnts is a light BB, then the heavy BB defaults to that weight as well
  def bbweight
    if @movements.include? @light
      return ["75/55", "95/65", "115/85", "135/95"].sample + "#\n"
    elsif @movements.include? @heavy
      return ["115/85", "135/95", "155/105", "185/115", "205/135", "225/155"].sample + "#\n"
    end
  end

  def kbweight
    if @movements.include? "KBS" || "KBSn" || "KBC"
      return ["1", "1.5", "2"].sample + "pd\n"
    end
  end

  def slamweight
    if @movements.include? "Slamballs"
      return ["20/15", "30/20", "40/30"].sample + "#\n"
    end
  end

  def height
    if @movements.include? @jump
      if @jump.include? "BJ" || "BBJ" || "BJO" || "BBJO"
        return ["24/20", "30/24"].sample + "\"\n"
      end
    end
  end

# number of reps for each movement
  def reps(movement)
    if @wod_type == "EMOM"
      if movement == "DU"
        return rand(2..5) * 4
      else
        return rand(2..5)
      end
    else
      if movement == "DU"
        return rand(3..21) * 4
      elsif movement =="Run"
        return ["100", "200", "300", "400"].sample + "m"
      else
        return rand(3..21)
      end
    end
  end

  def sets
    if @wod_type == "EMOM"
      return ["#{@set1}", "#{@set2}", "#{@set3}", "#{@set4}",
              "#{@set5}", "#{@set6}", "#{@set7}", "#{@set8}"]
              .sample(rand(2..3)).map { |i| "" + i.to_s + "" }.join("\n")
    else
      return ["#{@set1}", "#{@set2}", "#{@set3}", "#{@set4}",
              "#{@set5}", "#{@set6}", "#{@set7}", "#{@set8}"]
              .sample(rand(3..8)).map { |i| "" + i.to_s + "" }.join("\n")
    end
  end

  def print_wod
		if @wod_type == "EMOM"  	
    	"#{@wod_type} #{@time}:\n\n" +
    	"#{@sets}\n\n" +
      "#{@bbweight}" +
      "#{@kbweight}" +
      "#{@height}" +
      "#{@slamweight}"
    else
    	"#{@rounds}#{@wod_type}#{@time}:\n\n" +
      "#{@sets}\n\n" +
      "#{@bbweight}" +
      "#{@kbweight}" +
      "#{@height}" +
      "#{@slamweight}"
    end
  end

end