import crafttweaker.events.IEventManager;
import crafttweaker.event.PlayerPickupItemEvent;
import crafttweaker.command.ICommandManager;
import crafttweaker.player.IFoodStats;
import crafttweaker.player.IPlayer;

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
