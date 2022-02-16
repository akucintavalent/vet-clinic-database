/* Database schema to keep the structure of entire database. */

CREATE TABLE animals(
    id INT PRIMARY KEY NOT NULL GENERATED ALWAYS AS IDENTITY,
    name            VARCHAR(100) not null,
    date_of_birth   DATE,
    escape_attempts INT,
    neutered        BOOLEAN,
    weight_kg       DECIMAL,
    species         TEXT
);
