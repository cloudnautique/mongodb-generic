# MongoDB External

This repo is an Acorn for connecting external MongoDB instances to your application through the MongoDB service interface. This allows you to swap out the containerized MongoDB instance for one that is hosted externally. This could be one from a SaaS provider like MongoDB Atlas or a self-hosted production grade instance.

## Usage

This Acorn will prompt the user for the following information:

- address: the address of the MongoDB server (mongo.example.com)
- port: the port of the MongoDB server (27017)
- username: the username to use to connect to the MongoDB server
- password: the password to use to connect to the MongoDB server
- adminUsername: the username to use to connect to the MongoDB server as an admin
- adminPassword: the password to use to connect to the MongoDB server as an admin
- proto: the protocol to use to connect to the MongoDB server (mongodb or mongodb+srv)
- dbName: the name of the database to use

This information will be rendered into the Acorn service object.

If you run

```bash
acorn run -n mongodb-external ghcr.io/acorn-io/mongodb-external
```

It will require you to run:

```bash
acorn login mongodb-external
```

In the above example, the name of the app is `mongodb-external`. You can change this or allow one to be randomly generated. When you run the `acorn login` command, you will need to use the same name.

## How to use with MongoDB Atlas

Lets walk through how to setup an application to use this Acorn with a MongoDB from the Atlas service. We wll create a new database in the Atlas UI and then use the Acorn in the examples folder to connect to our database.

Other providers or installations of MongoDB can be consumed with this Acorn in a similar way.

### Create a new database in Atlas

In this first part we will create a new M0 (free tier) database in Atlas. If you already have the database, you can skip this step.

Go to the Atlas web page to [sign in or create a new account](https://mongodb.com). Click sign in to login or create a free account on the MongoDB Atlas platform.

Once signed in, click on the Create button to launch a new database.

Select the free tier (M0) and select AWS as the provider. The current Acorn platform is running in AWS, and you should pick the closest region to your project from the drop down. The M0 tier doesn't have all of the regions. If you are already using Atlas, you can pick paid tiers with access to additional regions.

Name your cluster something, it can not be changed later, but you can delete it once you get throuh this tutorial. Click the Create Cluster button to create the cluster.

### Create a new user

You need to create your first user on the cluster. This user will have admin privileges to the DB cluster by default. If you want to also create a user for the application, you do that later.

Provide a username and password for the user. You can use the auto-generated password or provide your own. Click the Create User button to create the user. Copy the password someplace safe for now, we will need it shortly. You can also change the password later if you need to.

### IP address allow list

For now, we will allow all IP addresses to connect to the database. This is not a good idea for production, but it is fine for this tutorial.

Enter in `0.0.0.0/0` in the IP Address field and click the Add IP Address button. This will allow all IP addresses to connect to the database. Click the Confirm button to confirm the change.

### Launch the Acorn

Now that we have created our database, we can launch our Acorn to connect to it. We will use the Acorn in the examples folder to connect to our database.

```bash
acorn run -n mongodb-external-demo ghcr.io/acorn-io/mongodb-external/examples:v#.#.#
```

This will come up and prompt us for additional information (If you have already launched a MongoDB external Acorn you can also select a previously entered DB if you want to use the same DB).

Now we will need to enter in:

```bash
## Overview                                                                 
                                                                              
  This will create the service from an existing MongoDB so that it can be     
  swapped with the MongoDB container service.                                 
                                                                              
  ## Instructions                                                             
                                                                              
  fill in:                                                                    
                                                                              
  • address: the address of the MongoDB server (mongo.example.com)            
  • port: the port of the MongoDB server (27017)                              
  • username: the username to use to connect to the MongoDB server            
  • password: the password to use to connect to the MongoDB server            
  • adminUsername: the username to use to connect to the MongoDB server as an 
  admin                                                                       
  • adminPassword: the password to use to connect to the MongoDB server as an 
  admin                                                                       
  • proto: the protocol to use to connect to the MongoDB server (mongodb or   
  mongodb+srv)                                                                
  • dbName: the name of the database to use                                   


? address ****************************
? adminPassword ****************
? adminUsername ****
? dbName *******
? password ****************
? port *****
? proto ***********
? username ****
STATUS: ENDPOINTS[https://example-639f3c49.upyiuu.on-acorn.io] HEALTHY[0] UPTODATE[0] "acorn login example" required
STATUS: ENDPOINTS[https://example-639f3c49.upyiuu.on-acorn.io] HEALTHY[0] UPTODATE[0] (container: app): waiting for service to be created [db], waiting for service to be ready [db]; (service: db): acorn [example.db] is not ready
STATUS: ENDPOINTS[https://example-639f3c49.upyiuu.on-acorn.io] HEALTHY[0] UPTODATE[0] (container: app): waiting for service to be ready [db]; (service: db): acorn [example.db] is not ready
STATUS: ENDPOINTS[https://example-639f3c49.upyiuu.on-acorn.io] HEALTHY[0] UPTODATE[0] (container: app): waiting for service to be ready [db]
STATUS: ENDPOINTS[https://example-639f3c49.upyiuu.on-acorn.io] HEALTHY[0] UPTODATE[0] (container: app): pending
...
┌──────────────────────────────────────────────────────────────────────────────────────────┐
| STATUS: ENDPOINTS[https://example-639f3c49.upyiuu.on-acorn.io] HEALTHY[1] UPTODATE[1] OK |
└──────────────────────────────────────────────────────────────────────────────────────────┘
```

The address can be obtained from the "Connect" dialog in Atlas. You will see a connection string that looks like this:

```bash
mongodb+srv://user:<password>@cluster0.2vpbb2r.mongodb.net/?retryWrites=true&w=majority
```

This breaks down to:

- proto: mongodb+srv
- address: cluster0.2vpbb2r.mongodb.net
- port: 27017
- username: user
- password: <password>
- dbName: example (can be whatever value you want except "")
- adminUsername: user
- adminPassword: <password>

The username created in Atlas during the wizard is the adminUsername and adminPassword. In this case, we are also using the same username and password for the application to connect to the database. You can go to Atlas and create another user with a different set of permissions.
