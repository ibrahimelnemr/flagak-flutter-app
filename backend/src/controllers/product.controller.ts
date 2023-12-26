import express from "express";
import productDao from "../dao/productDao";

export default class productController {
    static async viewAllProducts(req: express.Request, res: express.Response) {
        const products = await productDao.viewAllProducts();
        res.json(products);
    }

    static async viewProduct(req: express.Request, res: express.Response) {
        try {
            const name = req.params.name;
            if (typeof name !== "string") {
                return res
                    .status(400)
                    .send("viewProduct router: invalid input.");
            }

            const product = await productDao.viewProduct(name);
            res.send(product);
        } catch (error) {
            res.send(`viewProduct router: could not view product: ${error}`);
        }
    }

    static async createProduct(req: express.Request, res: express.Response) {
        try {
            const name = req.body.name;
            const description = req.body.description;
            const price = req.body.price;
            const admin_id = req.body.admin_id;

            let errorMessage = "";

            if (typeof admin_id !== "string") 
                errorMessage += `Invalid value for admin_id: ${admin_id}`;
            if (typeof name !== "string") 
                errorMessage += `Invalid value for product name: ${name}`;
            if (typeof description !== "string") 
                errorMessage += `Invalid value for product description: ${description}`;
            if (typeof price !== "number" || isNaN(price)) 
                errorMessage += `Invalid value for product price: ${price}`;
            
            if (errorMessage != "")
                return res
                    .status(400)
                    .send(`Could not create product; invalid input: ${errorMessage}`);

            const newProduct = await productDao.createProduct(name, description, price, admin_id);
            res.status(200).send({
                message: `Product created successfully with name: ${name}, description: ${description} and price: ${price}.`,
                product: newProduct
            });
            res.send(
                
            );
        } catch (error) {
            res.status(500).send(
                `productRouter: Could not create product: ${error}`,
            );
            console.log(`productRouter: Could not create product: ${error}`);
        }
    }

    static async editProduct(req: express.Request, res: express.Response) {
        try {
            const _id = req.body._id;
            const name = req.body.name;
            const description = req.body.description;
            const price = req.body.price;

            let errorMessage = "";

            if (typeof _id !== "string") 
                errorMessage += `Invalid value for product _id: ${_id}`;
            if (typeof name !== "string") 
                errorMessage += `Invalid value for product name: ${name}`;
            if (typeof description !== "string") 
                errorMessage += `Invalid value for product description: ${description}`;
            if (typeof price !== "number" || isNaN(price)) 
                errorMessage += `Invalid value for product price: ${price}`;
            
            if (errorMessage != "")
                return res
                    .status(400)
                    .send(`Could not edit product; invalid input: ${errorMessage}`);

            await productDao.editProduct(_id, name, description, price);

            res.send({
                message: `Product edited successfully with name: ${name}, description: ${description} and price: ${price}.`
            });

            console.log(
                `Product edited successfully with name: ${name}, description: ${description} and price: ${price}.`,
            );
        } catch (error) {
            res.status(500).send(`Could not edit product: ${error}`);
            console.log(`Could not edit product: ${error}`);
        }
    }
}
