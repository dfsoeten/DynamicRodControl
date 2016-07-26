--Define Objects
  local reactors = {
  peripheral.wrap("BigReactors-Reactor_1"),
  peripheral.wrap("BigReactors-Reactor_2"),
  peripheral.wrap("BigReactors-Reactor_3"),
  peripheral.wrap("BigReactors-Reactor_4"),
  peripheral.wrap("BigReactors-Reactor_5"),
  peripheral.wrap("BigReactors-Reactor_6"),
  peripheral.wrap("BigReactors-Reactor_7"),
  peripheral.wrap("BigReactors-Reactor_8"),
  peripheral.wrap("BigReactors-Reactor_9"),
  peripheral.wrap("BigReactors-Reactor_10")
  }
  
  local monitors = {
	 peripheral.wrap("monitor_0") 
  }
  
--Define table
  local rodper = {
  reactors[1].getControlRodLevel(1),
  reactors[2].getControlRodLevel(1),
  reactors[3].getControlRodLevel(1),
  reactors[4].getControlRodLevel(1),
  reactors[5].getControlRodLevel(1),
  reactors[6].getControlRodLevel(1),
  reactors[7].getControlRodLevel(1),
  reactors[8].getControlRodLevel(1),
  reactors[9].getControlRodLevel(1),
  reactors[10].getControlRodLevel(1)
  }
  
--Define Variables
message = ""
totalPowerOutput = ""

--Config
local below = 7000000 --When get's below this number increase power
local above = 900000 --When get's above this number decrease power
local timeout = 0,1 --How many seconds per loop 

--Define Functions
function showstats(x) 
 monitors[1].clear()
 
 draw(1, 1, 1, 1, 32,
  "                  REACTOR STATUS                                  ")
 draw(1, 1, 2, 1, 8192, 
  "                      Dan 2016                                    ")
        
	totalPowerOutput = (
	    	reactors[1].getEnergyProducedLastTick()+
		    reactors[2].getEnergyProducedLastTick()+
	    	reactors[3].getEnergyProducedLastTick()+
	    	reactors[4].getEnergyProducedLastTick()+
		    reactors[5].getEnergyProducedLastTick()+
		    reactors[6].getEnergyProducedLastTick()+
		    reactors[7].getEnergyProducedLastTick()+
		    reactors[8].getEnergyProducedLastTick()+
		    reactors[9].getEnergyProducedLastTick()+
		    reactors[10].getEnergyProducedLastTick()
	   )
	message = "Output: "
	draw(1, 1, 4, 1, 32768, message)
	
	if totalPowerOutput < 800000 then
		message = (totalPowerOutput /1000).." KRF/T"
		draw(1, 9, 4, 32, 32768, message)
	elseif totalPowerOutput > 950000 then	
		message = (totalPowerOutput /1000).." KRF/T"
		draw(1, 9, 4, 16384, 32768, message)
	else
		message = (totalPowerOutput /1000).." KRF/T"
		draw(1, 9, 4, 2, 32768, message)
	end
	
	draw(1, 1, 5, 1, 32768, "Reactor 1 - Insert %:  "..reactors[1].getControlRodLevel(1))
	draw(1, 1, 6, 1, 32768, "Reactor 2 - Insert %:  "..reactors[2].getControlRodLevel(1))
	draw(1, 1, 7, 1, 32768, "Reactor 3 - Insert %:  "..reactors[3].getControlRodLevel(1))
	draw(1, 1, 8, 1, 32768, "Reactor 4 - Insert %:  "..reactors[4].getControlRodLevel(1))
	draw(1, 1, 9, 1, 32768, "Reactor 5 - Insert %:  "..reactors[5].getControlRodLevel(1))
	draw(1, 1, 10, 1, 32768, "Reactor 6 - Insert %:  "..reactors[6].getControlRodLevel(1))
	draw(1, 1, 11, 1, 32768, "Reactor 7 - Insert %:  "..reactors[7].getControlRodLevel(1))
	draw(1, 1, 12, 1, 32768, "Reactor 8 - Insert %:  "..reactors[8].getControlRodLevel(1))
	draw(1, 1, 13, 1, 32768, "Reactor 9 - Insert %:  "..reactors[9].getControlRodLevel(1))
	draw(1, 1, 14, 1, 32768, "Reactor 10 - Insert %: "..reactors[10].getControlRodLevel(1))
	
end




function draw(tx, x, y, fcl, bcl, mes)
    monitors[1].setTextScale(tx)
    monitors[1].setCursorPos(x, y)
   	monitors[1].setTextColor(fcl)
	   monitors[1].setBackgroundColor(bcl)
    monitors[1].write(mes)
end

function reactorControl(i)
  --If energy stored gets below 7000000
  if reactors[i].getEnergyStored() < below then
    reactors[i].setAllControlRodLevels(rodper[i])
    if rodper[i] > 0 then
      rodper[i] = rodper[i] -5
    end  
   	showstats(i)
    sleep(timeout)
  --If energy stored gets above 900000
  --Decrease reactor power
  elseif reactors[i].getEnergyStored() > above then
    reactors[i].setAllControlRodLevels(rodper[i])
    if rodper[i] < 100 then
      rodper[i] = rodper[i] +5
    end
   	showstats(i)
    sleep(timeout)
  end
end

--Program
while true do 
  reactorControl(1)
  reactorControl(2)
  reactorControl(3)
  reactorControl(4)
  reactorControl(5)
  reactorControl(6)
  reactorControl(7)
  reactorControl(8)
  reactorControl(9)
  reactorControl(10)
end  

