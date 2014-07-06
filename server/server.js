var WebSocketServer = require('ws').Server, wss = new WebSocketServer({ port: 3000 });

wss.on('connection', function(ws) {
    ws.on('message', function(message) {
        console.log('received: %s', message);
    });

    ws.send('worky!!!');

    var count = 0;

    setInterval(function(){
      count++;
      ws.send(count.toString());
    }, 30);
});
