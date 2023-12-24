import { User, IUser } from "../models/user";

export class userDao {
    static async register(
        name: string,
        email: string,
        password: string,
        is_admin: boolean,
    ) {
        const newUser = new User({
            name: name,
            email: email,
            password_hash: password,
            is_admin: is_admin,
        });
        try {
            await newUser.save();
            console.log(`User ${name} added to database successfully.`);
        } catch (error) {
            console.log(`Error registering user: ${error}`);
        }
    }

    static async login(email: string, password: string): Promise<IUser | null> {
        try {
            const emailFound = await User.findOne({email: email});

            console.log(emailFound);
            return emailFound;
        } 
        catch (error){
            console.log(`userDao login error: ${error}`)
            return null;
        }
    }

}

export default userDao;
