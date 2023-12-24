import express from "express";
import userController from "../controllers/user.controller";
import utils from "../utils/utils";

const userRouter = express.Router();

// register
userRouter.post("/register", userController.register);

// login
userRouter.post("/login", userController.login);

export default userRouter;
