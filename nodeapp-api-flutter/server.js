const express = require('express');
const app = express();
app.use(express.json()); 

var cors = require('cors');
app.use(cors({origin: '*'}));

app.listen(3000, function() { // subir serviço da api na porta 3000 
    console.log('Testar por http://localhost:3000');   
});

app.get('/', (req, res) => {
    res.send('Atendida a requisição GET!!');
});

const contato = require('./contato');
contato(app);

