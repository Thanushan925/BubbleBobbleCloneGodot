# Bubble Bobble Clone - Thanushan Satheeskumar

## How to run
- Open the project in **Godot 4.x**  
- Run **scenes/world/Level01.tscn**  

## Controls (InputMap)
- **move_left / move_right** → Move the player left or right  
- **jump** → Jump  
- **fire** → Shoot a bubble  
- **start / restart** → Start or restart the game  

## Implemented features
- [x] Player movement + jump  
- [x] TileMap collisions  
- [x] Bubble shooting + bubble lifetime  
- [x] Enemies patrol + collisions  
- [x] Trap mechanic (capture enemy in bubble)  
- [x] Pop trapped bubble + score + lives  
- [x] Game over + restart  

## Bonus feature
- [x] Enemy Rage: trapped enemies escape after N seconds and move faster  

## Notes / known issues
- Currently using simple PNG sprites (player.png, enemy.png, bubble.png)  
- HUD for score and lives is printed on the screen, and doesn't use images
- No menu screen implemented and game starts immediately