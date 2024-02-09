const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

async function getAllProducts() {
  try {
    return await prisma.products.findMany();
  } catch (err) {
    throw err;
  }
}

async function getProductById(id) {
  try {
    return await prisma.products.findFirst({
      where: {
        id: Number(id),
      },
    });
  } catch (error) {
    throw error;
  }
}

module.exports = {
  getAllProducts,
  getProductById,
};
