import crafttweaker.events.IEventManager;
import crafttweaker.event.PlayerPickupItemEvent;
import crafttweaker.command.ICommandManager;
import crafttweaker.player.IFoodStats;
import crafttweaker.player.IPlayer;

events.onPlayerPickupItem(function(pickup as crafttweaker.event.PlayerPickupItemEvent){
	var test = pickup.item.displayName;
	if (pickup.item.displayName == test) {
		server.commandManager.executeCommand(server, "playsound cave1 ambient "~pickup.player.name~" ~ ~ ~ 0");
		pickup.player.foodStats.foodLevel -= 2;
		if (pickup.player.foodStats.foodLevel < 1) {
			pickup.player.dropItem(true);
		}
	}
});
