--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4
-- Dumped by pg_dump version 16.4

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: food; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.food (
    fdc_id integer NOT NULL,
    data_type character varying(50),
    description character varying(255),
    food_category_id integer,
    publication_date date
);


ALTER TABLE public.food OWNER TO postgres;

--
-- Name: food_intake; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.food_intake (
    intake_id integer NOT NULL,
    fdc_id integer,
    date_of_eating date
);


ALTER TABLE public.food_intake OWNER TO postgres;

--
-- Name: food_nutrient; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.food_nutrient (
    data_id integer NOT NULL,
    fdc_id integer,
    nutrient_id integer,
    amount numeric,
    data_points integer,
    derivation_id integer,
    min_amount numeric,
    max_amount numeric,
    median_amount numeric,
    min_year_acquired integer
);


ALTER TABLE public.food_nutrient OWNER TO postgres;

--
-- Name: nutrient; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.nutrient (
    nutrient_id integer NOT NULL,
    macronutrient_names character varying(255),
    unit_name character varying(50),
    nutrient_nbr numeric,
    nutrient_rank integer
);


ALTER TABLE public.nutrient OWNER TO postgres;

--
-- Name: food_intake food_intake_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.food_intake
    ADD CONSTRAINT food_intake_pkey PRIMARY KEY (intake_id);


--
-- Name: food_nutrient food_nutrient_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.food_nutrient
    ADD CONSTRAINT food_nutrient_pkey PRIMARY KEY (data_id);


--
-- Name: food food_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.food
    ADD CONSTRAINT food_pkey PRIMARY KEY (fdc_id);


--
-- Name: nutrient nutrient_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nutrient
    ADD CONSTRAINT nutrient_pkey PRIMARY KEY (nutrient_id);


--
-- Name: food_intake food_intake_fdc_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.food_intake
    ADD CONSTRAINT food_intake_fdc_id_fkey FOREIGN KEY (fdc_id) REFERENCES public.food(fdc_id);


--
-- Name: food_nutrient food_nutrient_fdc_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.food_nutrient
    ADD CONSTRAINT food_nutrient_fdc_id_fkey FOREIGN KEY (fdc_id) REFERENCES public.food(fdc_id);


--
-- PostgreSQL database dump complete
--

