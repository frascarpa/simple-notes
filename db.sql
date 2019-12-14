--
-- PostgreSQL database dump
--

-- Dumped from database version 11.6 (Ubuntu 11.6-1.pgdg19.10+1)
-- Dumped by pg_dump version 11.6 (Ubuntu 11.6-1.pgdg19.10+1)

-- Started on 2019-12-14 16:09:28 GMT

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
-- TOC entry 3097 (class 1262 OID 16384)
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

SET default_tablespace = '';

SET default_with_oids = false;

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
    "courseId" bigint,
    "userId" bigint
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
-- TOC entry 3087 (class 0 OID 16404)
-- Dependencies: 198
-- Data for Name: courses; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.courses (description, id, name, user_id) VALUES ('corso1', 1, 'corso1', 31);
INSERT INTO public.courses (description, id, name, user_id) VALUES ('corso 2', 2, 'corso 2', 31);


--
-- TOC entry 3090 (class 0 OID 16422)
-- Dependencies: 201
-- Data for Name: lessons; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3086 (class 0 OID 16387)
-- Dependencies: 197
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users (email, id, nickname, password, created) VALUES ('asd@asd.com', 31, 'aldo', '$2y$10$UF/cz3Q9r0A32nvlRXiZ1OPTxwWb/3nChGAINxvk3X2n05m3jCd.e', NULL);


--
-- TOC entry 3098 (class 0 OID 0)
-- Dependencies: 199
-- Name: courses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.courses_id_seq', 2, true);


--
-- TOC entry 3099 (class 0 OID 0)
-- Dependencies: 200
-- Name: lessons_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.lessons_id_seq', 1, false);


--
-- TOC entry 3100 (class 0 OID 0)
-- Dependencies: 202
-- Name: notes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notes_id_seq', 1, false);


--
-- TOC entry 3101 (class 0 OID 0)
-- Dependencies: 196
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 31, true);


--
-- TOC entry 2958 (class 2606 OID 16411)
-- Name: courses courses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT courses_pkey PRIMARY KEY (id);


--
-- TOC entry 2960 (class 2606 OID 16429)
-- Name: lessons lessons_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT lessons_pkey PRIMARY KEY (id);


--
-- TOC entry 2956 (class 2606 OID 16395)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 2963 (class 2606 OID 16435)
-- Name: lessons courseId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT "courseId" FOREIGN KEY ("courseId") REFERENCES public.courses(id) NOT VALID;


--
-- TOC entry 2962 (class 2606 OID 16430)
-- Name: lessons userId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT "userId" FOREIGN KEY ("userId") REFERENCES public.users(id);


--
-- TOC entry 2961 (class 2606 OID 16412)
-- Name: courses user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT user_id FOREIGN KEY (user_id) REFERENCES public.users(id);


-- Completed on 2019-12-14 16:09:28 GMT

--
-- PostgreSQL database dump complete
--

