CREATE TABLE IF NOT EXISTS Authors (
    id_author SERIAL PRIMARY KEY,
    author_name VARCHAR(100) NOT NULL,
    author_last_name VARCHAR(100) NOT NULL,
    author_country VARCHAR(100) NOT NULL,
    biography TEXT
);

CREATE TABLE IF NOT EXISTS Series (
    id_series INT PRIMARY KEY,
    id_author SERIAL REFERENCES Authors(id_author),
    name_series VARCHAR(225) NOT NULL,
    series_start_date DATE,
    series_finish_date DATE,
    description_series TEXT
);

CREATE TABLE IF NOT EXISTS Genres (
    id_genre SERIAL PRIMARY KEY,
    name_genre VARCHAR(100) NOT NULL,
    description_genre TEXT
);

CREATE TABLE IF NOT EXISTS Publishers (
    id_publisher SERIAL PRIMARY KEY,
    name_publisher VARCHAR(225) NOT NULL,
    country_publisher VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS Books (
    id_book SERIAL PRIMARY KEY,
    id_author INT REFERENCES Authors(id_author),
    year_of_publication INT NOT NULL,
    number_of_pages INT NOT NULL,
    book_title VARCHAR(225) NOT NULL,
    id_series INT REFERENCES Series(id_series),
    description_book TEXT,
    price DECIMAL(10,2) NOT NULL
);

CREATE TABLE IF NOT EXISTS Book_genres (
    id_book INT REFERENCES Books(id_book),
    id_genre INT REFERENCES Genres(id_genre),
    PRIMARY KEY (id_book, id_genre)
);

CREATE TABLE IF NOT EXISTS Book_publisher (
    id_book INT REFERENCES Books(id_book),
    id_publisher INT REFERENCES Publishers(id_publisher),
    PRIMARY KEY (id_book, id_publisher)
);

CREATE TABLE IF NOT EXISTS Price_history (
    id SERIAL PRIMARY KEY,
    id_book INT REFERENCES Books(id_book),
    price INT NOT NULL,
    date_price TIMESTAMP NOT NULL
);


