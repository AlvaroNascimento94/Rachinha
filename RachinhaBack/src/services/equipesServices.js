import Equipes from '../models/Equipes.js';


export const createServiceE = (body) => Equipes.create(body)

export const findAllService = () => Equipes.find();

export const deleteAllService = () => Equipes.deleteMany()