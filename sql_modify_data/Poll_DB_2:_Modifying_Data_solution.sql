-- Provided schema
CREATE TABLE congress_members (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(64) NOT NULL,
  party VARCHAR(64) NOT NULL,
  location VARCHAR(64) NOT NULL,
  grade_1996 REAL, 
  grade_current REAL, 
  years_in_congress INTEGER,
  dw1_score REAL,
  created_at DATETIME, 
  updated_at DATETIME);

CREATE TABLE voters (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name VARCHAR(64) NOT NULL,
    last_name  VARCHAR(64) NOT NULL,
    gender VARCHAR(64) NOT NULL,
    party VARCHAR(64) NOT NULL,
    party_duration INTEGER, 
    age INTEGER,
    married INTEGER,
    children_count INTEGER,
    homeowner INTEGER, 
    employed INTEGER, 
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL
  );

CREATE TABLE votes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    voter_id INTEGER,
    politician_id INTEGER,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    FOREIGN KEY(voter_id) REFERENCES voters(id),
    FOREIGN KEY(politician_id) REFERENCES congress_members(id)
  );




-- Begin Challenge


-- Delete voters and their votes (homeowners, employed, no children, party_duration < 3, voted for politicians speaking at grade level higher than 12)
-- Rename votes table to old_votes because the foreign key has no activity associated with it
ALTER TABLE votes RENAME TO old_votes;

-- Create a new votes table with foreign key action set to ON DELETE CASCADE
CREATE TABLE votes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    voter_id INTEGER,
    politician_id INTEGER,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    FOREIGN KEY(voter_id) REFERENCES voters(id) ON DELETE CASCADE,
    FOREIGN KEY(politician_id) REFERENCES congress_members(id)
  );

-- Copy data from old votes table into the new votes table
INSERT INTO votes (id, voter_id, politician_id, created_at, updated_at)
SELECT id, voter_id, politician_id, created_at, updated_at
FROM old_votes;

-- Delete the old votes table
DROP TABLE old_votes;



-- Turn on foreign keys
-- See https://www.sqlite.org/foreignkeys.html#fk_enable
PRAGMA foreign_keys=ON;



-- Delete the right voters and the votes will delete because of the ON DELETE CASCADE
DELETE
FROM voters
WHERE voters.id
IN (
SELECT voters.id
FROM voters
INNER JOIN votes
ON (voters.id = votes.voter_id)
INNER JOIN congress_members
ON (votes.politician_id = congress_members.id)
AND voters.homeowner = 1
AND voters.employed = 1
AND voters.children_count = 0
AND party_duration < 3
AND congress_members.grade_current > 12);




-- Find senators in NJ
SELECT id, name
FROM congress_members
WHERE location = 'NJ' and name LIKE 'Sen%';

-- Add two voters
INSERT INTO voters
(first_name, last_name, gender, party, created_at, updated_at)
VALUES
('Jimmy','Rustles', 'M', 'Republican', DATETIME('now'), DATETIME('now'));

INSERT INTO voters
(first_name, last_name, gender, party, created_at, updated_at)
VALUES
('Jenny','Rustles', 'F', 'Republican', DATETIME('now'), DATETIME('now'));

-- Add votes
INSERT INTO votes
(voter_id, politician_id, created_at, updated_at)
VALUES
(5001,145,DATETIME('now'),DATETIME('now'));

-- Add Trump as candidate
INSERT INTO congress_members
(name, party, location, created_at, updated_at)
VALUES
('Donald Trump', 'Trumpists', 'NJ', DATETIME('now'), DATETIME('now'));

-- Delete NJ Senator
DELETE FROM congress_members
WHERE id = 463;

-- Give votes from deleted politician to Trump
UPDATE votes
SET politician_id = 531
WHERE politician_id = 463;

-- Check that Donald Trump has votes
SELECT COUNT(votes.id)
FROM votes
WHERE votes.politician_id = 531;

-- Delete voters with only one vote who are not rep/dem
DELETE
FROM voters
WHERE voters.id
IN (
SELECT voters.id
FROM votes
INNER JOIN voters
ON (voters.id = votes.voter_id)
AND voters.party <> 'republican'
AND voters.party <> 'democrat'
GROUP BY voters.id
HAVING COUNT(votes.voter_id) = 1);

-- Check if voters with only one vote who are not rep/dem were deleted
SELECT voters.id, voters.party, COUNT(votes.id) FROM voters
INNER JOIN votes
ON voters.id = votes.voter_id
GROUP BY voters.id
ORDER BY COUNT(votes.id) DESC;


-- Updating records for more fudging
-- Update the votes for all the men over 80 that have no children. Change their vote to be for the secret politician with ID 346.
UPDATE votes 
SET politician_id = 346
WHERE voter_id 
IN (
SELECT id 
FROM voters 
WHERE voters.gender = "male" 
AND voters.age >= 80 
AND voters.children_count = 0);

SELECT COUNT(votes.id) FROM votes WHERE votes.politician_id = 346;



-- Smarty pants
SELECT MAX (grade_current) AS SmartyPants FROM congress_members;
SELECT * FROM congress_members WHERE grade_current = 20.46577636;

-- ID: 530 = smartypants

SELECT MIN (grade_current) AS SillyPants FROM congress_members;
SELECT * FROM congress_members WHERE grade_current = 6.686799034;

-- ID: 349 for sillypants

UPDATE votes
SET politician_id = 349
WHERE politician_id = 530;

--DONE