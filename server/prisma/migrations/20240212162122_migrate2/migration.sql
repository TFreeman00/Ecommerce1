/*
  Warnings:

  - You are about to drop the column `orderid` on the `orderdetails` table. All the data in the column will be lost.
  - You are about to drop the column `productid` on the `orderdetails` table. All the data in the column will be lost.
  - You are about to drop the column `userid` on the `orders` table. All the data in the column will be lost.
  - You are about to drop the column `imageurl` on the `products` table. All the data in the column will be lost.
  - You are about to drop the column `firstname` on the `users` table. All the data in the column will be lost.
  - You are about to drop the column `isadmin` on the `users` table. All the data in the column will be lost.
  - You are about to drop the column `lastname` on the `users` table. All the data in the column will be lost.
  - Added the required column `userId` to the `orders` table without a default value. This is not possible if the table is not empty.
  - Added the required column `imageUrl` to the `products` table without a default value. This is not possible if the table is not empty.
  - Added the required column `firstName` to the `users` table without a default value. This is not possible if the table is not empty.
  - Added the required column `lastName` to the `users` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "orderdetails" DROP CONSTRAINT "orderdetails_orderid_fkey";

-- DropForeignKey
ALTER TABLE "orderdetails" DROP CONSTRAINT "orderdetails_productid_fkey";

-- DropForeignKey
ALTER TABLE "orders" DROP CONSTRAINT "orders_userid_fkey";

-- AlterTable
ALTER TABLE "orderdetails" DROP COLUMN "orderid",
DROP COLUMN "productid",
ADD COLUMN     "orderId" INTEGER,
ADD COLUMN     "productId" INTEGER;

-- AlterTable
ALTER TABLE "orders" DROP COLUMN "userid",
ADD COLUMN     "userId" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "products" DROP COLUMN "imageurl",
ADD COLUMN     "imageUrl" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "users" DROP COLUMN "firstname",
DROP COLUMN "isadmin",
DROP COLUMN "lastname",
ADD COLUMN     "firstName" VARCHAR(255) NOT NULL,
ADD COLUMN     "isAdmin" BOOLEAN DEFAULT false,
ADD COLUMN     "lastName" VARCHAR(255) NOT NULL;

-- AddForeignKey
ALTER TABLE "orders" ADD CONSTRAINT "orders_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "orderdetails" ADD CONSTRAINT "orderdetails_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES "orders"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "orderdetails" ADD CONSTRAINT "orderdetails_productId_fkey" FOREIGN KEY ("productId") REFERENCES "products"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
