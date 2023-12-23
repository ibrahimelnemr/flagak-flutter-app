import mongoose from "mongoose";
import dotenv from "dotenv";

dotenv.config();

const mongodb_connection_string = process.env.URL as string;


export class database {
    async connectToMongoDB() {
        try {
            await mongoose.connect(mongodb_connection_string);
    
            console.log("Connected to MongoDB");
    
            setTimeout(() => {
        
                const connection = mongoose.connection;
                
                console.log(connection.readyState);
            
            }, 4000)
        }
        catch (error) 
        {
            console.log(`Could not connect to MongoDB: ${error}`);
        }
    }
}