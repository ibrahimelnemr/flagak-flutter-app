import express from "express";
import productController from "../controllers/product.controller";
import utils from "../utils/utils";

const productRouter = express.Router();

// View all products - all users
productRouter.get("/", utils.verifyAuthToken, productController.viewAllProducts);

// View product by name - all users
productRouter.get("/:name", utils.verifyAuthToken, productController.viewProduct);

// Create product - requires admin
productRouter.post("/create",  utils.verifyAuthToken, utils.verifyAdmin, productController.createProduct);

// Edit product - requires admin
productRouter.put("/edit", utils.verifyAuthToken, utils.verifyAdmin, productController.editProduct);

export default productRouter;
