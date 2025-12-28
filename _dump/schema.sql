--
-- PostgreSQL database dump
--

\restrict OQd571Ucsl5rMFUyQNR2N8v99gQBW8zo1shYdcH5YmnE755BOgD8hVRIyVx6kdI

-- Dumped from database version 18.1
-- Dumped by pg_dump version 18.1

-- Started on 2025-12-28 14:43:55

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE ONLY public.user_roles DROP CONSTRAINT fk_user;
ALTER TABLE ONLY public.user_roles DROP CONSTRAINT fk_role;
ALTER TABLE ONLY public.role_menus DROP CONSTRAINT fk_rm_role;
ALTER TABLE ONLY public.role_menus DROP CONSTRAINT fk_rm_menu;
ALTER TABLE ONLY public.menus DROP CONSTRAINT fk_parent_menu;
ALTER TABLE ONLY public.users DROP CONSTRAINT users_username_key;
ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
ALTER TABLE ONLY public.user_roles DROP CONSTRAINT user_roles_pkey;
ALTER TABLE ONLY public.roles DROP CONSTRAINT roles_pkey;
ALTER TABLE ONLY public.role_menus DROP CONSTRAINT role_menus_pkey;
ALTER TABLE ONLY public.menus DROP CONSTRAINT menus_pkey;
DROP TABLE public.users;
DROP TABLE public.user_roles;
DROP TABLE public.roles;
DROP TABLE public.role_menus;
DROP TABLE public.menus;
DROP SCHEMA public;
--
-- TOC entry 5 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA public;


--
-- TOC entry 5018 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_table_access_method = heap;

--
-- TOC entry 223 (class 1259 OID 16522)
-- Name: menus; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.menus (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    parentid uuid,
    name character varying(100) NOT NULL,
    path character varying(150),
    icon character varying(100),
    ordering integer DEFAULT 0
);


--
-- TOC entry 224 (class 1259 OID 16536)
-- Name: role_menus; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.role_menus (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    roleid uuid NOT NULL,
    menuid uuid NOT NULL
);


--
-- TOC entry 221 (class 1259 OID 16493)
-- Name: roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.roles (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name character varying(100) NOT NULL,
    description text
);


--
-- TOC entry 222 (class 1259 OID 16503)
-- Name: user_roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_roles (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    userid uuid NOT NULL,
    roleid uuid NOT NULL
);


--
-- TOC entry 220 (class 1259 OID 16477)
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    username character varying(100) NOT NULL,
    password text NOT NULL,
    fullname character varying(150),
    status smallint DEFAULT 1,
    datecreated timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    datemodified timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- TOC entry 5011 (class 0 OID 16522)
-- Dependencies: 223
-- Data for Name: menus; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.menus (id, parentid, name, path, icon, ordering) FROM stdin;
3bccc5ea-19e5-4c69-ad34-e464e6ee1a94	\N	Dashboard	\N	\N	1
82fa30e1-a70d-4ee8-9872-985f298ff04a	\N	Master Data	\N	\N	2
36670914-a8f3-4b0b-b5b2-7709c38ba20d	82fa30e1-a70d-4ee8-9872-985f298ff04a	Roles	/roles	\N	2
2f5240ec-02c6-434b-9e98-9b0e4ad39c99	82fa30e1-a70d-4ee8-9872-985f298ff04a	Menus	/menus	\N	3
cabe647c-6d59-4da9-8702-779334bd26e1	\N	finance	\N	\N	3
62ea1338-acf1-48eb-8e96-f126feb9edfe	cabe647c-6d59-4da9-8702-779334bd26e1	invoices	/finance/invoices	\N	1
bcf9917f-1cc7-4e9f-a3cf-70ba1f5f6cef	cabe647c-6d59-4da9-8702-779334bd26e1	payments	/finance/payments	\N	2
\.


--
-- TOC entry 5012 (class 0 OID 16536)
-- Dependencies: 224
-- Data for Name: role_menus; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.role_menus (id, roleid, menuid) FROM stdin;
5d1d6785-6c86-4191-85a3-75a797e08d6f	055009d3-fb4c-4678-9535-7b1851a345fd	3bccc5ea-19e5-4c69-ad34-e464e6ee1a94
71ce94a5-e7e1-40af-a47a-1a00ebe3e235	055009d3-fb4c-4678-9535-7b1851a345fd	82fa30e1-a70d-4ee8-9872-985f298ff04a
fca7c859-ef22-4964-8ffc-e568bb50e97c	055009d3-fb4c-4678-9535-7b1851a345fd	36670914-a8f3-4b0b-b5b2-7709c38ba20d
bba1d855-15f3-49a1-9eb0-2f48962a673f	055009d3-fb4c-4678-9535-7b1851a345fd	2f5240ec-02c6-434b-9e98-9b0e4ad39c99
c0f3f7d8-08e1-4921-9aac-9a42098a5db2	0429e2ab-f6bd-446c-829a-27889a924571	cabe647c-6d59-4da9-8702-779334bd26e1
40e09283-bcd4-43f9-aca5-3f90e1a3773c	0429e2ab-f6bd-446c-829a-27889a924571	62ea1338-acf1-48eb-8e96-f126feb9edfe
aa0aac0f-5723-4b2c-914e-e313b2997622	0429e2ab-f6bd-446c-829a-27889a924571	bcf9917f-1cc7-4e9f-a3cf-70ba1f5f6cef
\.


