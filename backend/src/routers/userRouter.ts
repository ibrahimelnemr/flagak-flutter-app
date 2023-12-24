import express from "express";
import userController from "../controllers/user.controller";
import utils from "../utils/utils";

const userRouter = express.Router();

userRouter.post("/register", userController.register);
userRouter.post("/login", userController.login);
userRouter.post("/logout", utils.verifyAuthToken, userController.logout);

export default userRouter;
