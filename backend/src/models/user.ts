import mongoose from "mongoose";

const userSchema = new mongoose.Schema({
    name: String,
    email: Number,
    password_hash: String,
    is_admin: Boolean
  });
  
const User = mongoose.model('User', userSchema);

export default User;