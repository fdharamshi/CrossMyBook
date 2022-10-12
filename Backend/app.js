const express = require('express')
const app = express();

app.get('/', (req, res) => {
    res.send("Working");
});

app.listen(3000, () => console.log("App is listening on Port 3000"))