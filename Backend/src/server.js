const express=require("express");

const app=express();
const mongoose=require("mongoose");

const dbURI="mongodb+srv://adithya01:adithyagsc23@gsccluster.l7s34uv.mongodb.net/?retryWrites=true&w=majority"


mongoose.connect(dbURI,{ useNewUrlParser: true, useUnifiedTopology: true }).then((result)=>{
    console.log("connected to db");
app.listen(8000,()=>{
    console.log("listening at 8000")
});


}).catch((err)=>{
    console.log(err);
})


app.use(express.json());
app.use(express.urlencoded({ extended: true }));