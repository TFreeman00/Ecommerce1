const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

const products = [
  {
    name: "Banana",
    price: 0.99,
    description: "it's a banana",
    inStock: 10,
  },
  {
    name: "Carrot",
    price: 0.99,
    description: "it's a carrot",
    inStock: 10,
  },
  {
    name: "Coca-Cola",
    price: 3.99,
    description: "2L",
    inStock: 10,
  },
];

const users = [
  {
    email: "aaron@admin.co",
    password: "aaron123",
    isAdmin: false,
  },
  {
    email: "mark@admin.co",
    password: "mark123",
    isAdmin: true,
  },
  {
    email: "tyrice@admin.co",
    password: "tyrice123",
    isAdmin: true,
  },
];

const generateData = async () => {
  await prisma.products.createMany({
    data: products,
  });
  await prisma.users.createMany({
    data: users,
  });
};

generateData();
