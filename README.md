# postgres_ext_has_many_and_with

```
ruby --version
ruby 2.2.1p85 (2015-02-26 revision 49769) [x86_64-darwin14]
bundle
ruby test_has_many_and_with.rb
-- create_table(:posts, {:force=>true})
D, [2015-03-23T11:01:27.221087 #15627] DEBUG -- :    (3.4ms)  DROP TABLE "posts"
D, [2015-03-23T11:01:27.225684 #15627] DEBUG -- :    (4.3ms)  CREATE TABLE "posts" ("id" serial primary key)
   -> 0.0300s
-- create_table(:comments, {:force=>true})
D, [2015-03-23T11:01:27.228532 #15627] DEBUG -- :    (1.4ms)  DROP TABLE "comments"
D, [2015-03-23T11:01:27.231679 #15627] DEBUG -- :    (2.9ms)  CREATE TABLE "comments" ("id" serial primary key, "post_id" integer)
   -> 0.0059s
Run options: --seed 17911

# Running:

D, [2015-03-23T11:01:27.267528 #15627] DEBUG -- :    (0.2ms)  BEGIN
D, [2015-03-23T11:01:27.272429 #15627] DEBUG -- :   SQL (0.9ms)  INSERT INTO "posts" DEFAULT VALUES RETURNING "id"
D, [2015-03-23T11:01:27.273730 #15627] DEBUG -- :    (0.5ms)  COMMIT
D, [2015-03-23T11:01:27.287610 #15627] DEBUG -- :    (0.2ms)  BEGIN
D, [2015-03-23T11:01:27.288934 #15627] DEBUG -- :   SQL (0.6ms)  INSERT INTO "comments" DEFAULT VALUES RETURNING "id"
D, [2015-03-23T11:01:27.289952 #15627] DEBUG -- :    (0.5ms)  COMMIT
D, [2015-03-23T11:01:27.290411 #15627] DEBUG -- :    (0.2ms)  BEGIN
D, [2015-03-23T11:01:27.298188 #15627] DEBUG -- :   SQL (0.4ms)  UPDATE "comments" SET "post_id" = $1 WHERE "comments"."id" = $2  [["post_id", 1], ["id", 1]]
D, [2015-03-23T11:01:27.298949 #15627] DEBUG -- :    (0.4ms)  COMMIT
D, [2015-03-23T11:01:27.301244 #15627] DEBUG -- :   Comment Load (0.7ms)  SELECT  *, 1 AS foo FROM "comments"  ORDER BY "comments"."id" ASC LIMIT 1
D, [2015-03-23T11:01:27.304760 #15627] DEBUG -- :   Comment Load (0.3ms)  SELECT  *, 1 AS foo FROM "comments" WHERE "comments"."post_id" = $1  ORDER BY "comments"."id" ASC LIMIT 1  [["post_id", 1]]
D, [2015-03-23T11:01:27.306904 #15627] DEBUG -- :   Comment Load (0.3ms)  SELECT  *, 1 AS foo FROM "comments" WHERE "comments"."post_id" = $1  ORDER BY "comments"."id" ASC LIMIT 1  [["post_id", 1]]
D, [2015-03-23T11:01:27.308686 #15627] DEBUG -- :   Comment Load (0.5ms)  WITH "comments" AS (SELECT *, 1 AS foo FROM "comments") SELECT  * FROM "comments"  ORDER BY "comments"."id" ASC LIMIT 1
D, [2015-03-23T11:01:27.310577 #15627] DEBUG -- :   Comment Load (0.3ms)  WITH "comments" AS (SELECT *, 1 AS foo FROM "comments" WHERE "comments"."post_id" = 1) SELECT  * FROM "comments" WHERE "comments"."post_id" = $1  ORDER BY "comments"."id" ASC LIMIT 1  [["post_id", 1]]
D, [2015-03-23T11:01:27.313140 #15627] DEBUG -- :   Comment Load (0.3ms)  SELECT  * FROM "comments" WHERE "comments"."post_id" = $1  ORDER BY "comments"."id" ASC LIMIT 1  [["post_id", 1]]
E

Finished in 0.054887s, 18.2193 runs/s, 91.0963 assertions/s.

  1) Error:
BugTest#test_has_many_and_with:
NoMethodError: undefined method `foo' for #<Comment id: 1, post_id: 1>
    /Users/sdecaste/.rbenv/versions/2.2.1/lib/ruby/gems/2.2.0/gems/activemodel-4.2.0/lib/active_model/attribute_methods.rb:433:in `method_missing'
    test_has_many_and_with.rb:51:in `test_has_many_and_with'

1 runs, 5 assertions, 0 failures, 1 errors, 0 skips
```
