/* Database schema to keep the structure of entire database. */

CREATE TABLE animals(
    id INT PRIMARY KEY NOT NULL GENERATED ALWAYS AS IDENTITY,
    name            VARCHAR(100) NOT NULL,
    date_of_birth   DATE,
    escape_attempts INT,
    neutered        BOOLEAN,
    weight_kg       DECIMAL
);

/* Day 2 */

ALTER TABLE animals ADD COLUMN species TEXT;

/* Day 3 */

CREATE TABLE owners(
    id        INT PRIMARY KEY NOT NULL GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR(100) NOT NULL,
    age       INT
);

CREATE TABLE species(
    id    INT PRIMARY KEY NOT NULL GENERATED ALWAYS AS IDENTITY,
    name  VARCHAR(100) NOT NULL
);

ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals ADD COLUMN species_id INT;
ALTER TABLE animals ADD FOREIGN KEY (species_id) REFERENCES species(id);
ALTER TABLE animals ADD COLUMN owner_id INT;
ALTER TABLE animals ADD FOREIGN KEY (owner_id) REFERENCES owners(id);

/* Day 4 */

CREATE TABLE vets(
    id    INT PRIMARY KEY NOT NULL GENERATED ALWAYS AS IDENTITY,
    name  VARCHAR(100) NOT NULL,
    age   INT,
    date_of_graduation DATE
);

CREATE TABLE specializations(
    species_id  INT NOT NULL,
    vet_id      INT NOT NULL,
    FOREIGN KEY (species_id) REFERENCES species(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (vet_id) REFERENCES vets(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    PRIMARY KEY (species_id, vet_id)
);

CREATE TABLE visits(
    animal_id   INT NOT NULL,
    vet_id      INT NOT NULL,
    date        DATE,
    FOREIGN KEY (animal_id) REFERENCES animals(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (vet_id) REFERENCES vets(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    PRIMARY KEY (animal_id, vet_id, date)
);

/* Week 2 Day 1 */

-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

-- Create indexes to increase performance
CREATE INDEX animals_id_ASC ON visits(animal_id ASC);
CREATE INDEX vet_id_ACS ON visits(vet_id ASC);
CREATE INDEX email_ACS ON owners(email ASC);
