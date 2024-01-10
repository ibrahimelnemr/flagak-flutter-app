import express from "express";
import jwt from "jsonwebtoken";
import dotenv from "dotenv";
dotenv.config();

export default class utils {

    static verifyAuthToken(
        req: express.Request,
        res: express.Response,
        next: express.NextFunction,
    ) {
        try {
            const authorizationHeader = req.headers.authorization;
    
            const token = (authorizationHeader as string).split(" ")[1];
    
            const decoded = jwt.verify(token, process.env.JWT_SECRET_KEY as string);


            const decodedJSONString = JSON.stringify(decoded, null, 2);

            const decodedJSON = JSON.parse(decodedJSONString);

            //req.userdata=decodedJSON;
    
            console.log("Token verified successfully!");
            next();
        } catch (err) {
            res.status(401);
            console.log(`Could not verify token: ${err}`);
            res.json(`Invalid token: ${err}`);
        }
    };

    static verifyAdmin(
        req: express.Request,
        res: express.Response,
        next: express.NextFunction) { 

            try {
                const authorizationHeader = req.headers.authorization;

                const token = (authorizationHeader as string).split(" ")[1];

    
                const decoded = jwt.verify(token, process.env.JWT_SECRET_KEY as string);

                const decodedJSONString = JSON.stringify(decoded, null, 2);

                const decodedJSON = JSON.parse(decodedJSONString);

                console.log(`Decoded token is_admin: ${decodedJSON.user.is_admin}`)

                if (decodedJSON.user.is_admin) {
                    console.log(`User ${decodedJSON.user.email} verified as admin.`)
                    next();
                }                

                else {
                    console.log(`User ${decodedJSON.user.email} is not an admin.`)
                    res.send(`User ${decodedJSON.user.email} does not have admin privileges and cannot access this page.`)
                }

            } catch (err) {
                res.status(401);
                console.log(`Could not verify admin token: ${err}`);
                res.json(`Invalid token: ${err}`);
            }
            
    }
    
}
