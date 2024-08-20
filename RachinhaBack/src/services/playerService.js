import Player from "../models/Player.js"

export const createService = (body) => Player.create(body);

export const findAllService = () => Player.find().sort({ _id: -1 });

export const findIdService = (id) => Player.findById(id)

export const updateService = (
    id,
    name,
    position,
  ) =>
    Player.findByIdAndUpdate(
      { _id: id }, 
      { name, position }
    );;

export const deleteService = (id) => Player.findOneAndDelete({ _id: id });