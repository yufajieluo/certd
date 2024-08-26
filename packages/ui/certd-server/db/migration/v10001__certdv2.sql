CREATE TABLE "pi_history" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer NOT NULL, "pipeline_id" integer NOT NULL, "pipeline" varchar(40960), "status" varchar(20), "end_time" datetime, "create_time" datetime NOT NULL DEFAULT (CURRENT_TIMESTAMP), "update_time" datetime NOT NULL DEFAULT (CURRENT_TIMESTAMP));

CREATE TABLE "pi_history_log" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer NOT NULL, "pipeline_id" integer NOT NULL, "history_id" integer NOT NULL, "node_id" varchar(100), "logs" varchar(40960), "create_time" datetime NOT NULL DEFAULT (CURRENT_TIMESTAMP), "update_time" datetime NOT NULL DEFAULT (CURRENT_TIMESTAMP));

CREATE TABLE "pi_pipeline" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer NOT NULL, "title" integer NOT NULL, "content" varchar(40960) NOT NULL, "keep_history_count" integer, "remark" varchar(100), "status" varchar(100), "disabled" boolean DEFAULT (0), "last_history_time" integer, "create_time" datetime NOT NULL DEFAULT (CURRENT_TIMESTAMP), "update_time" datetime NOT NULL DEFAULT (CURRENT_TIMESTAMP));

CREATE TABLE "pi_storage" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer NOT NULL, "scope" varchar NOT NULL, "namespace" varchar NOT NULL, "version" varchar(100),"key" varchar(100), "value" varchar(40960), "create_time" datetime NOT NULL DEFAULT (CURRENT_TIMESTAMP), "update_time" datetime NOT NULL DEFAULT (CURRENT_TIMESTAMP));
