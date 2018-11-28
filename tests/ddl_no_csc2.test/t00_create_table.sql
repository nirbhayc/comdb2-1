CREATE TABLE t1(i INT) $$
CREATE TABLE t1(i INT) $$
CREATE TABLE T1(i INT) $$
CREATE TABLE 't1'(i INT) $$
CREATE TABLE "t1"(i INT) $$
CREATE TABLE `t1`(i INT) $$
CREATE TABLE t2(i INT, i INT) $$
CREATE TABLE t3('i' INT, `j` INT, "k" INT) $$
CREATE TABLE t4(i INT NULL) $$
CREATE TABLE t5(i INT NULL, j INT NULL) $$
CREATE TABLE t6(i INT NOT NULL) $$
CREATE TABLE t7(i INT NOT NULL, j INT NOT NULL) $$
CREATE TABLE t8(i INT DEFAULT 1) $$
CREATE TABLE t9(i INT NOT NULL DEFAULT 0) $$
CREATE TABLE t10(i INT NULL DEFAULT 0) $$

SELECT * FROM comdb2_tables WHERE tablename NOT LIKE 'sqlite_stat%';
SELECT * FROM comdb2_columns WHERE tablename NOT LIKE 'sqlite_stat%';
SELECT * FROM comdb2_keys WHERE tablename NOT LIKE 'sqlite_stat%';
SELECT * FROM comdb2_constraints WHERE tablename NOT LIKE 'sqlite_stat%';
SELECT * FROM sqlite_master WHERE name NOT LIKE 'sqlite_stat%';
DROP TABLE t1;
DROP TABLE t2;
DROP TABLE t3;
DROP TABLE t4;
DROP TABLE t5;
DROP TABLE t6;
DROP TABLE t7;
DROP TABLE t8;
DROP TABLE t9;
DROP TABLE t10;

CREATE TABLE t1(i INT PRIMARY KEY) $$
CREATE TABLE t2(i INT PRIMARY KEY, j INT) $$
CREATE TABLE t3(i INT PRIMARY KEY, j INT PRIMARY KEY) $$
CREATE TABLE t4(i INT, i INT) $$
CREATE TABLE t5(i INT UNIQUE) $$
CREATE TABLE t6(i INT PRIMARY KEY, j INT UNIQUE) $$
CREATE TABLE t7(i INTt) $$
CREATE TABLE t8(INT i) $$
CREATE TABLE t9(i INT , j INT, PRIMARY KEY(i, j)) $$
CREATE TABLE t10(i INT, j INT, UNIQUE(i, j)) $$

SELECT * FROM comdb2_tables WHERE tablename NOT LIKE 'sqlite_stat%';
SELECT * FROM comdb2_columns WHERE tablename NOT LIKE 'sqlite_stat%';
SELECT * FROM comdb2_keys WHERE tablename NOT LIKE 'sqlite_stat%';
SELECT * FROM comdb2_constraints WHERE tablename NOT LIKE 'sqlite_stat%';
SELECT * FROM sqlite_master WHERE name NOT LIKE 'sqlite_stat%';
DROP TABLE t1;
DROP TABLE t2;
DROP TABLE t3;
DROP TABLE t4;
DROP TABLE t5;
DROP TABLE t6;
DROP TABLE t7;
DROP TABLE t8;
DROP TABLE t9;
DROP TABLE t10;

CREATE TABLE t1(i INT, j INT, UNIQUE(i, j), UNIQUE(i, j)) $$
CREATE TABLE t2(i INT, j INT, UNIQUE(i, j), UNIQUE(j, i)) $$
CREATE TABLE IF NOT EXISTS t3(i INT) $$
CREATE TABLE IF NOT EXISTS t3(i INT) $$
CREATE TABLE t4(i INT, j INT, UNIQUE(i DESC)) $$
CREATE TABLE t5(i INT, j INT, UNIQUE(i ASC)) $$
CREATE TABLE t6(i INT, j INT, UNIQUE(i ASC, j DESC)) $$
CREATE TABLE t7(i INT, j INT, UNIQUE(i DESC, j DESC)) $$
CREATE TABLE t8(i INT, j INT, UNIQUE(i DESC, j), UNIQUE(i, j), UNIQUE(i, j DESC)) $$

