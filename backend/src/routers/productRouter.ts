import express from "express";
import { productController } from "../controllers/product.controller";
import utils from "../utils/utils";

const productRouter = express.Router();

productRouter.get("/", productController.viewAllProducts);
productRouter.get("/:name", productController.viewProduct);
productRouter.post("/create", productController.createProduct);
productRouter.put("/edit", productController.editProduct);

export default productRouter;
