-- This script was generated by a beta version of the ERD tool in pgAdmin 4.
-- Please log an issue at https://redmine.postgresql.org/projects/pgadmin4/issues/new if you find any bugs, including reproduction steps.
BEGIN;

DROP SCHEMA IF EXISTS "SSAFY_PJT1"  CASCADE ;

CREATE SCHEMA IF NOT EXISTS "SSAFY_PJT1";
CREATE USER padmin ENCRYPTED PASSWORD 'padmin' NOSUPERUSER NOCREATEDB NOCREATEROLE;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA "SSAFY_PJT1" TO padmin;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA "SSAFY_PJT1" TO padmin;
CREATE TABLE "SSAFY_PJT1".account
(
    email character varying NOT NULL,
    pk_idx serial NOT NULL,
    passwd character varying NOT NULL,
    username character varying NOT NULL,
    PRIMARY KEY (pk_idx)
);

CREATE TABLE "SSAFY_PJT1".role
(
    pk_idx serial NOT NULL,
    name character varying NOT NULL,
    created timestamp with time zone NOT NULL,
    updated timestamp with time zone NOT NULL,
    admin boolean,
    PRIMARY KEY (pk_idx)
);

CREATE TABLE "SSAFY_PJT1".permission
(
    pk_idx serial NOT NULL,
    name character varying NOT NULL,
    created timestamp with time zone NOT NULL,
    updated timestamp with time zone NOT NULL,
    fk_role_idx integer,
    PRIMARY KEY (pk_idx)
);

CREATE TABLE "SSAFY_PJT1".user_roles
(
    pk_idx serial NOT NULL,
    fk_user_idx integer,
    fk_role_idx integer,
    PRIMARY KEY (pk_idx)
);

CREATE TABLE "SSAFY_PJT1".chat_session
(
--     pk_idx serial NOT NULL,
    session_id character varying NOT NULL,
    created_at timestamp with time zone NOT NULL,
    fk_created_by_idx integer NOT NULL,
    fk_client_idx integer,
    fk_host_idx integer,
    fk_permission_idx integer,
    status character varying(4),
    unread integer,
    qna_history character varying(1000) NULL,
    PRIMARY KEY (session_id)
);

CREATE TABLE "SSAFY_PJT1".chat_message
(
    pk_idx serial NOT NULL,
    message text NOT NULL,
    fk_author_idx integer NOT NULL,
    created timestamp with time zone NOT NULL,
    deleted boolean,
    fk_session_id character varying NOT NULL,
    type character varying(4),
    PRIMARY KEY (pk_idx)
);

CREATE TABLE "SSAFY_PJT1".service_case
(
    pk_idx serial NOT NULL,
    title character varying NOT NULL,
    link character varying,
    fk_charge_idx integer NOT NULL,
    fk_customer_idx integer NOT NULL,
    fk_session_id character varying NOT NULL,
    feedback integer,
    PRIMARY KEY (pk_idx)
);

CREATE TABLE "SSAFY_PJT1".question (
	pk_idx serial NOT NULL,
	"content" varchar NULL,
	title varchar NULL,
	CONSTRAINT question_pkey PRIMARY KEY (pk_idx)
);

CREATE TABLE "SSAFY_PJT1".answer (
	pk_idx serial NOT NULL,
	"content" varchar NOT NULL,
	fk_next_idx int4 NULL DEFAULT 2,
	fk_previous_idx int4 NULL,
	CONSTRAINT answer_pkey PRIMARY KEY (pk_idx)
);

ALTER TABLE "SSAFY_PJT1".permission
    ADD FOREIGN KEY (fk_role_idx)
        REFERENCES "SSAFY_PJT1".role (pk_idx)
    NOT VALID;


ALTER TABLE "SSAFY_PJT1".user_roles
    ADD FOREIGN KEY (fk_role_idx)
        REFERENCES "SSAFY_PJT1".role (pk_idx)
    NOT VALID;


ALTER TABLE "SSAFY_PJT1".user_roles
    ADD FOREIGN KEY (fk_user_idx)
        REFERENCES "SSAFY_PJT1".account (pk_idx)
    NOT VALID;


ALTER TABLE "SSAFY_PJT1".chat_session
    ADD FOREIGN KEY (fk_created_by_idx)
        REFERENCES "SSAFY_PJT1".account (pk_idx)
    NOT VALID;


ALTER TABLE "SSAFY_PJT1".chat_session
    ADD FOREIGN KEY (fk_client_idx)
        REFERENCES "SSAFY_PJT1".account (pk_idx)
    NOT VALID;


ALTER TABLE "SSAFY_PJT1".chat_session
    ADD FOREIGN KEY (fk_host_idx)
        REFERENCES "SSAFY_PJT1".account (pk_idx)
    NOT VALID;


ALTER TABLE "SSAFY_PJT1".chat_session
    ADD FOREIGN KEY (fk_permission_idx)
        REFERENCES "SSAFY_PJT1".permission (pk_idx)
    NOT VALID;


ALTER TABLE "SSAFY_PJT1".chat_message
    ADD FOREIGN KEY (fk_session_id)
        REFERENCES "SSAFY_PJT1".chat_session (session_id)
    NOT VALID;


ALTER TABLE "SSAFY_PJT1".chat_message
    ADD FOREIGN KEY (fk_author_idx)
        REFERENCES "SSAFY_PJT1".account (pk_idx)
    NOT VALID;


ALTER TABLE "SSAFY_PJT1".service_case
    ADD FOREIGN KEY (fk_customer_idx)
        REFERENCES "SSAFY_PJT1".account (pk_idx)
    NOT VALID;


ALTER TABLE "SSAFY_PJT1".service_case
    ADD FOREIGN KEY (fk_session_id)
        REFERENCES "SSAFY_PJT1".chat_session (session_id)
    NOT VALID;


ALTER TABLE "SSAFY_PJT1".service_case
    ADD FOREIGN KEY (fk_charge_idx)
        REFERENCES "SSAFY_PJT1".account (pk_idx)
    NOT VALID;


ALTER TABLE "SSAFY_PJT1".answer ADD CONSTRAINT answer_fk_next_idx_fkey FOREIGN KEY (fk_next_idx) REFERENCES "SSAFY_PJT1".question(pk_idx) ON DELETE SET NULL;
ALTER TABLE "SSAFY_PJT1".answer ADD CONSTRAINT answer_fk_previous_idx_fkey FOREIGN KEY (fk_previous_idx) REFERENCES "SSAFY_PJT1".question(pk_idx) ON DELETE SET NULL;

insert into "SSAFY_PJT1".question (content)
values ('상담 시작');

insert into "SSAFY_PJT1".question (content)
values ('상담 종료');

INSERT INTO "SSAFY_PJT1".account (email, passwd, username)
values ('daebalprime@gmail.com', '1a2a3a4a5a!!', 'daebalprime'),
('user11@naver.com', 'asdf555!@#', 'frontadmin');
END;