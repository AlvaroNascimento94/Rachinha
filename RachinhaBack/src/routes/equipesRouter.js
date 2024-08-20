import { Router } from "express";
import equipesController from "../controllers/equipesController.js";

const router = Router()

router.post("/" , equipesController.createE);
router.get("/", equipesController.findAllE);
router.delete("/", equipesController.deleteAllE);

export default router