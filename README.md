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

### Step 1: Bootstrap

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
	
