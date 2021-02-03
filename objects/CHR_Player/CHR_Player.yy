{
  "spriteId": {
    "name": "SPR_PlayerIdle",
    "path": "sprites/SPR_PlayerIdle/SPR_PlayerIdle.yy",
  },
  "solid": false,
  "visible": true,
  "spriteMaskId": {
    "name": "SPR_HitboxPlayer",
    "path": "sprites/SPR_HitboxPlayer/SPR_HitboxPlayer.yy",
  },
  "persistent": false,
  "parentObjectId": {
    "name": "CHR_Character",
    "path": "objects/CHR_Character/CHR_Character.yy",
  },
  "physicsObject": false,
  "physicsSensor": false,
  "physicsShape": 1,
  "physicsGroup": 1,
  "physicsDensity": 0.5,
  "physicsRestitution": 0.1,
  "physicsLinearDamping": 0.1,
  "physicsAngularDamping": 0.1,
  "physicsFriction": 0.2,
  "physicsStartAwake": true,
  "physicsKinematic": false,
  "physicsShapePoints": [],
  "eventList": [
    {"isDnD":false,"eventNum":0,"eventType":0,"collisionObjectId":null,"parent":{"name":"CHR_Player","path":"objects/CHR_Player/CHR_Player.yy",},"resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMEvent",},
  ],
  "properties": [
    {"varType":0,"value":"1.4","rangeEnabled":false,"rangeMin":0.0,"rangeMax":10.0,"listItems":[],"multiselect":false,"filters":[],"resourceVersion":"1.0","name":"SprintModifier","tags":[],"resourceType":"GMObjectProperty",},
  ],
  "overriddenProperties": [
    {"propertyId":{"name":"CharacterSpeed","path":"objects/CHR_Character/CHR_Character.yy",},"objectId":{"name":"CHR_Character","path":"objects/CHR_Character/CHR_Character.yy",},"value":"340","resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMOverriddenProperty",},
    {"propertyId":{"name":"CharacterAccel","path":"objects/CHR_Character/CHR_Character.yy",},"objectId":{"name":"CHR_Character","path":"objects/CHR_Character/CHR_Character.yy",},"value":"80","resourceVersion":"1.0","name":"","tags":[],"resourceType":"GMOverriddenProperty",},
  ],
  "parent": {
    "name": "Character",
    "path": "folders/Objects/Character.yy",
  },
  "resourceVersion": "1.0",
  "name": "CHR_Player",
  "tags": [],
  "resourceType": "GMObject",
}