--
-- PostgreSQL database dump
--

-- Dumped from database version 11.6 (Ubuntu 11.6-1.pgdg19.10+1)
-- Dumped by pg_dump version 11.6 (Ubuntu 11.6-1.pgdg19.10+1)

-- Started on 2019-12-15 23:03:02 GMT

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
-- TOC entry 3113 (class 1262 OID 16384)
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
-- TOC entry 218 (class 1255 OID 32806)
-- Name: audit_function(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.audit_function() RETURNS trigger
    LANGUAGE plpgsql
    AS $$	DECLARE
		description VARCHAR := '';
	BEGIN
        --
        -- Create a row in emp_audit to reflect the operation performed on emp,
        -- make use of the special variable TG_OP to work out the operation.
        --

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
-- TOC entry 205 (class 1259 OID 32799)
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
-- TOC entry 204 (class 1259 OID 32791)
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
-- TOC entry 199 (class 1259 OID 16417)
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
-- TOC entry 198 (class 1259 OID 16404)
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
-- TOC entry 200 (class 1259 OID 16420)
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
-- TOC entry 201 (class 1259 OID 16422)
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
-- TOC entry 202 (class 1259 OID 16440)
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
-- TOC entry 203 (class 1259 OID 24628)
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
-- TOC entry 196 (class 1259 OID 16385)
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
-- TOC entry 197 (class 1259 OID 16387)
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
-- TOC entry 2973 (class 2606 OID 16411)
-- Name: courses courses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT courses_pkey PRIMARY KEY (id);


--
-- TOC entry 2975 (class 2606 OID 16429)
-- Name: lessons lessons_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT lessons_pkey PRIMARY KEY (id);


--
-- TOC entry 2977 (class 2606 OID 24635)
-- Name: notes notes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notes
    ADD CONSTRAINT notes_pkey PRIMARY KEY (id);


--
-- TOC entry 2971 (class 2606 OID 16395)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 2984 (class 2620 OID 32807)
-- Name: courses course_audit; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER course_audit AFTER INSERT OR DELETE OR UPDATE ON public.courses FOR EACH ROW EXECUTE PROCEDURE public.audit_function();


--
-- TOC entry 2985 (class 2620 OID 32808)
-- Name: lessons lesson_audit; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER lesson_audit AFTER INSERT OR DELETE OR UPDATE ON public.lessons FOR EACH ROW EXECUTE PROCEDURE public.audit_function();


--
-- TOC entry 2986 (class 2620 OID 32809)
-- Name: notes note_audit; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER note_audit BEFORE INSERT OR DELETE OR UPDATE ON public.notes FOR EACH ROW EXECUTE PROCEDURE public.audit_function();


--
-- TOC entry 2983 (class 2620 OID 32810)
-- Name: users user_audit; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER user_audit AFTER INSERT OR DELETE OR UPDATE ON public.users FOR EACH ROW EXECUTE PROCEDURE public.audit_function();


--
-- TOC entry 2979 (class 2606 OID 16435)
-- Name: lessons course_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT course_id FOREIGN KEY (course_id) REFERENCES public.courses(id) NOT VALID;


--
-- TOC entry 2981 (class 2606 OID 24636)
-- Name: notes lesson_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notes
    ADD CONSTRAINT lesson_id FOREIGN KEY (lesson_id) REFERENCES public.lessons(id) NOT VALID;


--
-- TOC entry 2978 (class 2606 OID 16412)
-- Name: courses user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT user_id FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 2980 (class 2606 OID 16430)
-- Name: lessons user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT user_id FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 2982 (class 2606 OID 24641)
-- Name: notes user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notes
    ADD CONSTRAINT user_id FOREIGN KEY (user_id) REFERENCES public.users(id) NOT VALID;


-- Completed on 2019-12-15 23:03:02 GMT

--
-- PostgreSQL database dump complete
--

