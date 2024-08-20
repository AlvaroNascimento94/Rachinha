import mongoose from "mongoose";

const connectDataBase = () => {
  console.log("Wait connecting to the database");

  mongoose
    .connect("mongodb://127.0.0.1:27017/RachaTeste2")
    .then(() => console.log("MongoDb connect"))
    .catch((error) => console.log(error));
};

export default connectDataBase;
