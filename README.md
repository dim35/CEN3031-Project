# Dim35
A multiplayer RPG platformer developed in the open-source [Godot game engine](https://godotengine.org/) as a project for Introduction to Software Engineering.

## Contributors
- Aleksandr Hovhannisyan
- Daniel Volya
- Steven Spinner
- Matthew Wanner
- Diego Amador
- Jonathan Correa

## Getting Started - Development
Ensure Godot 3.0 is installed and ready. Then, clone the following repos:
```
git clone https://github.com/dim35/CEN3031-Project-Server/
git clone https://github.com/dim35/CEN3031-Project/
```
### Server
Run the server by opening up the server project within Godot and running it.

### Client
When launching the client project, due to API calls validiating usernames and passwords with a Flask backend, validation may need to be disabled. To do so, set `check = false` within `CEN3031-Project/screens/login_screen/login_screen.gd`.

If the server was run locally, set the IP address to `127.0.0.1`. If the server was run on a different machine, enter the corresponding address. Be aware of the notice above.

## Game Controls
```
Movement: WASD and Arrow Keys
Sprinting: Shift + Left/Right/A/D
Attacking: hold X
```

## Credits
- Sky background: [Paulina Riva](https://opengameart.org/content/sky-background), CC-BY 3.0 license
- Knight sprites: [Disthron](https://opengameart.org/content/classic-knight-animated), Public Domain
- Mage sprites (recolored from original): [Disthron](https://opengameart.org/content/mr-necromancer-man-animated), Public Domain
- Rogue sprites: [Disthron](https://opengameart.org/content/mr-knife-guy-animated), Public Domain
- Castle tiles: [OpenPixelProject](https://openpixelproject.itch.io/opp2017castle), Public Domain
- Lobby slot frames: [yd](https://opengameart.org/content/gui-windows-constructor), Public Domain
- Lobby unchecked/checked boxes: [Lamoot](https://opengameart.org/content/rpg-gui-construction-kit-v10), CC-BY 3.0 license