--
-- TOC entry 5009 (class 0 OID 16493)
-- Dependencies: 221
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.roles (id, name, description) FROM stdin;
0429e2ab-f6bd-446c-829a-27889a924571	Finance	Finance Role
055009d3-fb4c-4678-9535-7b1851a345fd	Admin	Full Access
7db7ad77-5c74-45ae-8d44-de28b65ba51d	HRD	Human Resource
\.


--
-- TOC entry 5010 (class 0 OID 16503)
-- Dependencies: 222
-- Data for Name: user_roles; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_roles (id, userid, roleid) FROM stdin;
8a2ca393-68dc-4bfd-92c1-b86156176a52	0cd4f9cb-580c-4ed9-850f-58a067a00307	055009d3-fb4c-4678-9535-7b1851a345fd
31bfca44-e9ae-4872-bafe-800a34dc0762	16e5ef0c-5b0a-4d87-bacf-e3c6d79fb1af	0429e2ab-f6bd-446c-829a-27889a924571
3c51a127-5944-424a-9e55-e9e573fb72e5	16e5ef0c-5b0a-4d87-bacf-e3c6d79fb1af	7db7ad77-5c74-45ae-8d44-de28b65ba51d
\.


--
-- TOC entry 5008 (class 0 OID 16477)
-- Dependencies: 220
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.users (id, username, password, fullname, status, datecreated, datemodified) FROM stdin;
0cd4f9cb-580c-4ed9-850f-58a067a00307	admin	$2b$10$gdk.XNksM9GibSwxbYbb5u6OxFJ7KVeJ3MJMJWqUUwrRgcurkgybe	Administrator	1	2025-12-28 13:00:19.845877	2025-12-28 13:00:19.845877
16e5ef0c-5b0a-4d87-bacf-e3c6d79fb1af	staff	$2b$10$UpBTILCNsStZ1svoacy84uYf/q/ANzNmLAmpPPALf4vy8AkE9yo/O	Staff Finance & HRD	1	2025-12-28 14:06:11.185716	2025-12-28 14:06:11.185716
\.


--
-- TOC entry 4853 (class 2606 OID 16530)
-- Name: menus menus_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.menus
    ADD CONSTRAINT menus_pkey PRIMARY KEY (id);


--
-- TOC entry 4855 (class 2606 OID 16544)
-- Name: role_menus role_menus_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.role_menus
    ADD CONSTRAINT role_menus_pkey PRIMARY KEY (id);


--
-- TOC entry 4849 (class 2606 OID 16502)
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- TOC entry 4851 (class 2606 OID 16511)
-- Name: user_roles user_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_pkey PRIMARY KEY (id);


--
-- TOC entry 4845 (class 2606 OID 16490)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 4847 (class 2606 OID 16492)
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- TOC entry 4858 (class 2606 OID 16531)
-- Name: menus fk_parent_menu; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.menus
    ADD CONSTRAINT fk_parent_menu FOREIGN KEY (parentid) REFERENCES public.menus(id) ON DELETE CASCADE;


--
-- TOC entry 4859 (class 2606 OID 16550)
-- Name: role_menus fk_rm_menu; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.role_menus
    ADD CONSTRAINT fk_rm_menu FOREIGN KEY (menuid) REFERENCES public.menus(id) ON DELETE CASCADE;


--
-- TOC entry 4860 (class 2606 OID 16545)
-- Name: role_menus fk_rm_role; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.role_menus
    ADD CONSTRAINT fk_rm_role FOREIGN KEY (roleid) REFERENCES public.roles(id) ON DELETE CASCADE;


--
-- TOC entry 4856 (class 2606 OID 16517)
-- Name: user_roles fk_role; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT fk_role FOREIGN KEY (roleid) REFERENCES public.roles(id) ON DELETE CASCADE;


--
-- TOC entry 4857 (class 2606 OID 16512)
-- Name: user_roles fk_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT fk_user FOREIGN KEY (userid) REFERENCES public.users(id) ON DELETE CASCADE;


-- Completed on 2025-12-28 14:43:55

--
-- PostgreSQL database dump complete
--

\unrestrict OQd571Ucsl5rMFUyQNR2N8v99gQBW8zo1shYdcH5YmnE755BOgD8hVRIyVx6kdI

