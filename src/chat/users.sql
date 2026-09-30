CREATE TABLE IF NOT EXISTS users (
    username VARCHAR NOT NULL PRIMARY KEY,
    password VARCHAR NOT NULL
) WITHOUT ROWID;

INSERT INTO users (username, password)
VALUES ('user_1','pwd_1_sha1');

INSERT INTO users (username, password)
VALUES ('user_2','pwd_2_sha1');
