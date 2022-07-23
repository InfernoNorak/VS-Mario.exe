function onCreate()
	-- background shit
	makeLuaSprite('7 grand stage', '7 grand stage', -600, -350);
	setScrollFactor('7 grand stage', 0.9, 0.9);
	
	makeLuaSprite('blank', 'blank', -650, 600);
	setScrollFactor('blank', 0.9, 0.9);
	scaleObject('blank', 1.1, 1.1);

	-- sprites that only load if Low Quality is turned off
	if not lowQuality then
		makeLuaSprite('blank', 'blank', -125, -100);
		setScrollFactor('blank', 0.9, 0.9);
		scaleObject('blank', 1.1, 1.1);
		
		makeLuaSprite('blank', 'blank', 1225, -100);
		setScrollFactor('blank', 0.9, 0.9);
		scaleObject('blank', 1.1, 1.1);
		setProperty('blank.flipX', true); --mirror sprite horizontally

		makeLuaSprite('blank', 'blank', -500, -300);
		setScrollFactor('blank', 1.3, 1.3);
		scaleObject('blank', 0.9, 0.9);
	end

	addLuaSprite('7 grand stage', false);
	addLuaSprite('blank', false);
	addLuaSprite('blank', false);
	addLuaSprite('blank', false);
	addLuaSprite('blank', false);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end