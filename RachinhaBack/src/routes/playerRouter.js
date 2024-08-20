import { Router } from "express";
import playerController from "../controllers/playerController.js";

const router = Router()

router.post("/" , playerController.create);
router.get("/", playerController.findAll);
router.get("/:id", playerController.findId);
router.put("/:id", playerController.update);
router.delete("/:id", playerController.deletePlayer);

export default router