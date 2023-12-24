import mongoose from "mongoose";

interface IProduct extends mongoose.Document {
    name: string,
    description: string,
    price: number
}

const productSchema = new mongoose.Schema<IProduct>({
    name: String,
    description: String,
    price: Number,
});

const Product = mongoose.model<IProduct>("Product", productSchema);

export { Product, IProduct }