var express = require('express');
var ParseServer = require('parse-server').ParseServer;

var api = new ParseServer({
  databaseURI: "mongodb://localhost/test_parse",
  cloud: __dirname + '/cloud/main.js',
  appId: "63966E18-33C1-431B-A50E-4F68652C2A4D",
  masterKey: "5B45972F-36B7-4FBB-85A0-B2EA733586CD",
  serverURL: "http://localhost:8001/parse"
});

var app = express();

app.use('/parse', api);

app.get('/', function(req, res) {
  res.status(200).send('test_parse API');
});

app.listen(8001, function() {
  console.log('parse-server-example running on port ' + 8001 + '.');
});
