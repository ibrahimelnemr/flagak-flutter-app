import { Product, IProduct } from "../models/product";
import mongoose from "mongoose";

export class productDao {
    static async viewAllProducts() {
        try {
            const products = await Product.find();
            console.log(`viewAllProducts: found ${products.length} products`);
            return products;
        } catch (error) {
            throw new Error(`Cannot view all products: ${error}`);
        }
    }

    static async viewProduct(name: string) {
        try {
            const product = Product.findOne({ name: name });
            console.log(`Product: ${product}`);
            return product;
        } catch (error) {
            console.log(`viewProduct Dao: could not find product: ${error}`);
        }
    }

    static async createProduct(name: string, description: string, price: number, user_id: string) {
        const newProduct = new Product({
            name: name,
            description: description,
            price: price,
            user_id: user_id
        });
        try {
            const newProductAdded = await newProduct.save();
            console.log(`Product ${name} added to database successfully.`);
            return newProductAdded;
        } catch (error) {
            console.log(`Error adding product: ${error}`);
        }
    }

    static async editProduct(
        id: string,
        name: string,
        description: string,
        price: number,
    ) {
        try {
            const updatedProduct = await Product.findOneAndUpdate(
                { _id: new mongoose.Types.ObjectId(id) },
                {
                    name: name,
                    description: description,
                    price: price,
                },
                { new: true },
            );
            return updatedProduct;
        } catch (error) {
            console.log(`Error updating product: ${error}`);
        }
    }
}

export default productDao;
