dmeta = {
  "name": "Dmeta Server",
  "clientId": "dmeta-co3h3j39f",
  "clientSecret": "dmeta-38f9d20d22aaepoqi",
  "trustedClient": true,
  "scope": [""]
}

dportal = {
  "name": "Dportal Server",
  "clientId": "dportal-c2ss3j39f",
  "clientSecret": "dportal-34fw420d2435aepoq",
  "trustedClient": true,
  "scope": [""]
}

dnext = {
  "name": "Dnext Server",
  "clientId": "dnext-c45df5fhj",
  "clientSecret": "dnext-25ty468f5687afas9",
  "trustedClient": true,
  "scope": [""]
}

use dsso;
db.clients.update({'clientId':'dmeta-co3h3j39f'}, { $setOnInsert:dmeta}, upsert=true); 
db.clients.update({'clientId':'dportal-c2ss3j39f'},{ $setOnInsert: dportal}, upsert=true); 
db.clients.update({'clientId':'dnext-c45df5fhj'},{ $setOnInsert: dnext}, upsert=true); 
