-- Main Programm for mining
function program()
	for interval = 1, 4, 1 do
		repeat
			turtle.dig() -- Block 1
		until(turtle.detect() == false)
		turtle.forward()
		repeat
			turtle.digUp() -- Block 2
		until(turtle.detectUp() == false)
		turtle.digDown() -- Block 3
		turtle.turnLeft()
		repeat
			turtle.dig() -- Block 4
		until(turtle.detect() == false)
		turtle.forward()
		repeat
			turtle.digUp() -- Block 5
		until(turtle.detectUp() == false)
		turtle.digDown() -- Block 6
		turtle.turnRight()
		
		repeat
			turtle.dig() -- Block 7
		until(turtle.detect() == false)
		turtle.forward()
		repeat
			turtle.digUp() -- Block 8
		until(turtle.detectUp() == false)
		turtle.digDown() -- Block 9
		turtle.turnRight()
		repeat
			turtle.dig() -- Block 10
		until(turtle.detect() == false)
		turtle.forward() 
		repeat
			turtle.digUp() -- Block 11
		until(turtle.detectUp() == false)
		turtle.digDown() -- Block 12
		turtle.turnLeft()
	end
	placeTorch()
end

function storeItems()
	local success, data = turtle.inspectDown()

	if success and string.match(data.name, "chest") then
		for i = 1, 16, 1 do
			if turtle.getItemDetail(i) ~= nil then
				local item = turtle.getItemDetail(i)
				if string.match(item.name, "torch") then	
				else
					turtle.select(i)
					turtle.dropDown()
				end
			end
		end
	end
end

function placeTorch()
	for i = 1, 16, 1 do
		if turtle.getItemDetail(i) ~= nil then
			local item = turtle.getItemDetail(i)
			if string.match(item.name, "torch") then
				turtle.select(i)
				turtle.placeDown()
			end
		end		
	end
end

-- Function for fuel
function refill()
	for i = 1, 16, 1 do
		if turtle.refuel(_fuelLimit) == true then
			_currentFuel = turtle.getFuelLevel()
			print("Erfolgreich getankt!")
			print("Tank: " .._currentFuel)
			return
		end
	end
	print("Vorsicht!")
	print("Die Turtle kann nicht mehr aufgefüllt werden!")
	print("\n")
end

function analyzeTank(dis)
	local waste = 24
	local totalWaste = waste * dis
	return totalWaste
end

local _currentFuel = turtle.getFuelLevel()

local emptyFuel = false
local _setDistance = 5

local _fuelLimit = turtle.getFuelLimit()

if _currentFuel == 0 then
	print("Vorsicht!") 
	print("Der Tank ist leer!")
	print("\n")
	
	print("Möchtest du den Tank auffüllen?  1 = Ja")
	local input = 0
	input = read()

	if input == 1 then
		refill()
	end
	if _currentFuel == 0 then
		emptyFuel = true
	end
end
if emptyFuel == false then
	print("Tank: " .._currentFuel)
	print("Geben Sie die Distanz an: Warnung 1 Distanz = 8 Blöcke")
	_setDistance = read()
	
	if analyzeTank(_setDistance) > _currentFuel then
		print("Vorsicht!") 
		print("Tank reicht nicht aus!")
		print("\n")
		
		print("Möchtest du den Tank auffüllen?  1 = Ja")
		local input = 0
		input = read()
		
		if input == 1 then
			refill()
		end
	end
	
	if emptyFuel == true then
		return;
	end

	local distance = _setDistance * 8
	print ("Die Distanz beträgt " ..distance)
	print("Programm wird gestartet...")
	for index = 1, _setDistance, 1 do
		program()
	end
	
	print ("Programm beendet")
	for index = 1, distance, 1 do
		turtle.back()
	end
	storeItems()
end