SELECT * FROM comdb2_tables WHERE tablename NOT LIKE 'sqlite_stat%';
SELECT * FROM comdb2_columns WHERE tablename NOT LIKE 'sqlite_stat%';
SELECT * FROM comdb2_keys WHERE tablename NOT LIKE 'sqlite_stat%';
SELECT * FROM comdb2_constraints WHERE tablename NOT LIKE 'sqlite_stat%';
SELECT * FROM sqlite_master WHERE name NOT LIKE 'sqlite_stat%';
DROP TABLE t1;
DROP TABLE t2;
DROP TABLE t3;
DROP TABLE t4;
DROP TABLE t5;
DROP TABLE t6;
DROP TABLE t7;
DROP TABLE t8;

CREATE TABLE t1(i INT PRIMARY KEY) $$
CREATE TABLE t2(i INT PRIMARY KEY, FOREIGN KEY (i) REFERENCES t1(i)) $$
CREATE TABLE t3(i INT, FOREIGN KEY (i) REFERENCES t1(i)) $$
CREATE TABLE t4(i INT) $$
CREATE TABLE t5(i INT PRIMARY KEY, FOREIGN KEY (i) REFERENCES t4(i)) $$
CREATE TABLE t6(i INT PRIMARY KEY REFERENCES t1(i)) $$
CREATE TABLE t7(i INT, j INT, PRIMARY KEY(i, j)) $$
CREATE TABLE t8(i INT, j INT, PRIMARY KEY(i, j), FOREIGN KEY (i, j) REFERENCES t7(i, j)) $$
CREATE TABLE t9(i INT, j INT, PRIMARY KEY(i), FOREIGN KEY (i, j) REFERENCES t7(i, j)) $$

SELECT * FROM comdb2_columns WHERE tablename NOT LIKE 'sqlite_stat%';
SELECT * FROM comdb2_keys WHERE tablename NOT LIKE 'sqlite_stat%';
SELECT * FROM comdb2_constraints WHERE tablename NOT LIKE 'sqlite_stat%';
SELECT * FROM sqlite_master WHERE name NOT LIKE 'sqlite_stat%';
DROP TABLE t2;
DROP TABLE t3;
DROP TABLE t4;
DROP TABLE t5;
DROP TABLE t6;
DROP TABLE t8;
DROP TABLE t9;
DROP TABLE t1;
DROP TABLE t7;

# Table options
CREATE TABLE t1(i INT) OPTIONS REC ZLIB, BLOBFIELD ZLIB $$
CREATE TABLE t2(i INT) OPTIONS REC ZLIB, REBUILD $$

SELECT * FROM comdb2_tables WHERE tablename NOT LIKE 'sqlite_stat%';
SELECT * FROM comdb2_columns WHERE tablename NOT LIKE 'sqlite_stat%';
SELECT * FROM comdb2_keys WHERE tablename NOT LIKE 'sqlite_stat%';
SELECT * FROM comdb2_constraints WHERE tablename NOT LIKE 'sqlite_stat%';
SELECT * FROM sqlite_master WHERE name NOT LIKE 'sqlite_stat%';
DROP TABLE t1;
DROP TABLE t2;

# Types
CREATE TABLE t1(v VUTF8(100)) $$
CREATE TABLE t2('d' DATETIME) $$
CREATE TABLE t3("t" TEXT(100)) $$
CREATE TABLE t4(`t` U_SHORT) $$
CREATE TABLE t5(c CHAR(100)) $$
CREATE TABLE t6(a INT(100)) $$
CREATE TABLE t7(v VARCHAR(    100)) $$
CREATE TABLE t8(v VARCHAR(    100  )) $$
CREATE TABLE t9(d DECIMAL64) $$
CREATE TABLE t10(f FLOAT, d DOUBLE, r REAL) $$
CREATE TABLE t11(i INTEGER, j SMALLINT, k BIGINT) $$

SELECT * FROM comdb2_columns WHERE tablename NOT LIKE 'sqlite_stat%';
SELECT * FROM comdb2_keys WHERE tablename NOT LIKE 'sqlite_stat%';
SELECT * FROM comdb2_constraints WHERE tablename NOT LIKE 'sqlite_stat%';
SELECT * FROM sqlite_master WHERE name NOT LIKE 'sqlite_stat%';
DROP TABLE t1;
DROP TABLE t2;
DROP TABLE t3;
DROP TABLE t4;
DROP TABLE t5;
DROP TABLE t6;
DROP TABLE t7;
DROP TABLE t8;
DROP TABLE t9;
DROP TABLE t10;
DROP TABLE t11;

CREATE TABLE main.t1(i INT) $$
CREATE TABLE remotedb.t1(i INT) $$
DROP TABLE t1;

