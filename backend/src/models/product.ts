import mongoose from "mongoose";

  const productSchema = new mongoose.Schema({
    name: String,
    description: String,
    email: Number,
  });
  
const Product = mongoose.model('Product', productSchema);

export default Product;