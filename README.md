# Dim35
A multiplayer RPG platformer developed as a project for Introduction to Software Engineering

## Getting Started - Development
Insure Godot v3 is installed and ready. Then clone the following repos:
```
git clone https://github.com/dim35/CEN3031-Project-Server/
git clone https://github.com/dim35/CEN3031-Project/
```
### Server
Run the server by opening up the Server Project within Godot and then running it.

### Client
When launching the Client Project, due to API calls validiating usernames and passwords with a Flask backend, the validation may need to be disabled. To do so, set `check = false` within `CEN3031-Project/screens/login_screen/login_screen.gd`. Furthermore, the Client expects at least 2 players to be connected. To remove this validation change line 23 in `CEN3031-Project/screens/lobby_screen/lobby_screen.gd` to `len(players) >= 1`.

If the server was run locally, set the IP address to `127.0.0.1`. If the server was run on a different machine, enter the corresponding address. Be aware of the notice above.

## Game Controls
```
Up, Down, Left, Right - Move
Space - Jump
Shift - Enable Sprint
X - Attack
```

