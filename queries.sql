/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-01-01';
SELECT name FROM animals WHERE neutered AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name LIKE 'Agumon' OR name LIKE 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered;
SELECT * FROM animals WHERE name NOT LIKE 'Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

/* Day 2 */

BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT species FROM animals;
ROLLBACK;
SELECT species FROM animals;
END;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
SELECT species FROM animals;
COMMIT;
SELECT species FROM animals;
END;

BEGIN;
DELETE from animals;
SELECT species FROM animals;
ROLLBACK;
SELECT species FROM animals;
END;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT remove_Plantmon;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO remove_Plantmon;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;
END;

SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals GROUP BY escape_attempts HAVING escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, SUM(escape_attempts) FROM animals GROUP BY neutered;
SELECT species, MIN(weight_kg) AS min_weight_kg, MAX(weight_kg) AS max_weight_kg  FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) AS avg_escape_attempts  FROM animals WHERE date_of_birth >= '1990-01-01' AND date_of_birth <= '2000-12-31' GROUP BY species;

/* Day 3 */

/* What animals belong to Melody Pond? */
SELECT name FROM animals A
    JOIN owners O
    ON A.owner_id = O.id
    WHERE O.full_name = 'Melody Pond';

/* List of all animals that are pokemon (their type is Pokemon). */
SELECT A.name FROM animals A
    JOIN species S
    ON A.species_id = S.id
    WHERE S.name = 'Pokemon';

/* List all owners and their animals, remember to include those that don't own any animal. */
SELECT full_name, name FROM owners O
    LEFT JOIN animals A
    ON O.id = A.owner_id;

/* How many animals are there per species? */
SELECT S.name, COUNT(A.name) FROM species S
    LEFT JOIN animals A
    ON S.id = a.species_id
    GROUP BY s.name;

/* List all Digimon owned by Jennifer Orwell. */
SELECT A.name FROM owners O
    LEFT JOIN animals A
    ON O.id = A.owner_id
    LEFT JOIN species S
    ON A.species_id = S.id
    WHERE full_name = 'Jennifer Orwell' AND S.name = 'Digimon';

/* List all animals owned by  that haven't tried to escape. */
SELECT name FROM owners O
    JOIN animals A
    ON O.id = A.owner_id
    WHERE O.full_name = 'Dean Winchester' AND escape_attempts = 0;

/* Who owns the most animals? */
SELECT full_name, COUNT(name) FROM owners O
    LEFT JOIN animals A
    ON O.id = A.owner_id
    GROUP BY full_name;

/* Day 4 */

/* Who was the last animal seen by William Tatcher? */
SELECT A.name FROM vets VE
    LEFT JOIN visits VI
    ON VE.id = VI.vet_id
    LEFT JOIN animals A
    ON VI.animal_id = A.id
    WHERE VE.name = 'William Tatcher'
    ORDER BY VI.date DESC
    LIMIT 1;

/* How many different animals did Stephanie Mendez see? */
SELECT COUNT(VI.animal_id) FROM vets VE
    LEFT JOIN visits VI
    ON VE.id = VI.vet_id
    WHERE VE.name = 'Stephanie Mendez'
    GROUP BY VE.name;

/* List all vets and their specialties, including vets with no specialties. */
SELECT V.name, SP.name FROM vets V
    LEFT JOIN specializations S
    ON S.vet_id = V.id
    LEFT JOIN species SP
    ON S.species_id = SP.id;

/* List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020. */
SELECT A.name FROM vets VE
    LEFT JOIN visits VI
    ON VE.id = VI.vet_id
    LEFT JOIN animals A
    ON VI.animal_id = A.id
    WHERE VE.name = 'Stephanie Mendez' AND VI.date >= '2020-04-01' AND VI.date <= '2020-08-30';

/* What animal has the most visits to vets? */
SELECT A.name FROM animals A
    LEFT JOIN visits V
    ON A.id = V.animal_id
    GROUP BY A.name
    ORDER BY COUNT(date) DESC
    LIMIT 1;

/* Who was Maisy Smith's first visit? */
SELECT A.name FROM vets VE
    LEFT JOIN visits VI
    ON VE.id = VI.vet_id
    LEFT JOIN animals A
    ON VI.animal_id = A.id
    WHERE VE.name = 'Maisy Smith'
    ORDER BY VI.date DESC
    LIMIT 1;

/* Details for most recent visit: animal information, vet information, and date of visit. */
SELECT * FROM animals A
    JOIN visits VI
    ON A.id = VI.animal_id
    JOIN vets VE
    ON VI.vet_id = VE.id
    ORDER BY VI.date DESC
    LIMIT 1;

/* How many visits were with a vet that did not specialize in that animal's species? */
SELECT 20 - COUNT(*) FROM visits VI
    JOIN vets VE
    ON VI.vet_id = VE.id
    JOIN animals A
    ON VI.animal_id = A.id
    LEFT JOIN specializations S
    ON VI.vet_id = S.vet_id
    WHERE A.species_id = S.species_id;

/* What specialty should Maisy Smith consider getting? Look for the species she gets the most. */
SELECT S.name FROM vets VE
    LEFT JOIN visits VI
    ON VE.id = VI.vet_id
    JOIN animals A
    ON VI.animal_id = A.id
    JOIN species S
    ON A.species_id = S.id
    WHERE VE.name = 'Maisy Smith'
    GROUP BY S.name
    ORDER BY COUNT(VI.date) DESC
    LIMIT 1;

/* Week 2 Day 1 */

EXPLAIN ANALYZE SELECT COUNT(*) FROM visits where animal_id = 4;
EXPLAIN ANALYZE SELECT * FROM visits where vet_id = 2;
EXPLAIN ANALYZE SELECT * FROM owners where email = 'owner_18327@mail.com';
