#!/bin/bash
mongosh \
  -u "$MONGO_INITDB_ROOT_USERNAME" \
  -p "$MONGO_INITDB_ROOT_PASSWORD" \
  --authenticationDatabase admin \
  --eval "
    db = db.getSiblingDB('$MONGO_INITDB_DATABASE');
    if (db.getUser('$MONGO_NON_ROOT_USERNAME') === null) {
      db.createUser({
        user: '$MONGO_NON_ROOT_USERNAME',
        pwd: '$MONGO_NON_ROOT_PASSWORD',
        roles: [{ role: 'readWrite', db: '$MONGO_INITDB_DATABASE' }]
      });
      print('User created successfully');
    } else {
      print('User already exists, skipping');
    }
  "