CREATE TABLE t1(b blob) $$
CREATE TABLE t2(b blob[1]) $$
CREATE TABLE t3(b blob(1)) $$
CREATE TABLE t4(b blob(100)) $$
CREATE TABLE t5(b blob(0)) $$
CREATE TABLE t6(b blob(-100)) $$

SELECT * FROM comdb2_columns WHERE tablename NOT LIKE 'sqlite_stat%';
CREATE TABLE t4(b blob(0)) $$
CREATE TABLE t5(b blob(-100)) $$

SELECT * FROM comdb2_columns WHERE tablename NOT LIKE 'sqlite_stat%';
SELECT * FROM comdb2_keys WHERE tablename NOT LIKE 'sqlite_stat%';
SELECT * FROM comdb2_constraints WHERE tablename NOT LIKE 'sqlite_stat%';
SELECT * FROM sqlite_master WHERE name NOT LIKE 'sqlite_stat%';
DROP TABLE t1;
DROP TABLE t3;
DROP TABLE t4;
DROP TABLE t5;

CREATE TABLE t1(i INT PRIMARY KEY) $$
CREATE TABLE t2(i INT PRIMARY KEY, FOREIGN KEY (i) REFERENCES t1) $$
CREATE TABLE t2(i INT PRIMARY KEY, FOREIGN KEY (i) REFERENCES t1(i)) $$
CREATE TABLE t3(i INT PRIMARY KEY, FOREIGN KEY (i) REFERENCES t1(i) ON DELETE CASCADE) $$
CREATE TABLE t4(i INT PRIMARY KEY, FOREIGN KEY (i) REFERENCES t1(i) ON UPDATE CASCADE ON DELETE CASCADE) $$
CREATE TABLE t5(i INT PRIMARY KEY, FOREIGN KEY (i) REFERENCES t1(i) ON DELETE NO ACTION) $$
CREATE TABLE t6(i INT PRIMARY KEY, FOREIGN KEY (i) REFERENCES t1(i) ON DELETE SET NULL) $$
CREATE TABLE t6(i INT PRIMARY KEY, FOREIGN KEY (i) REFERENCES t1(i) ON DELETE SET DEFAULT) $$
CREATE TABLE t6(i INT PRIMARY KEY, FOREIGN KEY (i) REFERENCES t1(i) ON DELETE RESTRICT) $$
CREATE TABLE t6(i INT PRIMARY KEY, FOREIGN KEY (i) REFERENCES t1(i) ON DELETE junk) $$

SELECT * FROM comdb2_columns WHERE tablename NOT LIKE 'sqlite_stat%';
SELECT * FROM comdb2_keys WHERE tablename NOT LIKE 'sqlite_stat%';
SELECT * FROM comdb2_constraints WHERE tablename NOT LIKE 'sqlite_stat%';
SELECT * FROM sqlite_master WHERE name NOT LIKE 'sqlite_stat%';
DROP TABLE t5;
DROP TABLE t4;
DROP TABLE t3;
DROP TABLE t2;
DROP TABLE t1;


CREATE TABLE t1(i INT NULL, PRIMARY KEY(i)) $$
CREATE TABLE t2(i INT NULL PRIMARY KEY) $$
CREATE TABLE t3(i INT NULL, j INT NOT NULL, PRIMARY KEY(i, j)) $$
INSERT INTO t1 VALUES(NULL);
INSERT INTO t2 VALUES(NULL);
INSERT INTO t3 VALUES(1, NULL);
INSERT INTO t3 VALUES(NULL, 1);
INSERT INTO t3 VALUES(NULL, NULL);
SELECT COUNT(*)=0 FROM t1;
SELECT COUNT(*)=0 FROM t2;
SELECT COUNT(*)=0 FROM t3;

SELECT * FROM comdb2_columns WHERE tablename NOT LIKE 'sqlite_stat%';
SELECT * FROM comdb2_keys WHERE tablename NOT LIKE 'sqlite_stat%';
SELECT * FROM comdb2_constraints WHERE tablename NOT LIKE 'sqlite_stat%';
SELECT * FROM sqlite_master WHERE name NOT LIKE 'sqlite_stat%';
DROP TABLE t1;
DROP TABLE t2;
DROP TABLE t3;

# Some tests for quoted default values for columns.
CREATE TABLE t1(i INT, j INT DEFAULT '1') $$
INSERT INTO t1(i) VALUES (1);
SELECT * FROM t1;
DROP TABLE t1;

CREATE TABLE t1(i INT, j INT DEFAULT "1") $$
INSERT INTO t1(i) VALUES (1);
SELECT * FROM t1;
DROP TABLE t1;

