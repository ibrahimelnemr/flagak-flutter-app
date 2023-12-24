import mongoose from "mongoose";
import dotenv from "dotenv";

dotenv.config();

const mongodb_connection_string = process.env.URL as string;

export class database {
    async connectToMongoDB() {
        try {
            const mongooseOptions = {
                autoIndex: true,
            };
            await mongoose.connect(mongodb_connection_string, mongooseOptions);

            console.log("Connected to MongoDB");
            const connection = mongoose.connection;
        } catch (error) {
            console.log(`Could not connect to MongoDB: ${error}`);
        }
    }
}
