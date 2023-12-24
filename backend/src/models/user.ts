import mongoose  from 'mongoose';

interface IUser extends mongoose.Document {
    name: string,
    email: string,
    password_hash: string,
    is_admin: boolean
}

const userSchema = new mongoose.Schema<IUser>({
    name: { type: String, required: true},
    email: { type: String, required: true },
    password_hash: { type: String, required : true},
    is_admin: { type: Boolean, required: true}
});

const User:mongoose.Model<IUser> = mongoose.model<IUser>("User", userSchema);

export { User, IUser }