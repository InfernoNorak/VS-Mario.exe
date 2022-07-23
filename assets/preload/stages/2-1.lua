function onCreate()
	-- background shit
	makeLuaSprite('2-1', '2-1', -500, -300);
	setLuaSpriteScrollFactor('2-1', 0.9, 0.9);
	
makeAnimatedLuaSprite('mario','mario', 1000,300)addAnimationByPrefix('mario','dance','Symbol',24,true)
objectPlayAnimation('dance','dance',false)
setScrollFactor('mario', 0.9, 0.9);

	makeLuaSprite('blank', 'blank', -650, 600);
	setLuaSpriteScrollFactor('blank', 0.9, 0.9);
	scaleObject('blank', 1.1, 1.1);

	-- sprites that only load if Low Quality is turned off
	if not lowQuality then
		makeLuaSprite('blank', 'mario', -125, -100);
		setLuaSpriteScrollFactor('blank', 0.9, 0.9);
		scaleObject('blank', 1.1, 1.1);
		
		makeLuaSprite('blank', 'blank', 1225, -100);
		setLuaSpriteScrollFactor('blank', 0.9, 0.9);
		scaleObject('mario', 1.1, 1.1);
		setPropertyLuaSprite('car', 'flipX', true); --mirror sprite horizontally

		makeLuaSprite('blank', 'blank', -500, -300);
		setLuaSpriteScrollFactor('blank', 1.3, 1.3);
		scaleObject('blank', 0.9, 0.9);
	end

	addLuaSprite('2-1', false);
	addLuaSprite('blank', false);
	addLuaSprite('blank', false);
	addLuaSprite('blank', false);
        addLuaSprite('mario',false,'flipX');

	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end