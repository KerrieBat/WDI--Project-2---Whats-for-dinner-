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

INSERT into recipes (recipe_name, user_id) values ('dal', '1');

  -- INSERT INTO users (email, username, password_digest)
  -- VALUES ('batrouney@gmail.com', 'kerriebat', 'Ruby123');

-- this works to get the list of recipe names but there are duplicates of the recipe name when more than one category is true.

SELECT recipes.recipe_name, links.category_id
FROM recipes
JOIN links ON recipes.id = links.recipe_id
JOIN categories ON categories.id = links.category_id
WHERE links.category_id = hotid
OR links.category_id = coldid
OR links.category_id = rawid
OR links.category_id = quickid
OR links.category_id = vegetarianid
OR links.category_id = kidid
OR links.category_id = spicyid
OR links.category_id = shadeid
OR links.category_id = dairyid
OR links.category_id = glutenid
OR links.category_id = impressid
OR links.category_id = healthyid;


SELECT recipes.recipe_name, links.category_id FROM recipes JOIN links ON recipes.id = links.recipe_id JOIN categories ON categories.id = links.category_id WHERE links.category_id IN (#{hotid}, #{coldid}, #{spicyid});










SELECT recipes.recipe_name, links.category_id
FROM recipes
JOIN links ON recipes.id = links.recipe_id
JOIN categories ON categories.id = links.category_id;
