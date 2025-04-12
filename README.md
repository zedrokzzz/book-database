# База данных для управления информацией о книгах, авторах, жанрах, сериях и издательствах

Эта база данных предназначена для управления информацией о книгах, авторах, жанрах, сериях и издательствах. Она включает таблицы для хранения данных о книгах, их авторах, жанрах, сериях и издательствах, а также таблицы для связей между этими сущностями и истории изменения цен на книги. Основная цель — обеспечить структурированное хранение данных о книгах и их характеристиках, а также поддерживать связь между различными аспектами книжной индустрии.

## Таблицы базы данных:

### Книги (Books)
Содержит информацию о книгах, включая данные о названии, авторе, году публикации, количестве страниц, жанре, серии и издательстве:
- `id_book (PK)` — уникальный ID книги
- `book_title` — название книги
- `year_of_publication` — год издания
- `number_of_pages` — количество страниц
- `id_author (FK)` — ID автора книги
- `id_series (FK)` — ID серии книги
- `description_book` — описание книги
- `price` — цена книги

### Авторы (Authors)
Содержит информацию об авторах книг:
- `id_author (PK)` — уникальный ID автора
- `author_name` — имя автора
- `author_last_name` — фамилия автора
- `author_country` — страна автора
- `biography` — краткая биография автора

### Жанры (Genres)
Содержит информацию о жанрах книг:
- `id_genre (PK)` — уникальный ID жанра
- `name_genre` — название жанра
- `description_genre` — описание жанра

### Серии (Series)
Содержит информацию о книжных сериях:
- `id_series (PK)` — уникальный ID серии
- `id_author (FK)` — ID автора серии
- `name_series` — название серии
- `series_start_date` — дата начала серии
- `series_finish_date` — дата завершения серии
- `description_series` — описание серии

### Издательства (Publishers)
Содержит информацию о издательствах:
- `id_publisher (PK)` — уникальный ID издательства
- `name_publisher` — название издательства
- `country_publisher` — страна издательства

### Связи книг с жанрами (Book_genres)
Обеспечивает связь между книгами и жанрами, так как одна книга может иметь несколько жанров:
- `id_book (FK)` — ID книги
- `id_genre (FK)` — ID жанра

### Связи книг с издательствами (Book_publisher)
Обеспечивает связь между книгами и издательствами, так как одна книга может быть выпущена несколькими издательствами:
- `id_book (FK)` — ID книги
- `id_publisher (FK)` — ID издательства

### История цен на книги (Price_history)
Хранит информацию о изменении цен на книги:
- `id (PK)` — уникальный ID записи
- `id_book (FK)` — ID книги
- `price` — цена книги
- `date_price` — дата изменения цены

