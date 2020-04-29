SELECT '---------------------------------- PART #00 ----------------------------------' AS part;
CREATE TABLE t1(i INT, j INT)$$
CREATE INDEX idx1 ON t1(i, j)
CREATE INDEX idx2 ON t1(i DESC, j ASC)
CREATE INDEX idx3 ON t1(i ASC, j DESC)
CREATE INDEX idx4 ON t1(i DESC, j DESC)
CREATE TABLE t2(i INT PRIMARY KEY)$$
CREATE TABLE t3(i INT REFERENCES t1(i DESC)) $$
CREATE TABLE t4(i INT, j INT, FOREIGN KEY (i, j) REFERENCES t1(i, j)) $$
CREATE TABLE t5(i INT UNIQUE, j INT, UNIQUE(i,j), UNIQUE 'unique_key'(j,i))$$
CREATE INDEX t5_ij ON t5(i, j)
CREATE INDEX dup_key ON t5(i, j)
CREATE TABLE t1_copy like t1 $$
CREATE TABLE t2_copy like t2 $$
CREATE TABLE t3_copy like t3 $$
CREATE TABLE t4_copy like t4 $$
CREATE TABLE t5_copy like t5 $$
# t6 does not exist
CREATE TABLE t6_copy like t6 $$
SELECT name, COUNT(*) FROM sqlite_master WHERE type = 'table' GROUP BY lower(csc2) HAVING COUNT(*) > 1 ORDER BY name;
DROP TABLE t2;
DROP TABLE t3;
DROP TABLE t4;
DROP TABLE t5;
DROP TABLE t1_copy;
DROP TABLE t2_copy;
DROP TABLE t3_copy;
DROP TABLE t4_copy;
DROP TABLE t5_copy;
DROP TABLE t1;

SELECT '---------------------------------- PART #01 ----------------------------------' AS part;
CREATE TABLE t0(i INT)$$
CREATE TABLE t1(i INT) OPTIONS REC NONE, BLOBFIELD NONE $$
CREATE TABLE t2(i INT) OPTIONS REC CRLE $$
CREATE TABLE t3(i INT) OPTIONS REC LZ4, BLOBFIELD LZ4 $$
CREATE TABLE t4(i INT) OPTIONS REC RLE, BLOBFIELD RLE $$
CREATE TABLE t5(i INT) OPTIONS REC ZLIB, BLOBFIELD ZLIB $$

CREATE TABLE t0a LIKE t0 $$
CREATE TABLE t1a LIKE t1 $$
CREATE TABLE t2a LIKE t2 $$
CREATE TABLE t3a LIKE t3 $$
CREATE TABLE t4a LIKE t4 $$
CREATE TABLE t5a LIKE t5 $$

SELECT SLEEP(5);

exec procedure sys.cmd.send('stat compr')

DROP TABLE t0;
DROP TABLE t1;
DROP TABLE t2;
DROP TABLE t3;
DROP TABLE t4;
DROP TABLE t5;
DROP TABLE t0a;
DROP TABLE t1a;
DROP TABLE t2a;
DROP TABLE t3a;
DROP TABLE t4a;
DROP TABLE t5a;
