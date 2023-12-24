import express from "express";
import { User, IUser } from "../models/user";

export class userDao {
    async register(
        name: string,
        email: string,
        password: string,
        is_admin: boolean,
    ) {
        const newUser = new User({
            name: name,
            email: email,
            password_hash: password,
            is_admin: is_admin,
        });
        try {
            await newUser.save();
            console.log(`User ${name} added to database successfully.`);
        } catch (error) {
            console.log(`Error registering user: ${error}`);
        }
    }

    async login(email: string, password: string): Promise<IUser | null> {
        try {
            const emailFound = await User.findOne({email: email});

            console.log(emailFound);
            return emailFound;
        } 
        catch (error){
            console.log(`userDao login error: ${error}`)
            return null;
        }
    }

    // async isAdmin(email: string, password_raw: string): Promise<boolean> {
    //     try {
    //         const emailFound = await User.findOne({email: email});

    //         console.log(emailFound);

    //         if (emailFound?.is_admin) {
    //             return true
    //         } else {
    //             return false
    //         }
    //     } 
    //     catch (error){
    //         console.log(`Error checking if user with email ${email} is admin: ${error}`)
    //         return false
    //     }
    // }


    // async logout(token: string) {

    // }
}

export default userDao;
