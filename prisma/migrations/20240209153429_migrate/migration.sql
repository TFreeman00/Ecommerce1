/*
  Warnings:

  - Changed the type of `inStock` on the `products` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.

*/
-- AlterTable
ALTER TABLE "products" DROP COLUMN "inStock",
ADD COLUMN     "inStock" INTEGER NOT NULL;

-- CreateTable
CREATE TABLE "orders" (
    "id" SERIAL NOT NULL,
    "items" TEXT NOT NULL,
    "total" MONEY NOT NULL,
    "isCart" BOOLEAN NOT NULL,

    CONSTRAINT "orders_pkey" PRIMARY KEY ("id")
);
