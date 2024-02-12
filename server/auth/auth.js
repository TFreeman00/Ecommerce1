const router = require("express").Router();
const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();
const jwt = require("jsonwebtoken");
const bcrypt = require("bcrypt");

router.post("/register", async (req, res, next) => {
  const salt = 5;
  const hashPassword = await bcrypt.hash(req.body.password, salt);

  try {
    const user = await prisma.users.create({
      data: {
        firstName: req.body.firstName,
        lastName: req.body.lastName,
        email: req.body.email,
        password: hashPassword,
      },
    });

    res.status(201).send("You have successfully registered your account!");
  } catch (error) {
    next(error);
  }
});

router.post("/login", async (req, res, next) => {
  try {
    const user = await prisma.users.findFirst({
      where: {
        email: req.body.email,
      },
    });
    if (!user) {
      return res
        .status(401)
        .send(
          "Account with that email address does not exist. Please register an account befor logging in."
        );
    }

    const passwordMatch = await bcrypt.compare(
      req.body.password,
      user?.password
    );
    if (!passwordMatch) {
      return res.status(401).send("Invalid login credentials.");
    }

    const token = jwt.sign({ id: user.id }, process.env.JWT);

    res.send({ token }, "You have logged in successfully!");
  } catch (error) {
    next(error);
  }
});


module.exports = router;

