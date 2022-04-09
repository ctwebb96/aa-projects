
DROP TABLE IF EXISTS questions_follows;
DROP TABLE IF EXISTS question_likes;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS users;


PRAGMA foreign_keys = ON; 

-- USERS

CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    fname VARCHAR(255) NOT NULL,
    lname VARCHAR(255) NOT NULL
);

INSERT INTO
    users (fname, lname)
VALUES
    ("Biz", "Nasty"), ("Ryan", "Whitney"), ("Rear", "Admiral");


-- QUESTIONS


CREATE TABLE questions (
    id INTEGER PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    body TEXT NOT NULL,
    author_id INTEGER NOT NULL,

    FOREIGN KEY (author_id) REFERENCES users(id)
);

INSERT INTO
    questions (title, body, author_id)
SELECT
    "Biz's Question", "GO YOTES", 1
FROM
    users
WHERE
    users.fname = "Biz" AND users.lname = "Nasty";

INSERT INTO
    questions (title, body, author_id)
SELECT
    "Whit's Question", "PINK WHITNEY", users.id
FROM
    users
WHERE
    users.fname = "Ryan" AND users.lname = "Whitney";

INSERT INTO
    questions (title, body, author_id)
SELECT
    "RA's Question", "HELLO EVERYBODY", users.id
FROM
    users
WHERE
    users.fname = "Rear" AND users.lname = "Admiral";

-- QUESTION_FOLLOWS

CREATE TABLE question_follows (
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO
    question_follows (user_id, question_id)
VALUES
    ((SELECT id FROM users WHERE fname = "Biz" AND lname = "Nasty"),
    (SELECT id FROM questions WHERE title = "RA's Question")),

    ((SELECT id FROM users WHERE fname = "Ryan" AND lname = "Whitney"),
    (SELECT id FROM questions WHERE title = "RA's Question")
);

-- REPLIES

CREATE TABLE replies (
    id INTEGER PRIMARY KEY,
    question_id INTEGER NOT NULL,
    parent_reply_id INTEGER,
    author_id INTEGER NOT NULL,
    body TEXT NOT NULL,
    FOREIGN KEY (question_id) REFERENCES questions(id),
    FOREIGN KEY (parent_reply_id) REFERENCES replies(id),
    FOREIGN KEY (author_id) REFERENCES users(id)
);

INSERT INTO
    replies (question_id, parent_reply_id, author_id, body)
VALUES
    ((SELECT id FROM questions WHERE title = "RA's Question"),
    NULL,
    (SELECT id FROM users WHERE fname = "Biz" AND lname = "Nasty"),
    "Leafs are killing it RA."
);

INSERT INTO
    replies (question_id, parent_reply_id, author_id, body)
VALUES
    ((SELECT id FROM questions WHERE title = "RA's Question"),
    (SELECT id FROM replies WHERE body = "Leafs are killing it RA."),
    (SELECT id FROM users WHERE fname = "Ryan" AND lname = "Whitney"),
    "He said HELLO EVERYBODY."
    );

-- QUESTION_LIKES

CREATE TABLE question_likes (
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,

    FOREIGN KEY(user_id) REFERENCES users(id)
    FOREIGN KEY(question_id) REFERENCES questions(id)
);

INSERT INTO
    question_likes (user_id, question_id)
VALUES
    ((SELECT id FROM users WHERE fname = "Ryan" AND lname = "Whitney"),
    (SELECT id FROM questions WHERE title = "RA's Question")
    );