# Simple cases
CREATE TABLE t1(i INT) $$
INSERT INTO t1 VALUES(1), (1);
SELECT * FROM t1;
DROP TABLE t1;

CREATE TABLE t1(i INT PRIMARY KEY) $$
INSERT INTO t1 VALUES(1), (1);
SELECT * FROM t1;
DROP TABLE t1;

# Test with non-unique (dup) key
CREATE TABLE t1(i INT PRIMARY KEY, j INT KEY) $$
INSERT INTO t1 VALUES(0,1);
INSERT INTO t1 VALUES(1,1);
SELECT * FROM t1;
DROP TABLE t1;

# ON CONFLICT DO NOTHING
CREATE TABLE t1(i INT PRIMARY KEY, j INT UNIQUE) $$
INSERT INTO t1 VALUES(0,1);
INSERT INTO t1 VALUES(1,1) ON CONFLICT DO NOTHING;
SELECT * FROM t1;
DROP TABLE t1;

# ON CONFLICT DO REPLACE
CREATE TABLE t1(i INT PRIMARY KEY, j INT UNIQUE) $$
INSERT INTO t1 VALUES(0,1);
INSERT INTO t1 VALUES(1,1) ON CONFLICT DO REPLACE;
SELECT * FROM t1;

CREATE TABLE t2(i INT PRIMARY KEY, j INT UNIQUE) $$
INSERT INTO t2 VALUES(0,1);
INSERT INTO t2 VALUES(1,0);
INSERT INTO t2 VALUES(1,1);
# Replaces both the existing records
INSERT INTO t2 VALUES(1,1), (2,2), (3,3) ON CONFLICT DO REPLACE;
SELECT * FROM t2;

CREATE TABLE t3(i INT PRIMARY KEY, j INT, k INT UNIQUE) $$
INSERT INTO t3 VALUES(0,1,0);
INSERT INTO t3 VALUES(1,0,1);
# Another syntax for .. ON CONFLICT DO REPLACE ..
REPLACE INTO t3 VALUES(1,2,0);
SELECT * FROM t3;
# A case where the same record is up for deletion twice.
INSERT INTO t3 VALUES(1,3,0) ON CONFLICT DO REPLACE;
SET TRANSACTION READ COMMITTED;
INSERT INTO t3 VALUES(1,3,0) ON CONFLICT DO REPLACE;
SET TRANSACTION BLOCKSQL;

SELECT * FROM t3 ORDER BY i;

DROP TABLE t1;
DROP TABLE t2;
DROP TABLE t3;

# ON CONFLICT DO UPDATE
CREATE TABLE t1(i INT PRIMARY KEY, j INT, k INT UNIQUE) $$
INSERT INTO t1 VALUES(0,1,0);
INSERT INTO t1 VALUES(1,0,1);
INSERT INTO t1 VALUEs(0,1,2);
INSERT INTO t1 VALUEs(0,1,2) ON CONFLICT (i) DO UPDATE SET z=z+1
INSERT INTO t1 VALUEs(0,1,2) ON CONFLICT (i) DO UPDATE SET k=z+1
INSERT INTO t1 VALUEs(0,1,2) ON CONFLICT (i) DO UPDATE SET k=k+1
INSERT INTO t1 VALUEs(0,1,2) ON CONFLICT (i) DO UPDATE SET j=j+1
INSERT INTO t1 VALUEs(2,1,3) ON CONFLICT (i) DO UPDATE SET i=1
SELECT * FROM t1 ORDER BY i;
DROP TABLE t1;

# EXCLUDED (sqlite/test/upsert2.test)
CREATE TABLE t1(a INTEGER PRIMARY KEY, b int, c DEFAULT 0)$$
INSERT INTO t1(a,b) VALUES(1,2),(3,4);
INSERT INTO t1(a,b) VALUES(1,8),(2,11),(3,1) ON CONFLICT(a) DO UPDATE SET b=excluded.b, c=c+1 WHERE t1.b<excluded.b;
SELECT * FROM t1 ORDER BY a;
DROP TABLE t1;
CREATE TABLE t1(x INTEGER PRIMARY KEY, y INT UNIQUE)$$
INSERT INTO t1(x,y) SELECT 1,2 WHERE 1 ON CONFLICT(x) DO UPDATE SET y=max(t1.y,excluded.y) AND 1;
DROP TABLE t1;

CREATE TABLE t1(x INTEGER PRIMARY KEY, y INT UNIQUE) $$
INSERT INTO t1(x,y) SELECT 1,2 WHERE 1 ON CONFLICT(x) DO UPDATE SET y=max(t1.y,excluded.y) AND 1;
SELECT * FROM t1
INSERT INTO t1(x,y) SELECT 1,1 WHERE 1 ON CONFLICT(x) DO UPDATE SET y=max(t1.y,excluded.y) AND 1;
SELECT * FROM t1
DROP TABLE t1;

# INDEX ON EXPRESSION (sqlite/test/upsert1.test)
CREATE TABLE t1 {
schema
    {
		int a
		int b null = yes
		int c dbstore = 0 null = yes
    }
keys
    {
		"COMDB2_PK" = a
		"idx1" = (int)"a+b"
    }
} $$
INSERT INTO t1(a,b) VALUES(7,8) ON CONFLICT(a+b) DO NOTHING;
INSERT INTO t1(a,b) VALUES(8,7),(9,6) ON CONFLICT(a+b) DO NOTHING;
SELECT * FROM t1;
INSERT INTO t1(a,b) VALUES(8,7),(9,6) ON CONFLICT(a) DO NOTHING;
SELECT * FROM t1;
DROP TABLE t1;

