/*
  Warnings:

  - You are about to alter the column `items` on the `orders` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(255)`.
  - You are about to alter the column `name` on the `products` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(255)`.
  - You are about to alter the column `description` on the `products` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(255)`.
  - You are about to drop the column `isAdmin` on the `users` table. All the data in the column will be lost.
  - You are about to alter the column `email` on the `users` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(255)`.
  - You are about to alter the column `password` on the `users` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(255)`.
  - Added the required column `userid` to the `orders` table without a default value. This is not possible if the table is not empty.
  - Added the required column `imageurl` to the `products` table without a default value. This is not possible if the table is not empty.
  - Added the required column `firstname` to the `users` table without a default value. This is not possible if the table is not empty.
  - Added the required column `lastname` to the `users` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "orders" ADD COLUMN     "userid" INTEGER NOT NULL,
ALTER COLUMN "items" SET DATA TYPE VARCHAR(255);

-- AlterTable
ALTER TABLE "products" ADD COLUMN     "imageurl" VARCHAR(255) NOT NULL,
ALTER COLUMN "name" SET DATA TYPE VARCHAR(255),
ALTER COLUMN "description" SET DATA TYPE VARCHAR(255);

-- AlterTable
ALTER TABLE "users" DROP COLUMN "isAdmin",
ADD COLUMN     "firstname" VARCHAR(255) NOT NULL,
ADD COLUMN     "isadmin" BOOLEAN DEFAULT false,
ADD COLUMN     "lastname" VARCHAR(255) NOT NULL,
ALTER COLUMN "email" SET DATA TYPE VARCHAR(255),
ALTER COLUMN "password" SET DATA TYPE VARCHAR(255);

-- CreateTable
CREATE TABLE "orderdetails" (
    "id" SERIAL NOT NULL,
    "productid" INTEGER,
    "orderid" INTEGER,

    CONSTRAINT "orderdetails_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "orders" ADD CONSTRAINT "orders_userid_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "orderdetails" ADD CONSTRAINT "orderdetails_orderid_fkey" FOREIGN KEY ("orderid") REFERENCES "orders"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "orderdetails" ADD CONSTRAINT "orderdetails_productid_fkey" FOREIGN KEY ("productid") REFERENCES "products"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- RenameIndex
ALTER INDEX "users_email_idx" RENAME TO "users_email_key";
