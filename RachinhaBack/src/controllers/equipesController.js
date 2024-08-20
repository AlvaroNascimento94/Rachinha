import { createServiceE,
    findAllService,
    deleteAllService} from "../services/equipesServices.js"

const createE  = async( req, res) => {
    try {
        const { nameTime, players} = req.body

        await createServiceE({
            nameTime, players
        })
        res.send("Created")
    } catch (error) {
        res.status(500).send({message: error.message})
    }
}

const findAllE = async(req,res) => {
try{
    const findEquipe = await findAllService()
     
    if(findEquipe.length === 0){
        return res.status(400).send("There are not Equipes")
    }
    res.send(findEquipe)}
    catch(error){
        res.status(500).send({ message: error.message });
    }
}

const deleteAllE = async (req, res) => {
try {
    await deleteAllService()
    return res.send({ message: "Equipes deleted successfully" });
} catch (error) {
    res.status(500).send({ message: error.message });
}
    

}

export default {createE, findAllE, deleteAllE}