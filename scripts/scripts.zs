import crafttweaker.events.IEventManager;
import crafttweaker.event.EntityMountEvent;
import crafttweaker.world.IWorld;
import crafttweaker.event.IEventCancelable;
import crafttweaker.command.ICommandManager;
import crafttweaker.player.IPlayer;
import crafttweaker.event.PlayerPickupItemEvent;
import crafttweaker.player.IFoodStats;

recipes.removeShaped(<harvestcraft:market>, [[<ore:plankWood>, <ore:wool>, <ore:plankWood>],[<ore:wool>, <minecraft:emerald>, <ore:wool>], [<ore:plankWood>, <ore:wool>, <ore:plankWood>]]);
recipes.removeShaped(<harvestcraft:shippingbin>, [[<ore:plankWood>, <ore:logWood>, <ore:plankWood>],[<ore:logWood>, <minecraft:emerald>, <ore:logWood>], [<ore:plankWood>, <ore:logWood>, <ore:plankWood>]]);
recipes.removeShaped(<effortlessbuilding:reach_upgrade1>, [[null, <minecraft:string>],[<minecraft:stick>, null]]);
recipes.removeShaped(<effortlessbuilding:reach_upgrade2>, [[null, <minecraft:magma_cream>],[<minecraft:bone>, null]]);
recipes.removeShaped(<effortlessbuilding:reach_upgrade3>, [[null, <minecraft:feather>, <minecraft:ender_eye>],[null, <minecraft:blaze_rod>, <minecraft:feather>], [<minecraft:blaze_rod>, null, null]]);
recipes.removeShaped(<bibliocraft:maptool>, [[null, <minecraft:iron_ingot>, null],[<minecraft:iron_ingot>, null, <minecraft:iron_ingot>], [<minecraft:stick>, null, <minecraft:stick>]]);
recipes.removeShaped(<galacticraftplanets:mars_machine:8>, [[<galacticraftplanets:item_basic_mars:2>, <galacticraftcore:basic_item:19>, <galacticraftplanets:item_basic_mars:2>],[<galacticraftplanets:item_basic_mars:5>, <galacticraftcore:basic_item:14>, <galacticraftplanets:item_basic_mars:5>], [<galacticraftplanets:item_basic_mars:2>, <galacticraftcore:aluminum_wire:0>, <galacticraftplanets:item_basic_mars:2>]]);
recipes.removeShapeless(<grapplemod:launcheritem>, [<minecraft:piston>, <minecraft:ender_pearl>]);
recipes.removeShapeless(<grapplemod:staffupgradeitem>, [<grapplemod:launcheritem>, <grapplemod:baseupgradeitem>]);
recipes.removeShaped(<waystones:waystone>, [[null, <minecraft:stonebrick>, null],[<minecraft:stonebrick>, <waystones:warp_stone>, <minecraft:stonebrick>], [<minecraft:obsidian>, <minecraft:obsidian>, <minecraft:obsidian>]]);
recipes.addShaped(<minecraft:diamond_horse_armor>, [[<ore:gemDiamond>, null, <ore:gemDiamond>],[<ore:gemDiamond>, <ore:gemDiamond>, <ore:gemDiamond>], [<ore:gemDiamond>, null, <ore:gemDiamond>]]);
recipes.addShaped(<minecraft:golden_horse_armor>, [[<ore:ingotGold>, null, <ore:ingotGold>],[<ore:ingotGold>, <ore:ingotGold>, <ore:ingotGold>], [<ore:ingotGold>, null, <ore:ingotGold>]]);
recipes.addShaped(<minecraft:iron_horse_armor>, [[<ore:ingotIron>, null, <ore:ingotIron>],[<ore:ingotIron>, <ore:ingotIron>, <ore:ingotIron>], [<ore:ingotIron>, null, <ore:ingotIron>]]);
recipes.addShaped(<minecraft:saddle>, [[<ore:leather>, <ore:leather>, <ore:leather>],[<ore:leather>, null, <ore:leather>], [<ore:ingotIron>, null, <ore:ingotIron>]]);
recipes.addShapeless(<minecraft:name_tag>, [<ore:string>, <ore:paper>]);
recipes.addShapeless(<harvestcraft:freshmilkitem>, [<betteranimalsplus:goatmilk>]);
recipes.addShaped(<waystones:waystone>, [[<ore:gemDiamond>, <minecraft:stonebrick>, <ore:gemDiamond>],[<minecraft:stonebrick>, <waystones:warp_stone>, <minecraft:stonebrick>], [<minecraft:obsidian>, <minecraft:obsidian>, <minecraft:obsidian>]]);
recipes.addShapeless(<quark:rune:6>, [<quark:rune:0>, <ore:dyeRed>]);
recipes.addShapeless(<quark:rune:6>, [<quark:rune:14>, <ore:dyeWhite>]);
recipes.addShapeless(<quark:rune:7>, [<quark:rune:0>, <ore:dyeBlack>]);
recipes.addShapeless(<quark:rune:7>, [<quark:rune:15>, <ore:dyeWhite>]);
recipes.addShapeless(<quark:rune:8>, [<quark:rune:0>, <ore:dyeBlack>, <ore:dyeBlack>]);
recipes.addShapeless(<quark:rune:8>, [<quark:rune:15>, <ore:dyeWhite>, <ore:dyeWhite>]);
recipes.addShapeless(<quark:rune:9>, [<quark:rune:11>, <ore:dyeGreen>]);
recipes.addShapeless(<quark:rune:9>, [<quark:rune:13>, <ore:dyeBlue>]);
recipes.addShapeless(<quark:rune:10>, [<quark:rune:11>, <ore:dyeRed>]);
recipes.addShapeless(<quark:rune:10>, [<quark:rune:14>, <ore:dyeBlue>]);
recipes.addShapeless(<quark:rune:12>, [<quark:rune:0>, <ore:dyeBrown>]);
recipes.addShapeless(<quark:rune:13>, [<quark:rune:4>, <ore:dyeBlue>]);
recipes.addShapeless(<quark:rune:13>, [<quark:rune:11>, <ore:dyeYellow>]);

