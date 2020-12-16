PRAGMA foreign_keys = ON;

CREATE TABLE users (
    id INTEGER PRIMARY KEY, 
    fname TEXT NOT NULL, 
    lname TEXT NOT NULL

);

CREATE TABLE questions (
    id INTEGER PRIMARY KEY, 
    title TEXT NOT NULL, 
    body TEXT NOT NULL,
    author_id INTEGER NOT NULL, 

    FOREIGN KEY (author_id) REFERENCES users(id)
);

CREATE TABLE question_follows (
    id INTEGER PRIMARY KEY, 
    users_id INTEGER NOT NULL, 
    questions_id INTEGER NOT NULL,

    FOREIGN KEY (questions_id) REFERENCES questions(id),
    FOREIGN KEY (users_id) REFERENCES users(id)
 
);

CREATE TABLE replies (
    id INTEGER PRIMARY KEY,
    body TEXT NOT NULL,
    questions_id INTEGER NOT NULL,
    author_id INTEGER NOT NULL,
    parent_reply_id INTEGER,

    FOREIGN KEY (author_id) REFERENCES users(id),
    FOREIGN KEY (questions_id) REFERENCES questions(id),
    FOREIGN KEY (parent_reply_id) REFERENCES replies(id)
);

CREATE TABLE question_likes (
    id INTEGER PRIMARY KEY,
    users_id INTEGER NOT NULL, 
    questions_id INTEGER NOT NULL,

    FOREIGN KEY (questions_id) REFERENCES questions(id),
    FOREIGN KEY (users_id) REFERENCES users(id)
);

INSERT INTO
    users (fname, lname)
VALUES
    ("Bob","Bobbington"), ("Cindy", "Carpenter"), ("Sam", "Smith");



INSERT INTO 
    questions (title, body, author_id)
VALUES 
    ("Does God exist?", "Looks like no", (SELECT id FROM users WHERE users.fname = "Bob" and users.lname = "Bobbington"));

INSERT INTO 
    questions (title, body, author_id)
VALUES 
    ("Is Bob kind of a jerk?", "Looks like yes", (SELECT id FROM users WHERE users.fname = "Cindy" and users.lname = "Carpenter"));

INSERT INTO 
    questions (title, body, author_id)
VALUES 
    ("What is the meaning of life?", "what is the answer", (SELECT id FROM users WHERE users.fname = "Sam" and users.lname = "Smith"));

INSERT INTO 
    question_follows (users_id, questions_id)
VALUES
    ((SELECT id FROM users WHERE users.fname = "Bob" and users.lname = "Bobbington"),
    (SELECT id FROM questions WHERE title = "Does God exist?")
);

INSERT INTO 
    question_follows (users_id, questions_id)
VALUES
    ((SELECT id FROM users WHERE users.fname = "Cindy" and users.lname = "Carpingtor"),
    (SELECT id FROM questions WHERE title = "Is Bob kind of a jerk?")
    );

INSERT INTO 
    question_follows (users_id, questions_id)
VALUES
    ((SELECT id FROM users WHERE users.fname = "Sam" and users.lname = "Smith"),
    (SELECT id FROM questions WHERE title = "What is the meaning of life?")
    );


