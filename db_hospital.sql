-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 30-11-2021 a las 20:51:05
-- Versión del servidor: 10.4.20-MariaDB
-- Versión de PHP: 8.0.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `db_hospital`
--
CREATE DATABASE IF NOT EXISTS `db_hospital` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `db_hospital`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `doctores`
--

CREATE TABLE `doctores` (
  `rut_dr` varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `apellido` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `apellido2` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `especialidad` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `hospital_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `doctores`
--

INSERT INTO `doctores` (`rut_dr`, `nombre`, `apellido`, `apellido2`, `especialidad`, `hospital_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
('17.859.923-2', 'ASDASDASDS', 'aSDASDASD', 'ASDASDasd', 'Dental', 6, '2021-11-30 18:38:50', '2021-11-30 18:38:50', NULL),
('17.994.303-2', 'Antonio', 'Rodríguez', 'Vásquez', 'Dental', 5, NULL, '2021-11-30 18:53:21', NULL),
('19.373.773-0', 'Sebastian', 'Arenas', 'Leal', 'General', 2, NULL, NULL, NULL),
('20.272.305-K', 'Juan', 'Pérez', 'Soto', 'Cardiologo', 4, NULL, NULL, NULL),
('20.483.093-2', 'Nicolás', 'Astudillo', 'Díaz', 'Neurologo', 1, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `hospitales`
--

CREATE TABLE `hospitales` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nombre` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `direccion` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telefono` int(11) NOT NULL,
  `num_camas` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `hospitales`
--

INSERT INTO `hospitales` (`id`, `nombre`, `direccion`, `telefono`, `num_camas`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Gustavo Fricke', 'Los Laureles 320, Viña del Mar', 321234567, 8, NULL, NULL, NULL),
(2, 'Sotero del Río', 'Av. Argentina 125, Valparaíso', 327895412, 10, NULL, NULL, NULL),
(3, 'Van Bueren', 'Av. Alcachofa 415, Quilpué', 322917358, 5, NULL, NULL, NULL),
(4, 'Los Perales', 'Los Perales 78, Villa Alemana', 327891562, 8, NULL, NULL, NULL),
(5, 'San Martín', 'Vespucio 55, Qullota', 324567891, 5, NULL, NULL, NULL),
(6, 'asdsadasdsadasdasdasdsdasdasdadsadasdasdasdaasdasd', 'asdsadasdsadasdasdasdsdasdasdadsadasdasdasdaasdasd', 322917358, 25, '2021-11-30 18:38:20', '2021-11-30 19:08:41', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(2, '2021_11_21_185411_create_hospitales_table', 1),
(3, '2021_11_21_185418_create_doctores_table', 1),
(4, '2021_11_21_195147_create_pacientes_table', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pacientes`
--

CREATE TABLE `pacientes` (
  `rut_pc` varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `apellido` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `apellido2` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `prevision` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipo_atencion` int(10) UNSIGNED NOT NULL,
  `edad` int(10) UNSIGNED NOT NULL,
  `rut_dr` varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `pacientes`
--

INSERT INTO `pacientes` (`rut_pc`, `nombre`, `apellido`, `apellido2`, `prevision`, `tipo_atencion`, `edad`, `rut_dr`) VALUES
('15.089.432-1', 'Fionna', 'Lanon', 'Mooney', 'Fonasa B', 3, 42, '20.483.093-2'),
('15.707.809-5', 'Maddie', 'Fraczak', 'Grunder', 'Isapre', 2, 40, '20.272.305-K'),
('18.505.789-1', 'asdsadasdsadasdasda0', 'ASDSADASD', 'ASDASDAD', 'Fonasa A', 2, 25, '17.859.923-2'),
('18.705.789-6', 'Conrade', 'Over', 'Coldbreath', 'Fonasa A', 2, 28, '20.483.093-2'),
('20.489.505-6', 'Nick', 'Molden', 'Empringham', 'Fonasa A', 1, 28, '20.483.093-2'),
('20.505.489-8', 'Gregg', 'Scothorn', 'Livingstone', 'Fonasa C', 2, 18, '19.373.773-0'),
('20.705.743-K', 'Barbe', 'Hargitt', 'Mattiassi', 'Isapre', 2, 19, '20.272.305-K'),
('22.905.789-5', 'Orin', 'Cain', 'Wanklyn', 'Isapre', 1, 18, '20.272.305-K'),
('5.805.489-8', 'Vicki', 'Chicotti', 'Eathorne', 'Fonasa B', 2, 70, '17.994.303-2'),
('7.878.507-K', 'Myca', 'Espadas', 'Corragan', 'Fonasa D', 3, 58, '19.373.773-0'),
('9.774.740-7', 'Erina', 'Noades', 'Carhart', 'Isapre', 2, 50, '20.483.093-2');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `doctores`
--
ALTER TABLE `doctores`
  ADD PRIMARY KEY (`rut_dr`),
  ADD KEY `doctores_hospital_id_foreign` (`hospital_id`);

--
-- Indices de la tabla `hospitales`
--
ALTER TABLE `hospitales`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `pacientes`
--
ALTER TABLE `pacientes`
  ADD PRIMARY KEY (`rut_pc`),
  ADD KEY `pacientes_rut_dr_foreign` (`rut_dr`);

--
-- Indices de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `hospitales`
--
ALTER TABLE `hospitales`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `doctores`
--
ALTER TABLE `doctores`
  ADD CONSTRAINT `doctores_hospital_id_foreign` FOREIGN KEY (`hospital_id`) REFERENCES `hospitales` (`id`);

--
-- Filtros para la tabla `pacientes`
--
ALTER TABLE `pacientes`
  ADD CONSTRAINT `pacientes_rut_dr_foreign` FOREIGN KEY (`rut_dr`) REFERENCES `doctores` (`rut_dr`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
