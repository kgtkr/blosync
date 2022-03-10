CREATE TABLE "users" (
  "id" VARCHAR(64) PRIMARY KEY,
  "created_at" TIMESTAMPTZ NOT NULL,
  "version" INTEGER NOT NULL
);

ALTER TABLE "users" ADD INDEX "users_created_at_idx" ("created_at");
ALTER TABLE "users" ADD INDEX "users_version_idx" ("version");

CREATE TABLE "account_infos" (
  "user_id" VARCHAR(64) NOT NULL,
  "id" VARCHAR(64) NOT NULL,
  "screen_name" VARCHAR(64) NOT NULL,
  "name" VARCHAR(128) NOT NULL,
  "description" VARCHAR(1024) NOT NULL,
  "updated_at" TIMESTAMPTZ NOT NULL,
  "icon_url" VARCHAR(1024) NOT NULL,
  "created_at" TIMESTAMPTZ NOT NULL,
  "version" INTEGER NOT NULL,
  PRIMARY KEY ("user_id", "id"),
  CONSTRAINT "account_infos_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION
);

ALTER TABLE "account_infos" ADD INDEX "account_infos_updated_at_idx" ("updated_at");
ALTER TABLE "account_infos" ADD INDEX "account_infos_created_at_idx" ("created_at");
ALTER TABLE "account_infos" ADD INDEX "account_infos_version_idx" ("version");

CREATE TABLE "user_authed_accounts" (
  "user_id" VARCHAR(64) NOT NULL,
  "account_id" VARCHAR(64) NOT NULL,
  "oauth_token" VARCHAR(1024) NOT NULL,
  "oauth_token_secret" VARCHAR(1024) NOT NULL,
  "created_at" TIMESTAMPTZ NOT NULL,
  PRIMARY KEY ("user_id", "account_id"),
  CONSTRAINT "user_authed_accounts_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT "user_authed_accounts_account_id_ukey" UNIQUE ("account_id")
);

ALTER TABLE "user_authed_accounts" ADD INDEX "user_authed_accounts_created_at_idx" ("created_at");
