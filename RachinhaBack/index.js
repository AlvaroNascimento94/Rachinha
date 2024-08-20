import express from "express"
import connectDataBase from './src/database/db.js'


import playerRouter from "./src/routes/playerRouter.js"
import equipesRouter from "./src/routes/equipesRouter.js"

const app = express()


const PORT = process.env.PORT || 3333;


connectDataBase()

app.use(express.json())
app.use("/player", playerRouter);
app.use("/equipes", equipesRouter);

app.listen(PORT, () => console.log(`Servidor na porta ${PORT}`));