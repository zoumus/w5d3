
PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS question_likes;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS users;

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

    FOREIGN KEY(author_id) REFERENCES users(id)
);

CREATE TABLE question_follows (
    id INTEGER PRIMARY KEY,
    question_id INTEGER NOT NULL,
    follower_author_id INTEGER NOT NULL,

    FOREIGN KEY(question_id) REFERENCES questions(id),
    FOREIGN KEY(follower_author_id) REFERENCES users(id)
);

CREATE TABLE replies (
    id INTEGER PRIMARY KEY,
    body TEXT NOT NULL,
    author_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,
    parent_reply_id INTEGER,

    FOREIGN KEY(question_id) REFERENCES questions(id),
    FOREIGN KEY(author_id) REFERENCES users(id),
    FOREIGN KEY(parent_reply_id) REFERENCES replies(id)
);

CREATE TABLE question_likes (
    id INTEGER PRIMARY KEY,
    author_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,

    FOREIGN KEY(author_id) REFERENCES users(id),
    FOREIGN KEY(question_id) REFERENCES questions(id)
);

INSERT INTO
    users(fname, lname)
VALUES
    ('zuzu', 'chaoui'),
    ('jeffrey', 'li');


INSERT INTO
    questions(title, body, author_id)
VALUES
    ('Zuzu questions','can I use the bathrooom?', 1),
    ('Jeffrey questions', 'Can we finish the project?', 2);


INSERT INTO
    question_follows(follower_author_id, question_id)
VALUES
    (1,1),
    (2,1),
    (2,2);

    
INSERT INTO
    replies(body,question_id, parent_reply_id, author_id)
VALUES
    ('Your question sucks', 1, NULL, 1),
        ('No, your question sucks!',1, 1, 2),
        ('Too bad', 1,2,1),
    ('No way', 2, NULL, 2),
        ('Are you sure?',2, 3, 1 ),
        ('Not really',2, 4, 2);


INSERT INTO
    question_likes(author_id, question_id)
VALUES
    (1,1),
    (2,2);