## Концептуальная модель
![Концептуальная модель drawio](https://github.com/user-attachments/assets/bb9e8649-735e-4c17-9596-68ce6442aa23)

## Логическая модель
![Логическая модель drawio](https://github.com/user-attachments/assets/764d9ec7-08e3-427a-9a06-32a672d2269f)

## Физическая модель
![Диаграмма без названия drawio](https://github.com/user-attachments/assets/90f25032-ee09-4a8f-84ca-4c93411aa5d1)

## Нормальная форма

Для своей базы данных я выбрала 3NF:

### 1. 1NF (Первая нормальная форма):
Таблица в 1NF, потому что все столбцы содержат атомарные значения (например, `book_title` — это одно значение, а не список). Нет многозначных атрибутов.

### 2. 2NF (Вторая нормальная форма):
Таблица в 2NF, так как все атрибуты зависят от полного первичного ключа — `id_book`. Например, `book_title`, `year_of_publication`, `price` зависят от `id_book`, а не от части ключа.

### 3. 3NF (Третья нормальная форма):
Таблица в 3NF, так как нет транзитивных зависимостей. Это значит, что нет таких случаев, когда одно неключевое поле зависит от другого неключевого поля. Описание книги (`description_book`) зависит напрямую от `id_book`, а не от `id_author` или других атрибутов. Цена (`price`) зависит от `id_book`, а не от других столбцов, например, от автора или серии.

Отсутствие транзитивных зависимостей:
В таблице `Books` цена книги не зависит от автора или серии, она зависит только от самой книги (`id_book`). Сведения о серии (например, `id_series`, `description_series`) хранятся в таблице `Series`, а не в таблице `Books`, чтобы избежать зависимости между неключевыми столбцами.

Таким образом, таблица `Books` в 3NF, потому что все неключевые атрибуты зависят только от первичного ключа и не зависят друг от друга.

### Преимущества:
- **Меньше избыточности:** Данные хранятся только в одном месте.
- **Целостность данных:** Меньше шансов на аномалии при обновлениях.
- **Производительность:** Оптимизация запросов через правильные связи и индексы.
- **Гибкость:** Легко добавлять новые данные без изменения структуры.

## Нормальная форма с версионированием

У меня используется версионирование на основе истории. В таблице `Price_history` я храню все изменения цен для каждой книги с датой изменения. Каждое новое изменение добавляется как отдельная запись, не заменяя старую.

Каждый раз, когда меняется цена книги, добавляется новая запись в таблицу `Price_history` с указанием нового значения цены и даты изменения. Это позволяет отслеживать изменения цены книги с течением времени.

Таблица не перезаписывает старые значения, а добавляет новые записи, создавая историю изменений.

### Преимущества версионирования на основе истории:
- **Полная история изменений:** я могу отслеживать все изменения цен книги с точными датами.
- **Восстановление данных:** можно восстановить цену на любую дату, что важно для анализа или отчетности.

---
-- Создание таблицы Authors (Авторы)
CREATE TABLE Authors (
    id_author SERIAL PRIMARY KEY,
    author_name VARCHAR(100) NOT NULL,
    author_last_name VARCHAR(100) NOT NULL,
    author_country VARCHAR(100) NOT NULL,
    biography TEXT
);

-- Создание таблицы Series (Серии)
CREATE TABLE Series (
    id_series INT PRIMARY KEY,
    id_author SERIAL REFERENCES Authors(id_author),
    name_series VARCHAR(225) NOT NULL,
    series_start_date DATE,
    series_finish_date DATE,
    description_series TEXT
);

-- Создание таблицы Genres (Жанры)
CREATE TABLE Genres (
    id_genre SERIAL PRIMARY KEY,
    name_genre VARCHAR(100) NOT NULL,
    description_genre TEXT
);

-- Создание таблицы Publishers (Издательства)
CREATE TABLE Publishers (
    id_publisher SERIAL PRIMARY KEY,
    name_publisher VARCHAR(225) NOT NULL,
    country_publisher VARCHAR(100) NOT NULL
);

-- Создание таблицы Books (Книги)
CREATE TABLE Books (
    id_book SERIAL PRIMARY KEY,
    id_author INT REFERENCES Authors(id_author),
    year_of_publication INT NOT NULL,
    number_of_pages INT NOT NULL,
    book_title VARCHAR(225) NOT NULL,
    id_series INT REFERENCES Series(id_series),
    description_book TEXT,
    price DECIMAL(10,2) NOT NULL
);

-- Создание таблицы Book_genres (Связи книг с жанрами)
CREATE TABLE Book_genres (
    id_book INT REFERENCES Books(id_book),
    id_genre INT REFERENCES Genres(id_genre),
    PRIMARY KEY (id_book, id_genre)
);

-- Создание таблицы Book_publisher (Связи книг с издательствами)
CREATE TABLE Book_publisher (
    id_book INT REFERENCES Books(id_book),
    id_publisher INT REFERENCES Publishers(id_publisher),
    PRIMARY KEY (id_book, id_publisher)
);

-- Создание таблицы Price_history (История цен на книги)
CREATE TABLE Price_history (
    id SERIAL PRIMARY KEY,
    id_book INT REFERENCES Books(id_book),
    price INT NOT NULL,
    date_price TIMESTAMP NOT NULL
);