mods.orestages.OreStages.addReplacement("diamondBlock", <minecraft:diamond_ore>, <minecraft:stone>);

events.onPlayerAdvancement(function(adv as crafttweaker.event.PlayerAdvancementEvent) {
	if (adv.id == "minecraft:story/smelt_iron") {
		adv.player.addGameStage("diamondStart");
		adv.player.addGameStage("diamondBlock");
	}
});

events.onPlayerLoggedIn(function(login as crafttweaker.event.PlayerLoggedInEvent) {
	if (login.player.hasGameStage("diamondStart") == true && login.player.hasGameStage("diamondBlock") == false && login.player.foodStats.foodLevel > 10 && login.player.y > 63) {
		login.player.addGameStage("diamondBlock");
	}
});

events.onPlayerPickupItem(function(pickup as crafttweaker.event.PlayerPickupItemEvent) {
	if (pickup.item.item.name == "item.diamond") {
		server.commandManager.executeCommand(server, "playsound cave1 ambient "~pickup.player.name~" ~ ~ ~ 0");
		var test = pickup.player.foodStats.foodLevel;
		pickup.player.foodStats.foodLevel -= 2;
		if (pickup.player.foodStats.foodLevel >= 2 && pickup.player.foodStats.foodLevel != test - 2) {
			pickup.player.removeGameStage("diamondBlock");
			pickup.player.removeGameStage("diamondStart");
			server.commandManager.executeCommand(server, "kick "~pickup.player.name~" Unexpected behavior. Please contact an admin.");
		}
		if (pickup.player.foodStats.foodLevel < 1 && pickup.player.hasGameStage("diamondBlock")) {
			pickup.player.removeGameStage("diamondBlock");
		}
		if (pickup.player.foodStats.foodLevel > 20) {
			pickup.player.removeGameStage("diamondBlock");
			pickup.player.removeGameStage("diamondStart");
			server.commandManager.executeCommand(server, "kick "~pickup.player.name~" Unexpected behavior. Please contact an admin.");
		}
	} else {
		if (pickup.player.hasGameStage("diamondBlock") == false && pickup.player.hasGameStage("diamondStart") == true && pickup.player.foodStats.foodLevel > 10 && pickup.player.y > 63) {
			pickup.player.addGameStage("diamondBlock");
		}
	}
});

events.onPlayerChangedDimension(function(dim as crafttweaker.event.PlayerChangedDimensionEvent) {
	if (dim.toWorld.dimension != 0 && dim.toWorld.dimension != 1 && dim.toWorld.dimension != -1 && dim.toWorld.dimension != 3) {
		server.commandManager.executeCommand(server, "w "~dim.player.name~" You get the feeling that you are unable to use mounts here...");
	}
	if (dim.toWorld.dimension == 0 || dim.toWorld.dimension == 1 || dim.toWorld.dimension == -1 || dim.toWorld.dimension == 3 ) {
		server.commandManager.executeCommand(server, "w "~dim.player.name~" You have regained the ability to use mounts!");
	}
});

events.onEntityMount(function(mount as crafttweaker.event.EntityMountEvent) {
	if (mount.world.dimension != 0 && mount.world.dimension != 1 && mount.world.dimension != -1 && mount.world.dimension != 3 ) {
		mount.cancel();
	}
});
