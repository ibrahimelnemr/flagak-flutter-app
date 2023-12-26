import mongoose from "mongoose";
import dotenv from "dotenv";

dotenv.config();

const mongodb_connection_string = process.env.URL as string;
const mongodb_local_test_connection_string = process.env.LOCAL_TEST_URL as string;

// connect to remote database
//const uri = mongodb_connection_string;

// connect to localhost database
const uri = mongodb_local_test_connection_string;

export class database {
    async connectToMongoDB() {
        try {
            const mongooseOptions = {
                autoIndex: true,
            };
            await mongoose.connect(uri, mongooseOptions);

            console.log("Connected to MongoDB");
            const connection = mongoose.connection;
        } catch (error) {
            console.log(`Could not connect to MongoDB: ${error}`);
        }
    }
}
