import mongoose, { Schema, Document, Model } from 'mongoose';

interface IProduct extends Document {
  name: string;
  description: string;
  price: number;
  user_id: mongoose.Types.ObjectId;
}

const productSchema: Schema<IProduct> = new mongoose.Schema<IProduct>({
  name: { type: String, required: true, unique: true, collation: { locale: 'en', strength: 2 } },
  description: { type: String, required: true },
  price: { type: Number, required: true },
  user_id: { type: Schema.Types.ObjectId, required: true, ref: 'User' },
});

const Product: Model<IProduct> = mongoose.model<IProduct>('Product', productSchema);

export { Product, IProduct };
