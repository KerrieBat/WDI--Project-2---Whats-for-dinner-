CREATE DATABASE dinners;


CREATE TABLE recipes (
  id SERIAL4 PRIMARY KEY,
  recipe_name VARCHAR (400),
  description TEXT,
  user_id INTEGER,
  recipe TEXT,
  photo TEXT,
  votes INTEGER
);

CREATE TABLE users (
  id SERIAL4 PRIMARY KEY,
  email VARCHAR (300),
  username VARCHAR (300),
  password_digest VARCHAR (400)
);

CREATE TABLE categories (
  id SERIAL4 PRIMARY KEY,
  vegetarian BOOLEAN,
  healthy BOOLEAN,
  no_cook BOOLEAN,
  hot BOOLEAN,
  cold BOOLEAN,
  gluten_free BOOLEAN,
  nightshade_free BOOLEAN,
  dairy_free BOOLEAN,
  spicy BOOLEAN,
  kid_friendly BOOLEAN,
  will_impress BOOLEAN,
  less_than_30 BOOLEAN
);

CREATE TABLE links(
id SERIAL4 PRIMARY KEY,
recipe_id INTEGER,
category_id INTEGER
);

CREATE TABLE categories (
  id SERIAL4 PRIMARY KEY,
  category_name VARCHAR(100)
);


INSERT INTO categories (category_name) VALUES ('

INSERT INTO links (recipe_id, category_id) VALUES ('1', '2');



  -- INSERT INTO users (email, username, password_digest)
  -- VALUES ('batrouney@gmail.com', 'kerriebat', 'Ruby123');
