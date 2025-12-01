-- CreateTable
CREATE TABLE "Client" (
    "client_id" SERIAL NOT NULL,
    "last_name" VARCHAR(255) NOT NULL,
    "first_name" VARCHAR(255) NOT NULL,

    CONSTRAINT "Client_pkey" PRIMARY KEY ("client_id")
);

-- CreateTable
CREATE TABLE "Genre" (
    "genre_id" SERIAL NOT NULL,
    "genre_name" VARCHAR(255) NOT NULL,

    CONSTRAINT "Genre_pkey" PRIMARY KEY ("genre_id")
);

-- CreateTable
CREATE TABLE "Hall" (
    "hall_id" SERIAL NOT NULL,
    "hall_name" VARCHAR(255) NOT NULL,

    CONSTRAINT "Hall_pkey" PRIMARY KEY ("hall_id")
);

-- CreateTable
CREATE TABLE "Movie" (
    "movie_id" SERIAL NOT NULL,
    "title" VARCHAR(255) NOT NULL,
    "budget" DECIMAL(15,2),
    "description" TEXT,
    "release_date" DATE,
    "box_office" DECIMAL(15,2),
    "duration" INTEGER,
    "tagline" VARCHAR(255),
    "average_rating" REAL,

    CONSTRAINT "Movie_pkey" PRIMARY KEY ("movie_id")
);

-- CreateTable
CREATE TABLE "MovieGenre" (
    "movie_id" INTEGER NOT NULL,
    "genre_id" INTEGER NOT NULL,

    CONSTRAINT "MovieGenre_pkey" PRIMARY KEY ("movie_id","genre_id")
);

-- CreateTable
CREATE TABLE "Schedule" (
    "schedule_id" SERIAL NOT NULL,
    "hall_id" INTEGER NOT NULL,
    "showing_id" INTEGER NOT NULL,
    "movie_id" INTEGER NOT NULL,

    CONSTRAINT "Schedule_pkey" PRIMARY KEY ("schedule_id")
);

-- CreateTable
CREATE TABLE "Showing" (
    "showing_id" SERIAL NOT NULL,
    "show_date" DATE NOT NULL,
    "show_time" TIME(6) NOT NULL,

    CONSTRAINT "Showing_pkey" PRIMARY KEY ("showing_id")
);

-- CreateTable
CREATE TABLE "ShowtimePrice" (
    "show_time" TIME(6) NOT NULL,
    "price" DECIMAL(8,2) NOT NULL,

    CONSTRAINT "ShowtimePrice_pkey" PRIMARY KEY ("show_time")
);

-- CreateTable
CREATE TABLE "Ticket" (
    "ticket_id" SERIAL NOT NULL,
    "schedule_id" INTEGER NOT NULL,
    "client_id" INTEGER NOT NULL,
    "seat" VARCHAR(10) NOT NULL,

    CONSTRAINT "Ticket_pkey" PRIMARY KEY ("ticket_id")
);

-- CreateTable
CREATE TABLE "reviews" (
    "id" SERIAL NOT NULL,
    "movieId" INTEGER NOT NULL,
    "rating" SMALLINT NOT NULL,
    "comment" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "reviews_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Genre_genre_name_key" ON "Genre"("genre_name");

-- CreateIndex
CREATE UNIQUE INDEX "Hall_hall_name_key" ON "Hall"("hall_name");

-- CreateIndex
CREATE UNIQUE INDEX "Movie_title_key" ON "Movie"("title");

-- CreateIndex
CREATE UNIQUE INDEX "Ticket_schedule_id_seat_key" ON "Ticket"("schedule_id", "seat");

-- AddForeignKey
ALTER TABLE "MovieGenre" ADD CONSTRAINT "MovieGenre_movie_id_fkey" FOREIGN KEY ("movie_id") REFERENCES "Movie"("movie_id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "MovieGenre" ADD CONSTRAINT "MovieGenre_genre_id_fkey" FOREIGN KEY ("genre_id") REFERENCES "Genre"("genre_id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "Schedule" ADD CONSTRAINT "Schedule_hall_id_fkey" FOREIGN KEY ("hall_id") REFERENCES "Hall"("hall_id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "Schedule" ADD CONSTRAINT "Schedule_movie_id_fkey" FOREIGN KEY ("movie_id") REFERENCES "Movie"("movie_id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "Schedule" ADD CONSTRAINT "Schedule_showing_id_fkey" FOREIGN KEY ("showing_id") REFERENCES "Showing"("showing_id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "Showing" ADD CONSTRAINT "Showing_show_time_fkey" FOREIGN KEY ("show_time") REFERENCES "ShowtimePrice"("show_time") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "Ticket" ADD CONSTRAINT "Ticket_client_id_fkey" FOREIGN KEY ("client_id") REFERENCES "Client"("client_id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "Ticket" ADD CONSTRAINT "Ticket_schedule_id_fkey" FOREIGN KEY ("schedule_id") REFERENCES "Schedule"("schedule_id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "reviews" ADD CONSTRAINT "reviews_movieId_fkey" FOREIGN KEY ("movieId") REFERENCES "Movie"("movie_id") ON DELETE CASCADE ON UPDATE CASCADE;
