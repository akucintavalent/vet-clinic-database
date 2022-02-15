/* Database schema to keep the structure of entire database. */

CREATE TABLE animals(
    id int primary key not null,
    name            varchar(100) not null,
    date_of_birth   date,
    escape_attempts int,
    neutered        boolean,
    weight_kg       decimal
);
