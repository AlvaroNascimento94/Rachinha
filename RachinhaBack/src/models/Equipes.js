import mongoose from "mongoose";

const EquipesSchema = new mongoose.Schema({
  nameTime: { type: String, require: true },
  players: { type: Array, require: true }
});

const Equipes = mongoose.model("Equipes", EquipesSchema);

export default Equipes;
