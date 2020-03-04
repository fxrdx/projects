-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 28-02-2020 a las 21:45:12
-- Versión del servidor: 10.1.19-MariaDB
-- Versión de PHP: 5.6.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `cardjs`
--
CREATE DATABASE IF NOT EXISTS `cardjs` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `cardjs`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `area`
--

CREATE TABLE `area` (
  `id_area` int(11) NOT NULL,
  `area` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `card`
--

CREATE TABLE `card` (
  `id_card` int(20) NOT NULL,
  `model` int(2) NOT NULL,
  `issued` date NOT NULL,
  `expiration` date NOT NULL,
  `employeed` int(11) NOT NULL,
  `status` enum('wait','completed','canceled') COLLATE utf8mb4_unicode_ci NOT NULL,
  `registered` datetime NOT NULL,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `departament`
--

CREATE TABLE `departament` (
  `id_departament` int(20) NOT NULL,
  `area` char(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `departament` char(60) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `employeed`
--

CREATE TABLE `employeed` (
  `id_employeed` int(20) NOT NULL,
  `name_nice` char(8) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` char(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `photo` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` char(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lastname` char(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `country` char(5) COLLATE utf8mb4_unicode_ci NOT NULL,
  `identitycard` char(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `birthday` date NOT NULL,
  `gender` enum('m','f') COLLATE utf8mb4_unicode_ci NOT NULL,
  `blood_type` enum('a','b','ab','o') COLLATE utf8mb4_unicode_ci NOT NULL,
  `rh_factor` enum('1','0') COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` int(11) NOT NULL,
  `homeaddress` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` char(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` int(11) DEFAULT NULL,
  `mobile` int(11) NOT NULL,
  `hiredday` date NOT NULL,
  `fired` date NOT NULL,
  `reason_fired` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `registered` datetime NOT NULL,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `employeed`
--

INSERT INTO `employeed` (`id_employeed`, `name_nice`, `password`, `photo`, `name`, `lastname`, `country`, `identitycard`, `birthday`, `gender`, `blood_type`, `rh_factor`, `role`, `homeaddress`, `email`, `phone`, `mobile`, `hiredday`, `fired`, `reason_fired`, `registered`, `updated`) VALUES
(16, NULL, NULL, 'b731551faba27ac52eba26d9163a388f.png', 'Nardy Sarahy', 'Mateus Jaimes', 'E', 'AN73363', '0000-00-00', 'f', 'ab', '1', 1, '123123', 'fxrdx2@gmail.com', 123123123, 123123, '0000-00-00', '0000-00-00', '', '2020-02-28 21:39:07', '2020-02-28 20:39:07');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `role`
--

CREATE TABLE `role` (
  `id_role` int(11) NOT NULL,
  `departament` int(11) NOT NULL,
  `role` char(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `salary` int(11) NOT NULL,
  `level` int(2) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `area`
--
ALTER TABLE `area`
  ADD PRIMARY KEY (`id_area`);

--
-- Indices de la tabla `card`
--
ALTER TABLE `card`
  ADD PRIMARY KEY (`id_card`),
  ADD UNIQUE KEY `ticket` (`expiration`);

--
-- Indices de la tabla `departament`
--
ALTER TABLE `departament`
  ADD PRIMARY KEY (`id_departament`) USING BTREE;

--
-- Indices de la tabla `employeed`
--
ALTER TABLE `employeed`
  ADD PRIMARY KEY (`id_employeed`);

--
-- Indices de la tabla `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`id_role`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `card`
--
ALTER TABLE `card`
  MODIFY `id_card` int(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `departament`
--
ALTER TABLE `departament`
  MODIFY `id_departament` int(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `employeed`
--
ALTER TABLE `employeed`
  MODIFY `id_employeed` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