CREATE TABLE t1(i INT, c CHAR(100) DEFAULT 0) $$
INSERT INTO t1(i) VALUES (1);
SELECT * FROM t1;
DROP TABLE t1;

CREATE TABLE t1(i INT, c CHAR(100) DEFAULT 'foo') $$
INSERT INTO t1(i) VALUES (1);
SELECT * FROM t1;
DROP TABLE t1;

CREATE TABLE t1(i INT, d DATETIME DEFAULT 'CURRENT_TIMESTAMP') $$
INSERT INTO t1(i) VALUES (1);
INSERT INTO t1(i) VALUES (2);
SELECT COUNT(*) = 2 FROM t1;
DROP TABLE t1;

CREATE TABLE t1(i INT, d INTERVALDS DEFAULT '1 11:11:11.111') $$
CREATE TABLE t1(i INT, b BLOB(100) DEFAULT 'xxxxx') $$

CREATE TABLE t1(i INT, f1 FLOAT DEFAULT '1.1', f2 FLOAT DEFAULT "1.1" ,f3 FLOAT DEFAULT 1.1) $$
INSERT INTO t1(i) VALUES (1);
SELECT * FROM t1;
DROP TABLE t1;

CREATE TABLE t1(i INT, j INT, KEY(i,j), KEY (j,i))$$
CREATE TABLE t2(i INT, j INT, KEY 'dup1'(i,j), KEY dup2(j,i))$$
CREATE TABLE t3(i INT, j INT, UNIQUE(i,j), UNIQUE(j,i))$$
CREATE TABLE t4(i INT, j INT, UNIQUE 'uniq1'(i,j), UNIQUE 'uniq2'(j,i))$$
CREATE TABLE t5(i INT UNIQUE, j INT, KEY(i,j), UNIQUE(i,j), KEY dup_key(i,j), UNIQUE 'unique_key'(j,i))$$
CREATE TABLE t6(i INT, KEY COMDB2_PK(i)) $$
CREATE TABLE t6(i INT, j INT, KEY 'dup'(i), KEY 'dup'(j)) $$
CREATE TABLE t6(i INT, j INT, KEY 'xxxx'(i), UNIQUE 'xxxx'(j)) $$
SELECT * FROM comdb2_columns WHERE tablename NOT LIKE 'sqlite_stat%';
SELECT * FROM comdb2_keys WHERE tablename NOT LIKE 'sqlite_stat%';
SELECT * FROM comdb2_constraints WHERE tablename NOT LIKE 'sqlite_stat%';
SELECT * FROM sqlite_master WHERE name NOT LIKE 'sqlite_stat%';
DROP TABLE t1;
DROP TABLE t2
DROP TABLE t3;
DROP TABLE t4;
DROP TABLE t5;

CREATE TABLE t1(c1 CHAR(2), c2 CSTRING(2), c3 VARCHAR(2), c4 TEXT) $$
SELECT * FROM comdb2_columns WHERE tablename NOT LIKE 'sqlite_stat%';
SELECT * FROM sqlite_master WHERE name NOT LIKE 'sqlite_stat%';
DROP TABLE t1;

CREATE TABLE t1(i INT UNIQUE ASC) $$
CREATE TABLE t1(i INT UNIQUE DESC) $$
CREATE TABLE t1(i INT KEY ASC) $$
CREATE TABLE t1(i INT KEY DESC) $$
CREATE TABLE t1(i INT PRIMARY KEY ASC) $$
CREATE TABLE t2(i INT PRIMARY KEY DESC) $$
CREATE TABLE t3(i INT UNIQUE) $$
CREATE TABLE t4(i INT KEY) $$
CREATE TABLE t5(i INT, j INT, KEY(j DESC, i ASC)) $$
SELECT * FROM comdb2_columns WHERE tablename NOT LIKE 'sqlite_stat%';
SELECT * FROM comdb2_keys WHERE tablename NOT LIKE 'sqlite_stat%';
SELECT * FROM comdb2_constraints WHERE tablename NOT LIKE 'sqlite_stat%';
SELECT * FROM sqlite_master WHERE name NOT LIKE 'sqlite_stat%';
DROP TABLE t1;
DROP TABLE t2;
DROP TABLE t3;
DROP TABLE t4;
DROP TABLE t5;

