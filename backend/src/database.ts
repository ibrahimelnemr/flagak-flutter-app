import mongoose from "mongoose";
import dotenv from "dotenv";

dotenv.config();

const env = process.env.ENVIRONMENT as string;

console.log(`Current environment: ${env}`)

const mongodb_connection_string = process.env.URL as string;
const mongodb_local_test_connection_string = process.env.LOCAL_TEST_URL as string;

let uri = "";

if (env === 'TEST') {
    console.log("Connecting to local test database");
    uri = mongodb_local_test_connection_string;
    console.log(`Connection string: ${uri}`);
}
else if (env === 'DEV') {
    uri = mongodb_connection_string;
    console.log("Connecting to development database");
    console.log(`Connection string: ${uri}`);
}
else if (env === null) {
    console.log("Environment variable for test or development database undefined. Defaulting to DEV database environment.");

    uri = mongodb_connection_string;
}

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
