const router = require("express").Router();
const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();
const { getAllProducts, getProductById } = require("../db/products");

router.get("/", async (req, res, next) => {
  try {
    const products = await getAllProducts();
    res.send(products);
  } catch (error) {
    next(error);
  }
});

router.get("/:id", async (req, res, next) => {
  try {
    const product = await getProductById(req.params.id);
    if (!product) {
      return res.status(404).send("Product was not found");
    }
  } catch (error) {
    next(error);
  }
});

router.post("/", async (req, res, next) => {
  try {
    if (req.user.isAdmin === false) {
      return res.status(401).send("You must be an Admin to Post");
    }
    const product = await prisma.products.create({
      data: {
        name: req.body.name,
        price: req.body.price,
        description: req.body.description,
        imageUrl: req.body.imageUrl,
        inStock: req.body.inStock,
      },
    });
    res.status(201).send(product);
  } catch (error) {
    next(error);
  }
});

router.put("/:id", async (req, res, next) => {
  try {
    if (req.user.isAdmin === false) {
      return res.status(401).send("You must be an Admin to update a post.");
    }

    const product = await prisma.products.update({
      where: {
        id: parseInt(req.params.id),
      },
      data: {
        name: req.body.name,
        price: req.body.price,
        description: req.body.description,
        imageUrl: req.body.imageUrl,
        inStock: req.body.inStock,
      },
    });

    res.send(product);
  } catch (error) {
    next(error);
  }
});

router.delete("/:id", async (req, res, next) => {
  try {
    if (req.user.isAdmin === false) {
      return res.status(401).send("You must be an Admin to delete a product.");
    }

    const product = await prisma.products.delete({
      where: {
        id: parseInt(req.params.id),
        userId: parseInt(req.user.id),
      },
    });

    res.send(product);
  } catch (error) {
    next(error);
  }
});

module.exports = router;
