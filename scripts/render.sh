#!/bin/sh

cat > /run/secrets/output<<EOF
services: mongo: {
  address: "${address}"
  default: true
  secrets: ["admin", "user"]
  ports: "${port}"
  data: {
    proto: "${proto}"
    dbName: "${dbName}"
  }
}

secrets: admin: {
  type: "basic"
  data: {
    username: "${adminUsername}"
    password: "${adminPassword}"
  }
}

secrets: user: {
  type: "basic"
  data: {
    username: "${username}"
    password: "${password}"
  }
}
EOF