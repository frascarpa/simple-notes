--
-- PostgreSQL database dump
--

-- Dumped from database version 11.6 (Ubuntu 11.6-1.pgdg19.10+1)
-- Dumped by pg_dump version 11.6 (Ubuntu 11.6-1.pgdg19.10+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: simple-notes; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE "simple-notes" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_GB.UTF-8' LC_CTYPE = 'en_GB.UTF-8';


ALTER DATABASE "simple-notes" OWNER TO postgres;

\connect -reuse-previous=on "dbname='simple-notes'"

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: audit_function(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.audit_function() RETURNS trigger
    LANGUAGE plpgsql
    AS $$	DECLARE
		description VARCHAR := '';
	BEGIN

		IF to_jsonb(NEW) ? 'name' THEN
            description := NEW.name;
         END IF;
		
		IF to_jsonb(NEW) ? 'title' THEN
            description := NEW.title;
         END IF;
		
		IF to_jsonb(NEW) ? 'nickname' THEN
            description := NEW.nickname;
         END IF;
		
		
        IF (TG_OP = 'DELETE') THEN
            INSERT INTO audit SELECT 'D', TG_TABLE_NAME, now(), OLD.id, description;
            RETURN OLD;
        ELSIF (TG_OP = 'UPDATE') THEN
            INSERT INTO audit SELECT 'U', TG_TABLE_NAME, now(), NEW.id, description;
            RETURN NEW;
        ELSIF (TG_OP = 'INSERT') THEN
            INSERT INTO audit SELECT 'I', TG_TABLE_NAME, now(), NEW.id, description;
            RETURN NEW;
        END IF;
    END$$;


ALTER FUNCTION public.audit_function() OWNER TO postgres;

--
-- Name: audit_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.audit_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.audit_id_seq OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: audit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.audit (
    action character varying NOT NULL,
    "table" character varying,
    "time" timestamp with time zone,
    ref_id bigint,
    descr character varying,
    id bigint DEFAULT nextval('public.audit_id_seq'::regclass)
);


ALTER TABLE public.audit OWNER TO postgres;

--
-- Name: courses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.courses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.courses_id_seq OWNER TO postgres;

--
-- Name: courses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.courses (
    description character varying(256),
    id bigint DEFAULT nextval('public.courses_id_seq'::regclass) NOT NULL,
    name character varying(256),
    user_id bigint NOT NULL
);


ALTER TABLE public.courses OWNER TO postgres;

--
-- Name: lessons_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.lessons_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lessons_id_seq OWNER TO postgres;

--
-- Name: lessons; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lessons (
    id bigint DEFAULT nextval('public.lessons_id_seq'::regclass) NOT NULL,
    name character varying,
    description character varying,
    course_id bigint,
    user_id bigint
);


ALTER TABLE public.lessons OWNER TO postgres;

--
-- Name: notes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notes_id_seq OWNER TO postgres;

--
-- Name: notes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notes (
    id bigint DEFAULT nextval('public.notes_id_seq'::regclass) NOT NULL,
    title character varying,
    content character varying,
    content_clean character varying,
    description character varying,
    lesson_id bigint NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE public.notes OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    email character varying(256),
    id bigint DEFAULT nextval('public.users_id_seq'::regclass) NOT NULL,
    nickname character varying(256),
    password character varying(256),
    created timestamp with time zone
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: courses courses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT courses_pkey PRIMARY KEY (id);


--
-- Name: lessons lessons_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT lessons_pkey PRIMARY KEY (id);


--
-- Name: notes notes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notes
    ADD CONSTRAINT notes_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: courses course_audit; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER course_audit AFTER INSERT OR DELETE OR UPDATE ON public.courses FOR EACH ROW EXECUTE PROCEDURE public.audit_function();


--
-- Name: lessons lesson_audit; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER lesson_audit AFTER INSERT OR DELETE OR UPDATE ON public.lessons FOR EACH ROW EXECUTE PROCEDURE public.audit_function();


--
-- Name: notes note_audit; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER note_audit BEFORE INSERT OR DELETE OR UPDATE ON public.notes FOR EACH ROW EXECUTE PROCEDURE public.audit_function();


--
-- Name: users user_audit; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER user_audit AFTER INSERT OR DELETE OR UPDATE ON public.users FOR EACH ROW EXECUTE PROCEDURE public.audit_function();


--
-- Name: lessons course_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT course_id FOREIGN KEY (course_id) REFERENCES public.courses(id) NOT VALID;


--
-- Name: notes lesson_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notes
    ADD CONSTRAINT lesson_id FOREIGN KEY (lesson_id) REFERENCES public.lessons(id) NOT VALID;


--
-- Name: courses user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT user_id FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: lessons user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT user_id FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: notes user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notes
    ADD CONSTRAINT user_id FOREIGN KEY (user_id) REFERENCES public.users(id) NOT VALID;


--
-- PostgreSQL database dump complete
--

