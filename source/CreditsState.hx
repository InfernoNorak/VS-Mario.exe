package;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
#if MODS_ALLOWED
import sys.FileSystem;
import sys.io.File;
#end
import lime.utils.Assets;

using StringTools;

class CreditsState extends MusicBeatState
{
	var curSelected:Int = -1;

	private var grpOptions:FlxTypedGroup<Alphabet>;
	private var iconArray:Array<AttachedSprite> = [];
	private var creditsStuff:Array<Array<String>> = [];

	var bg:FlxSprite;
	var descText:FlxText;
	var intendedColor:Int;
	var colorTween:FlxTween;
	var descBox:AttachedSprite;

	var offsetThing:Float = -75;

	override function create()
	{
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		persistentUpdate = true;
		bg = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		add(bg);
		bg.screenCenter();
		
		grpOptions = new FlxTypedGroup<Alphabet>();
		add(grpOptions);

		#if MODS_ALLOWED
		var path:String = 'modsList.txt';
		if(FileSystem.exists(path))
		{
			var leMods:Array<String> = CoolUtil.coolTextFile(path);
			for (i in 0...leMods.length)
			{
				if(leMods.length > 1 && leMods[0].length > 0) {
					var modSplit:Array<String> = leMods[i].split('|');
					if(!Paths.ignoreModFolders.contains(modSplit[0].toLowerCase()) && !modsAdded.contains(modSplit[0]))
					{
						if(modSplit[1] == '1')
							pushModCreditsToList(modSplit[0]);
						else
							modsAdded.push(modSplit[0]);
					}
				}
			}
		}

		var arrayOfFolders:Array<String> = Paths.getModDirectories();
		arrayOfFolders.push('');
		for (folder in arrayOfFolders)
		{
			pushModCreditsToList(folder);
		}
		#end

		var pisspoop:Array<Array<String>> = [ //Name - Icon name - Description - Link - BG Color
			['Vs mario.exe team'],
			['ajofilms',		'ajofilms',		'Director and artist',							'https://gamejolt.com/@ajofilms',	'3A0159'],
			['TrevorKrafters',			'trevor',		'second in command',						'https://www.youtube.com/channel/UC6argbOMRb8Nn7m14T2Fgsg',		'51F934'],
			['InfernoGaming',				'inferno',			'coder of vs mario.exe',					'https://www.youtube.com/channel/UCtbXQjBrCwPP_gxtMhfsXEQ',			'ff0000'],
			['gavinmiddleton',				'gavinmiddleton',			'Main composer and second charter',					'https://gamejolt.com/@gavinmiddleton',			'FFFFFF'],
			['nintegafan100',				'nintegafan100',			'Backround artist sometimes',					'https:https://twitter.com/nintegafan100',			'FE0000'],
			['iDarkGamez',				'Idarkgamez',			'main charter',					'https:https://gamejolt.com/@iDG',			'3854EF'],
			['dantetheytdevil',				'dante',			'Beta tester',					'https://www.youtube.com/c/DanteTheYTDevilSubToMeNowOrElseSherkTakesUrMumL0L',			'F0B753'],
			['pablo6440',				'pablo6440',			'second beta tester',					'https://gamejolt.com/@Pablo6440',			'00BFFF'],
			['C0URT J3ST3R',				'redalertDOOT',			'icons',					'https://gamejolt.com/@C0URT_J3ST3R',			'FFFFFF'],
			['Coolskull212',				'coolskull',			'3rd artist',					'https://gamejolt.com/@CoolSkull212',			'50EEFF'],
			['Mr. pixel productions', 'mrpixel', '3rd beta tester', 'https://gamejolt.com/@MrPixelGames', '068900'],
			['Vs mario.exe art style'],
			['TrevorKrafters',			'trevor',		'gave me the permission to use his artstyle for this mod',						'https://www.youtube.com/channel/UC6argbOMRb8Nn7m14T2Fgsg',		'51F934'],
			[''],
			['Vs mario.exe supporters'],
			['Christopher Games',				'Christopher Games',			'good guy',	'https:https://gamejolt.com/@unknownter',			'E1F1D2'],
			['NercoPhatic',			'bigshotbraker',			'helps with character ideas',						'https://gamejolt.com/@BigShotBreaker-RONIFIED',			'CCC70E'],
			['VALENTITEOYGUIGUI',		'valenlieoyguigui',	'also helped with character ideas',								'https://gamejolt.com/@VALENTITEOYGUIGUI',	'22260B'],
			['arandomperson',				'arandomperson',			'another good guy',									'@aRandomPerson_Gamejolt_',			'F54021'],
			[''],
			["creators of the characters"],
			['coolrash',		'coolrash',	"creator of mario.exe",						'https://gamejolt.com/@coolrash',	'080532'],
			['Tarkan809',		'tarkan',	"creator of ink mario",							'https://gamejolt.com/@Tarkan809',	'00e926'],
			['WWWwario',			'wwwwario',			"creator of headless mario",							'https://gamejolt.com/@WwwWarioo',			'fbff00'],
			['TerminalMontage',			'TerminalMontage',		"creator of speedrunner mario",							'https://www.youtube.com/channel/UCLFXk9J3O-hhOk0msOjKYdQ',		'004d4b'],
			['slimebeast',			'slimebeast',		"creator of I hate you.exe and the drowned mario corpses",							'https://www.youtube.com/c/Slimebeast/featured',		'51F934'],
			['J.Y company',			'JY_company',		"creator of 7 grand dad",							'https://bootleggames.fandom.com/wiki/J.Y._Company#:~:text=Company%20(Chinese%3A%20%E6%99%B6%E5%A4%AA),to%20possibly%20the%20mid%202000s',		'D82800'],
			['Vinesause',			'vinesause',		"creator of sponge and pretzel",							'https://twitter.com/Vinesauce?ref_src=twsrc%5Egoogle%7Ctwcamp%5Eserp%7Ctwgr%5Eauthor',		'76EBB1'],
			['brentafloss',			'brentafloss',		"creator of dr mario with lyrics",							'https://www.youtube.com/user/brentalfloss',		'006699'],
			['classicsonic124',			'classicsonic124',		"creator of mario.unzipped",							'https://gamejolt.com/@ClassicSonic124',		'083BCE'],
			['ziggity',			'ziggity',		"creator of super mario dolor",							'https://twitter.com/ZiggityO',		'083BCE'],
			['jeff rovin',			'jeff_rovin',		"creator of chocolate hoax mario",							'https://gaming-urban-legends.fandom.com/wiki/Chocolate_Factory_Level',		'CCCCCC']
		];
		
		for(i in pisspoop){
			creditsStuff.push(i);
		}
	
		for (i in 0...creditsStuff.length)
		{
			var isSelectable:Bool = !unselectableCheck(i);
			var optionText:Alphabet = new Alphabet(0, 70 * i, creditsStuff[i][0], !isSelectable, false);
			optionText.isMenuItem = true;
			optionText.screenCenter(X);
			optionText.yAdd -= 70;
			if(isSelectable) {
				optionText.x -= 70;
			}
			optionText.forceX = optionText.x;
			//optionText.yMult = 90;
			optionText.targetY = i;
			grpOptions.add(optionText);

			if(isSelectable) {
				if(creditsStuff[i][5] != null)
				{
					Paths.currentModDirectory = creditsStuff[i][5];
				}

				var icon:AttachedSprite = new AttachedSprite('credits/' + creditsStuff[i][1]);
				icon.xAdd = optionText.width + 10;
				icon.sprTracker = optionText;
	
				// using a FlxGroup is too much fuss!
				iconArray.push(icon);
				add(icon);
				Paths.currentModDirectory = '';

				if(curSelected == -1) curSelected = i;
			}
		}
		
		descBox = new AttachedSprite();
		descBox.makeGraphic(1, 1, FlxColor.BLACK);
		descBox.xAdd = -10;
		descBox.yAdd = -10;
		descBox.alphaMult = 0.6;
		descBox.alpha = 0.6;
		add(descBox);

		descText = new FlxText(50, FlxG.height + offsetThing - 25, 1180, "", 32);
		descText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER/*, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK*/);
		descText.scrollFactor.set();
		//descText.borderSize = 2.4;
		descBox.sprTracker = descText;
		add(descText);

