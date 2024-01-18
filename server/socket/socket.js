const express = require('express');
const http = require('http');
const socketIO = require('socket.io');
const bodyParser = require('body-parser');

const app = express();

const server = http.createServer(app);

const io = socketIO(server);

var notify = [];
// Use body-parser middleware
app.use(bodyParser.json());

io.on("connection", (socket) => {
  console.log(`new client ID : ${socket.id}`);

  socket.on("notify", (data) => {
    console.log("notification : " + data);
    notify.push(data);
    io.emit("notify", notify);
  })
  io.emit("notify", notify);
})

function sendTestNotification(productName) {
  io.emit("notify", productName);
}

// Array to store products
let productsArray = [];

setInterval(() => {
  productsArray = []
}, 50000);

app.post('/notify', (req, res) => {
    const receivedProduct = req.body;
    console.log(receivedProduct);

    // Check if the product is already in the array
    const existingProduct = productsArray.find(product => product.id === receivedProduct.id);

    if (!existingProduct) {
        // If not, add it to the array
        productsArray.push(receivedProduct);
        console.log('Added to the array:', receivedProduct);

        sendTestNotification(receivedProduct['name']);
    } else {
        console.log('Product already exists in the array:', existingProduct);
    }

    res.sendStatus(200);
});


app.get('/getProducts', (req, res) => {
  res.json(productsArray);
})

const port = 9091;
server.listen(port, () => {
  console.log(`Server on ${port}`);
});