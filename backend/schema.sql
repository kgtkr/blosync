CREATE TABLE "users" (
  "id" VARCHAR(64) PRIMARY KEY,
  "created_at" TIMESTAMPTZ NOT NULL,
  "version" INTEGER NOT NULL
);

ALTER TABLE "users" ADD INDEX "users_created_at_idx" ("created_at");
ALTER TABLE "users" ADD INDEX "users_version_idx" ("version");

CREATE TABLE "accounts" (
  "id" VARCHAR(64) PRIMARY KEY,
  "screen_name" VARCHAR(64) NOT NULL,
  "name" VARCHAR(128) NOT NULL,
  "description" VARCHAR(1024) NOT NULL,
  "updated_at" TIMESTAMPTZ NOT NULL,
  "icon_url" VARCHAR(1024) NOT NULL,
  "created_at" TIMESTAMPTZ NOT NULL,
  "version" INTEGER NOT NULL
);

ALTER TABLE "accounts" ADD INDEX "accounts_updated_at_idx" ("updated_at");
ALTER TABLE "accounts" ADD INDEX "accounts_created_at_idx" ("created_at");
ALTER TABLE "accounts" ADD INDEX "accounts_version_idx" ("version");