		bg.color = getCurrentBGColor();
		intendedColor = bg.color;
		changeSelection();
		super.create();
	}

	var quitting:Bool = false;
	var holdTime:Float = 0;
	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		if(!quitting)
		{
			if(creditsStuff.length > 1)
			{
				var shiftMult:Int = 1;
				if(FlxG.keys.pressed.SHIFT) shiftMult = 3;

				var upP = controls.UI_UP_P;
				var downP = controls.UI_DOWN_P;

				if (upP)
				{
					changeSelection(-1 * shiftMult);
					holdTime = 0;
				}
				if (downP)
				{
					changeSelection(1 * shiftMult);
					holdTime = 0;
				}

				if(controls.UI_DOWN || controls.UI_UP)
				{
					var checkLastHold:Int = Math.floor((holdTime - 0.5) * 10);
					holdTime += elapsed;
					var checkNewHold:Int = Math.floor((holdTime - 0.5) * 10);

					if(holdTime > 0.5 && checkNewHold - checkLastHold > 0)
					{
						changeSelection((checkNewHold - checkLastHold) * (controls.UI_UP ? -shiftMult : shiftMult));
					}
				}
			}

			if(controls.ACCEPT) {
				CoolUtil.browserLoad(creditsStuff[curSelected][3]);
			}
			if (controls.BACK)
			{
				if(colorTween != null) {
					colorTween.cancel();
				}
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new MainMenuState());
				quitting = true;
			}
		}
		
		for (item in grpOptions.members)
		{
			if(!item.isBold)
			{
				var lerpVal:Float = CoolUtil.boundTo(elapsed * 12, 0, 1);
				if(item.targetY == 0)
				{
					var lastX:Float = item.x;
					item.screenCenter(X);
					item.x = FlxMath.lerp(lastX, item.x - 70, lerpVal);
					item.forceX = item.x;
				}
				else
				{
					item.x = FlxMath.lerp(item.x, 200 + -40 * Math.abs(item.targetY), lerpVal);
					item.forceX = item.x;
				}
			}
		}
		super.update(elapsed);
	}

	var moveTween:FlxTween = null;
	function changeSelection(change:Int = 0)
	{
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		do {
			curSelected += change;
			if (curSelected < 0)
				curSelected = creditsStuff.length - 1;
			if (curSelected >= creditsStuff.length)
				curSelected = 0;
		} while(unselectableCheck(curSelected));

		var newColor:Int =  getCurrentBGColor();
		if(newColor != intendedColor) {
			if(colorTween != null) {
				colorTween.cancel();
			}
			intendedColor = newColor;
			colorTween = FlxTween.color(bg, 1, bg.color, intendedColor, {
				onComplete: function(twn:FlxTween) {
					colorTween = null;
				}
			});
		}

		var bullShit:Int = 0;

		for (item in grpOptions.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			if(!unselectableCheck(bullShit-1)) {
				item.alpha = 0.6;
				if (item.targetY == 0) {
					item.alpha = 1;
				}
			}
		}

		descText.text = creditsStuff[curSelected][2];
		descText.y = FlxG.height - descText.height + offsetThing - 60;

		if(moveTween != null) moveTween.cancel();
		moveTween = FlxTween.tween(descText, {y : descText.y + 75}, 0.25, {ease: FlxEase.sineOut});

		descBox.setGraphicSize(Std.int(descText.width + 20), Std.int(descText.height + 25));
		descBox.updateHitbox();
	}

	#if MODS_ALLOWED
	private var modsAdded:Array<String> = [];
	function pushModCreditsToList(folder:String)
	{
		if(modsAdded.contains(folder)) return;

		var creditsFile:String = null;
		if(folder != null && folder.trim().length > 0) creditsFile = Paths.mods(folder + '/data/credits.txt');
		else creditsFile = Paths.mods('data/credits.txt');

		if (FileSystem.exists(creditsFile))
		{
			var firstarray:Array<String> = File.getContent(creditsFile).split('\n');
			for(i in firstarray)
			{
				var arr:Array<String> = i.replace('\\n', '\n').split("::");
				if(arr.length >= 5) arr.push(folder);
				creditsStuff.push(arr);
			}
			creditsStuff.push(['']);
		}
		modsAdded.push(folder);
	}
	#end

	function getCurrentBGColor() {
		var bgColor:String = creditsStuff[curSelected][4];
		if(!bgColor.startsWith('0x')) {
			bgColor = '0xFF' + bgColor;
		}
		return Std.parseInt(bgColor);
	}

	private function unselectableCheck(num:Int):Bool {
		return creditsStuff[num].length <= 1;
	}
}