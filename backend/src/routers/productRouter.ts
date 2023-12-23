import User from "../models/user";
import Product from "../models/product";
import express from "express";
import userDao from "../dao/userDao";
import productDao from "../dao/productDao";

const viewAllProducts = async(req: express.Request, res: express.Response) => {
    res.send("View All products");
}

const viewProduct = async(req: express.Request, res: express.Response) => {
    res.send("View product");
}

const createProduct = async(req: express.Request, res: express.Response) => {
    res.send("View product");
}

const editProduct = async(req: express.Request, res: express.Response) => {
    res.send("Edit product");
}

const productRouter = express.Router();

productRouter.get('/', viewAllProducts)
productRouter.get('/:id', viewProduct)
productRouter.post('/create', createProduct)
productRouter.post('/edit/:id', editProduct)

export default productRouter;