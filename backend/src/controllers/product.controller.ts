import express from "express";
import productDao from "../dao/productDao";

const dao = new productDao();

export class productController {
    static async viewAllProducts(req: express.Request, res: express.Response) {
        const products = await dao.viewAllProducts();
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

            const product = await dao.viewProduct(name);
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

            if (
                typeof name !== "string" ||
                typeof description !== "string" ||
                typeof price !== "number" ||
                isNaN(price)
            ) {
                return res
                    .status(400)
                    .send("Could not add product: invalid input.");
            }

            await dao.createProduct(name, description, price);
            res.send(
                `Product created successfully with name: ${name}, description: ${description} and price: ${price}.`,
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
            const id = req.body._id;
            const name = req.body.name;
            const description = req.body.description;
            const price = req.body.price;

            if (
                typeof name !== "string" ||
                typeof id !== "string" ||
                typeof description !== "string" ||
                typeof price !== "number" ||
                isNaN(price)
            ) {
                return res
                    .status(400)
                    .send("Could not edit product: invalid input.");
            }

            await dao.editProduct(id, name, description, price);

            res.send(
                `Product edited successfully with name: ${name}, description: ${description} and price: ${price}.`,
            );

            console.log(
                `Product edited successfully with name: ${name}, description: ${description} and price: ${price}.`,
            );
        } catch (error) {
            res.status(500).send(`Could not edit product: ${error}`);
            console.log(`Could not edit product: ${error}`);
        }
    }
}
