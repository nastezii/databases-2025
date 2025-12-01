/*
  Warnings:

  - You are about to drop the `Hall` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `MovieGenre` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Schedule` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `ShowtimePrice` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Ticket` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "MovieGenre" DROP CONSTRAINT "MovieGenre_genre_id_fkey";

-- DropForeignKey
ALTER TABLE "MovieGenre" DROP CONSTRAINT "MovieGenre_movie_id_fkey";

-- DropForeignKey
ALTER TABLE "Schedule" DROP CONSTRAINT "Schedule_hall_id_fkey";

-- DropForeignKey
ALTER TABLE "Schedule" DROP CONSTRAINT "Schedule_movie_id_fkey";

-- DropForeignKey
ALTER TABLE "Schedule" DROP CONSTRAINT "Schedule_showing_id_fkey";

-- DropForeignKey
ALTER TABLE "Showing" DROP CONSTRAINT "Showing_show_time_fkey";

-- DropForeignKey
ALTER TABLE "Ticket" DROP CONSTRAINT "Ticket_client_id_fkey";

-- DropForeignKey
ALTER TABLE "Ticket" DROP CONSTRAINT "Ticket_schedule_id_fkey";

-- DropTable
DROP TABLE "Hall";

-- DropTable
DROP TABLE "MovieGenre";

-- DropTable
DROP TABLE "Schedule";

-- DropTable
DROP TABLE "ShowtimePrice";

-- DropTable
DROP TABLE "Ticket";

-- CreateTable
CREATE TABLE "hall" (
    "hall_id" SERIAL NOT NULL,
    "hall_name" VARCHAR(255) NOT NULL,
    "isVip" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "hall_pkey" PRIMARY KEY ("hall_id")
);

-- CreateTable
CREATE TABLE "movies_genres" (
    "movie_id" INTEGER NOT NULL,
    "genre_id" INTEGER NOT NULL,

    CONSTRAINT "movies_genres_pkey" PRIMARY KEY ("movie_id","genre_id")
);

-- CreateTable
CREATE TABLE "schedule" (
    "schedule_id" SERIAL NOT NULL,
    "hall_id" INTEGER NOT NULL,
    "showing_id" INTEGER NOT NULL,
    "movie_id" INTEGER NOT NULL,

    CONSTRAINT "schedule_pkey" PRIMARY KEY ("schedule_id")
);

-- CreateTable
CREATE TABLE "showtime_prices" (
    "show_time" TIME(6) NOT NULL,
    "price" DECIMAL(8,2) NOT NULL,

    CONSTRAINT "showtime_prices_pkey" PRIMARY KEY ("show_time")
);

-- CreateTable
CREATE TABLE "tickets" (
    "ticket_id" SERIAL NOT NULL,
    "schedule_id" INTEGER NOT NULL,
    "client_id" INTEGER NOT NULL,
    "seat" VARCHAR(10) NOT NULL,

    CONSTRAINT "tickets_pkey" PRIMARY KEY ("ticket_id")
);

-- CreateIndex
CREATE UNIQUE INDEX "hall_hall_name_key" ON "hall"("hall_name");

-- CreateIndex
CREATE UNIQUE INDEX "tickets_schedule_id_seat_key" ON "tickets"("schedule_id", "seat");

-- AddForeignKey
ALTER TABLE "movies_genres" ADD CONSTRAINT "movies_genres_movie_id_fkey" FOREIGN KEY ("movie_id") REFERENCES "Movie"("movie_id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "movies_genres" ADD CONSTRAINT "movies_genres_genre_id_fkey" FOREIGN KEY ("genre_id") REFERENCES "Genre"("genre_id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "schedule" ADD CONSTRAINT "schedule_hall_id_fkey" FOREIGN KEY ("hall_id") REFERENCES "hall"("hall_id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "schedule" ADD CONSTRAINT "schedule_movie_id_fkey" FOREIGN KEY ("movie_id") REFERENCES "Movie"("movie_id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "schedule" ADD CONSTRAINT "schedule_showing_id_fkey" FOREIGN KEY ("showing_id") REFERENCES "Showing"("showing_id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "Showing" ADD CONSTRAINT "Showing_show_time_fkey" FOREIGN KEY ("show_time") REFERENCES "showtime_prices"("show_time") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tickets" ADD CONSTRAINT "tickets_client_id_fkey" FOREIGN KEY ("client_id") REFERENCES "Client"("client_id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tickets" ADD CONSTRAINT "tickets_schedule_id_fkey" FOREIGN KEY ("schedule_id") REFERENCES "schedule"("schedule_id") ON DELETE CASCADE ON UPDATE NO ACTION;