CREATE TABLE t1(unique INT UNIQUE) $$
CREATE TABLE t1(key INT KEY) $$
CREATE TABLE t2('unique' INT UNIQUE) $$
CREATE TABLE t3('key' INT KEY) $$
SELECT * FROM comdb2_columns WHERE tablename NOT LIKE 'sqlite_stat%';
SELECT * FROM comdb2_keys WHERE tablename NOT LIKE 'sqlite_stat%';
SELECT * FROM comdb2_constraints WHERE tablename NOT LIKE 'sqlite_stat%';
SELECT * FROM sqlite_master WHERE name NOT LIKE 'sqlite_stat%';
DROP TABLE t1;
DROP TABLE t2;
DROP TABLE t3;

CREATE TABLE t1(i INT, j INT, key idx1 (i, j), key idx2 (i DESC, j ASC), key idx3 (i ASC, j DESC), key idx4 (i DESC, j DESC))$$
CREATE TABLE t2(i INT REFERENCES t1(i)) $$
CREATE TABLE t3(i INT REFERENCES t1(i DESC)) $$
CREATE TABLE t4(i INT, j INT, FOREIGN KEY (i, j) REFERENCES t1(i, j)) $$
CREATE TABLE t5(i INT, j INT, FOREIGN KEY (i DESC, j) REFERENCES t1(i DESC, j)) $$
CREATE TABLE t6(i INT, j INT, FOREIGN KEY (i, j DESC) REFERENCES t1(i, j DESC)) $$
CREATE TABLE t7(i INT, j INT, FOREIGN KEY (i DESC, j DESC) REFERENCES t1(i DESC, j DESC)) $$
CREATE TABLE t8(i INT, KEY idx1 (i DESC), FOREIGN KEY (i DESC) REFERENCES t1(i DESC)) $$
SELECT * FROM comdb2_columns WHERE tablename NOT LIKE 'sqlite_stat%';
SELECT * FROM comdb2_keys WHERE tablename NOT LIKE 'sqlite_stat%';
SELECT * FROM comdb2_constraints WHERE tablename NOT LIKE 'sqlite_stat%';
SELECT * FROM sqlite_master WHERE name NOT LIKE 'sqlite_stat%';
DROP TABLE t2;
DROP TABLE t3;
DROP TABLE t4;
DROP TABLE t5;
DROP TABLE t6;
DROP TABLE t7;
DROP TABLE t8;
DROP TABLE t1;

CREATE TABLE t1(i INT PRIMARY KEY)$$
CREATE TABLE t2(i INT CONSTRAINT mycons1 REFERENCES t1(i)) $$
CREATE TABLE t3(i INT, CONSTRAINT 'mycons2' FOREIGN KEY (i) REFERENCES t1(i)) $$
CREATE TABLE t4(i INT, FOREIGN KEY (i) REFERENCES t1(i) CONSTRAINT "mycons3") $$
SELECT * FROM comdb2_constraints WHERE tablename NOT LIKE 'sqlite_stat%';
DROP TABLE t2;
DROP TABLE t3;
DROP TABLE t1;

# CTAS is currently not supported.
CREATE TABLE t1(i INT) $$
INSERT INTO t1 VALUES(1);
CREATE TABLE t2 AS SELECT * FROM t1 $$
DROP TABLE t1;

CREATE TABLE t1(i INT (100))$$
CREATE TABLE t1(v VARCHAR (100))$$
CREATE TABLE t2(v VARCHAR      (100)    )$$
SELECT csc2 FROM sqlite_master WHERE name NOT LIKE 'sqlite_stat%';
DROP TABLE t1;
DROP TABLE t2;

CREATE TABLE t1(i INT, j DEFAULT 1) $$

CREATE TABLE t1(v CSTRING(10), UNIQUE(CAST(v || 'aaa' AS CSTRING(10))))$$
SELECT csc2 FROM sqlite_master WHERE tbl_name = 't1' AND type = 'table';
DROP TABLE t1;

# Test an invalid case of providing expression without CAST()
CREATE TABLE t1(json vutf8(128), UNIQUE (json_extract(json, '$.a')))$$

CREATE TABLE t1(json vutf8(128), UNIQUE (CAST(json_extract(json, '$.a') AS int)), UNIQUE (CAST(json_extract(json, '$.b') AS cstring(10)))) $$
SELECT csc2 FROM sqlite_master WHERE tbl_name = 't1' AND type = 'table';
INSERT INTO t1 VALUES ('{"a":0,"b":"zero"}'), ('{"a":1,"b":"one"}');
INSERT INTO t1 VALUES ('{"a":0,"b":"zero"}'), ('{"a":1,"b":"one"}');
SELECT * FROM t1;
DROP TABLE t1;
