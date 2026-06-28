const http = require('http');
const port = 8001;
const server = http.createServer(function(request, response){
    response.writeHead(200);
    response.end('Hello World');
})

server.listen(port);
console.log(`server started ${port}`)