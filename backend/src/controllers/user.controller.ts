import userDao from "../dao/userDao";
import express from "express";
const dao = new userDao();
import dotenv from "dotenv";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";

dotenv.config();

const bcryptPepper = process.env.BCRYPT_PEPPER;

const bcryptSaltRounds = process.env.BCRYPT_SALT_ROUNDS;

const jwtSecretKey = process.env.JWT_SECRET_KEY;

export default class userController {
    static async register(req: express.Request, res: express.Response) {
        try {
            const name = req.body.name;
            const email = req.body.email;
            const password = req.body.password;
            const is_admin = req.body.is_admin;

            if (
                typeof name !== "string" ||
                typeof email !== "string" ||
                typeof password !== "string" ||
                typeof is_admin !== "boolean") {
                return res
                    .status(400)
                    .send("Could not register user: invalid input.");
            }

            const password_hash = bcrypt.hashSync(password+bcryptPepper, parseInt(bcryptSaltRounds as string));

            await dao.register(name, email, password_hash, is_admin);
            res.send(`User registered successfully with email: ${email}.`);
        } catch (error) {
            res.status(500).send(`Could not register user: ${error}`);
            console.log(`Could not create register user: ${error}`);
        }
    }

    static async login(req: express.Request, res: express.Response) {
        try {
            const email = req.body.email;
            const password_raw = req.body.password;

        if (
            typeof email !== "string" ||
            typeof password_raw !== "string") {
            return res
                .status(400)
                .send("Could not register user: invalid input.");
        }

        const userFound = await dao.login(email, password_raw);

        console.log(`user found: ${userFound}`)

        const password_hash = bcrypt.hashSync(password_raw+bcryptPepper, parseInt(bcryptSaltRounds as string));

        if (userFound) {
            if (bcrypt.compareSync(password_raw+bcryptPepper, password_hash)) {
                console.log(`User authenticated! Email: ${email}, Raw password: ${password_raw}, password hash: ${password_hash}`)
            } else {
                console.log("Incorrect user password")
            }

            const token = jwt.sign( {
                user: userFound},
                jwtSecretKey as jwt.Secret)

            res.json(token)

            console.log(`User added successfully with token ${token}`)

            // const isAdmin = await dao.isAdmin(email, password_raw);

            // if (isAdmin) {
            //     console.log(`User with email ${email} is an admin`)
            // }
            // else {
            //     console.log(`User with email ${email} is not an admin`)
            // } 

        } else {
            res.send("User not found.")
        }
       

    } catch (error) {
        res.status(500).send(`Could not login user: ${error}`);
        console.log(`Could not create login user: ${error}`);
    }

    }

    static async logout(req: express.Request, res: express.Response) {

        try {
            res.send("User has been logged out successfully")
        } 
        catch(error) {
            res.status(500).send(`Could not logout user: ${error}`);
            console.log(`Could not logout user: ${error}`);
        }
        
    }
}
