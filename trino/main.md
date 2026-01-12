# Run sleep() in trino query
```
WITH
  FUNCTION sleep(x integer)
    RETURNS integer
    LANGUAGE PYTHON
    WITH (handler = 'sleep')
    AS $$
    def sleep(a):
     import time
     time.sleep(a)
     return a
    $$
SELECT sleep(20);
```
