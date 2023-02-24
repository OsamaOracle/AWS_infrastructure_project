CREATE DATABASE ClientNameMetaDB CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER 'ClientNameMetaUser' IDENTIFIED BY 'very_Strong_Pass';
GRANT USAGE ON . TO 'ClientNameMetaUser'@'%' IDENTIFIED BY 'very_Strong_Pass';
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP,
REFERENCES, INDEX, ALTER, CREATE TEMPORARY TABLES,
LOCK TABLES, EXECUTE, CREATE VIEW, SHOW VIEW, CREATE ROUTINE,
ALTER ROUTINE, EVENT, TRIGGER ON ClientNameMetaDB.* TO 'ClientNameMetaUser'@'%';
FLUSH PRIVILEGES;