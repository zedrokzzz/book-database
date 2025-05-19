# База данных для управления информацией о книгах

Эта база данных предназначена для удобного пользования информацией книжной библиотеки. Она включает таблицы для хранения данных о книгах, их авторах, жанрах, сериях и издательствах, а также таблицы для связей между этими сущностями и истории изменения цен на книги. Основная цель — обеспечить структурированное хранение данных о книгах и их характеристиках.

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
Таблица в 3NF, так как нет транзитивных зависимостей. Это значит, что нет таких случаев, когда одно неключевое поле зависит от другого неключевого поля. 

Описание книги (`description_book`) зависит напрямую от `id_book`, а не от `id_author` или других атрибутов. Цена (`price`) зависит от `id_book`, а не от других столбцов, например, от автора или серии.
В таблице `Books` цена книги не зависит от автора или серии, она зависит только от самой книги (`id_book`). Сведения о серии (например, `id_series`, `description_series`) хранятся в таблице `Series`, а не в таблице `Books`, чтобы избежать зависимости между неключевыми столбцами.

Таким образом, таблица `Books` в 3NF, потому что все неключевые атрибуты зависят только от первичного ключа и не зависят друг от друга.

### Преимущества:
- **Меньше избыточности:** Данные хранятся только в одном месте.
- **Целостность данных:** Меньше шансов на аномалии при обновлениях.
- **Производительность:** Оптимизация запросов через правильные связи и индексы.
- **Гибкость:** Легко добавлять новые данные без изменения структуры.

## Тип версионирования

У меня используется версионирование на основе истории. В таблице `Price_history` я храню все изменения цен для каждой книги с датой изменения. Каждое новое изменение добавляется как отдельная запись, не заменяя старую.
Таблица не перезаписывает старые значения, а добавляет новые записи, создавая историю изменений.

### Преимущества версионирования на основе истории:
- **Полная история изменений:** я могу отслеживать все изменения цен книги с точными датами.
- **Восстановление данных:** можно восстановить цену на любую дату, что важно для анализа или отчетности.

---

## Скрипт
```sql
-- Создание таблицы Authors (Авторы)
CREATE TABLE IF NOT EXISTS Authors (
    id_author SERIAL PRIMARY KEY,
    author_name VARCHAR(100) NOT NULL,
    author_last_name VARCHAR(100) NOT NULL,
    author_country VARCHAR(100) NOT NULL,
    biography TEXT
);

-- Создание таблицы Series (Серии)
CREATE TABLE IF NOT EXISTS Series (
    id_series INT PRIMARY KEY,
    id_author SERIAL REFERENCES Authors(id_author),
    name_series VARCHAR(225) NOT NULL,
    series_start_date DATE,
    series_finish_date DATE,
    description_series TEXT
);

-- Создание таблицы Genres (Жанры)
CREATE TABLE IF NOT EXISTS Genres (
    id_genre SERIAL PRIMARY KEY,
    name_genre VARCHAR(100) NOT NULL,
    description_genre TEXT
);

-- Создание таблицы Publishers (Издательства)
CREATE TABLE IF NOT EXISTS Publishers (
    id_publisher SERIAL PRIMARY KEY,
    name_publisher VARCHAR(225) NOT NULL,
    country_publisher VARCHAR(100) NOT NULL
);

-- Создание таблицы Books (Книги)
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

-- Создание таблицы Book_genres (Связи книг с жанрами)
CREATE TABLE IF NOT EXISTS Book_genres (
    id_book INT REFERENCES Books(id_book),
    id_genre INT REFERENCES Genres(id_genre),
    PRIMARY KEY (id_book, id_genre)
);

-- Создание таблицы Book_publisher (Связи книг с издательствами)
CREATE TABLE IF NOT EXISTS Book_publisher (
    id_book INT REFERENCES Books(id_book),
    id_publisher INT REFERENCES Publishers(id_publisher),
    PRIMARY KEY (id_book, id_publisher)
);

-- Создание таблицы Price_history (История цен на книги)
CREATE TABLE IF NOT EXISTS Price_history (
    id SERIAL PRIMARY KEY,
    id_book INT REFERENCES Books(id_book),
    price INT NOT NULL,
    date_price TIMESTAMP NOT NULL
);
```


