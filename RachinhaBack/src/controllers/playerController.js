import Player from "../models/Player.js";
import {
    createService, 
    findAllService,
    findIdService,
    updateService,
    deleteService} from "../services/playerService.js"

const create = async (req, res) => {
    try {
      const { name, position } = req.body;
  
      if (!name || !position) {
        res.status(400).send({ message: "Submit all fields for registration" });
      }
      const existingUser = await Player.findOne({ $or: [{ name }] });
  
      if (existingUser) {
        return res
          .status(409)
          .send({ message: "Palyer already exists" });
      }
  
      const user = await createService(req.body)
        .catch((err) => console.log(err.message));
  
      if (!user) {
        return res.status(400).send({ message: "Error creating player" });
      }
  
      res.status(201).send({
        message: "User created successfully",
  
        user: {
          id: user._id,
          name,
          position
        },
      });
    } catch (error) {
      res.status(500).send({ message: error.message });
    }
  };

  const findAll = async (req, res) => {
    try {
      const users = await findAllService();
  
      if (users.length === 0) {
        return res.status(400).send("There are no registered users");
      }
      res.send(users);
    } catch (error) {
      res.status(500).send({ message: error.message });
    }
  };

  const findId = async (req, res) => {
        try {
          const { id } = req.params;
      
          const player = await findIdService(id);
      
          return res.send({
            player: {
              id: player._id,
              name: player.name,
              position: player.position,
            },
          });
        } catch (error) {
          res.status(500).send({ message: error.message });
        }
      };

  const update = async (req, res) => {
    try {
      const { id } = req.params;
      const { name, position } = req.body;
      
      if (!name && !position ) { //opcao de alteracao //
        res.status(400).send({ message: "Submit at least one field for update" });
      }
  
      await updateService(
        id,
        name,
        position
      );
  
      res.send({ message: "Usse successfully updated!" });
    } catch (error) {
      res.status(500).send({ message: error.message });
    }
  };

  const deletePlayer = async(req, res)  => {
    const id = req.params.id
    try {
      const result = await deleteService(id)
      res.status(200).send(result)
    } catch (error) {
      res. status(404).send(error.message)
    }
  }

  export default { create, findAll, update, findId, deletePlayer };
