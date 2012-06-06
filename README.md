# Type This

## How to run

### Step 1: Node.js + Express

Install node.js.

Clone this git repository.

Install modules on the project.

	npm install

### Step 2: Redis

Install Redis.

Run Redis server.

	redis-server

### Step 3: Execute  


open [http://localhost:3000](http://localhost:3000) with your browser.

Create or join a room.

## How to develop

Please do installation and boot-up of "How to run" section prior to the followings.

### Bootstrap

Install express.
	
	npm install express -g

Create express project.

	express type-this
	
Then install necessary modules.

	cd type-this && npm install
	
Rename app.js to server.js for "npm start".

	npm start
	
Make sure http://localhost:3000 is on.

Install connect-redis to use Redis server for session storage.

	npm install connect-redis --save

### Rooms Page

index.jade

#### Create a room

Become a host.

#### Enlist rooms

##### Join a room

Become a guest

### Room page

game.jade

#### Enlist players

Host must start a game, then the room is closed.

#### Type

Host starts typing a word, which is supposed to be broadcast.

Guests type the word, which is also broadcast.

#### Result

Once every player finish typing, judgement is made.

Now the winner has the right to manage the game, which means he or she can finish the game.

The winner starts typing a word, and so on.