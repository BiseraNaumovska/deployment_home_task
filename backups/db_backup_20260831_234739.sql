--
-- PostgreSQL database dump
--

\restrict vqVndg9o8dDTVpAuaTEhsY62bADjtao3Ryoh5FzAlzX7CA48M0wv433S2FrT8Bi

-- Dumped from database version 15.19
-- Dumped by pg_dump version 15.19

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
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: active_network_equipment; Type: TABLE; Schema: public; Owner: db_admin
--

CREATE TABLE public.active_network_equipment (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    device_type character varying(50) NOT NULL,
    serial_number character varying(100) NOT NULL,
    ip_address character varying(45) NOT NULL,
    install_date date NOT NULL,
    maintenance_date date NOT NULL
);


ALTER TABLE public.active_network_equipment OWNER TO db_admin;

--
-- Data for Name: active_network_equipment; Type: TABLE DATA; Schema: public; Owner: db_admin
--

COPY public.active_network_equipment (id, device_type, serial_number, ip_address, install_date, maintenance_date) FROM stdin;
b548e482-84d7-4475-95c8-4ef9358598a3	Router	SN-RTR-001	192.168.1.1	2023-01-15	2024-01-15
eb9d8de6-5ebd-49da-9849-0809657437b3	Switch	SN-SW-002	192.168.1.2	2023-02-10	2024-02-10
4455b1e0-15dd-48ec-87df-dd0b24c555c9	Firewall	SN-FW-003	192.168.1.254	2023-03-01	2024-03-01
567cf2e7-3c58-4f6f-8642-eaa1fdf2d481	Access Point	SN-AP-004	192.168.1.50	2023-03-12	2024-03-12
4ef05bd9-4d0a-49c6-b997-d6575d1735dd	Router	SN-RTR-005	10.0.0.1	2023-04-05	2024-04-05
9d055315-84c0-45f4-92d4-7b085a1fd1c2	Switch	SN-SW-006	10.0.0.2	2023-04-18	2024-04-18
65d29853-c963-40bf-bbff-2744821090f3	Switch	SN-SW-007	10.0.0.3	2023-05-01	2024-05-01
174d19ff-fe3d-441c-9cf7-f4b6698efdce	Firewall	SN-FW-008	10.0.0.254	2023-05-20	2024-05-20
9dc90e2c-f104-4097-9170-e0c0fb227c7e	Load Balancer	SN-LB-009	192.168.2.1	2023-06-01	2024-06-01
02206b35-8225-4946-ad10-9de787fd813a	Access Point	SN-AP-010	192.168.1.51	2023-06-15	2024-06-15
e18ceaab-5a3b-4779-a92c-d7adf8f35fc3	Router	SN-RTR-011	172.16.0.1	2023-07-02	2024-07-02
228b2e5f-11de-45fa-9162-909bf8ed3696	Switch	SN-SW-012	172.16.0.2	2023-07-11	2024-07-11
2d907d92-349f-4e51-8ca5-80e6d82ee739	Switch	SN-SW-013	172.16.0.3	2023-08-01	2024-08-01
5e3b1375-a67b-4a7f-8a23-c3e590021611	Access Point	SN-AP-014	192.168.1.52	2023-08-14	2024-08-14
6d9aeb80-362b-417c-b8a1-95af2fb8266f	Firewall	SN-FW-015	172.16.0.254	2023-09-01	2024-09-01
920cf049-c0e5-4a1a-8835-fce2019ed877	Gateway	SN-GW-016	192.168.3.1	2023-09-10	2024-09-10
b5be052c-b04e-4a7f-9dcf-6d00cfd792ad	Switch	SN-SW-017	192.168.3.2	2023-09-25	2024-09-25
beab1511-569b-4649-aa2c-1a43e448c378	Router	SN-RTR-018	10.1.0.1	2023-10-05	2024-10-05
9201f5db-ca1a-4b0b-bfaf-4823735afa64	Access Point	SN-AP-019	192.168.1.53	2023-10-12	2024-10-12
bcb29108-64a6-49dc-8f87-34354424e74c	Switch	SN-SW-020	10.1.0.2	2023-11-01	2024-11-01
93377bad-7911-47a3-958b-fb106893d9fd	Load Balancer	SN-LB-021	192.168.2.2	2023-11-15	2024-11-15
b3b4a39e-62e2-4285-9d63-6d82a282ae2a	Firewall	SN-FW-022	10.1.0.254	2023-12-01	2024-12-01
ebe52271-bfa9-4077-86e4-2a0e4ab1f394	Router	SN-RTR-023	192.168.4.1	2023-12-10	2024-12-10
24ab6580-6643-4abb-b784-cd8939f83088	Switch	SN-SW-024	192.168.4.2	2024-01-05	2025-01-05
264372b5-a2fc-4522-ae88-153c4fb7f488	Access Point	SN-AP-025	192.168.1.54	2024-01-20	2025-01-20
c6d616c0-21d7-49a9-ae1c-c3fef10b45d1	Switch	SN-SW-026	192.168.4.3	2024-02-01	2025-02-01
ebb3c04d-4dcf-4db6-bc8d-48e31a1bc6a5	Gateway	SN-GW-027	10.2.0.1	2024-02-14	2025-02-14
cd9ba069-8d05-4bac-9ab7-385bba7e0907	Firewall	SN-FW-028	10.2.0.254	2024-03-01	2025-03-01
fb10459c-9e2e-4469-837e-9651d18bd058	Router	SN-RTR-029	10.2.0.2	2024-03-15	2025-03-15
e1248860-9666-424f-a6d5-747fd397669b	Switch	SN-SW-030	10.2.0.3	2024-04-01	2025-04-01
\.


--
-- Name: active_network_equipment active_network_equipment_pkey; Type: CONSTRAINT; Schema: public; Owner: db_admin
--

ALTER TABLE ONLY public.active_network_equipment
    ADD CONSTRAINT active_network_equipment_pkey PRIMARY KEY (id);


--
-- Name: active_network_equipment active_network_equipment_serial_number_key; Type: CONSTRAINT; Schema: public; Owner: db_admin
--

ALTER TABLE ONLY public.active_network_equipment
    ADD CONSTRAINT active_network_equipment_serial_number_key UNIQUE (serial_number);


--
-- PostgreSQL database dump complete
--

\unrestrict vqVndg9o8dDTVpAuaTEhsY62bADjtao3Ryoh5FzAlzX7CA48M0wv433S2FrT8Bi