---
# SQL-запросы для базы данных книг

### 1. Топ-5 самых дорогих книг (цена > 500₽)

```sql
SELECT
  b.book_title,
  b.price,
  a.author_name,
  a.author_last_name
FROM Books b
JOIN Authors a ON a.id_author = b.id_author
WHERE b.price > 500
ORDER BY b.price DESC
LIMIT 5 OFFSET 0;
```

---

### 2. Авторы, у которых средняя цена книг выше 600₽

```sql
SELECT
  a.author_name,
  a.author_last_name, 
  ROUND(AVG(b.price), 0) AS avg_price
FROM Authors a
JOIN Books b ON a.id_author = b.id_author
GROUP BY a.author_name, a.author_last_name
HAVING AVG(b.price) > 600
ORDER BY avg_price DESC;
```

---

### 3. Книги в жанре "Научная фантастика"

```sql
SELECT
  a.author_name,
  a.author_last_name,
  b.book_title, 
  g.name_genre
FROM Books b
JOIN Authors a ON a.id_author = b.id_author
JOIN Book_genres bg ON b.id_book = bg.id_book
JOIN Genres g ON bg.id_genre = g.id_genre
WHERE g.name_genre = 'Science Fiction';
```

---

### 4. Книги в том же жанре, что и "1984"

```sql
SELECT DISTINCT b.book_title
FROM Books b
JOIN Book_genres bg ON b.id_book = bg.id_book
WHERE bg.id_genre IN (
  SELECT id_genre
  FROM Book_genres
  WHERE id_book = (
    SELECT id_book
    FROM Books
    WHERE book_title = '1984'
  )
);
```

---

### 5. Рейтинг книг по цене для каждого автора

```sql
SELECT
    a.author_name,
    a.author_last_name,
    b.book_title,
    b.price,
    ROW_NUMBER() OVER (
        PARTITION BY a.id_author
        ORDER BY b.price DESC
    ) AS price_rank
FROM 
    Books b
JOIN 
    Authors a 
    ON b.id_author = a.id_author;
```

---

### 6. История изменения цены книги "Преступление и наказание"

```sql
SELECT 
  ph.date_price,
  ph.price,
  LAG(ph.price) OVER (ORDER BY ph.date_price) AS previous_price,
  ph.price - LAG(ph.price) OVER (ORDER BY ph.date_price) AS price_diff
FROM Price_history ph
JOIN Books b ON b.id_book = ph.id_book
WHERE b.book_title = 'Crime and Punishment';
```

---

### 7. Самые популярные жанры (по числу книг в каждом жанре)

```sql
SELECT 
  g.name_genre, 
  COUNT(bg.id_book) AS books_in_genre
FROM Genres g
JOIN Book_genres bg ON g.id_genre = bg.id_genre
GROUP BY g.name_genre
ORDER BY books_in_genre DESC
LIMIT 5;
```

---


### 8. Разница между минимальной и максимальной ценой книги

```sql
SELECT 
  MAX(price) - MIN(price) AS price_range
FROM Books;
```

---

### 9. Список книг, у которых нет истории изменения цены

```sql
SELECT b.book_title
FROM Books b
LEFT JOIN Price_history ph ON b.id_book = ph.id_book
WHERE ph.id_book IS NULL;
```

---

### 10. Авторы и количество книг в каждом жанре, которые они написали

```sql
SELECT 
  a.author_name || ' ' || a.author_last_name AS full_author_name,
  g.name_genre,
  COUNT(DISTINCT b.id_book) AS books_in_genre
FROM Books b
JOIN Authors a ON b.id_author = a.id_author
JOIN Book_genres bg ON b.id_book = bg.id_book
JOIN Genres g ON bg.id_genre = g.id_genre
GROUP BY a.author_name, a.author_last_name, g.name_genre
ORDER BY 
  a.author_last_name,
  a.author_name,
  books_in_genre DESC;
![image](https://github.com/user-attachments/assets/4bb6f81a-91e4-463b-8fe9-4f143e2b7a2c)

```

---
