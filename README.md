# MongoDB External

This repo is an Acorn for connecting external MongoDB instances to your application through the standardized MongoDB service interface. This allows you to swap out the containerized MongoDB instance for one that is hosted externally.

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

Which is the app name. This will trigger Acorn to prompt you.

## Examples

To see how to setup an application to use this Acorn, see the [examples](examples) directory.
