import User from "../models/user";
import Product from "../models/product";
import express from "express";
import userDao from "../dao/userDao";

const register = async(req: express.Request, res: express.Response) => {
    res.send("Register user");
}

const login = async(req: express.Request, res: express.Response) => {
    res.send("Login user");
}

const logout = async(req: express.Request, res: express.Response) => {
    res.send("Logout user");
}

const userRouter = express.Router();

userRouter.post('/register', register)
userRouter.post('/login', login)
userRouter.post('/logout', logout)

export default userRouter;