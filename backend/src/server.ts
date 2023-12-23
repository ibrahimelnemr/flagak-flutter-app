import express from "express";
import cors from "cors";
import bodyParser from "body-parser";
import dotenv from "dotenv";
import mongoose, { modelNames } from "mongoose";
import userRouter from "./routers/userRouter";
import productRouter from "./routers/productRouter";
import { database } from "./database";

dotenv.config();

// Constants
export const app: express.Application = express();

const PORT: string = "3000";

app.use(cors());

// Connect to mongodb

const db = new database();
db.connectToMongoDB();

// Set up app routing

app.get("/", (req: express.Request, res: express.Response) => {
    res.send("Welcome to the store. Navigate to /users or /products");
});

app.use('/users', userRouter)
app.use('/products', productRouter)

app.listen(PORT, () => {
    console.log(`server started at http://localhost:${PORT}`);
  });
  