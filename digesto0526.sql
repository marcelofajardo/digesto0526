-- phpMyAdmin SQL Dump
-- version 5.2.1deb3
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 21-10-2026 a las 17:19:03
-- Versión del servidor: 10.11.14-MariaDB-0ubuntu0.24.04.1
-- Versión de PHP: 8.3.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `digesto0526`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ai_providers`
--

CREATE TABLE `ai_providers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `driver` varchar(32) NOT NULL,
  `url` text NOT NULL,
  `model` varchar(255) NOT NULL,
  `api_key` text DEFAULT NULL,
  `env_key` varchar(255) DEFAULT NULL,
  `priority` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `ai_providers`
--

INSERT INTO `ai_providers` (`id`, `name`, `driver`, `url`, `model`, `api_key`, `env_key`, `priority`, `enabled`, `created_at`, `updated_at`) VALUES
(1, 'Ollama', 'ollama', 'http://localhost:11434/v1', 'qwen2.5-coder:7b', 'eyJpdiI6InZIOEFCZ3ZnU2IreDBCQ2YzSG15T1E9PSIsInZhbHVlIjoiYUd4OWNRNXJzS2pyRldzdWNoUnBEZz09IiwibWFjIjoiYmJjNWI0ZTM4NmE2NzEwYjZiOTEwNWQ1YmYyNzI1ZTBhMTBkYzg0OTFlZDUzNzRkNzFiYTZhYTgwNzFiYTg5MyIsInRhZyI6IiJ9', NULL, 2, 1, '2026-10-14 15:28:44', '2026-10-15 21:43:33'),
(2, 'Gemini', 'gemini', 'https://generativelanguage.googleapis.com/v1beta/models', 'gemini-3.8-flash', 'eyJpdiI6IkhIZEYyd0NuWXE2RUJsUUhLQ2VvM1E9PSIsInZhbHVlIjoiNERNdnVpaUpUNDFsNTZaclpvVHJqaVdRZjBMNW5GVkpFM1FPUmRVZlJibnpxaE9pY1BVanUyZ2wxMS9rWURwS09KS0grVkxPY0JZeDYrcnk5eHdGTkE9PSIsIm1hYyI6IjFjN2ViMWE1MzZhZmI4M2FkY2E4ZjI3NzIxOWNiNGUxYWVhNjM5YmQ5OWM5MTc5Zjc5NTRkMTQyYWE4ZTY2MzYiLCJ0YWciOiIifQ==', 'GEMINI_API_KEY', 3, 0, '2026-10-14 15:28:44', '2026-10-15 21:43:21'),
(3, 'OpenAI', 'openai_compatible', 'https://api.openai.com/v1/chat/completions', 'gpt-4o-mini', 'eyJpdiI6Imp5Q2RLNytjbzJ2QnRrbGRCWC94MWc9PSIsInZhbHVlIjoiSjBFNzBOTDNnandaakh2TjlUblhiZXJOblU4VXRnZUx0NjIzMVJzNXRhUkJ4NHZucnVma2UwTHRTeDVQSG1rRDJ5SWZadWI3eCtSQTVhK3dRWGpGMGEvaDVaZXNWT3pKY0t5N21qYXYzT01MdUlSWmk5QjM5d0VuTmh6NFVUVWRDbjloQ2NxVXIybkZBandZTjBZYVF1T1hpWXRtekg5d2wrT2I3bVJyZk9od3M5U1QrUCtyMThkY0pjaG1VblE1QVdQbDJxR1ZCcWtoTTZHWk8wN0w0Z2VVaGtyQmFNQk9aS0hpeDh6M01Rbz0iLCJtYWMiOiI5NmJkMWExNmJmYThkOGRhMWNhMjM2Nzc5MjYwZDc5NWU0MjZkYjE4MDA5OGJmODUxZDExZDMxNTRhNGQyOWRmIiwidGFnIjoiIn0=', 'OPENAI_API_KEY', 4, 0, '2026-10-14 15:28:44', '2026-10-15 21:43:25'),
(4, 'DeepSeek', 'deepseek', 'https://api.deepseek.com/chat/completions', 'deepseek-chat', 'eyJpdiI6IlNNdGNxMVMrRjVhakZXdG9BaHRVbXc9PSIsInZhbHVlIjoiUStEYzlzK25IZWFtTTZ6WE94cG4zM0l1RTJGa0hPRVJnbEFpY29TQzR0cmNxYVE1SW5pMkNZYlJiMDdMUVdoSCIsIm1hYyI6IjRmMTdhMTgzMzA0ZDk0ZDM3ZmRiODBmZWRmMjcyOTFkMDk4ZWE4MWI0MDhmY2MxMzVmMGNhNTg5MjJmYjk3ZTciLCJ0YWciOiIifQ==', 'deepseek_api_key', 5, 0, '2026-10-14 16:48:26', '2026-10-15 21:43:29'),
(6, 'groq', 'openai_compatible', 'https://api.groq.com/openai/v1', 'openai/gpt-oss-120b', 'eyJpdiI6ImJIbUVKSldQdGpKZ1ZxV05ib1liVGc9PSIsInZhbHVlIjoiSUQwVDk4S2xDdytyUDhacjdaNHJhYWJoRS84L2VDRnB0N0I2c3JvbzhZZEpHZElYWm1TWXFXQVgwc285UjJveGd5bno0ZUQ0OWF0Y1VmelU1YlJWQ1E9PSIsIm1hYyI6Ijk3ZjRjZTJmNzgxZmI2NWVhNTY4YTIzODQzNThkMmY2YzEyM2QzYjRjYjc1N2I5N2FiZWNhZjBiODc5NGE4YjMiLCJ0YWciOiIifQ==', NULL, 1, 1, '2026-10-15 14:41:10', '2026-10-15 14:41:10'),
(7, 'groq20b', 'openai_compatible', 'https://api.groq.com/openai/v1', 'openai/gpt-oss-20b', 'eyJpdiI6IkpVaEV1aDdvM3dWa2pKTnk4amdmL0E9PSIsInZhbHVlIjoiVlAzWEtpcU1vQkJrQk0yeWRMOW5GeS8zVDVzVzBxRGlQTnZMWlptM3kyWStZaXN4bmVmMUJkcDJ4YkI2dGp0aWMvS0hpZ1RETEhDZ2pXZy82SnpFRUE9PSIsIm1hYyI6ImM4NTI5MzMxODE4NjdkNThkZGZkODgzMTcyMzU0YmRlN2YxMjFlN2E1NjgyYTVlOGEzNjI3MWIzMGEzMDM0YzIiLCJ0YWciOiIifQ==', NULL, 1, 1, '2026-10-15 14:47:16', '2026-10-15 14:47:16');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `cache`
--

INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('digestounvime-cache-1b6453892473a467d07372d45eb05abc2031647a', 'i:1;', 1781798805),
('digestounvime-cache-1b6453892473a467d07372d45eb05abc2031647a:timer', 'i:1781798805;', 1781798805),
('digestounvime-cache-356a192b7913b04c54574d18c28d46e6395428ab', 'i:1;', 1792078121),
('digestounvime-cache-356a192b7913b04c54574d18c28d46e6395428ab:timer', 'i:1792078121;', 1792078121),
('digestounvime-cache-boost:mcp:database-schema:mysql::1:0:0:0', 'a:2:{s:6:\"engine\";s:5:\"mysql\";s:6:\"tables\";a:20:{s:12:\"ai_providers\";a:11:{s:2:\"id\";s:19:\"bigint(20) unsigned\";s:4:\"name\";s:12:\"varchar(255)\";s:6:\"driver\";s:11:\"varchar(32)\";s:3:\"url\";s:4:\"text\";s:5:\"model\";s:12:\"varchar(255)\";s:7:\"api_key\";s:4:\"text\";s:7:\"env_key\";s:12:\"varchar(255)\";s:8:\"priority\";s:16:\"int(10) unsigned\";s:7:\"enabled\";s:10:\"tinyint(1)\";s:10:\"created_at\";s:9:\"timestamp\";s:10:\"updated_at\";s:9:\"timestamp\";}s:5:\"cache\";a:3:{s:3:\"key\";s:12:\"varchar(255)\";s:5:\"value\";s:10:\"mediumtext\";s:10:\"expiration\";s:10:\"bigint(20)\";}s:11:\"cache_locks\";a:3:{s:3:\"key\";s:12:\"varchar(255)\";s:5:\"owner\";s:12:\"varchar(255)\";s:10:\"expiration\";s:10:\"bigint(20)\";}s:10:\"categorias\";a:5:{s:2:\"id\";s:19:\"bigint(20) unsigned\";s:6:\"nombre\";s:12:\"varchar(255)\";s:11:\"descripcion\";s:4:\"text\";s:10:\"created_at\";s:9:\"timestamp\";s:10:\"updated_at\";s:9:\"timestamp\";}s:10:\"documentos\";a:10:{s:2:\"id\";s:19:\"bigint(20) unsigned\";s:12:\"categoria_id\";s:19:\"bigint(20) unsigned\";s:7:\"tipo_id\";s:19:\"bigint(20) unsigned\";s:6:\"titulo\";s:12:\"varchar(255)\";s:8:\"ruta_doc\";s:12:\"varchar(255)\";s:11:\"descripcion\";s:4:\"text\";s:4:\"anio\";s:20:\"smallint(5) unsigned\";s:6:\"numero\";s:12:\"varchar(255)\";s:10:\"created_at\";s:9:\"timestamp\";s:10:\"updated_at\";s:9:\"timestamp\";}s:11:\"failed_jobs\";a:7:{s:2:\"id\";s:19:\"bigint(20) unsigned\";s:4:\"uuid\";s:12:\"varchar(255)\";s:10:\"connection\";s:12:\"varchar(255)\";s:5:\"queue\";s:12:\"varchar(255)\";s:7:\"payload\";s:8:\"longtext\";s:9:\"exception\";s:8:\"longtext\";s:9:\"failed_at\";s:9:\"timestamp\";}s:4:\"jobs\";a:7:{s:2:\"id\";s:19:\"bigint(20) unsigned\";s:5:\"queue\";s:12:\"varchar(255)\";s:7:\"payload\";s:8:\"longtext\";s:8:\"attempts\";s:20:\"smallint(5) unsigned\";s:11:\"reserved_at\";s:16:\"int(10) unsigned\";s:12:\"available_at\";s:16:\"int(10) unsigned\";s:10:\"created_at\";s:16:\"int(10) unsigned\";}s:11:\"job_batches\";a:10:{s:2:\"id\";s:12:\"varchar(255)\";s:4:\"name\";s:12:\"varchar(255)\";s:10:\"total_jobs\";s:7:\"int(11)\";s:12:\"pending_jobs\";s:7:\"int(11)\";s:11:\"failed_jobs\";s:7:\"int(11)\";s:14:\"failed_job_ids\";s:8:\"longtext\";s:7:\"options\";s:10:\"mediumtext\";s:12:\"cancelled_at\";s:7:\"int(11)\";s:10:\"created_at\";s:7:\"int(11)\";s:11:\"finished_at\";s:7:\"int(11)\";}s:10:\"migrations\";a:3:{s:2:\"id\";s:16:\"int(10) unsigned\";s:9:\"migration\";s:12:\"varchar(255)\";s:5:\"batch\";s:7:\"int(11)\";}s:21:\"model_has_permissions\";a:3:{s:13:\"permission_id\";s:19:\"bigint(20) unsigned\";s:10:\"model_type\";s:12:\"varchar(255)\";s:8:\"model_id\";s:19:\"bigint(20) unsigned\";}s:15:\"model_has_roles\";a:3:{s:7:\"role_id\";s:19:\"bigint(20) unsigned\";s:10:\"model_type\";s:12:\"varchar(255)\";s:8:\"model_id\";s:19:\"bigint(20) unsigned\";}s:21:\"password_reset_tokens\";a:3:{s:5:\"email\";s:12:\"varchar(255)\";s:5:\"token\";s:12:\"varchar(255)\";s:10:\"created_at\";s:9:\"timestamp\";}s:11:\"permissions\";a:5:{s:2:\"id\";s:19:\"bigint(20) unsigned\";s:4:\"name\";s:12:\"varchar(255)\";s:10:\"guard_name\";s:12:\"varchar(255)\";s:10:\"created_at\";s:9:\"timestamp\";s:10:\"updated_at\";s:9:\"timestamp\";}s:5:\"roles\";a:5:{s:2:\"id\";s:19:\"bigint(20) unsigned\";s:4:\"name\";s:12:\"varchar(255)\";s:10:\"guard_name\";s:12:\"varchar(255)\";s:10:\"created_at\";s:9:\"timestamp\";s:10:\"updated_at\";s:9:\"timestamp\";}s:20:\"role_has_permissions\";a:2:{s:13:\"permission_id\";s:19:\"bigint(20) unsigned\";s:7:\"role_id\";s:19:\"bigint(20) unsigned\";}s:8:\"sessions\";a:6:{s:2:\"id\";s:12:\"varchar(255)\";s:7:\"user_id\";s:19:\"bigint(20) unsigned\";s:10:\"ip_address\";s:11:\"varchar(45)\";s:10:\"user_agent\";s:4:\"text\";s:7:\"payload\";s:8:\"longtext\";s:13:\"last_activity\";s:7:\"int(11)\";}s:9:\"taggables\";a:3:{s:6:\"tag_id\";s:19:\"bigint(20) unsigned\";s:13:\"taggable_type\";s:12:\"varchar(255)\";s:11:\"taggable_id\";s:19:\"bigint(20) unsigned\";}s:4:\"tags\";a:7:{s:2:\"id\";s:19:\"bigint(20) unsigned\";s:4:\"name\";s:8:\"longtext\";s:4:\"slug\";s:8:\"longtext\";s:4:\"type\";s:12:\"varchar(255)\";s:12:\"order_column\";s:7:\"int(11)\";s:10:\"created_at\";s:9:\"timestamp\";s:10:\"updated_at\";s:9:\"timestamp\";}s:15:\"tipo_documentos\";a:6:{s:2:\"id\";s:19:\"bigint(20) unsigned\";s:6:\"nombre\";s:12:\"varchar(255)\";s:5:\"color\";s:12:\"varchar(255)\";s:4:\"icon\";s:12:\"varchar(255)\";s:10:\"created_at\";s:9:\"timestamp\";s:10:\"updated_at\";s:9:\"timestamp\";}s:5:\"users\";a:8:{s:2:\"id\";s:19:\"bigint(20) unsigned\";s:4:\"name\";s:12:\"varchar(255)\";s:5:\"email\";s:12:\"varchar(255)\";s:17:\"email_verified_at\";s:9:\"timestamp\";s:8:\"password\";s:12:\"varchar(255)\";s:14:\"remember_token\";s:12:\"varchar(100)\";s:10:\"created_at\";s:9:\"timestamp\";s:10:\"updated_at\";s:9:\"timestamp\";}}}', 1792081007),
('digestounvime-cache-livewire-rate-limiter:16d36dff9abd246c67dfac3e63b993a169af77e6', 'i:1;', 1792588791),
('digestounvime-cache-livewire-rate-limiter:16d36dff9abd246c67dfac3e63b993a169af77e6:timer', 'i:1792588791;', 1792588791),
('digestounvime-cache-spatie.permission.cache', 'a:3:{s:5:\"alias\";a:4:{s:1:\"a\";s:2:\"id\";s:1:\"b\";s:4:\"name\";s:1:\"c\";s:10:\"guard_name\";s:1:\"r\";s:5:\"roles\";}s:11:\"permissions\";a:97:{i:0;a:4:{s:1:\"a\";i:1;s:1:\"b\";s:17:\"ViewAny:Categoria\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:3:{i:0;i:1;i:1;i:2;i:2;i:3;}}i:1;a:4:{s:1:\"a\";i:2;s:1:\"b\";s:14:\"View:Categoria\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:2;a:4:{s:1:\"a\";i:3;s:1:\"b\";s:16:\"Create:Categoria\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:3;a:4:{s:1:\"a\";i:4;s:1:\"b\";s:16:\"Update:Categoria\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:4;a:4:{s:1:\"a\";i:5;s:1:\"b\";s:16:\"Delete:Categoria\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:5;a:4:{s:1:\"a\";i:6;s:1:\"b\";s:19:\"DeleteAny:Categoria\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:6;a:4:{s:1:\"a\";i:7;s:1:\"b\";s:17:\"Restore:Categoria\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:7;a:4:{s:1:\"a\";i:8;s:1:\"b\";s:21:\"ForceDelete:Categoria\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:8;a:4:{s:1:\"a\";i:9;s:1:\"b\";s:24:\"ForceDeleteAny:Categoria\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:9;a:4:{s:1:\"a\";i:10;s:1:\"b\";s:20:\"RestoreAny:Categoria\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:10;a:4:{s:1:\"a\";i:11;s:1:\"b\";s:19:\"Replicate:Categoria\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:11;a:4:{s:1:\"a\";i:12;s:1:\"b\";s:17:\"Reorder:Categoria\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:12;a:4:{s:1:\"a\";i:13;s:1:\"b\";s:17:\"ViewAny:Documento\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:3:{i:0;i:1;i:1;i:2;i:2;i:3;}}i:13;a:4:{s:1:\"a\";i:14;s:1:\"b\";s:14:\"View:Documento\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:14;a:4:{s:1:\"a\";i:15;s:1:\"b\";s:16:\"Create:Documento\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:15;a:4:{s:1:\"a\";i:16;s:1:\"b\";s:16:\"Update:Documento\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:16;a:4:{s:1:\"a\";i:17;s:1:\"b\";s:16:\"Delete:Documento\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:17;a:4:{s:1:\"a\";i:18;s:1:\"b\";s:19:\"DeleteAny:Documento\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:18;a:4:{s:1:\"a\";i:19;s:1:\"b\";s:17:\"Restore:Documento\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:19;a:4:{s:1:\"a\";i:20;s:1:\"b\";s:21:\"ForceDelete:Documento\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:20;a:4:{s:1:\"a\";i:21;s:1:\"b\";s:24:\"ForceDeleteAny:Documento\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:21;a:4:{s:1:\"a\";i:22;s:1:\"b\";s:20:\"RestoreAny:Documento\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:22;a:4:{s:1:\"a\";i:23;s:1:\"b\";s:19:\"Replicate:Documento\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:23;a:4:{s:1:\"a\";i:24;s:1:\"b\";s:17:\"Reorder:Documento\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:24;a:4:{s:1:\"a\";i:25;s:1:\"b\";s:12:\"ViewAny:Role\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:25;a:4:{s:1:\"a\";i:26;s:1:\"b\";s:9:\"View:Role\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:26;a:4:{s:1:\"a\";i:27;s:1:\"b\";s:11:\"Create:Role\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:27;a:4:{s:1:\"a\";i:28;s:1:\"b\";s:11:\"Update:Role\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:28;a:4:{s:1:\"a\";i:29;s:1:\"b\";s:11:\"Delete:Role\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:29;a:4:{s:1:\"a\";i:30;s:1:\"b\";s:14:\"DeleteAny:Role\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:30;a:4:{s:1:\"a\";i:31;s:1:\"b\";s:12:\"Restore:Role\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:31;a:4:{s:1:\"a\";i:32;s:1:\"b\";s:16:\"ForceDelete:Role\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:32;a:4:{s:1:\"a\";i:33;s:1:\"b\";s:19:\"ForceDeleteAny:Role\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:33;a:4:{s:1:\"a\";i:34;s:1:\"b\";s:15:\"RestoreAny:Role\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:34;a:4:{s:1:\"a\";i:35;s:1:\"b\";s:14:\"Replicate:Role\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:35;a:4:{s:1:\"a\";i:36;s:1:\"b\";s:12:\"Reorder:Role\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:36;a:4:{s:1:\"a\";i:37;s:1:\"b\";s:21:\"ViewAny:TipoDocumento\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:3:{i:0;i:1;i:1;i:2;i:2;i:3;}}i:37;a:4:{s:1:\"a\";i:38;s:1:\"b\";s:18:\"View:TipoDocumento\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:38;a:4:{s:1:\"a\";i:39;s:1:\"b\";s:20:\"Create:TipoDocumento\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:39;a:4:{s:1:\"a\";i:40;s:1:\"b\";s:20:\"Update:TipoDocumento\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:40;a:4:{s:1:\"a\";i:41;s:1:\"b\";s:20:\"Delete:TipoDocumento\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:41;a:4:{s:1:\"a\";i:42;s:1:\"b\";s:23:\"DeleteAny:TipoDocumento\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:42;a:4:{s:1:\"a\";i:43;s:1:\"b\";s:21:\"Restore:TipoDocumento\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:43;a:4:{s:1:\"a\";i:44;s:1:\"b\";s:25:\"ForceDelete:TipoDocumento\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:44;a:4:{s:1:\"a\";i:45;s:1:\"b\";s:28:\"ForceDeleteAny:TipoDocumento\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:45;a:4:{s:1:\"a\";i:46;s:1:\"b\";s:24:\"RestoreAny:TipoDocumento\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:46;a:4:{s:1:\"a\";i:47;s:1:\"b\";s:23:\"Replicate:TipoDocumento\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:47;a:4:{s:1:\"a\";i:48;s:1:\"b\";s:21:\"Reorder:TipoDocumento\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:3;}}i:48;a:4:{s:1:\"a\";i:49;s:1:\"b\";s:20:\"View:DocumentosStats\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:49;a:4:{s:1:\"a\";i:50;s:1:\"b\";s:18:\"ViewAny:Permission\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:1;i:1;i:2;}}i:50;a:4:{s:1:\"a\";i:51;s:1:\"b\";s:15:\"View:Permission\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:51;a:4:{s:1:\"a\";i:52;s:1:\"b\";s:17:\"Create:Permission\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:52;a:4:{s:1:\"a\";i:53;s:1:\"b\";s:17:\"Update:Permission\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:53;a:4:{s:1:\"a\";i:54;s:1:\"b\";s:17:\"Delete:Permission\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:54;a:4:{s:1:\"a\";i:55;s:1:\"b\";s:20:\"DeleteAny:Permission\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:55;a:4:{s:1:\"a\";i:56;s:1:\"b\";s:18:\"Restore:Permission\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:56;a:4:{s:1:\"a\";i:57;s:1:\"b\";s:22:\"ForceDelete:Permission\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:57;a:4:{s:1:\"a\";i:58;s:1:\"b\";s:25:\"ForceDeleteAny:Permission\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:58;a:4:{s:1:\"a\";i:59;s:1:\"b\";s:21:\"RestoreAny:Permission\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:59;a:4:{s:1:\"a\";i:60;s:1:\"b\";s:20:\"Replicate:Permission\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:60;a:4:{s:1:\"a\";i:61;s:1:\"b\";s:18:\"Reorder:Permission\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:61;a:4:{s:1:\"a\";i:62;s:1:\"b\";s:12:\"ViewAny:User\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:62;a:4:{s:1:\"a\";i:63;s:1:\"b\";s:9:\"View:User\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:63;a:4:{s:1:\"a\";i:64;s:1:\"b\";s:11:\"Create:User\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:64;a:4:{s:1:\"a\";i:65;s:1:\"b\";s:11:\"Update:User\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:65;a:4:{s:1:\"a\";i:66;s:1:\"b\";s:11:\"Delete:User\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:66;a:4:{s:1:\"a\";i:67;s:1:\"b\";s:14:\"DeleteAny:User\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:67;a:4:{s:1:\"a\";i:68;s:1:\"b\";s:12:\"Restore:User\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:68;a:4:{s:1:\"a\";i:69;s:1:\"b\";s:16:\"ForceDelete:User\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:69;a:4:{s:1:\"a\";i:70;s:1:\"b\";s:19:\"ForceDeleteAny:User\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:70;a:4:{s:1:\"a\";i:71;s:1:\"b\";s:15:\"RestoreAny:User\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:71;a:4:{s:1:\"a\";i:72;s:1:\"b\";s:14:\"Replicate:User\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:72;a:4:{s:1:\"a\";i:73;s:1:\"b\";s:12:\"Reorder:User\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:73;a:4:{s:1:\"a\";i:74;s:1:\"b\";s:18:\"ViewAny:AiProvider\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:74;a:4:{s:1:\"a\";i:75;s:1:\"b\";s:15:\"View:AiProvider\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:75;a:4:{s:1:\"a\";i:76;s:1:\"b\";s:17:\"Create:AiProvider\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:76;a:4:{s:1:\"a\";i:77;s:1:\"b\";s:17:\"Update:AiProvider\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:77;a:4:{s:1:\"a\";i:78;s:1:\"b\";s:17:\"Delete:AiProvider\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:78;a:4:{s:1:\"a\";i:79;s:1:\"b\";s:20:\"DeleteAny:AiProvider\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:79;a:4:{s:1:\"a\";i:80;s:1:\"b\";s:18:\"Restore:AiProvider\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:80;a:4:{s:1:\"a\";i:81;s:1:\"b\";s:22:\"ForceDelete:AiProvider\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:81;a:4:{s:1:\"a\";i:82;s:1:\"b\";s:25:\"ForceDeleteAny:AiProvider\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:82;a:4:{s:1:\"a\";i:83;s:1:\"b\";s:21:\"RestoreAny:AiProvider\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:83;a:4:{s:1:\"a\";i:84;s:1:\"b\";s:20:\"Replicate:AiProvider\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:84;a:4:{s:1:\"a\";i:85;s:1:\"b\";s:18:\"Reorder:AiProvider\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:85;a:4:{s:1:\"a\";i:86;s:1:\"b\";s:11:\"ViewAny:Tag\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:86;a:4:{s:1:\"a\";i:87;s:1:\"b\";s:8:\"View:Tag\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:87;a:4:{s:1:\"a\";i:88;s:1:\"b\";s:10:\"Create:Tag\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:88;a:4:{s:1:\"a\";i:89;s:1:\"b\";s:10:\"Update:Tag\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:89;a:4:{s:1:\"a\";i:90;s:1:\"b\";s:10:\"Delete:Tag\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:90;a:4:{s:1:\"a\";i:91;s:1:\"b\";s:13:\"DeleteAny:Tag\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:91;a:4:{s:1:\"a\";i:92;s:1:\"b\";s:11:\"Restore:Tag\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:92;a:4:{s:1:\"a\";i:93;s:1:\"b\";s:15:\"ForceDelete:Tag\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:93;a:4:{s:1:\"a\";i:94;s:1:\"b\";s:18:\"ForceDeleteAny:Tag\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:94;a:4:{s:1:\"a\";i:95;s:1:\"b\";s:14:\"RestoreAny:Tag\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:95;a:4:{s:1:\"a\";i:96;s:1:\"b\";s:13:\"Replicate:Tag\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:96;a:4:{s:1:\"a\";i:97;s:1:\"b\";s:11:\"Reorder:Tag\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}}s:5:\"roles\";a:3:{i:0;a:3:{s:1:\"a\";i:1;s:1:\"b\";s:11:\"super_admin\";s:1:\"c\";s:3:\"web\";}i:1;a:3:{s:1:\"a\";i:2;s:1:\"b\";s:12:\"usuario-test\";s:1:\"c\";s:3:\"web\";}i:2;a:3:{s:1:\"a\";i:3;s:1:\"b\";s:7:\"admines\";s:1:\"c\";s:3:\"web\";}}}', 1792675131),
('laravel-cache-356a192b7913b04c54574d18c28d46e6395428ab', 'i:1;', 1781201227),
('laravel-cache-356a192b7913b04c54574d18c28d46e6395428ab:timer', 'i:1781201227;', 1781201227),
('laravel-cache-livewire-rate-limiter:16d36dff9abd246c67dfac3e63b993a169af77e6', 'i:2;', 1781201088),
('laravel-cache-livewire-rate-limiter:16d36dff9abd246c67dfac3e63b993a169af77e6:timer', 'i:1781201088;', 1781201088),
('laravel-cache-spatie.permission.cache', 'a:3:{s:5:\"alias\";a:4:{s:1:\"a\";s:2:\"id\";s:1:\"b\";s:4:\"name\";s:1:\"c\";s:10:\"guard_name\";s:1:\"r\";s:5:\"roles\";}s:11:\"permissions\";a:73:{i:0;a:4:{s:1:\"a\";i:1;s:1:\"b\";s:17:\"ViewAny:Categoria\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:1;a:4:{s:1:\"a\";i:2;s:1:\"b\";s:14:\"View:Categoria\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:2;a:4:{s:1:\"a\";i:3;s:1:\"b\";s:16:\"Create:Categoria\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:3;a:4:{s:1:\"a\";i:4;s:1:\"b\";s:16:\"Update:Categoria\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:4;a:4:{s:1:\"a\";i:5;s:1:\"b\";s:16:\"Delete:Categoria\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:5;a:4:{s:1:\"a\";i:6;s:1:\"b\";s:19:\"DeleteAny:Categoria\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:6;a:4:{s:1:\"a\";i:7;s:1:\"b\";s:17:\"Restore:Categoria\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:7;a:4:{s:1:\"a\";i:8;s:1:\"b\";s:21:\"ForceDelete:Categoria\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:8;a:4:{s:1:\"a\";i:9;s:1:\"b\";s:24:\"ForceDeleteAny:Categoria\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:9;a:4:{s:1:\"a\";i:10;s:1:\"b\";s:20:\"RestoreAny:Categoria\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:10;a:4:{s:1:\"a\";i:11;s:1:\"b\";s:19:\"Replicate:Categoria\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:11;a:4:{s:1:\"a\";i:12;s:1:\"b\";s:17:\"Reorder:Categoria\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:12;a:4:{s:1:\"a\";i:13;s:1:\"b\";s:17:\"ViewAny:Documento\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:13;a:4:{s:1:\"a\";i:14;s:1:\"b\";s:14:\"View:Documento\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:14;a:4:{s:1:\"a\";i:15;s:1:\"b\";s:16:\"Create:Documento\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:15;a:4:{s:1:\"a\";i:16;s:1:\"b\";s:16:\"Update:Documento\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:16;a:4:{s:1:\"a\";i:17;s:1:\"b\";s:16:\"Delete:Documento\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:17;a:4:{s:1:\"a\";i:18;s:1:\"b\";s:19:\"DeleteAny:Documento\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:18;a:4:{s:1:\"a\";i:19;s:1:\"b\";s:17:\"Restore:Documento\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:19;a:4:{s:1:\"a\";i:20;s:1:\"b\";s:21:\"ForceDelete:Documento\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:20;a:4:{s:1:\"a\";i:21;s:1:\"b\";s:24:\"ForceDeleteAny:Documento\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:21;a:4:{s:1:\"a\";i:22;s:1:\"b\";s:20:\"RestoreAny:Documento\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:22;a:4:{s:1:\"a\";i:23;s:1:\"b\";s:19:\"Replicate:Documento\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:23;a:4:{s:1:\"a\";i:24;s:1:\"b\";s:17:\"Reorder:Documento\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:24;a:4:{s:1:\"a\";i:25;s:1:\"b\";s:12:\"ViewAny:Role\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:25;a:4:{s:1:\"a\";i:26;s:1:\"b\";s:9:\"View:Role\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:26;a:4:{s:1:\"a\";i:27;s:1:\"b\";s:11:\"Create:Role\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:27;a:4:{s:1:\"a\";i:28;s:1:\"b\";s:11:\"Update:Role\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:28;a:4:{s:1:\"a\";i:29;s:1:\"b\";s:11:\"Delete:Role\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:29;a:4:{s:1:\"a\";i:30;s:1:\"b\";s:14:\"DeleteAny:Role\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:30;a:4:{s:1:\"a\";i:31;s:1:\"b\";s:12:\"Restore:Role\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:31;a:4:{s:1:\"a\";i:32;s:1:\"b\";s:16:\"ForceDelete:Role\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:32;a:4:{s:1:\"a\";i:33;s:1:\"b\";s:19:\"ForceDeleteAny:Role\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:33;a:4:{s:1:\"a\";i:34;s:1:\"b\";s:15:\"RestoreAny:Role\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:34;a:4:{s:1:\"a\";i:35;s:1:\"b\";s:14:\"Replicate:Role\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:35;a:4:{s:1:\"a\";i:36;s:1:\"b\";s:12:\"Reorder:Role\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:36;a:4:{s:1:\"a\";i:37;s:1:\"b\";s:21:\"ViewAny:TipoDocumento\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:37;a:4:{s:1:\"a\";i:38;s:1:\"b\";s:18:\"View:TipoDocumento\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:38;a:4:{s:1:\"a\";i:39;s:1:\"b\";s:20:\"Create:TipoDocumento\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:39;a:4:{s:1:\"a\";i:40;s:1:\"b\";s:20:\"Update:TipoDocumento\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:40;a:4:{s:1:\"a\";i:41;s:1:\"b\";s:20:\"Delete:TipoDocumento\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:41;a:4:{s:1:\"a\";i:42;s:1:\"b\";s:23:\"DeleteAny:TipoDocumento\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:42;a:4:{s:1:\"a\";i:43;s:1:\"b\";s:21:\"Restore:TipoDocumento\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:43;a:4:{s:1:\"a\";i:44;s:1:\"b\";s:25:\"ForceDelete:TipoDocumento\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:44;a:4:{s:1:\"a\";i:45;s:1:\"b\";s:28:\"ForceDeleteAny:TipoDocumento\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:45;a:4:{s:1:\"a\";i:46;s:1:\"b\";s:24:\"RestoreAny:TipoDocumento\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:46;a:4:{s:1:\"a\";i:47;s:1:\"b\";s:23:\"Replicate:TipoDocumento\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:47;a:4:{s:1:\"a\";i:48;s:1:\"b\";s:21:\"Reorder:TipoDocumento\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:48;a:4:{s:1:\"a\";i:49;s:1:\"b\";s:20:\"View:DocumentosStats\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:49;a:4:{s:1:\"a\";i:50;s:1:\"b\";s:18:\"ViewAny:Permission\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:50;a:4:{s:1:\"a\";i:51;s:1:\"b\";s:15:\"View:Permission\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:51;a:4:{s:1:\"a\";i:52;s:1:\"b\";s:17:\"Create:Permission\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:52;a:4:{s:1:\"a\";i:53;s:1:\"b\";s:17:\"Update:Permission\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:53;a:4:{s:1:\"a\";i:54;s:1:\"b\";s:17:\"Delete:Permission\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:54;a:4:{s:1:\"a\";i:55;s:1:\"b\";s:20:\"DeleteAny:Permission\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:55;a:4:{s:1:\"a\";i:56;s:1:\"b\";s:18:\"Restore:Permission\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:56;a:4:{s:1:\"a\";i:57;s:1:\"b\";s:22:\"ForceDelete:Permission\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:57;a:4:{s:1:\"a\";i:58;s:1:\"b\";s:25:\"ForceDeleteAny:Permission\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:58;a:4:{s:1:\"a\";i:59;s:1:\"b\";s:21:\"RestoreAny:Permission\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:59;a:4:{s:1:\"a\";i:60;s:1:\"b\";s:20:\"Replicate:Permission\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:60;a:4:{s:1:\"a\";i:61;s:1:\"b\";s:18:\"Reorder:Permission\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:61;a:4:{s:1:\"a\";i:62;s:1:\"b\";s:12:\"ViewAny:User\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:62;a:4:{s:1:\"a\";i:63;s:1:\"b\";s:9:\"View:User\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:63;a:4:{s:1:\"a\";i:64;s:1:\"b\";s:11:\"Create:User\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:64;a:4:{s:1:\"a\";i:65;s:1:\"b\";s:11:\"Update:User\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:65;a:4:{s:1:\"a\";i:66;s:1:\"b\";s:11:\"Delete:User\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:66;a:4:{s:1:\"a\";i:67;s:1:\"b\";s:14:\"DeleteAny:User\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:67;a:4:{s:1:\"a\";i:68;s:1:\"b\";s:12:\"Restore:User\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:68;a:4:{s:1:\"a\";i:69;s:1:\"b\";s:16:\"ForceDelete:User\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:69;a:4:{s:1:\"a\";i:70;s:1:\"b\";s:19:\"ForceDeleteAny:User\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:70;a:4:{s:1:\"a\";i:71;s:1:\"b\";s:15:\"RestoreAny:User\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:71;a:4:{s:1:\"a\";i:72;s:1:\"b\";s:14:\"Replicate:User\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}i:72;a:4:{s:1:\"a\";i:73;s:1:\"b\";s:12:\"Reorder:User\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:1;}}}s:5:\"roles\";a:1:{i:0;a:3:{s:1:\"a\";i:1;s:1:\"b\";s:11:\"super_admin\";s:1:\"c\";s:3:\"web\";}}}', 1781287436);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `color` varchar(255) NOT NULL DEFAULT '#f59e0b'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`id`, `nombre`, `descripcion`, `created_at`, `updated_at`, `color`) VALUES
(1, 'Administración', 'Documentos relacionados con administración general.', '2026-06-18 19:01:11', '2026-10-21 17:48:05', '#ff0000'),
(2, 'Educación', 'Documentos sobre educación e instituciones educativas.', '2026-06-18 19:01:11', '2026-10-21 17:48:29', '#c700b6'),
(3, 'Salud', 'Documentos relacionados con salud pública.', '2026-06-18 19:01:11', '2026-10-21 17:48:50', '#f4f50a'),
(4, 'Infraestructura', 'Documentos sobre obras e infraestructura.', '2026-06-18 19:01:11', '2026-10-21 17:48:36', '#0a5df5'),
(5, 'Recursos Humanos', 'Documentos sobre personal y recursos humanos.', '2026-06-18 19:01:11', '2026-10-21 17:48:41', '#0af533');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `documentos`
--

CREATE TABLE `documentos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `categoria_id` bigint(20) UNSIGNED NOT NULL,
  `tipo_id` bigint(20) UNSIGNED NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `ruta_doc` varchar(255) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `anio` smallint(5) UNSIGNED NOT NULL,
  `numero` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `documentos`
--

INSERT INTO `documentos` (`id`, `categoria_id`, `tipo_id`, `titulo`, `ruta_doc`, `descripcion`, `anio`, `numero`, `created_at`, `updated_at`) VALUES
(1, 2, 1, 'Magni voluptates laboriosam iste omnis in.', 'documentos/doc0.pdf', 'Id unde est ut optio ab. Aut tempore blanditiis non rem a repudiandae eos repudiandae. Natus quia saepe voluptas voluptatum omnis et. Adipisci temporibus quasi ullam veritatis ipsum voluptatem et.', 2021, '6436', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(2, 2, 2, 'Esse adipisci qui ipsum.', 'documentos/doc1.pdf', 'Eum aut et provident quae facere. Autem et et eos dicta quod neque. Laborum inventore perferendis eligendi sed quia rerum sint.', 2026, '3189', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(3, 4, 4, 'Beatae sint sit dolores.', 'documentos/doc2.pdf', 'Dolorem rem eius deleniti magni. Vero sit tempore necessitatibus occaecati voluptas mollitia. Quam autem quia illum et perspiciatis similique reprehenderit quia. Tempora eaque eum nobis eligendi error voluptatem quas. Excepturi id repellat inventore non.', 2024, '8307', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(4, 2, 3, 'Nulla cum qui minima corporis.', 'documentos/doc3.pdf', 'Minima ex tempore ipsum rerum et. Deserunt consequatur et quaerat eum perferendis. Quam dolores et optio sint. Rem magni voluptates voluptatem eligendi necessitatibus.', 2022, '4277', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(5, 2, 2, 'Quasi ipsa ut quia odit.', 'documentos/doc4.pdf', 'Consectetur consectetur corporis delectus tenetur nostrum. Molestias consectetur et eos et adipisci nulla. Temporibus libero rerum voluptas unde vero neque tempora. Ea harum ut vero minus vel laudantium.', 2021, '2650', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(6, 5, 4, 'Odit quam optio est.', 'documentos/doc5.pdf', 'Qui consequuntur debitis quis. Incidunt at tempore sunt dolorem. Sit totam rerum culpa in atque. Voluptatem voluptatem culpa dolorum corrupti. Velit ducimus dolores aliquid culpa.', 2020, '3504', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(7, 1, 2, 'Aperiam eaque autem adipisci voluptas quo.', 'documentos/doc6.pdf', 'Sint rerum sed est voluptatem voluptatum. Nihil voluptas labore voluptatem accusamus dicta impedit numquam aspernatur. Corporis minima expedita et voluptas. Atque qui expedita nostrum id assumenda eius.', 2025, '5851', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(8, 3, 5, 'Nesciunt explicabo atque deserunt explicabo.', 'documentos/doc7.pdf', 'Amet sed ut blanditiis ut error qui blanditiis. Quasi dolorem maiores id et commodi dolor. Quo et quam quibusdam exercitationem. Sed dignissimos asperiores doloremque numquam.', 2026, '3726', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(9, 5, 2, 'Sed adipisci omnis in amet.', 'documentos/doc8.pdf', 'Commodi corrupti dolore ipsa est ut vel illum veritatis. Assumenda quo accusantium voluptatem iusto fugit omnis qui. Repellendus aut veniam ex pariatur et consequatur. Facilis dolores nisi et odit repudiandae.', 2026, '5706', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(10, 2, 4, 'Est voluptas ipsam.', 'documentos/doc9.pdf', 'Animi sed culpa et eos et est. Placeat nam sed expedita officia. Sed ducimus minima aperiam sit.', 2020, '4626', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(11, 3, 1, 'Odio odio aperiam qui minus aut.', 'documentos/doc0.pdf', 'Nam quo et laborum impedit pariatur porro. Quam aut veritatis alias nesciunt error. Est rerum maxime impedit iusto occaecati tempore. Perferendis ut consequuntur quod id.', 2024, '7136', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(12, 2, 3, 'Eum aut cum id aperiam.', 'documentos/doc1.pdf', 'Facilis fuga porro rem rerum. Necessitatibus unde ab soluta ea quod aut nobis. Optio et maxime ut ut quasi enim. Aut repellat quos cumque temporibus.', 2025, '7487', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(13, 3, 4, 'Corporis temporibus cum cum iste.', 'documentos/doc2.pdf', 'Eligendi sunt velit ipsam fugiat est dolorum et. Porro itaque harum consequuntur ipsam facere aut qui. Quia dolores est et cumque repudiandae.', 2025, '2745', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(14, 5, 5, 'Asperiores id molestias dolore.', 'documentos/doc3.pdf', 'Est omnis et quisquam officia. Minima at aliquid iste. Repellat incidunt nihil et hic ex ipsa voluptates. Qui quia officia omnis minus.', 2021, '2251', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(15, 5, 3, 'Rem quos officiis similique.', 'documentos/doc4.pdf', 'Modi rerum quos quae sint nihil. Quia dolor quibusdam necessitatibus qui. Modi dolor incidunt nulla qui esse provident.', 2024, '7649', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(16, 2, 3, 'Veritatis placeat doloribus expedita.', 'documentos/doc5.pdf', 'Repudiandae voluptatem in voluptatum porro. Voluptas saepe consequatur maiores veniam fugiat omnis fuga. Laboriosam sed dolor ea architecto quod quia molestiae. Illum quasi quas accusamus nisi.', 2018, '617', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(17, 3, 4, 'Cupiditate architecto autem ad.', 'documentos/doc6.pdf', 'Magni labore quas rerum cumque repudiandae. Dolorem qui nesciunt quia architecto ipsam. Quisquam officia vero laudantium voluptatem animi delectus culpa.', 2022, '8444', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(18, 5, 4, 'Impedit dolore itaque debitis repudiandae.', 'documentos/doc7.pdf', 'Doloribus voluptas vitae tempore magni occaecati mollitia temporibus. Libero similique enim necessitatibus sed placeat et tenetur.', 2019, '6568', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(19, 1, 3, 'Dolorum eveniet vero sint accusantium.', 'documentos/doc8.pdf', 'Non ipsum molestias et sed temporibus aut. Omnis occaecati nam minima mollitia cum. Sunt neque ut eum id unde accusantium eos et. Quasi consequatur et voluptatem provident ut recusandae rerum. Fuga accusamus sed ut perferendis rerum autem repudiandae aspernatur.', 2023, '2', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(20, 1, 5, 'Harum dolorem sapiente.', 'documentos/doc9.pdf', 'Occaecati occaecati quo est autem quod et ea est. Ut doloribus quo accusamus excepturi quas rem vel quia. Unde modi consequatur cumque omnis. Quisquam aspernatur necessitatibus ut veniam molestias.', 2022, '1186', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(21, 5, 2, 'Dolore quis numquam non.', 'documentos/doc0.pdf', 'Consequatur illum dignissimos autem distinctio ut et. Enim aut voluptas saepe quo. Ex voluptatem sequi ut occaecati eos quia quia. In totam et et sed.', 2023, '8267', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(22, 3, 4, 'Explicabo illo hic amet nobis.', 'documentos/doc1.pdf', 'Qui nam perspiciatis soluta voluptas. Id sit molestiae tempora accusamus iure. Aliquid enim iure quia laudantium delectus modi minima ad. Et atque beatae ut ducimus tempora reiciendis veniam.', 2026, '8828', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(23, 1, 4, 'Explicabo ea laboriosam est enim debitis.', 'documentos/doc2.pdf', 'Hic eos non ut. Ut non et ut sunt aliquid. Odit praesentium sint tempore aut distinctio. Aliquam quia magni quos nobis aut voluptatem.', 2021, '3133', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(24, 3, 3, 'Aspernatur dolorem eaque dolorem rem architecto.', 'documentos/doc3.pdf', 'Enim aspernatur voluptatem veniam itaque vel optio. Id eius dicta laudantium nihil saepe. Illum ut assumenda quia rerum fuga molestiae.', 2024, '5325', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(25, 4, 5, 'Rem nesciunt dignissimos autem.', 'documentos/doc4.pdf', 'Molestias quia recusandae in sunt sed. Nemo recusandae quo at tenetur iure. Ullam similique et enim aut. Minima qui numquam reprehenderit cumque.', 2018, '5118', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(26, 5, 1, 'Vitae accusantium optio facilis quia.', 'documentos/doc5.pdf', 'Eligendi nulla quam est ipsum quam ut. Quis rerum qui pariatur ut sapiente consequatur ipsum. Et fugit asperiores sunt earum et. Voluptatem velit ducimus voluptatibus nulla tempore commodi aut perspiciatis. Inventore ex non nobis quam saepe dolore voluptates.', 2019, '7199', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(27, 5, 3, 'Ut laboriosam officia.', 'documentos/doc6.pdf', 'Est consectetur qui quaerat tenetur perferendis dolore enim. Velit et omnis animi nobis. Exercitationem laudantium aliquam voluptatem qui dolorem vel.', 2024, '8989', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(28, 3, 3, 'Dolorum nulla ipsum et.', 'documentos/doc7.pdf', 'Dolores quis in quasi natus rem sapiente. Corrupti aut accusamus molestiae aliquam eveniet laboriosam expedita. Quidem et veniam qui omnis quo ullam. Commodi doloribus dolorem qui architecto cumque. Voluptatem enim qui quis et ut.', 2022, '5327', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(29, 3, 1, 'Dolorum adipisci et debitis necessitatibus.', 'documentos/doc8.pdf', 'Quia quibusdam qui sunt praesentium reprehenderit inventore corrupti. Quis dolor laudantium dicta qui. Reprehenderit accusamus et autem totam doloremque. Architecto deleniti quas corporis.', 2026, '783', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(30, 3, 5, 'Veritatis occaecati reprehenderit et enim.', 'documentos/doc9.pdf', 'Repudiandae esse natus et nemo. Sit corrupti dicta voluptatem sunt autem voluptatibus. Minus et odio consequatur delectus ut eum nam dolor.', 2024, '3893', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(31, 5, 3, 'Architecto totam consequatur libero.', 'documentos/doc0.pdf', 'Quis magni maxime consequatur incidunt nam iste iusto. Voluptatem et nostrum reprehenderit error quas.', 2026, '4920', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(32, 5, 2, 'Aut sit libero perspiciatis nihil.', 'documentos/doc1.pdf', 'Eligendi vel deserunt dolor. Ut eum et qui.', 2024, '442', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(33, 2, 4, 'Ipsa iste consequatur mollitia.', 'documentos/doc2.pdf', 'Sed provident qui et sit accusantium aut temporibus minima. Sequi molestiae aut reiciendis nam. Aut beatae recusandae sequi minus sunt in non. Laborum a aliquam et nam.', 2018, '8331', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(34, 2, 4, 'Unde esse ut repellat repudiandae.', 'documentos/doc3.pdf', 'Illum qui iure et vero. Vitae nemo officiis est debitis veritatis sed quibusdam. Ratione nemo aut ut numquam omnis at. Non amet est doloremque veritatis neque. Eligendi quae saepe consequatur omnis reprehenderit minima quia.', 2021, '6105', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(35, 2, 3, 'Similique perspiciatis officia rerum esse.', 'documentos/doc4.pdf', 'Sunt ut aut laudantium nihil mollitia voluptas. Beatae non ullam quia sint et necessitatibus dolorum.', 2020, '1254', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(36, 1, 4, 'Neque ad tempore cupiditate dolores.', 'documentos/doc5.pdf', 'Omnis et consectetur odio adipisci iure voluptas incidunt. Tempora labore ut occaecati aut dolores optio.', 2024, '4715', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(37, 4, 4, 'A et autem minus voluptate.', 'documentos/doc6.pdf', 'Et sint dolorem rerum sed rem. Vel excepturi ea ea autem iusto esse. Fugiat itaque fugit et dolore officia quos.', 2024, '7211', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(38, 2, 2, 'Culpa at nihil atque maiores.', 'documentos/doc7.pdf', 'Eos occaecati quisquam voluptatem tempore vero. Voluptates ut rerum vitae totam adipisci.', 2019, '1008', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(39, 3, 5, 'Eligendi sapiente et voluptates totam.', 'documentos/doc8.pdf', 'Facilis quisquam adipisci et nisi commodi in dolorem aut. Officia est placeat eos facilis autem temporibus ad molestiae. Dolores modi suscipit et. Quia aut numquam id nihil iure provident. Reprehenderit rem odio odio esse illum est neque.', 2021, '5181', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(40, 1, 5, 'Soluta explicabo doloremque eos autem ut.', 'documentos/doc9.pdf', 'Harum aut ut ex vero natus. Ad ipsa rerum ut facere eum officiis hic. Repudiandae provident nam quam doloribus ut.', 2022, '6247', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(41, 3, 5, 'Ut occaecati molestias veritatis officiis illum.', 'documentos/doc0.pdf', 'Quo provident provident maxime eos fuga earum sed et. Quaerat architecto et voluptas recusandae voluptas nisi perspiciatis sunt. Et qui est blanditiis et numquam. Ratione optio beatae quo.', 2020, '7135', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(42, 3, 3, 'Distinctio perspiciatis sapiente non eligendi.', 'documentos/doc1.pdf', 'Ad perspiciatis dolorem ipsam. Voluptas ex voluptatem quam voluptas nostrum in. Voluptas laboriosam distinctio expedita nemo dolorum repudiandae blanditiis ut. Non sit exercitationem et ut accusamus ab quia sit.', 2020, '4311', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(43, 1, 5, 'Facere magni eligendi possimus id.', 'documentos/doc2.pdf', 'Esse consectetur architecto facere rerum blanditiis error dolorum. Odit sint facilis excepturi quasi sint et. Facilis facere delectus veritatis qui molestiae facere. Voluptatum expedita dolor commodi totam molestiae tenetur nam.', 2025, '6434', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(44, 5, 2, 'Nobis doloribus expedita voluptate tempora consequuntur.', 'documentos/doc3.pdf', 'Sed aut laudantium tenetur repellendus eos dolorem officia. Nihil omnis excepturi et est inventore eum perferendis inventore. Voluptas at et ipsam nemo eum sed. Vel aut qui eum quaerat et ut rem.', 2025, '7792', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(45, 5, 2, 'Est laudantium ea voluptatum dolorem adipisci.', 'documentos/doc4.pdf', 'Distinctio temporibus rerum incidunt cum eos rem id. Porro repellat sed unde autem totam et. Ut dolores nam et sed. Voluptatum eligendi optio illum.', 2018, '8085', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(46, 2, 5, 'Harum repudiandae ab autem ratione.', 'documentos/doc5.pdf', 'Corrupti voluptatem corrupti mollitia rem omnis. Animi similique quam quis soluta. Non deleniti rem et est et qui illum. Consequatur suscipit dolor et distinctio aliquid.', 2025, '9205', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(47, 1, 1, 'Natus recusandae error quae ut.', 'documentos/doc6.pdf', 'Exercitationem nemo expedita expedita quia voluptatem aut. Beatae iusto quis laboriosam libero corporis laborum molestiae. Consequatur non delectus et esse dolorem facilis fugit porro. Possimus suscipit dicta incidunt repellendus aut.', 2024, '9418', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(48, 5, 1, 'Autem earum non inventore nobis.', 'documentos/doc7.pdf', 'Sit odio eius rerum deserunt occaecati eveniet magnam cum. Ducimus vero eveniet molestiae id voluptatem mollitia. Unde quia harum nihil repellendus deleniti. Quasi fuga autem explicabo unde eaque. Laboriosam quia officiis pariatur qui et ad.', 2020, '6744', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(49, 4, 5, 'Voluptatem quasi dolor incidunt.', 'documentos/doc8.pdf', 'Aperiam eum aspernatur iste voluptatem voluptate. Ipsam dolorem quia sint. Molestiae eius aspernatur ab quia. Excepturi placeat tempore ducimus nulla aliquid quod.', 2019, '6008', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(50, 3, 1, 'Ea quia porro iusto corporis.', 'documentos/doc9.pdf', 'Nihil perspiciatis perspiciatis recusandae in sequi quia sed. Maxime omnis nihil necessitatibus nihil inventore eum.', 2026, '5064', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(51, 2, 3, 'Temporibus quam exercitationem nam.', 'documentos/doc0.pdf', 'Error rem eius perspiciatis illum dolor. Aliquid enim sed ex et praesentium. Sed laborum distinctio aspernatur molestias enim amet ut. Corporis sapiente non dolorem deserunt autem eligendi id.', 2019, '2801', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(52, 3, 2, 'Dolores repellendus eum consequatur ratione.', 'documentos/doc1.pdf', 'Provident qui aspernatur molestiae ut quaerat in et aliquam. Commodi dolor enim impedit voluptas error molestiae est. Porro eum voluptatem tenetur ab. Sunt est fugit dolores reiciendis dignissimos aperiam.', 2019, '6228', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(53, 5, 2, 'Architecto natus quam.', 'documentos/doc2.pdf', 'Enim nesciunt suscipit voluptatem quia. Consequuntur molestiae ducimus quia est enim.', 2018, '9221', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(54, 5, 5, 'Autem ut totam nobis nemo.', 'documentos/doc3.pdf', 'Repellat est ad libero eos quis id vitae. Nisi eveniet at id quisquam voluptas eveniet. Sit molestiae non necessitatibus.', 2022, '3721', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(55, 3, 3, 'Magnam earum molestias est vitae.', 'documentos/doc4.pdf', 'Et aliquid voluptates voluptates aut quisquam. Doloremque eaque in quam mollitia dignissimos ipsam.', 2020, '7402', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(56, 2, 1, 'Incidunt temporibus est unde sint.', 'documentos/doc5.pdf', 'Suscipit ipsam quisquam perferendis vero. Sunt libero velit voluptatem natus repellendus.', 2023, '8842', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(57, 4, 1, 'Nam sunt odio odio voluptate quisquam.', 'documentos/doc6.pdf', 'Error dolorem harum ipsam laboriosam et. Quo et voluptatem exercitationem voluptate. Et dolor illo dignissimos enim reiciendis ipsam. Voluptatibus minima delectus cupiditate sint doloremque ut.', 2024, '1425', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(58, 4, 2, 'Perspiciatis ullam sit eaque et.', 'documentos/doc7.pdf', 'At eveniet et quo ullam et autem fuga. Ut totam voluptas in voluptatem non rerum enim. Harum harum qui voluptatem.', 2025, '4452', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(59, 5, 3, 'Nisi voluptas ut et.', 'documentos/doc8.pdf', 'Quas repudiandae et consequatur dicta sunt. Dolores quo non aliquam officiis fugit. Aperiam et et deleniti corporis est repellendus. Quos ab facere perferendis repudiandae placeat quia voluptatem. Pariatur nesciunt ullam accusamus commodi exercitationem eum ullam ut.', 2023, '1022', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(60, 3, 1, 'Et libero sint perspiciatis iure.', 'documentos/doc9.pdf', 'Qui ut rem deleniti optio. Natus ut recusandae nihil minus sit doloribus. Beatae dolorum id hic aperiam laborum eius quae. Omnis iusto aut repudiandae.', 2019, '1475', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(61, 5, 4, 'Nihil sint sint.', 'documentos/doc0.pdf', 'At velit officiis mollitia corrupti eius aliquid. Consequatur porro omnis expedita et quia. Dicta doloremque sed dignissimos rerum.', 2018, '4658', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(62, 1, 4, 'Adipisci est voluptas quidem a ipsa.', 'documentos/doc1.pdf', 'Eaque dicta vel labore inventore eum sequi. Et perferendis voluptatem provident sit ut. Eaque commodi dolores consequatur ut sit quia.', 2022, '9186', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(63, 1, 5, 'Eius accusamus sed est fugit voluptas.', 'documentos/doc2.pdf', 'Sit totam et inventore commodi ullam dolorum enim numquam. Doloremque consequatur quia voluptas sint est sed voluptatem commodi. Corporis harum sint velit atque aperiam sed natus.', 2022, '879', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(64, 1, 5, 'Sequi hic voluptatum veritatis.', 'documentos/doc3.pdf', 'Ab ut sit similique eos facilis aspernatur. Explicabo incidunt non dolores sit dolorum provident distinctio rerum. Ratione in non alias.', 2024, '3946', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(65, 2, 2, 'Quibusdam sunt magnam harum placeat.', 'documentos/doc4.pdf', 'Qui consequatur nihil enim omnis numquam consequatur. Ex et natus magnam consequatur in explicabo ut. Consectetur ut doloremque voluptatum. Minus consequatur id est eos natus debitis consequatur.', 2018, '8005', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(66, 1, 4, 'Sed impedit aut.', 'documentos/doc5.pdf', 'Cupiditate odio odio rerum facere odit. Voluptatem explicabo est maxime voluptatem eum. Dolorum suscipit voluptates et voluptas cumque.', 2021, '8429', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(67, 5, 4, 'Et quo ut sit incidunt.', 'documentos/doc6.pdf', 'Ut accusantium est voluptatem autem. Aut rerum reprehenderit sequi ut earum. Quisquam voluptate et reprehenderit maxime dolores voluptatem.', 2023, '8185', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(68, 1, 4, 'Est et saepe alias ut ut.', 'documentos/doc7.pdf', 'Non voluptatem labore laboriosam soluta accusamus voluptas. Eveniet aut beatae ut asperiores labore quo a dolores. Excepturi qui nam sapiente voluptatem assumenda voluptatem. Exercitationem dolor fugiat atque dignissimos non.', 2024, '935', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(69, 2, 2, 'Id reprehenderit dolorem.', 'documentos/doc8.pdf', 'Qui labore quo ut sed quaerat consequuntur aut ut. Maxime iste ut vitae aut. Saepe molestiae minima adipisci autem porro maiores. Natus molestiae similique ipsam sequi dolores id et.', 2019, '493', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(70, 4, 5, 'Maxime ut minus corrupti ut at.', 'documentos/doc9.pdf', 'Sit consequatur exercitationem sapiente et qui qui voluptate voluptas. Consequuntur qui corporis quam enim debitis autem sed. Facere consequatur id est distinctio at deleniti.', 2022, '7905', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(71, 1, 5, 'Laborum quo aut modi et.', 'documentos/doc0.pdf', 'Ducimus id rerum aut consequatur velit neque. Molestias ut odit quam facilis. Suscipit corrupti nam consectetur qui voluptas quia dolorem. Ut minima beatae beatae mollitia qui ipsum repudiandae cupiditate.', 2021, '7229', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(72, 1, 3, 'Ullam atque impedit.', 'documentos/doc1.pdf', 'Velit dicta ducimus laboriosam et. Commodi autem et ut vero quibusdam quia voluptatum. Maxime similique animi aut nobis. Delectus delectus cum voluptatem commodi commodi libero dolor.', 2024, '1690', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(73, 2, 5, 'Quia sint consectetur.', 'documentos/doc2.pdf', 'Ducimus explicabo autem rerum soluta numquam ut expedita. Quia molestiae ut voluptas molestiae. Earum quibusdam et enim.', 2024, '7831', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(74, 3, 3, 'Est odio et.', 'documentos/doc3.pdf', 'Illum omnis ex autem officia. Amet fugiat autem non placeat temporibus maxime. Quis eaque rerum natus quia in rerum vero.', 2025, '1683', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(75, 4, 1, 'Dolore esse consequatur ea quia.', 'documentos/doc4.pdf', 'Commodi voluptatum eaque alias facilis. Cumque veritatis provident blanditiis accusantium. Tempora repellat ut minus debitis et. Reiciendis quo rerum odit et aut sed et.', 2024, '4352', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(76, 2, 5, 'Nostrum suscipit sint exercitationem.', 'documentos/doc5.pdf', 'Aut distinctio autem reiciendis nemo excepturi nobis nihil cupiditate. Nihil tempora quam maxime architecto pariatur dolore soluta. Voluptatem vitae sit cupiditate dignissimos. Hic et nam blanditiis eum a nam.', 2020, '3083', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(77, 1, 3, 'Et deleniti sed.', 'documentos/doc6.pdf', 'Voluptas laborum dicta voluptatum aut quia fugiat qui natus. Sed quis iste autem magnam quaerat. Ut itaque aut eveniet aspernatur. Libero non illo quibusdam dicta voluptas placeat velit.', 2021, '306', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(78, 4, 2, 'Modi excepturi a ullam.', 'documentos/doc7.pdf', 'Saepe tempore ab et aut delectus sit laudantium aspernatur. Reprehenderit et incidunt sint est error libero. Non ut in veniam mollitia voluptatum.', 2025, '6288', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(79, 5, 3, 'Modi nostrum perferendis ipsam voluptas molestiae.', 'documentos/doc8.pdf', 'Voluptates et quasi commodi dolorem. Odio perferendis laudantium repellat nemo veniam quia incidunt excepturi. Eos natus consequatur ea cumque harum. Qui itaque nihil velit ea commodi.', 2022, '7005', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(80, 1, 2, 'Ea quisquam aut iure sit.', 'documentos/doc9.pdf', 'Fugiat veniam non molestiae ea natus modi et. In non veritatis sit quibusdam. Omnis quasi odio voluptatem qui cupiditate odio incidunt. Cupiditate amet ut ut.', 2024, '6510', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(81, 3, 3, 'Excepturi minus id.', 'documentos/doc0.pdf', 'Temporibus vel voluptas modi est eos voluptatibus aspernatur. Voluptates qui sit sit voluptatem similique quae repellat. Tenetur saepe commodi ea enim aperiam voluptate et.', 2021, '9187', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(82, 2, 1, 'Omnis vitae cumque illo.', 'documentos/doc1.pdf', 'Non aut voluptatem qui velit porro nihil eum vel. Sunt velit sequi illo nihil rerum. Quibusdam nisi quia ab id.', 2025, '1235', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(83, 1, 3, 'Qui eius nam consequatur.', 'documentos/doc2.pdf', 'Architecto in totam modi autem tempora provident itaque. Quibusdam et ut molestiae voluptas laboriosam. Sit sint recusandae sed.', 2026, '7635', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(84, 4, 2, 'Hic a deleniti blanditiis voluptatem fugit.', 'documentos/doc3.pdf', 'Dicta sunt voluptatem error officia. Fugiat eos veniam qui voluptatibus delectus voluptas. Reprehenderit quia officiis qui sint eveniet dolorem. Tempore reiciendis totam fugit animi.', 2019, '5282', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(85, 3, 3, 'Consequuntur eveniet aut dicta.', 'documentos/doc4.pdf', 'Quidem voluptatem atque consequatur quas est sit. Ducimus quia sunt quaerat molestiae consequatur eligendi. Eum blanditiis natus eveniet ipsam. Consectetur qui voluptatem ratione ut possimus est.', 2026, '388', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(86, 3, 3, 'Beatae quia praesentium.', 'documentos/doc5.pdf', 'Modi voluptate mollitia harum ullam sint tenetur at. Incidunt et laboriosam voluptatibus. Nihil doloribus commodi laboriosam explicabo.', 2020, '5397', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(87, 5, 2, 'Pariatur sit adipisci soluta.', 'documentos/doc6.pdf', 'Quas ipsa aliquam quaerat. Ut dolorem laboriosam saepe omnis minus et quo. Alias officiis recusandae aut ratione facere quo.', 2018, '6400', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(88, 1, 5, 'Et minus quae.', 'documentos/doc7.pdf', 'Molestias doloribus quas facere odit quia aut cupiditate. Aut est reiciendis deleniti mollitia dignissimos aut. Et aliquam vitae mollitia sit voluptatibus aut quod exercitationem.', 2024, '2230', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(89, 1, 3, 'Inventore quisquam iste nobis.', 'documentos/doc8.pdf', 'Officia harum id autem pariatur voluptatem aut aliquam tempora. Voluptatem quaerat rerum natus adipisci quia soluta. Assumenda possimus labore quam quis placeat aspernatur enim qui.', 2020, '7017', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(90, 2, 2, 'Sit et in voluptatem veniam.', 'documentos/doc9.pdf', 'Facilis ipsa aut praesentium cumque id et. Et blanditiis et odit et ad velit est voluptates. Iusto ducimus quas assumenda tempora repudiandae magnam alias.', 2020, '765', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(91, 3, 5, 'Placeat deserunt repellat et.', 'documentos/doc0.pdf', 'Molestiae corporis saepe vero aut ut sit. Laboriosam assumenda atque qui consequatur vero. Fugit possimus omnis consequatur optio quaerat assumenda.', 2026, '5056', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(92, 1, 4, 'Nulla est deserunt.', 'documentos/doc1.pdf', 'Et iusto autem expedita sequi facere accusantium. Exercitationem deserunt non autem occaecati accusantium suscipit. Quam sint qui quo voluptas vel dicta. Error delectus non quae sunt sint.', 2025, '4465', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(93, 3, 4, 'Alias enim nobis tenetur qui ut.', 'documentos/doc2.pdf', 'Voluptates debitis voluptatem tempora voluptates earum. Similique facere sunt numquam voluptatem autem mollitia officiis laudantium. Velit commodi qui odit delectus illo aut modi.', 2025, '8239', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(94, 1, 2, 'Dolorem aliquam voluptas dolor.', 'documentos/doc3.pdf', 'Aliquid quos optio aut perspiciatis. Aut sunt eum quibusdam quas aut sunt assumenda.', 2025, '7887', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(95, 4, 3, 'Quidem et commodi totam maiores.', 'documentos/doc4.pdf', 'Quaerat culpa adipisci maxime tenetur aliquid. Harum molestias sint repellat libero numquam qui nemo. Laborum corrupti eos distinctio assumenda. Sit eum qui accusamus alias sequi.', 2020, '5775', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(96, 5, 4, 'Voluptatem sed voluptas saepe dolorem ea.', 'documentos/doc5.pdf', 'In omnis qui commodi reprehenderit et enim consectetur sit. Reiciendis modi laboriosam quidem qui repellat ea. Qui quis excepturi accusamus in repudiandae et dolore dolorem.', 2023, '5771', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(97, 1, 1, 'Dolores sed consectetur sit eaque.', 'documentos/doc6.pdf', 'Fugiat laborum recusandae voluptatem cupiditate. Eaque recusandae necessitatibus nihil et ad ea atque neque. Eveniet animi et praesentium suscipit maiores repellendus ut.', 2024, '4444', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(98, 3, 5, 'Quis pariatur sit delectus pariatur voluptates.', 'documentos/doc7.pdf', 'Libero ullam doloribus necessitatibus debitis voluptas fuga. Quae ipsa vel qui deserunt nisi. Non quia voluptate dolor animi sed est. Molestias numquam cupiditate dolores consequatur autem sunt numquam.', 2022, '4640', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(99, 3, 2, 'Sed voluptate nihil omnis et reiciendis.', 'documentos/doc8.pdf', 'Dolores dolor fugit excepturi tenetur. Illum maiores reiciendis ea quia optio totam. Et ratione laudantium dolorum inventore voluptas occaecati quae distinctio.', 2019, '3010', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(100, 1, 3, 'Amet qui et minima excepturi.', 'documentos/doc9.pdf', 'Explicabo voluptatem quaerat fuga saepe ea sint vel quos. Dolores deleniti in delectus cum quia. Ut at odit et sapiente culpa. Ad et aliquam et quam occaecati incidunt quisquam.', 2024, '2487', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(101, 3, 3, 'Explicabo labore earum.', 'documentos/doc0.pdf', 'Et hic dolores vero ut et enim. Error sit excepturi rerum adipisci sit vero. Aut et nihil ea quisquam porro sint id. Voluptatem nostrum eius at molestiae.', 2024, '6031', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(102, 4, 5, 'Earum amet itaque possimus.', 'documentos/doc1.pdf', 'Autem id eaque enim fuga ea. Non repellendus quisquam magnam repudiandae vel hic. Et in id illo praesentium itaque. Corrupti consequuntur voluptas est. Molestiae dolorem culpa qui.', 2020, '1795', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(103, 4, 4, 'Ut quod eum eum est.', 'documentos/doc2.pdf', 'Ut dignissimos quo maiores est iure. Deserunt praesentium nesciunt dolores ipsam qui. Consequatur est molestiae sunt perferendis.', 2018, '2285', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(104, 2, 4, 'Sed sit exercitationem ullam.', 'documentos/doc3.pdf', 'Voluptas nobis occaecati vel alias eos sed. Deserunt veritatis velit numquam dolorem quasi. Incidunt et animi recusandae quaerat et et id. Rem nemo voluptatem eaque ut tempora velit voluptas.', 2022, '4441', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(105, 2, 5, 'Voluptas placeat minima vitae.', 'documentos/doc4.pdf', 'Maxime eos laudantium porro minus reprehenderit quis vel molestiae. Id enim sit iure et consequatur assumenda. Qui consequatur in qui dolorem. Perspiciatis hic consequatur omnis minus sunt.', 2023, '2991', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(106, 2, 4, 'Beatae rerum amet qui.', 'documentos/doc5.pdf', 'Adipisci laudantium suscipit aut ex earum et. Nobis labore occaecati quia. Occaecati voluptas aut et nemo modi.', 2018, '7270', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(107, 2, 5, 'Facere mollitia qui consectetur.', 'documentos/doc6.pdf', 'Commodi voluptatem tenetur id voluptas necessitatibus dolorem. Deserunt ducimus praesentium exercitationem recusandae sed. Cumque temporibus autem deserunt repellendus.', 2024, '1960', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(108, 4, 4, 'Dolore est voluptas laborum.', 'documentos/doc7.pdf', 'Nihil at rerum unde et. Quae voluptas accusantium dolore culpa ab velit non. Voluptatem dolorem ut id delectus.', 2025, '1711', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(109, 2, 4, 'Laborum amet est.', 'documentos/doc8.pdf', 'In repudiandae et rerum nihil. Unde corrupti vel deserunt laudantium. Et earum iure quis ab.', 2023, '1235', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(110, 2, 1, 'Quod ea sit et.', 'documentos/doc9.pdf', 'Exercitationem corrupti consequatur commodi et voluptatibus reprehenderit eligendi. Error nobis sed quia pariatur laboriosam. Corporis praesentium saepe expedita omnis placeat. Delectus quod expedita mollitia tempore rerum.', 2021, '683', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(111, 1, 3, 'Dolorem quibusdam facere aspernatur.', 'documentos/doc0.pdf', 'Omnis et saepe odit placeat ex. Laboriosam rem voluptas voluptatibus nihil id porro. Sapiente minus facere quod et. In corrupti velit veniam accusamus id atque aspernatur.', 2024, '8740', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(112, 1, 3, 'Nihil dolorem est.', 'documentos/doc1.pdf', 'Quia vel aut porro cupiditate. Vitae eum distinctio asperiores est dolorem quae itaque. Incidunt deleniti nobis eligendi illo qui illo numquam earum.', 2024, '7129', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(113, 5, 4, 'Saepe iure natus ut dolore eos.', 'documentos/doc2.pdf', 'Hic beatae culpa nihil quaerat. Laudantium sint officia sed quisquam et. Nihil consectetur officia voluptate voluptatum est eum blanditiis.', 2020, '2170', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(114, 2, 3, 'Porro vero officia vel.', 'documentos/doc3.pdf', 'Modi a et aut iste voluptatem quisquam. Est illum quam ea repellendus molestiae eveniet.', 2021, '3670', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(115, 1, 2, 'Laboriosam et reprehenderit ipsam.', 'documentos/doc4.pdf', 'Minima et voluptas alias iure. Omnis suscipit qui animi et necessitatibus. Esse necessitatibus aut illo ut.', 2018, '2049', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(116, 2, 4, 'Eum voluptatem atque sint minus.', 'documentos/doc5.pdf', 'Voluptas quos voluptatibus repudiandae facilis. Provident id aliquid ab exercitationem animi. Vero molestias itaque modi quasi. Autem a et maiores commodi ea minima.', 2020, '5726', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(117, 4, 1, 'Quia non suscipit et.', 'documentos/doc6.pdf', 'Eum qui vel aliquid quia et quae. Distinctio in occaecati consequuntur est et provident. Explicabo esse voluptatem quaerat quis quia dicta perspiciatis cumque.', 2025, '8649', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(118, 4, 3, 'Nulla nobis eligendi sapiente.', 'documentos/doc7.pdf', 'Autem ex aspernatur est tenetur. Modi qui debitis et expedita. Quidem modi eligendi enim quidem aut sequi. Quis in odio quos beatae.', 2023, '3132', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(119, 5, 4, 'Sit enim similique repudiandae enim.', 'documentos/doc8.pdf', 'Quia molestiae assumenda possimus ea. Optio dolor voluptas non illo autem ut. Voluptatem facilis itaque ea quasi dignissimos.', 2025, '6574', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(120, 1, 2, 'Voluptatem exercitationem voluptatem velit deleniti.', 'documentos/doc9.pdf', 'Deserunt et corrupti aut at. Qui vel et repellendus iste.', 2022, '9363', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(121, 3, 5, 'Provident similique voluptate.', 'documentos/doc0.pdf', 'Suscipit est inventore inventore dicta ipsum. Dolorem omnis voluptas et iure sapiente. Quia corporis quos quidem nam non ipsum dicta.', 2026, '3162', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(122, 4, 3, 'Nihil quibusdam occaecati.', 'documentos/doc1.pdf', 'Maxime fuga neque minus dolores vel. Eos fuga expedita rerum velit voluptas molestiae eum dolorem. Dolor doloremque ipsam totam sed quia culpa inventore. Rerum nulla nihil nisi aliquam impedit.', 2022, '8032', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(123, 5, 3, 'Nihil explicabo libero.', 'documentos/doc2.pdf', 'Et quam iusto ut. Voluptas magni neque neque dolorem. Modi temporibus sapiente eum esse corrupti harum. In voluptates cupiditate vitae pariatur est officia ut.', 2025, '5545', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(124, 5, 4, 'At aut tempora possimus.', 'documentos/doc3.pdf', 'Tempora facere quibusdam culpa harum veritatis. Nobis neque vero laborum enim sint labore ut.', 2020, '9704', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(125, 2, 2, 'Est rerum aut deleniti veniam.', 'documentos/doc4.pdf', 'Vel nemo nesciunt doloribus porro accusantium. Quo rerum dolorum velit molestiae aut sit. Assumenda rerum numquam est earum. Adipisci sunt sint nesciunt et.', 2026, '3012', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(126, 5, 5, 'Beatae et facere odio.', 'documentos/doc5.pdf', 'Quia dolores eveniet voluptatibus est modi non ut. Enim et laudantium sequi quaerat quod. Enim corrupti deleniti fugit aut.', 2018, '7650', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(127, 2, 5, 'Non minus recusandae vel et.', 'documentos/doc6.pdf', 'Nihil et quia voluptatem est voluptates reprehenderit aut. Voluptas dolor tempora beatae commodi qui architecto illum consequatur. Voluptas laborum sed velit voluptas at reiciendis reiciendis.', 2026, '5495', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(128, 3, 5, 'Sint molestiae odit odio.', 'documentos/doc7.pdf', 'Autem sit et corporis. Et omnis incidunt ut voluptatem quia voluptas numquam animi. Vitae sed et id.', 2019, '6696', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(129, 2, 1, 'Dolor eaque eos voluptatem qui.', 'documentos/doc8.pdf', 'Cum nam harum quia omnis sed. Fuga commodi qui consequatur fugiat. Cumque aut vel dolorem.', 2018, '1551', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(130, 3, 1, 'Harum ab ab ut debitis excepturi.', 'documentos/doc9.pdf', 'Est iste nostrum voluptas ut. Consequuntur illo occaecati vel nihil nam enim omnis minus. Sit facere similique animi non qui ad dolorem.', 2024, '9747', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(131, 4, 1, 'Perferendis laborum maxime natus.', 'documentos/doc0.pdf', 'Et sit repudiandae possimus voluptas eos aliquam. Voluptatum aut culpa temporibus excepturi aut velit earum rerum.', 2023, '8898', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(132, 4, 2, 'Velit vitae omnis labore est ea.', 'documentos/doc1.pdf', 'Nobis earum maxime nemo alias et. Consequatur sed optio ratione. Itaque quo soluta sed nobis. Molestiae voluptatem ipsam sed dolorem.', 2025, '9999', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(133, 2, 2, 'Est possimus debitis sint.', 'documentos/doc2.pdf', 'Non consectetur sunt vitae aperiam asperiores cum. Accusamus est non fugit deserunt.', 2018, '1808', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(134, 4, 3, 'Laboriosam minus modi omnis.', 'documentos/doc3.pdf', 'Expedita aut blanditiis omnis voluptas alias sed voluptas. In natus culpa cum corporis et ut qui. Non aliquam officiis accusamus inventore consequatur atque.', 2021, '4078', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(135, 2, 5, 'Inventore earum non unde dolor itaque.', 'documentos/doc4.pdf', 'Qui natus explicabo unde repellat earum molestiae. Possimus deserunt est unde perferendis nobis pariatur. Consequatur dignissimos et ea adipisci. Dolores et suscipit quod quas.', 2022, '3384', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(136, 4, 4, 'Quo suscipit voluptatem vitae.', 'documentos/doc5.pdf', 'Earum velit libero ab fugit nisi voluptatum ipsam. Sed blanditiis cumque et qui perferendis corporis. Reprehenderit at vel at amet rerum. Voluptas unde illo est eveniet eos corporis qui. Est facilis aut fuga dolore quia molestias.', 2025, '3922', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(137, 2, 4, 'Sapiente dolorem sed adipisci sunt.', 'documentos/doc6.pdf', 'Tenetur earum voluptas autem qui libero iure harum. Et inventore error aut laborum fuga quia facilis. Repellendus corporis eius harum. Temporibus ea blanditiis doloribus excepturi.', 2026, '7022', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(138, 5, 5, 'Voluptates est illo molestias.', 'documentos/doc7.pdf', 'A doloribus nemo dignissimos officia voluptatem. At ut aliquid vitae quaerat aliquam deserunt iure. Consequatur nisi ullam possimus.', 2020, '1878', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(139, 4, 4, 'Sunt nihil quasi qui quidem.', 'documentos/doc8.pdf', 'Eum consequatur eum consequuntur non velit architecto autem. Esse voluptatem sit odio quo enim animi. Voluptatum placeat et veniam non harum.', 2024, '6492', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(140, 4, 4, 'Magni veniam perspiciatis.', 'documentos/doc9.pdf', 'Est voluptatem dolores nobis enim quo dolorem eos. Mollitia et omnis iste provident magni iusto. Consequatur soluta quasi minus velit enim qui quia. Placeat recusandae consequatur voluptas omnis.', 2018, '7710', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(141, 5, 3, 'Optio et labore aut repellendus.', 'documentos/doc0.pdf', 'Voluptas doloribus animi dolorem. Neque rem voluptas dolorem maxime quia et. In veniam omnis eius eos. Rerum nam aut sint consequatur maiores labore ullam.', 2026, '8262', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(142, 3, 3, 'Error quas aspernatur.', 'documentos/doc1.pdf', 'Dolores et saepe assumenda et soluta natus. Modi ratione itaque repellendus qui qui aspernatur soluta quidem. Quisquam eius odio eos est dicta quas nulla.', 2026, '4524', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(143, 2, 1, 'Et exercitationem id qui.', 'documentos/doc2.pdf', 'Aut incidunt eius ad laborum doloribus. Incidunt aut molestiae eligendi provident qui placeat architecto. Harum deleniti laboriosam et architecto id autem. Aliquid illo laborum adipisci omnis quasi ut.', 2022, '5504', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(144, 4, 4, 'Sit rerum officia.', 'documentos/doc3.pdf', 'Dolorem a corporis expedita aspernatur. Doloribus ex voluptatem temporibus dolores.', 2025, '7365', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(145, 3, 3, 'Eum ut tenetur quis.', 'documentos/doc4.pdf', 'Est itaque voluptas quaerat dolore. Quasi quasi molestiae quia dolor quia sint et. Omnis maiores eaque sit dicta.', 2021, '8496', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(146, 1, 4, 'Veniam nemo ad repellat doloribus.', 'documentos/doc5.pdf', 'Adipisci veritatis omnis ut. Delectus ullam delectus eveniet et autem voluptas assumenda. Sit enim voluptatibus temporibus.', 2022, '1013', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(147, 5, 1, 'Id quod consequatur eum ratione.', 'documentos/doc6.pdf', 'Natus culpa amet in alias. Sed molestiae est et qui qui commodi distinctio inventore. Aut magnam dolorem debitis atque impedit ab impedit.', 2025, '1971', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(148, 3, 5, 'Quis dolore commodi perspiciatis quo.', 'documentos/doc7.pdf', 'Earum soluta nihil magnam labore ipsa. Nobis facilis tenetur quam quos aut. Rerum consequatur nesciunt aperiam quo quae deserunt dolores quam.', 2023, '9673', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(149, 5, 1, 'Reiciendis voluptas eius quisquam.', 'documentos/doc8.pdf', 'Non consectetur autem voluptatem ut qui voluptatem reprehenderit. Rem occaecati voluptatum deleniti aut harum tenetur. Consequatur vel rerum placeat enim cupiditate. Nihil labore nihil tempore sed quasi qui.', 2019, '6224', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(150, 4, 2, 'Aut ipsa ipsum commodi expedita.', 'documentos/doc9.pdf', 'Voluptas voluptas adipisci in nihil omnis ullam omnis. Voluptas cum a autem sunt. Natus pariatur in quo quia dicta in natus voluptatem. Dolores et atque ut aut culpa molestias.', 2020, '3919', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(151, 5, 2, 'Similique eos odio.', 'documentos/doc0.pdf', 'Quae assumenda ea inventore ipsum ea vel. Sed dolor commodi labore et ab saepe. Nam est necessitatibus libero quod. Nulla deserunt nihil illo omnis.', 2023, '95', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(152, 4, 2, 'Consequatur consectetur quo quisquam.', 'documentos/doc1.pdf', 'Non sequi veritatis voluptate facere. Quas optio voluptates veritatis vero. Architecto fuga aut et.', 2020, '8773', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(153, 5, 1, 'Qui ipsa esse et itaque.', 'documentos/doc2.pdf', 'Dolorem quae dolorem sed alias. Dolores aperiam eveniet quam voluptatem aliquid tenetur.', 2020, '3065', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(154, 5, 2, 'At corrupti vitae consequatur.', 'documentos/doc3.pdf', 'Saepe eos neque perspiciatis eius. Numquam cupiditate nihil repudiandae praesentium est. Iusto ut recusandae molestiae aut.', 2019, '9448', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(155, 1, 3, 'Pariatur iste aut reiciendis.', 'documentos/doc4.pdf', 'Enim consequatur molestias voluptatem nihil consequatur. Quidem ex modi incidunt ullam sequi hic. Ullam ut voluptatem voluptatem quis minima.', 2023, '5117', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(156, 1, 3, 'Voluptas unde dolor iusto.', 'documentos/doc5.pdf', 'Dicta quae eius sit in ratione velit illo. Qui sint voluptatum ab et eum amet ullam. Ut impedit excepturi laborum similique ut esse. Harum sed nemo non animi dolores eum qui. Aut voluptates iusto ut aut est quia cum.', 2018, '520', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(157, 4, 3, 'Occaecati veritatis sint.', 'documentos/doc6.pdf', 'Possimus ipsum id earum repellendus vitae autem possimus ut. Sit consequatur odio quod saepe sequi recusandae aut. Enim et vel facilis voluptatibus.', 2025, '4108', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(158, 1, 4, 'Iusto aliquid deleniti.', 'documentos/doc7.pdf', 'Explicabo voluptatibus veniam sapiente sint aperiam. Tempora incidunt repudiandae qui. Sit in praesentium tempora nobis quaerat dolorem.', 2020, '8967', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(159, 5, 4, 'Consequatur aut illo.', 'documentos/doc8.pdf', 'Nesciunt molestiae dolorem non quae ex. Ut molestiae est debitis quo quo. Alias tempora aut aut magni. Debitis assumenda eum sed modi laborum.', 2025, '8894', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(160, 3, 5, 'Quis vero fuga.', 'documentos/doc9.pdf', 'Recusandae laudantium ipsa sint doloremque suscipit. In atque ipsam dicta inventore quaerat quia tenetur.', 2023, '6394', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(161, 1, 1, 'Voluptas illum maiores.', 'documentos/doc0.pdf', 'Et minima quam quibusdam dolor autem quo. Dolore sed libero sint voluptas consequatur nihil distinctio nostrum. Quia delectus officiis enim quae consequuntur ipsum est. Modi ad laboriosam ut.', 2023, '9770', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(162, 4, 5, 'Voluptatibus laborum similique eos.', 'documentos/doc1.pdf', 'Aliquid nesciunt cumque officiis sed voluptas voluptatibus et. Tenetur cumque consequuntur modi beatae dolor voluptatem. Sit aut rerum quia praesentium amet quia quo. Nemo itaque sed id et.', 2025, '3332', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(163, 4, 4, 'Aspernatur necessitatibus rem rerum sit.', 'documentos/doc2.pdf', 'Et distinctio et atque quia quibusdam. Tempora est nobis voluptatibus impedit atque.', 2023, '4202', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(164, 1, 4, 'Et accusantium quia temporibus aut.', 'documentos/doc3.pdf', 'Porro qui nisi placeat qui necessitatibus distinctio iste non. Est minima deleniti nostrum vitae voluptas voluptates consequatur.', 2023, '6182', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(165, 5, 5, 'Quis quae animi.', 'documentos/doc4.pdf', 'Ut architecto ut fuga voluptas inventore accusantium. Et voluptas ex quo delectus.', 2024, '1806', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(166, 1, 1, 'Amet placeat autem ea.', 'documentos/doc5.pdf', 'Voluptate cupiditate iure deleniti. Est quas nisi ab est fuga dolor. Voluptate animi iste quod vel.', 2026, '6050', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(167, 3, 1, 'Qui dolorem eum.', 'documentos/doc6.pdf', 'Quia quo optio debitis quia et porro. Est necessitatibus nesciunt corporis beatae dolorem. Occaecati incidunt maxime magni omnis facere similique aut.', 2021, '2202', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(168, 2, 4, 'Earum dignissimos iusto molestiae.', 'documentos/doc7.pdf', 'Dolorem aut animi est magnam. Facere cum occaecati esse inventore reprehenderit illo magni voluptatem. Autem modi blanditiis consequatur consequatur. Fuga sapiente assumenda dolorum ullam excepturi atque enim voluptas.', 2018, '7514', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(169, 2, 2, 'Voluptatem voluptatem excepturi corporis.', 'documentos/doc8.pdf', 'Facilis soluta dolorem velit illum rem sit. Perferendis accusamus amet error aut. Eos facilis ut sed.', 2025, '6720', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(170, 2, 2, 'Laboriosam quis et voluptatibus.', 'documentos/doc9.pdf', 'Quas ut blanditiis harum. Debitis incidunt voluptatem illum eveniet similique. Nulla dolorem sunt placeat eveniet magnam nostrum dolor est. Placeat ut aut dolor quidem sed ipsa.', 2022, '8033', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(171, 2, 1, 'Eum eius voluptates ullam nihil.', 'documentos/doc0.pdf', 'Ratione quia similique eum. Voluptatum placeat ab iusto quo et dolor vitae. Temporibus expedita laborum ipsum illo quia corrupti.', 2020, '8966', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(172, 5, 5, 'Et rerum dolorem esse.', 'documentos/doc1.pdf', 'Dolor cum non perferendis odio totam tempore quam debitis. Provident itaque quo ut ut. Aliquam est sit blanditiis voluptate repellendus in debitis. Qui alias delectus velit voluptas.', 2025, '1211', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(173, 3, 3, 'Cupiditate aspernatur aliquid sed.', 'documentos/doc2.pdf', 'Id at et voluptatem omnis aut fugit. Quo molestiae animi quia sapiente qui dicta. Odio eum itaque dolorem praesentium sit quia ex.', 2019, '1933', '2026-06-18 19:01:18', '2026-06-18 19:01:18');
INSERT INTO `documentos` (`id`, `categoria_id`, `tipo_id`, `titulo`, `ruta_doc`, `descripcion`, `anio`, `numero`, `created_at`, `updated_at`) VALUES
(174, 1, 4, 'Mollitia qui nam eius.', 'documentos/doc3.pdf', 'Eligendi voluptatem unde quis quis et cupiditate quia corrupti. Et magni et voluptatem maiores quis provident. Aut occaecati amet magnam sed possimus voluptas quam. Inventore deserunt eveniet voluptas quod.', 2023, '4429', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(175, 2, 3, 'Enim vero nihil nihil.', 'documentos/doc4.pdf', 'Quidem consequatur et cum quae nesciunt possimus sapiente. Placeat vitae enim laudantium nemo aliquid. Rerum totam quisquam molestiae distinctio voluptatem. Est sequi eum repellat sint aspernatur facere.', 2021, '3067', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(176, 4, 1, 'Magnam quos ab magni.', 'documentos/doc5.pdf', 'Nihil ipsum et et architecto molestias. Est rerum ex officiis provident exercitationem neque voluptatem. Molestiae cum numquam ut accusantium consequatur sed.', 2024, '603', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(177, 5, 1, 'Ducimus minus dolor numquam commodi.', 'documentos/doc6.pdf', 'Dignissimos aut rerum corrupti ipsam ab iure necessitatibus mollitia. Quia ipsum blanditiis nihil. In aspernatur tempora aut et.', 2021, '5971', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(178, 3, 5, 'Aut neque dolorem saepe rem quae.', 'documentos/doc7.pdf', 'Voluptas et consequatur aut illum quam. Consequatur asperiores repudiandae in omnis sapiente. Perferendis et adipisci voluptas nam quod vel.', 2019, '2627', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(179, 1, 1, 'Earum molestias illo architecto eaque.', 'documentos/doc8.pdf', 'Culpa perferendis quaerat consequuntur illum rerum. Molestiae mollitia perferendis totam accusamus. Non omnis dolorem vitae adipisci dolorem molestiae maiores.', 2018, '2966', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(180, 3, 2, 'Quae sint est aliquid voluptatem.', 'documentos/doc9.pdf', 'Dolor aut quaerat est quia omnis. Repellendus est adipisci maxime qui. Qui laborum culpa cupiditate voluptatem aut voluptatem.', 2023, '6054', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(181, 2, 3, 'Beatae nisi harum.', 'documentos/doc0.pdf', 'Beatae accusantium quibusdam quam laborum repudiandae. Hic consequatur et perspiciatis sequi rerum. Dolores accusantium numquam sit quia. Rem magni at consequuntur dolor.', 2024, '2162', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(182, 5, 3, 'Voluptas numquam asperiores quasi.', 'documentos/doc1.pdf', 'Aperiam deserunt dignissimos dolores. Accusantium omnis minus aut qui nemo et. Consectetur explicabo natus enim. Quia laudantium ab sit perspiciatis eveniet.', 2020, '549', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(183, 1, 5, 'Aliquam magnam veniam odio maiores.', 'documentos/doc2.pdf', 'Ducimus occaecati et odit minima veniam. Excepturi tempore possimus perspiciatis quia reprehenderit. Beatae itaque repellendus quisquam repellendus corporis blanditiis vel.', 2022, '6357', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(184, 2, 3, 'Totam aperiam omnis.', 'documentos/doc3.pdf', 'Accusamus dolor voluptatibus quas sunt. Animi delectus sunt dolorem et officiis est fugit. Dicta quaerat sequi ut vero odio quod unde. Veritatis ad quo ex et suscipit aliquid.', 2023, '8097', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(185, 5, 2, 'Ut rerum rerum in nemo.', 'documentos/doc4.pdf', 'Aut earum sit suscipit nostrum ut quo. Placeat consequatur et tempore repudiandae eos voluptatum. Inventore quia iure aut. Ad voluptas et veniam illum maiores eos nobis.', 2023, '1186', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(186, 4, 2, 'Quas amet rem voluptas esse non.', 'documentos/doc5.pdf', 'Minus eos explicabo culpa rerum omnis reprehenderit. Veritatis qui sit vitae aut dolorum.', 2018, '5094', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(187, 5, 2, 'Perferendis explicabo dolores id.', 'documentos/doc6.pdf', 'Fugiat aspernatur veniam rem minus voluptatem cupiditate enim. Mollitia est earum ratione asperiores ipsam commodi. In illo omnis ea eos enim.', 2021, '1110', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(188, 2, 5, 'Minima eum ut quae.', 'documentos/doc7.pdf', 'Magni doloribus autem et et nulla at excepturi facilis. Ipsa nobis reprehenderit nemo aperiam quasi.', 2026, '4970', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(189, 1, 5, 'Modi consequatur cum deserunt consequatur.', 'documentos/doc8.pdf', 'Ut perspiciatis assumenda natus aut harum libero. Placeat et illo quia dolorem.', 2024, '7608', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(190, 3, 2, 'Animi possimus nobis nulla est eum.', 'documentos/doc9.pdf', 'Magni voluptates iusto quo voluptatem quo quia. Nostrum iste fugiat laboriosam quasi sunt provident odit. Ab ad dolores quaerat odio reprehenderit.', 2024, '260', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(191, 2, 4, 'Sint illum quo et ad.', 'documentos/doc0.pdf', 'Quos praesentium consequatur hic. Labore velit voluptatem delectus molestias aperiam animi magnam quam. Minus dignissimos et rerum perspiciatis.', 2025, '31', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(192, 5, 5, 'Ut optio aut quibusdam.', 'documentos/doc1.pdf', 'Necessitatibus enim repellat vel dolorem rerum ea. Id sequi earum nostrum perspiciatis odit sit ducimus. Non repellendus rerum esse quis et. Maiores rem et consectetur reprehenderit ut.', 2024, '3207', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(193, 5, 5, 'Atque iusto voluptatibus voluptatibus in voluptas.', 'documentos/doc2.pdf', 'Magni aspernatur sed possimus rerum. Perferendis dolor mollitia voluptas enim ea dolorem voluptas. Eum quasi odit officia ut excepturi quia. Assumenda placeat id libero dolorem ut.', 2024, '6798', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(194, 4, 5, 'Autem velit aut possimus.', 'documentos/doc3.pdf', 'Vel laudantium omnis tenetur voluptatem ducimus. Dolorem quasi perspiciatis hic amet tempore. Sit odit dolorum praesentium velit est.', 2026, '3742', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(195, 4, 1, 'Voluptas quis et exercitationem possimus.', 'documentos/doc4.pdf', 'Doloribus rerum provident consectetur laborum quo delectus exercitationem. Ipsa amet non minima natus iure non. Qui fugiat dolores sint fugiat ex rerum doloribus recusandae. Recusandae cum id vero.', 2024, '1221', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(196, 5, 4, 'Perspiciatis est laboriosam amet.', 'documentos/doc5.pdf', 'Assumenda quos tenetur magni voluptatem reprehenderit deleniti ducimus ut. Optio vitae tempora perferendis unde magnam quos est. Molestiae voluptatem aut debitis enim.', 2020, '3593', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(197, 1, 4, 'Minus molestiae aut vel.', 'documentos/doc6.pdf', 'Aliquam quia laborum consectetur. Assumenda rerum dolorem eligendi laborum voluptatem vero. Optio vitae recusandae eum libero fugit fuga vel rerum.', 2020, '7253', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(198, 2, 3, 'Autem ipsa et impedit vel.', 'documentos/doc7.pdf', 'Quia molestiae quasi in illo alias repellendus maiores fugiat. Iste voluptatum et ut in minus incidunt. Vel placeat aut velit. Assumenda accusantium facilis optio quia numquam non repellendus et.', 2020, '6055', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(199, 3, 1, 'Odio ut aut cupiditate ea.', 'documentos/doc8.pdf', 'Velit in sit ducimus. Quam atque omnis atque dolores perspiciatis quia ipsam. Libero soluta quis nemo nisi molestias neque ipsum. Omnis iure et omnis eius commodi pariatur qui.', 2023, '579', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(200, 1, 3, 'Eius recusandae qui.', 'documentos/doc9.pdf', 'Ducimus iure consequatur temporibus sed in. Est adipisci sit est qui tenetur unde praesentium. Dolor et veritatis architecto nobis dolorem deleniti repellat quis. Ullam perspiciatis id deserunt dolorem sunt perferendis.', 2019, '384', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(201, 1, 5, 'Ipsum sit quisquam aperiam asperiores.', 'documentos/doc0.pdf', 'Sint dicta illum atque quisquam. In in ut quam cum corporis fugit laboriosam laborum. Aliquid omnis aut laudantium praesentium cumque voluptates dolor.', 2022, '2929', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(202, 4, 4, 'Eligendi magnam officia aliquam.', 'documentos/doc1.pdf', 'Quos ea et at aliquid ab autem. Voluptas reprehenderit dicta est voluptates deleniti adipisci sint ab. Tempora suscipit rerum nam reprehenderit eaque.', 2024, '1565', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(203, 4, 2, 'Harum doloribus inventore.', 'documentos/doc2.pdf', 'Non ratione quis debitis saepe cupiditate beatae corrupti dolor. Ut consequatur qui sit enim nemo non. Est atque molestiae quis quod corrupti sed molestias cum. Reprehenderit praesentium veritatis eius fugit cumque nesciunt.', 2024, '1977', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(204, 1, 5, 'Placeat sit repellat.', 'documentos/doc3.pdf', 'Quaerat id eum officia fugiat aut inventore ratione. Quod accusamus aut qui quaerat recusandae voluptatem rerum ratione. Minus dolor porro exercitationem enim qui quos. At qui esse est in ducimus animi.', 2018, '2344', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(205, 2, 2, 'Tenetur et mollitia in ullam.', 'documentos/doc4.pdf', 'Consectetur ut recusandae eos necessitatibus molestiae dolores. Ipsam fugiat quasi autem sunt animi.', 2021, '8214', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(206, 1, 1, 'Accusamus culpa aut.', 'documentos/doc5.pdf', 'Quas error veniam rerum quaerat officia consequatur. Minima commodi placeat beatae reiciendis nihil adipisci neque. Ducimus alias repellendus eius.', 2025, '7242', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(207, 5, 5, 'Dicta animi in sit ipsam.', 'documentos/doc6.pdf', 'Suscipit sint quisquam sunt. Blanditiis non tempora maxime natus accusantium sint minus natus. Et voluptatibus mollitia ut.', 2026, '7674', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(208, 5, 4, 'Mollitia natus maxime modi dolor.', 'documentos/doc7.pdf', 'Voluptatem et veritatis dolor occaecati. Rerum quia asperiores repellendus ex qui omnis quae. Perspiciatis accusantium natus architecto nemo occaecati porro. Sint reiciendis incidunt animi omnis quod aperiam. Sed aut expedita voluptatem voluptatem aspernatur facere.', 2018, '675', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(209, 3, 3, 'Porro quaerat officiis quas repellendus.', 'documentos/doc8.pdf', 'Officiis rerum molestiae nobis optio eos. Ut in ut nulla minima aut.', 2019, '4949', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(210, 3, 2, 'Repudiandae non tempora incidunt.', 'documentos/doc9.pdf', 'Et sed adipisci ipsum fugit quos perferendis aut ab. Sint eos quis rerum eum facere et.', 2023, '5993', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(211, 2, 5, 'Porro iste esse odio distinctio.', 'documentos/doc0.pdf', 'Nisi aut mollitia nihil cupiditate. Quae exercitationem iure ea. Accusamus aut ex voluptates atque voluptas. Qui laboriosam voluptatem ipsam omnis suscipit odio. Non itaque mollitia et accusamus quasi possimus commodi.', 2022, '6141', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(212, 3, 2, 'Enim temporibus quis ut voluptatibus qui.', 'documentos/doc1.pdf', 'Perspiciatis qui doloribus sed quia ipsa. Dolores debitis et laboriosam distinctio facere. Non cumque sapiente est minima earum officia assumenda. Vero omnis quia repellendus consequuntur praesentium consequatur natus blanditiis.', 2024, '9488', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(213, 3, 2, 'Culpa saepe facere sed quod.', 'documentos/doc2.pdf', 'Tempora voluptate corporis ut eveniet incidunt voluptas. Earum quos nobis culpa ut. Provident molestiae sint et quos delectus. Rerum consequuntur amet eos possimus sint similique sapiente.', 2023, '5039', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(214, 5, 5, 'Est eaque quod quam.', 'documentos/doc3.pdf', 'Maxime qui iure ad voluptatem et ullam provident. Laudantium provident et ipsum fugit. Molestias impedit quia earum consequuntur deleniti.', 2024, '5333', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(215, 1, 2, 'Laboriosam totam perspiciatis.', 'documentos/doc4.pdf', 'Voluptas facere et qui ad. Non ut ut illum sint ipsam laboriosam officia qui. Et impedit sit impedit ea vitae. Enim et non est error reprehenderit iure eius.', 2023, '5290', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(216, 1, 1, 'Eum libero molestias nulla porro.', 'documentos/doc5.pdf', 'Doloremque et voluptatibus odit quae ea. Voluptatem maxime laborum non doloremque sed. Officia porro qui accusamus ab placeat vel tenetur.', 2020, '2748', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(217, 1, 4, 'Distinctio dolorem odit distinctio voluptatum maxime.', 'documentos/doc6.pdf', 'Deserunt itaque optio quia. Voluptas fugit nihil est qui possimus. Dolorum sunt distinctio aut corporis excepturi enim. Ea culpa adipisci ea voluptate.', 2024, '4037', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(218, 4, 5, 'Recusandae laborum eos dolorum vel.', 'documentos/doc7.pdf', 'Et corrupti voluptatem molestiae in praesentium quia. Non autem ad consequatur dolores nostrum blanditiis quis. Exercitationem quidem earum necessitatibus et sunt. Distinctio sapiente molestiae fugit vel et repellat officiis.', 2026, '7634', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(219, 2, 3, 'Eaque dolor sit voluptatum consectetur.', 'documentos/doc8.pdf', 'Voluptas non perferendis possimus suscipit sunt fugit quidem. Est aut in eum totam et dolore consequuntur. Ut harum explicabo nihil odit beatae. Mollitia voluptatem quia ut fugiat earum eum sint.', 2020, '1906', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(220, 2, 5, 'Voluptatem officia impedit.', 'documentos/doc9.pdf', 'Error cum beatae in sequi praesentium dolorem illo. Voluptas harum eum ipsa quo aut voluptatibus. Sed nostrum quo est provident natus dicta laborum sit.', 2021, '7545', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(221, 4, 3, 'Harum sint voluptatem non sapiente.', 'documentos/doc0.pdf', 'Voluptates temporibus animi voluptatem adipisci et cum vero. Incidunt voluptas expedita ut aut incidunt quod maiores exercitationem. Expedita aut cupiditate et et commodi nihil vero. Dolorem quia fugiat ipsam vero perferendis ut.', 2026, '6220', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(222, 2, 3, 'Dolorem accusamus repellat eum at.', 'documentos/doc1.pdf', 'Sit nesciunt architecto ipsam vero. Et commodi vel eum velit ab voluptatum. Dignissimos libero voluptas et ducimus natus explicabo. Facere molestias accusamus aut modi similique.', 2023, '9325', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(223, 2, 1, 'Labore beatae ipsum labore.', 'documentos/doc2.pdf', 'Eaque et sequi est aut sit. Et porro aliquid assumenda temporibus aspernatur dolor iusto consequatur. Nostrum est reprehenderit enim cupiditate numquam voluptate.', 2026, '5571', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(224, 1, 5, 'Dolores porro doloremque.', 'documentos/doc3.pdf', 'Id voluptatem voluptatem sit ipsam quam odio blanditiis. Cupiditate consequuntur eum et ut sint.', 2020, '2289', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(225, 3, 5, 'Sunt debitis ducimus.', 'documentos/doc4.pdf', 'Harum est aut molestias quia dolorum quae. Earum molestiae repudiandae esse illum quisquam voluptatem qui. Repudiandae odit suscipit quia autem.', 2020, '9018', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(226, 4, 4, 'Impedit quisquam eveniet.', 'documentos/doc5.pdf', 'Est beatae numquam aperiam consectetur corrupti vitae vero. Eligendi rerum impedit ut inventore. Laudantium maxime sit hic non. Quis qui ipsa mollitia qui sed sapiente.', 2026, '5910', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(227, 2, 5, 'Blanditiis ut at debitis.', 'documentos/doc6.pdf', 'Non minima explicabo fuga autem ratione eum. Neque quos quis provident natus quod eligendi. Repellat ea sed dicta iste et nesciunt. Nemo dolor facere earum a.', 2023, '1726', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(228, 5, 2, 'Blanditiis corrupti qui voluptatibus dolores.', 'documentos/doc7.pdf', 'Quia assumenda perspiciatis non libero enim. Eum optio laboriosam soluta in. Qui minima voluptatem eligendi sed et esse.', 2024, '1048', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(229, 2, 1, 'Quibusdam odio earum a natus.', 'documentos/doc8.pdf', 'Praesentium veniam animi suscipit. Omnis atque nostrum ullam doloremque aut.', 2018, '7613', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(230, 1, 5, 'Dolor aliquam recusandae fugiat.', 'documentos/doc9.pdf', 'Veritatis sint suscipit itaque unde. Provident eos vero dolores consequatur. Animi odio et sit quos facere.', 2020, '1974', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(231, 5, 4, 'Et atque praesentium quas cum.', 'documentos/doc0.pdf', 'Perspiciatis distinctio velit magnam reiciendis. Quas sequi ut voluptate tempora. Ut ad eaque voluptatem veniam autem. Consectetur nesciunt et fugit cumque.', 2021, '9363', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(232, 4, 1, 'Maiores nostrum cumque neque porro nostrum.', 'documentos/doc1.pdf', 'Ipsam labore expedita pariatur. Tempora dolor ullam doloribus. Fugiat id deserunt iste similique enim assumenda neque.', 2020, '4045', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(233, 4, 2, 'Quod aliquid autem eos ipsam.', 'documentos/doc2.pdf', 'Enim vitae magni enim. Vel temporibus tempore rerum qui eum. Nostrum perspiciatis et necessitatibus ipsam modi dolore.', 2023, '3110', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(234, 3, 5, 'In omnis consequatur dolorem.', 'documentos/doc3.pdf', 'Vitae eligendi quae ipsam ad sed cupiditate. Molestiae voluptatem vel incidunt eos non. Magnam esse rem consequuntur nihil nesciunt nemo. Eius optio nisi esse.', 2024, '2701', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(235, 4, 2, 'Minus quis enim voluptatem ea.', 'documentos/doc4.pdf', 'Corporis iure animi voluptatum adipisci asperiores eaque dolor. Id necessitatibus ad perspiciatis esse fuga. Error consequatur debitis blanditiis molestiae sit facere quasi.', 2024, '9847', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(236, 3, 2, 'Doloremque et enim mollitia veniam.', 'documentos/doc5.pdf', 'Voluptatem omnis explicabo neque quae a tempora eligendi. Cupiditate ipsum ipsa ut sit velit. A rerum qui rerum. Sunt sequi est sint et molestiae quibusdam.', 2025, '8273', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(237, 3, 5, 'Laboriosam et fugiat repudiandae architecto error.', 'documentos/doc6.pdf', 'In excepturi possimus qui nihil eaque. Fugiat alias ab corrupti sapiente. Voluptatum dolorem repellat quam soluta sunt dolorum molestias. Nihil explicabo explicabo fugiat omnis odit quas totam ullam.', 2024, '6303', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(238, 3, 1, 'Et ad ut corporis.', 'documentos/doc7.pdf', 'Sed velit modi minus. Veritatis est repellat cumque. Deleniti porro sint quas.', 2022, '9909', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(239, 5, 4, 'Ea iure in et.', 'documentos/doc8.pdf', 'Tenetur maiores ea earum. Sit omnis dolore quia placeat. Est adipisci soluta nostrum est quae dolorem similique. Exercitationem aut atque aut illum molestiae maxime eum.', 2024, '2110', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(240, 3, 5, 'Distinctio asperiores perferendis voluptas.', 'documentos/doc9.pdf', 'Qui quas officia excepturi tempore. Alias tenetur aliquam molestias qui est assumenda. Sit ut hic aliquam qui aut ut impedit.', 2022, '6136', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(241, 2, 2, 'Est expedita et.', 'documentos/doc0.pdf', 'Voluptatum explicabo soluta sed facere. Nobis eos similique sit et ut mollitia dolorum. Nemo tempora iste odit eum ratione quo et. Molestiae inventore incidunt excepturi similique nesciunt temporibus.', 2022, '7531', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(242, 4, 3, 'Culpa eveniet ab omnis quidem veniam.', 'documentos/doc1.pdf', 'Eligendi nam sed hic aut nam illum enim. Omnis nam vel porro est totam et eos.', 2020, '3669', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(243, 3, 5, 'Natus dolorum distinctio veniam id doloribus.', 'documentos/doc2.pdf', 'Possimus soluta animi voluptatem est nobis. Voluptas voluptate quae et adipisci. In veniam sunt et veniam.', 2026, '3333', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(244, 2, 4, 'Consequuntur labore sed laborum.', 'documentos/doc3.pdf', 'Eius cupiditate cum mollitia sit. Aut voluptas soluta aut dolores est et assumenda aut. Quidem enim deleniti facilis voluptates.', 2022, '8271', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(245, 1, 2, 'Numquam qui voluptatem tempore tempore.', 'documentos/doc4.pdf', 'Nisi vitae rerum natus in. Ut quidem fuga eligendi ipsam quis rerum. Nemo repellendus eos vitae culpa debitis. Rem voluptas recusandae quaerat laboriosam in aperiam qui maiores.', 2026, '7149', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(246, 2, 5, 'Sit atque totam minima rerum mollitia.', 'documentos/doc5.pdf', 'Dolor at quibusdam debitis voluptas. Velit nam veniam illum maxime porro. Iste magnam quaerat ducimus et est culpa quia repellendus.', 2026, '5578', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(247, 4, 2, 'Rerum eius nostrum nobis voluptas animi.', 'documentos/doc6.pdf', 'Dolores totam voluptates eligendi ut facilis dolor sed. Rerum quos rerum ut corrupti tenetur et. Et adipisci eum odio eum.', 2018, '4925', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(248, 1, 4, 'Nesciunt corporis optio quod dolores illo.', 'documentos/doc7.pdf', 'Aut mollitia eos quasi officia hic. Repellendus saepe repudiandae minus voluptas reiciendis. Odit ab qui recusandae nobis iusto et.', 2023, '9765', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(249, 3, 3, 'Ratione inventore aut facere quia molestiae.', 'documentos/doc8.pdf', 'Aperiam voluptate repellendus suscipit rerum. Ex ad vitae rem. Optio vel quia minus illo.', 2018, '2814', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(250, 2, 1, 'Consequatur quis et autem.', 'documentos/doc9.pdf', 'Mollitia id voluptatem dolores. Porro est dolor blanditiis soluta. Quidem occaecati a eum reprehenderit odio qui tempore. Ea et libero nemo.', 2021, '6945', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(251, 4, 4, 'Expedita mollitia nemo repellendus.', 'documentos/doc0.pdf', 'Alias iusto quia hic veritatis fugiat eum commodi. Dignissimos sequi illum a modi. Fugit veniam consectetur inventore.', 2025, '9579', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(252, 1, 3, 'Doloribus ut doloremque.', 'documentos/doc1.pdf', 'Quia ut aut officia illo rem. Aut est numquam est quod facere est. Aut in consectetur quis maxime et voluptas.', 2018, '8753', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(253, 4, 4, 'Hic fugiat dicta occaecati.', 'documentos/doc2.pdf', 'Sed illum ea non vitae ut possimus earum. Odio ut cum et fugiat et voluptatem neque. Soluta sit dolorem consectetur nobis quod nesciunt. Quidem quis ullam quia non autem blanditiis.', 2018, '714', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(254, 2, 3, 'Consequatur occaecati odio magni recusandae.', 'documentos/doc3.pdf', 'Rerum ut dicta nostrum consequatur. Voluptatem sint laboriosam est. Nesciunt id voluptatem facere maxime aspernatur.', 2020, '7919', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(255, 2, 4, 'Ratione sunt illum in id.', 'documentos/doc4.pdf', 'Eveniet aspernatur vel omnis at. Rerum et sed maiores et. Sunt velit non non eveniet officia blanditiis. Fugiat iusto consequuntur non atque et harum voluptas.', 2019, '7305', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(256, 1, 1, 'Nostrum ut et atque nam.', 'documentos/doc5.pdf', 'Est quia amet saepe atque dolores velit dolor. Porro velit nihil aliquam eligendi adipisci laborum.', 2025, '3995', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(257, 2, 3, 'Aperiam voluptatem et.', 'documentos/doc6.pdf', 'Incidunt dolores repudiandae exercitationem porro quaerat consequatur quo. Temporibus reprehenderit sint ea atque deleniti. Dolorem ea qui et adipisci. Culpa vitae error qui pariatur ut.', 2020, '949', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(258, 3, 4, 'Itaque illum a.', 'documentos/doc7.pdf', 'Nobis ut nihil eum. Fuga et eveniet quia fugiat quod nihil quia. Optio quia temporibus repellendus optio. Suscipit aliquam repellat quas adipisci dolor. Ut maxime consequuntur dolor dolore optio beatae.', 2019, '5115', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(259, 5, 1, 'Totam laboriosam aut.', 'documentos/doc8.pdf', 'Odio consequatur ipsum at earum consequatur optio. Animi rerum voluptatem voluptatibus minima deleniti. Itaque suscipit quia sunt. Est aut id non placeat.', 2021, '1085', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(260, 2, 5, 'Nostrum dolor eaque officiis.', 'documentos/doc9.pdf', 'Fugiat non qui vitae deserunt modi. Odio ut porro laudantium et magnam. Repellendus neque qui ut a. Non voluptatum in molestiae delectus sit.', 2020, '1754', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(261, 3, 3, 'Aut est quo temporibus odio minus.', 'documentos/doc0.pdf', 'Architecto fugiat in saepe. Pariatur qui nisi unde cupiditate labore. Eum quisquam fugiat ipsam numquam non quia.', 2026, '6710', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(262, 5, 2, 'Laboriosam deleniti libero quos.', 'documentos/doc1.pdf', 'Ex a non necessitatibus neque sunt eveniet. Ut neque et praesentium doloribus ut aut. Asperiores quo fugiat ea distinctio consequatur. Voluptatem eum ut est adipisci.', 2026, '6623', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(263, 1, 2, 'Rerum corporis similique reiciendis quis provident.', 'documentos/doc2.pdf', 'Unde repellendus et sapiente repellat sed vitae. Et neque quam ea laboriosam sit dicta. Fugiat natus non dolores porro amet quos architecto.', 2023, '3905', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(264, 5, 3, 'Sit incidunt esse voluptatem.', 'documentos/doc3.pdf', 'Eum ipsa labore aut impedit in accusamus et. Quae sit delectus atque voluptatem. Facilis ut et rerum qui ut nemo voluptas. Et alias sed mollitia ut ut est asperiores. Ducimus vitae et voluptas reiciendis quia assumenda.', 2019, '9520', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(265, 1, 4, 'Facilis doloremque qui nam.', 'documentos/doc4.pdf', 'Sapiente quibusdam suscipit nulla vitae officiis. Sunt vel occaecati nisi est libero ducimus. Sunt et velit dolor.', 2018, '9251', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(266, 2, 1, 'Eligendi officiis sed eum dignissimos.', 'documentos/doc5.pdf', 'Est placeat pariatur voluptatem aut recusandae. Ex vero alias enim qui et eum placeat. Atque omnis occaecati velit rerum. Et deleniti velit amet facilis molestiae. Sapiente neque illo nisi rerum rem ab.', 2022, '5904', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(267, 2, 5, 'Distinctio dolor molestias veniam eos modi.', 'documentos/doc6.pdf', 'Est dolorum magni fugit perspiciatis cumque tempora ratione. Maxime in eius quis doloribus. Culpa vitae aperiam quos. Occaecati quis esse voluptate quia vel iste.', 2020, '8911', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(268, 3, 1, 'Est quia voluptatibus nobis.', 'documentos/doc7.pdf', 'Hic earum voluptas exercitationem eum at voluptatem qui. Eveniet qui modi ut qui temporibus similique doloremque. In cumque consequatur iusto quos vel. Fugit nulla debitis ullam qui quibusdam.', 2022, '1873', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(269, 3, 3, 'Cum necessitatibus dolores esse.', 'documentos/doc8.pdf', 'Repudiandae est dicta quis reiciendis nihil. Dicta eum laborum labore dolor mollitia architecto enim. Repudiandae id blanditiis quasi tenetur. Nulla suscipit quia esse qui.', 2020, '1782', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(270, 1, 4, 'Ut aut nesciunt.', 'documentos/doc9.pdf', 'Et qui quia et quia. Praesentium doloribus rerum placeat laudantium facere exercitationem est.', 2025, '2668', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(271, 4, 3, 'Dolor dolore dolorem ipsum facere.', 'documentos/doc0.pdf', 'Ullam nemo rem eos eos qui. Omnis voluptates vero fugit assumenda inventore voluptatibus nobis earum. Assumenda sint magni molestiae minima.', 2019, '8548', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(272, 1, 3, 'Voluptates incidunt omnis.', 'documentos/doc1.pdf', 'Consequatur tempore animi aut sunt hic exercitationem. Aut ut at placeat quia. Iure deserunt incidunt id beatae.', 2022, '2082', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(273, 5, 3, 'Aut vel et.', 'documentos/doc2.pdf', 'Aut cupiditate est itaque enim. Ad nisi qui explicabo officiis. Voluptate numquam necessitatibus illum qui. Nostrum sint et delectus minus laboriosam et.', 2018, '1933', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(274, 3, 5, 'Esse aut rerum est dolor corrupti.', 'documentos/doc3.pdf', 'Qui hic ut delectus architecto temporibus aut odio qui. Pariatur cum itaque magni sit enim alias aut pariatur. Similique consectetur ut ipsam.', 2020, '3094', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(275, 2, 4, 'Aut optio quos officiis.', 'documentos/doc4.pdf', 'Eum fuga recusandae dolor aspernatur ea facere. Velit cumque sequi quia illo voluptas. Voluptas sunt iste sed ipsum.', 2024, '28', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(276, 2, 1, 'Deserunt sit tempora voluptatem.', 'documentos/doc5.pdf', 'Et unde voluptatem consectetur non dolor. Quidem necessitatibus autem earum consectetur sit. Est architecto dolores veniam autem pariatur eius similique ipsa. At aut et debitis minus velit molestias inventore.', 2024, '82', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(277, 3, 5, 'Amet animi similique ratione.', 'documentos/doc6.pdf', 'At repudiandae et minima consequuntur neque asperiores in. Tempore harum est dolor fuga molestiae vero error consequatur. Natus accusantium sunt ea hic. Et fugit magnam dolor ut laboriosam dolorem.', 2019, '8718', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(278, 4, 4, 'Vitae quam recusandae.', 'documentos/doc7.pdf', 'Dignissimos quibusdam consequatur neque. Nulla quas occaecati magni non qui qui. Ullam aspernatur sed expedita omnis.', 2021, '6743', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(279, 3, 2, 'Autem iste veniam nam.', 'documentos/doc8.pdf', 'Natus quam qui maiores. Dolore iste maiores et voluptatem. In veniam reprehenderit ut quia. Et ad voluptatibus inventore minus.', 2023, '8408', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(280, 1, 4, 'Eos cumque dolor saepe.', 'documentos/doc9.pdf', 'Tempore est ipsa consequatur tempore eos numquam consequatur. Aut aut quaerat quo sequi provident quo. Ratione necessitatibus voluptatem ex adipisci.', 2024, '1894', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(281, 3, 5, 'Consequuntur inventore earum quibusdam.', 'documentos/doc0.pdf', 'Nulla quis voluptatem blanditiis. Veniam qui sequi illum qui doloremque qui. Dolores iusto eos alias quis nam.', 2025, '5508', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(282, 4, 1, 'Possimus explicabo hic voluptatem inventore.', 'documentos/doc1.pdf', 'Nihil molestias enim voluptatum consectetur. Inventore eos vero incidunt ipsa repellendus. Id ut quo sunt quia. Temporibus eos tenetur qui in deserunt.', 2018, '3006', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(283, 3, 5, 'Odit excepturi et ut quis.', 'documentos/doc2.pdf', 'Voluptas veritatis facere quasi quidem. Delectus sed sunt deserunt ipsam debitis qui. Omnis dolore provident et optio.', 2021, '8796', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(284, 1, 2, 'Tempora dolores vel veniam consequatur.', 'documentos/doc3.pdf', 'Optio voluptas sit aut porro delectus aliquid. Sit omnis aut quasi deleniti doloremque distinctio ratione id.', 2024, '1866', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(285, 4, 2, 'Voluptates sint voluptates qui in accusamus.', 'documentos/doc4.pdf', 'Dolores incidunt reprehenderit praesentium quia et quidem quam dolor. Quasi repellendus temporibus error rem dolores nihil. Voluptatem omnis ut dolorem rerum.', 2025, '2413', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(286, 2, 5, 'Totam modi facere sunt.', 'documentos/doc5.pdf', 'Laborum cum blanditiis excepturi nobis provident quisquam debitis. Minima cupiditate occaecati magnam labore corrupti porro unde. A eos voluptas inventore tempora est.', 2021, '8291', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(287, 5, 5, 'Aspernatur cupiditate ea saepe.', 'documentos/doc6.pdf', 'Ut quaerat repudiandae totam necessitatibus. Laboriosam ut numquam qui. Rerum aut quia ea voluptatem quia recusandae.', 2020, '4727', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(288, 5, 2, 'Atque sit libero ut quidem.', 'documentos/doc7.pdf', 'Assumenda aut suscipit esse repellat qui dolore et officia. Odio deleniti rerum libero incidunt qui. Et animi non et ea doloremque sunt assumenda.', 2020, '2352', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(289, 4, 2, 'Atque aut reprehenderit.', 'documentos/doc8.pdf', 'Perferendis cum nihil repellat ab ut modi. Et eos ex eos fugiat reiciendis eum ut. Voluptates quas enim sit ab iure tempore dicta.', 2026, '5950', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(290, 2, 1, 'Aliquid dolor nobis saepe nobis.', 'documentos/doc9.pdf', 'Hic ut rerum dolorum architecto aut repudiandae reprehenderit. Veritatis exercitationem explicabo doloremque repudiandae eos.', 2021, '6951', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(291, 5, 4, 'Tempore architecto ea quis inventore aperiam.', 'documentos/doc0.pdf', 'LXD es una herramienta de gestión de contenedores del sistema operativo Linux que permite crear y administrar contenedores de sistemas completos, ideal para entornos en la nube y servidores con múltiples aplicaciones, contrastando con Docker que se centra en contenedores de corta duración; sus principales características incluyen compatibilidad con todas las imágenes Linux, una API intuitiva, escalabilidad, aislamiento seguro, control sofisticado de recursos, soporte para múltiples backends de almacenamiento y redes, y acceso a hardware del host; entre sus ventajas destaca la eficiencia en el uso de recursos y la posibilidad de operar con sistemas operativos completos sin ocupar mucho espacio, aunque su principal inconveniente es la limitación a sistemas Linux; la instalación se realiza mediante snap, añadiendo el usuario al grupo lxd y configurando una red por defecto, mientras que la gestión de redes y almacenamiento se lleva a cabo mediante comandos de lxc que permiten crear, editar y aplicar perfiles, redes, ACL y volúmenes de almacenamiento con drivers como Btrfs, LVM o ZFS; las copias de seguridad se pueden realizar mediante instantáneas o exportaciones a archivos tar, y la restauración requiere detener las instancias que usan el volumen; la configuración de LXD abarca la creación de contenedores y máquinas virtuales, la asignación de límites de CPU, memoria, red y disco, la transferencia de archivos entre host y contenedores, y la creación de snapshots programados para garantizar la continuidad operativa; las máquinas virtuales se gestionan con comandos similares a los de los contenedores, pero se indica explícitamente el uso de la opción --vm y se pueden habilitar consolas gráficas con Spice, lo que permite instalar y probar aplicaciones como Apache en un entorno aislado; en conclusión, LXD ofrece una amplia gama de funcionalidades que permiten crear, gestionar y respaldar contenedores y máquinas virtuales con gran flexibilidad y eficiencia, convirtiéndolo en una herramienta poderosa para la administración de sistemas en red.', 2018, '6986', '2026-06-18 19:01:18', '2026-10-15 18:38:44'),
(292, 4, 1, 'Maxime dolore reiciendis.', 'documentos/doc1.pdf', 'Financiar iniciativas socioeducativas en las comunidades donde opera ArcelorMittal Acindar constituye el eje central de la Convocatoria Construir Comunidad 2025, cuyo objetivo es fortalecer el tejido comunitario y promover la educación, la inclusión social y la equidad de género y diversidad mediante proyectos que utilicen ciencia y tecnología; para ello, la convocatoria está abierta a instituciones de nivel superior, organizaciones de la sociedad civil y municipios que desarrollen sus acciones en las localidades de Villa Mercedes (San Luis), Villa Constitución (Santa Fe), San Nicolás y La Matanza (Buenos Aires), y la fecha límite de presentación es el 24 de abril de 2025 por correo electrónico a fundacion.acindar@arcelormittal.com.ar, mientras que los subsidios se otorgan con un monto máximo de $8 000 000 para universidades e instituciones terciarias y $4 000 000 para organizaciones sociales y municipios, y serán evaluados por el consejo de la fundación según criterios de factibilidad, razonabilidad financiera, pertinencia, alineación estratégica con los objetivos educativos, de inclusión, de CTIM, de innovación, de género y diversidad, de localía, de relación con la fundación y la compañía, de participación comunitaria, e impacto y sostenibilidad; los proyectos deben presentarse en el formulario oficial sin alterar su formato, incluir únicamente costos directos, acompañarse de un video de un minuto, contar con la firma y sello de la autoridad competente, ejecutarse íntegramente durante 2025 y cumplir con requisitos legales como personería jurídica, registro y balances al día, además de demostrar capacidad técnica y haber rendido cuentas en convocatorias anteriores; una vez aprobados, los beneficiarios enviarán el proyecto impreso y firmado por correo postal, la documentación de estatuto, inscripción AFIP y datos bancarios para el depósito, y deberán rendir gastos el 17 de octubre de 2025 y presentar informe final con imágenes o videos el 12 de diciembre de 2025, mientras que la fundación garantiza la confidencialidad del material recibido, declara definitiva e inapelable su decisión, y podrá difundir públicamente los nombres de los organismos beneficiados, asegurando que los proyectos mantengan indicadores claros de éxito, mecanismos de monitoreo y evaluación, y planes de sostenibilidad financiera, social, educativa y ambiental para garantizar su continuidad y replicabilidad.', 2022, '1373', '2026-06-18 19:01:18', '2026-10-15 18:38:28'),
(293, 2, 2, 'Corporis ut aut maiores eum ad.', 'documentos/doc2.pdf', 'El cronograma establece que la unidad 2 de Modelado 3D Básico de la Diplomatura en Impresión y Modelado 3D, con sede en Villa Mercedes, se desarrollará entre el 30 de abril y el 27 de mayo, iniciando la teoría el 1 de mayo de 2026 y la práctica el 6 de mayo, mientras que la unidad 3 de Impresión 3D comenzará el 5 de mayo con la última fecha de entrega de TPS U1 fijada para esa misma fecha; se indica además que los contenidos de las sedes San Luis y Quines deben entregarse el mismo día señalado o posteriormente, nunca antes, y que el feriado del 5 de mayo afecta la programación, por lo que se incluyen fechas específicas para parciales teóricos y prácticos, consultas y revisiones de la unidad 1, así como la entrega de los trabajos prácticos TP1, TP2 y TP3, culminando con un final evaluativo que debe estar completo y aprobado, y se añaden actividades de simulación de pedidos y diferentes rubros de impresión 3D para reforzar el aprendizaje a lo largo de las semanas 2, 3 y 4.', 2019, '189', '2026-06-18 19:01:18', '2026-10-15 18:38:02'),
(294, 5, 4, 'Enim id consectetur aut minus harum.', 'documentos/doc3.pdf', 'LXD, el demonio de contenedores de Linux, permite virtualizar sistemas operativos completos mediante contenedores de tipo LXC y máquinas virtuales, ofreciendo un rendimiento superior al de las VMs tradicionales y una gestión sencilla a través de una API clara y una línea de comandos intuitiva; sus principales características incluyen compatibilidad con todas las imágenes Linux, escalabilidad, aislamiento seguro, control sofisticado de recursos, soporte para múltiples backends de almacenamiento y redes, y acceso a dispositivos de hardware como USB y GPU, mientras que sus ventajas se centran en la eficiencia de recursos y la facilidad de administración desde una sola terminal, aunque su limitación es la imposibilidad de crear contenedores con sistemas operativos distintos a Linux; la instalación se realiza mediante snap, añadiendo el usuario al grupo lxd y configurando la red y el almacenamiento, preferentemente con Btrfs por su resistencia a la corrupción, y se pueden crear grupos de almacenamiento, volúmenes de tipo filesystem o block, y gestionar su tamaño y ubicación; la gestión de redes implica la creación y edición de redes y perfiles, la aplicación de ACLs y la asignación de redes a contenedores mediante perfiles, mientras que la gestión de almacenamiento abarca la creación de volúmenes, su adjunto a instancias, la realización de copias de seguridad mediante instantáneas o exportaciones a archivos tar.gz, y la restauración de volúmenes o instantáneas; la configuración de LXD incluye comandos básicos para lanzar, listar, iniciar, detener y eliminar contenedores y VMs, así como la edición de archivos y la transferencia de datos entre host y contenedores; se pueden establecer límites de CPU, memoria, red y disco tanto al crear como después de la creación de instancias, lo que resulta útil para evitar que un contenedor monopolice recursos y afecte a otros; las instantáneas de instancias permiten crear puntos de restauración, programar snapshots diarios, y restaurar estados anteriores, mientras que la gestión de máquinas virtuales sigue la misma lógica que los contenedores pero con la opción de consola VGA y soporte para entornos gráficos mediante Spice, lo que facilita la administración de VMs con interfaces gráficas; en conjunto, LXD ofrece una plataforma robusta y flexible para la creación, configuración y mantenimiento de contenedores y máquinas virtuales, con amplias opciones de personalización y respaldo que la convierten en una herramienta valiosa para entornos de desarrollo, pruebas y producción, aunque su complejidad y la gran cantidad de parámetros disponibles pueden requerir tiempo de aprendizaje para aprovecharla al máximo.', 2020, '5864', '2026-06-18 19:01:18', '2026-10-15 20:59:56'),
(295, 2, 3, 'Consequatur omnis officiis aliquid in quae.', 'documentos/doc4.pdf', 'Et quia numquam accusamus dolorem quos ratione voluptas. Autem ea et voluptas omnis ipsum eum omnis consequatur. Quia neque asperiores ratione ipsam in rerum. Aut non quisquam quis. Ut quod sed minima neque dicta.', 2019, '122', '2026-06-18 19:01:18', '2026-06-18 19:01:18'),
(296, 2, 5, 'Eius est saepe dolor.', 'documentos/doc5.pdf', 'Financiar iniciativas socioeducativas en las comunidades donde opera ArcelorMittal Acindar se materializa a través de la Convocatoria Construir Comunidad 2025, cuyo objetivo es fortalecer el tejido local, promover la educación, la inclusión social y la equidad de género mediante proyectos que integren ciencia, tecnología, ingeniería y matemáticas (CTIM). La convocatoria, abierta a universidades, instituciones terciarias, organizaciones de la sociedad civil y municipios, acepta propuestas para Villa Mercedes, Villa Constitución, San Nicolás y La Matanza, con fecha límite de presentación el 24 de abril de 2025 y financiamiento máximo de $8 millones para instituciones de nivel superior y $4 millones para organizaciones sociales o municipales. Los proyectos deben presentar formulario completo, presupuesto de costos directos, video explicativo de un minuto y documentación legal, y serán evaluados según criterios de factibilidad, razonabilidad financiera, pertinencia, alineación estratégica, género y diversidad, localía, relación con la fundación, participación comunitaria, impacto y sostenibilidad. Tras la adjudicación, se exige rendición de gastos el 17 de octubre y informe final el 12 de diciembre de 2025, garantizando confidencialidad y reconocimiento público de los beneficiarios.', 2025, '5129', '2026-06-18 19:01:18', '2026-10-19 14:15:31'),
(297, 2, 1, 'hoja de excel rerum iusto eum quis voluptas.', 'documentos/doc6.pdf', 'El texto presenta el cronograma de la Unidad 2 “Modelado 3D Básico” de la Diplomatura en Impresión y Modelado 3D, impartida en la sede de Villa Mercedes entre el 30 de abril y el 27 de mayo de 2026; detalla las fechas de teoría y práctica para cada semana, los feriados y la última fecha de entrega de trabajos, subrayando que los contenidos deben entregarse el día indicado o después, y establece los objetivos de completar los ejercicios parciales y el evaluativo final para aprobar la unidad.', 2025, '8034', '2026-06-18 19:01:18', '2026-10-15 15:09:42'),
(298, 3, 4, 'Fuga praesentium modi aliquid nihil sunt.', 'documentos/doc7.pdf', 'LXD es una herramienta de gestión de contenedores del sistema operativo Linux que permite crear y administrar contenedores completos y máquinas virtuales, ofreciendo un uso más eficiente de los recursos al compartirlos entre distintas aplicaciones y sistemas operativos; sus principales características incluyen compatibilidad con todas las imágenes de Linux, una API y cliente de línea de comandos intuitivos, escalabilidad para gestionar contenedores en múltiples entornos, seguridad mediante aislamiento de recursos, control sofisticado de CPU, memoria, red y almacenamiento, soporte para diversos back‑ends de almacenamiento como Btrfs y ZFS, gestión de redes mediante puentes y túneles, y acceso a hardware como USB y GPU cuando la configuración lo permite; entre sus ventajas destaca la posibilidad de controlar todo desde la terminal y ejecutar sistemas operativos completos sin ocupar mucho espacio, mientras que su principal limitación es la restricción a contenedores Linux; el proyecto descrito muestra cómo se instalan y configuran LXD y sus redes por defecto o personalizadas mediante perfiles, cómo se gestionan grupos y volúmenes de almacenamiento con Btrfs, incluyendo la creación, redimensionado y migración de volúmenes, así como la realización de copias de seguridad y restauraciones mediante instantáneas y archivos de exportación; se detallan los comandos básicos para crear, listar, iniciar, detener y eliminar contenedores y máquinas virtuales, limitar recursos como CPU, memoria, ancho de banda y disco, transferir archivos entre host y contenedores, y gestionar instantáneas programadas o manuales, permitiendo restaurar estados específicos; finalmente, la conclusión subraya que LXD brinda una amplia gama de opciones para crear, editar y gestionar entornos virtualizados como si fueran máquinas físicas, demostrando ser una herramienta útil y eficiente a pesar de la imposibilidad de cubrir todas sus funcionalidades en un solo proyecto.', 2019, '2986', '2026-06-18 19:01:18', '2026-10-15 20:59:33'),
(299, 3, 3, 'Dolorum quo quod.', 'documentos/pruebas-ai.pdf', 'La evaluación del proyecto de la convocatoria Construir Comunidad 2025 debe realizarse en relación con los objetivos y resultados esperados, sirviendo al equipo o institución ejecutora para conocer los logros y perfeccionar la acción, considerando tanto los cambios en las personas destinatarias y la situación‑problema de la comunidad como las transformaciones en la institución, el equipo de trabajo y otros grupos involucrados, por lo que se solicita completar información institucional y del responsable, describir los objetivos alcanzados y los no alcanzados con sus causas, detallar los resultados cuantitativos esperados y los realmente obtenidos, identificar efectos inesperados y sus motivos, indicar el número de beneficiarios desglosado por género, analizar las actividades previstas versus las realizadas explicando posibles diferencias, describir la sostenibilidad e impacto futuro del proyecto y las actividades que continuarán, evaluar el vínculo con Fundación Acindar durante la propuesta e implementación, y adjuntar material documental como fotos, videos, encuestas, entrevistas y trabajos de los destinatarios.', 2026, '4717', '2026-06-18 19:01:18', '2026-10-15 18:27:51'),
(300, 5, 2, 'Voluptatem laborum ducimus.', 'documentos/doc1.pdf', 'Financiar iniciativas socioeducativas en las comunidades donde opera ArcelorMittal Acindar mediante la Convocatoria Construir Comunidad 2025, que busca fortalecer el tejido local, impulsar la educación, la inclusión de género y diversidad, y promover el uso de CTIM; pueden postular instituciones de nivel superior, organizaciones civiles y municipios con proyectos en Villa Mercedes, Villa Constitución, San Nicolás y La Matanza, con fecha límite 24 abril 2025 y subsidios de hasta $8 000 000 para universidades y $4 000 000 para organizaciones sociales, siempre que presenten formulario completo, video de un minuto, presupuesto de costos directos y aval institucional; la evaluación considerará factibilidad, pertinencia, alineación estratégica, impacto, sostenibilidad financiera, social, educativa y ambiental, y los resultados se comunicarán dos meses después del cierre.', 2022, '1235', '2026-06-18 19:01:18', '2026-10-19 17:22:51');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` varchar(255) NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` smallint(5) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2026_05_20_174200_create_tipo_documentos_table', 2),
(5, '2026_05_20_174201_create_categorias_table', 3),
(6, '2026_05_20_174202_create_documentos_table', 3),
(7, '2026_05_20_174503_create_permission_tables', 3),
(8, '2026_05_20_180129_create_tag_tables', 4),
(9, '2026_05_20_180142_migrate_documentos_json_tags_to_spatie_tags', 4),
(10, '2026_05_20_182050_drop_tipo_id_from_categorias_table', 5),
(11, '2026_10_14_122206_create_ai_providers_table', 6),
(12, '2026_10_14_134454_add_deepseek_ai_provider', 7),
(13, '2026_10_14_150026_add_zai_ai_provider', 8),
(14, '2026_10_21_144422_update_metadata_fields_on_categorias_and_tipo_documentos_table', 9);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(1, 'App\\Models\\User', 1),
(2, 'App\\Models\\User', 2),
(2, 'App\\Models\\User', 5),
(3, 'App\\Models\\User', 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'ViewAny:Categoria', 'web', '2026-05-20 20:52:33', '2026-05-20 20:52:33'),
(2, 'View:Categoria', 'web', '2026-05-20 20:52:33', '2026-05-20 20:52:33'),
(3, 'Create:Categoria', 'web', '2026-05-20 20:52:33', '2026-05-20 20:52:33'),
(4, 'Update:Categoria', 'web', '2026-05-20 20:52:33', '2026-05-20 20:52:33'),
(5, 'Delete:Categoria', 'web', '2026-05-20 20:52:33', '2026-05-20 20:52:33'),
(6, 'DeleteAny:Categoria', 'web', '2026-05-20 20:52:33', '2026-05-20 20:52:33'),
(7, 'Restore:Categoria', 'web', '2026-05-20 20:52:33', '2026-05-20 20:52:33'),
(8, 'ForceDelete:Categoria', 'web', '2026-05-20 20:52:33', '2026-05-20 20:52:33'),
(9, 'ForceDeleteAny:Categoria', 'web', '2026-05-20 20:52:33', '2026-05-20 20:52:33'),
(10, 'RestoreAny:Categoria', 'web', '2026-05-20 20:52:33', '2026-05-20 20:52:33'),
(11, 'Replicate:Categoria', 'web', '2026-05-20 20:52:33', '2026-05-20 20:52:33'),
(12, 'Reorder:Categoria', 'web', '2026-05-20 20:52:33', '2026-05-20 20:52:33'),
(13, 'ViewAny:Documento', 'web', '2026-05-20 20:52:33', '2026-05-20 20:52:33'),
(14, 'View:Documento', 'web', '2026-05-20 20:52:33', '2026-05-20 20:52:33'),
(15, 'Create:Documento', 'web', '2026-05-20 20:52:33', '2026-05-20 20:52:33'),
(16, 'Update:Documento', 'web', '2026-05-20 20:52:33', '2026-05-20 20:52:33'),
(17, 'Delete:Documento', 'web', '2026-05-20 20:52:33', '2026-05-20 20:52:33'),
(18, 'DeleteAny:Documento', 'web', '2026-05-20 20:52:33', '2026-05-20 20:52:33'),
(19, 'Restore:Documento', 'web', '2026-05-20 20:52:33', '2026-05-20 20:52:33'),
(20, 'ForceDelete:Documento', 'web', '2026-05-20 20:52:33', '2026-05-20 20:52:33'),
(21, 'ForceDeleteAny:Documento', 'web', '2026-05-20 20:52:33', '2026-05-20 20:52:33'),
(22, 'RestoreAny:Documento', 'web', '2026-05-20 20:52:33', '2026-05-20 20:52:33'),
(23, 'Replicate:Documento', 'web', '2026-05-20 20:52:33', '2026-05-20 20:52:33'),
(24, 'Reorder:Documento', 'web', '2026-05-20 20:52:33', '2026-05-20 20:52:33'),
(25, 'ViewAny:Role', 'web', '2026-05-20 20:52:33', '2026-05-20 20:52:33'),
(26, 'View:Role', 'web', '2026-05-20 20:52:33', '2026-05-20 20:52:33'),
(27, 'Create:Role', 'web', '2026-05-20 20:52:33', '2026-05-20 20:52:33'),
(28, 'Update:Role', 'web', '2026-05-20 20:52:33', '2026-05-20 20:52:33'),
(29, 'Delete:Role', 'web', '2026-05-20 20:52:33', '2026-05-20 20:52:33'),
(30, 'DeleteAny:Role', 'web', '2026-05-20 20:52:33', '2026-05-20 20:52:33'),
(31, 'Restore:Role', 'web', '2026-05-20 20:52:33', '2026-05-20 20:52:33'),
(32, 'ForceDelete:Role', 'web', '2026-05-20 20:52:33', '2026-05-20 20:52:33'),
(33, 'ForceDeleteAny:Role', 'web', '2026-05-20 20:52:33', '2026-05-20 20:52:33'),
(34, 'RestoreAny:Role', 'web', '2026-05-20 20:52:33', '2026-05-20 20:52:33'),
(35, 'Replicate:Role', 'web', '2026-05-20 20:52:33', '2026-05-20 20:52:33'),
(36, 'Reorder:Role', 'web', '2026-05-20 20:52:33', '2026-05-20 20:52:33'),
(37, 'ViewAny:TipoDocumento', 'web', '2026-05-20 20:52:33', '2026-05-20 20:52:33'),
(38, 'View:TipoDocumento', 'web', '2026-05-20 20:52:33', '2026-05-20 20:52:33'),
(39, 'Create:TipoDocumento', 'web', '2026-05-20 20:52:33', '2026-05-20 20:52:33'),
(40, 'Update:TipoDocumento', 'web', '2026-05-20 20:52:33', '2026-05-20 20:52:33'),
(41, 'Delete:TipoDocumento', 'web', '2026-05-20 20:52:33', '2026-05-20 20:52:33'),
(42, 'DeleteAny:TipoDocumento', 'web', '2026-05-20 20:52:33', '2026-05-20 20:52:33'),
(43, 'Restore:TipoDocumento', 'web', '2026-05-20 20:52:33', '2026-05-20 20:52:33'),
(44, 'ForceDelete:TipoDocumento', 'web', '2026-05-20 20:52:33', '2026-05-20 20:52:33'),
(45, 'ForceDeleteAny:TipoDocumento', 'web', '2026-05-20 20:52:33', '2026-05-20 20:52:33'),
(46, 'RestoreAny:TipoDocumento', 'web', '2026-05-20 20:52:33', '2026-05-20 20:52:33'),
(47, 'Replicate:TipoDocumento', 'web', '2026-05-20 20:52:33', '2026-05-20 20:52:33'),
(48, 'Reorder:TipoDocumento', 'web', '2026-05-20 20:52:33', '2026-05-20 20:52:33'),
(49, 'View:DocumentosStats', 'web', '2026-05-20 20:52:33', '2026-05-20 20:52:33'),
(50, 'ViewAny:Permission', 'web', '2026-05-20 21:23:05', '2026-05-20 21:23:05'),
(51, 'View:Permission', 'web', '2026-05-20 21:23:05', '2026-05-20 21:23:05'),
(52, 'Create:Permission', 'web', '2026-05-20 21:23:05', '2026-05-20 21:23:05'),
(53, 'Update:Permission', 'web', '2026-05-20 21:23:05', '2026-05-20 21:23:05'),
(54, 'Delete:Permission', 'web', '2026-05-20 21:23:05', '2026-05-20 21:23:05'),
(55, 'DeleteAny:Permission', 'web', '2026-05-20 21:23:05', '2026-05-20 21:23:05'),
(56, 'Restore:Permission', 'web', '2026-05-20 21:23:05', '2026-05-20 21:23:05'),
(57, 'ForceDelete:Permission', 'web', '2026-05-20 21:23:05', '2026-05-20 21:23:05'),
(58, 'ForceDeleteAny:Permission', 'web', '2026-05-20 21:23:05', '2026-05-20 21:23:05'),
(59, 'RestoreAny:Permission', 'web', '2026-05-20 21:23:05', '2026-05-20 21:23:05'),
(60, 'Replicate:Permission', 'web', '2026-05-20 21:23:05', '2026-05-20 21:23:05'),
(61, 'Reorder:Permission', 'web', '2026-05-20 21:23:05', '2026-05-20 21:23:05'),
(62, 'ViewAny:User', 'web', '2026-05-20 21:23:05', '2026-05-20 21:23:05'),
(63, 'View:User', 'web', '2026-05-20 21:23:05', '2026-05-20 21:23:05'),
(64, 'Create:User', 'web', '2026-05-20 21:23:05', '2026-05-20 21:23:05'),
(65, 'Update:User', 'web', '2026-05-20 21:23:05', '2026-05-20 21:23:05'),
(66, 'Delete:User', 'web', '2026-05-20 21:23:05', '2026-05-20 21:23:05'),
(67, 'DeleteAny:User', 'web', '2026-05-20 21:23:05', '2026-05-20 21:23:05'),
(68, 'Restore:User', 'web', '2026-05-20 21:23:05', '2026-05-20 21:23:05'),
(69, 'ForceDelete:User', 'web', '2026-05-20 21:23:05', '2026-05-20 21:23:05'),
(70, 'ForceDeleteAny:User', 'web', '2026-05-20 21:23:05', '2026-05-20 21:23:05'),
(71, 'RestoreAny:User', 'web', '2026-05-20 21:23:05', '2026-05-20 21:23:05'),
(72, 'Replicate:User', 'web', '2026-05-20 21:23:05', '2026-05-20 21:23:05'),
(73, 'Reorder:User', 'web', '2026-05-20 21:23:05', '2026-05-20 21:23:05'),
(74, 'ViewAny:AiProvider', 'web', '2026-10-15 18:56:02', '2026-10-15 18:56:02'),
(75, 'View:AiProvider', 'web', '2026-10-15 18:56:02', '2026-10-15 18:56:02'),
(76, 'Create:AiProvider', 'web', '2026-10-15 18:56:02', '2026-10-15 18:56:02'),
(77, 'Update:AiProvider', 'web', '2026-10-15 18:56:02', '2026-10-15 18:56:02'),
(78, 'Delete:AiProvider', 'web', '2026-10-15 18:56:02', '2026-10-15 18:56:02'),
(79, 'DeleteAny:AiProvider', 'web', '2026-10-15 18:56:02', '2026-10-15 18:56:02'),
(80, 'Restore:AiProvider', 'web', '2026-10-15 18:56:02', '2026-10-15 18:56:02'),
(81, 'ForceDelete:AiProvider', 'web', '2026-10-15 18:56:02', '2026-10-15 18:56:02'),
(82, 'ForceDeleteAny:AiProvider', 'web', '2026-10-15 18:56:02', '2026-10-15 18:56:02'),
(83, 'RestoreAny:AiProvider', 'web', '2026-10-15 18:56:02', '2026-10-15 18:56:02'),
(84, 'Replicate:AiProvider', 'web', '2026-10-15 18:56:02', '2026-10-15 18:56:02'),
(85, 'Reorder:AiProvider', 'web', '2026-10-15 18:56:02', '2026-10-15 18:56:02'),
(86, 'ViewAny:Tag', 'web', '2026-10-15 18:56:02', '2026-10-15 18:56:02'),
(87, 'View:Tag', 'web', '2026-10-15 18:56:02', '2026-10-15 18:56:02'),
(88, 'Create:Tag', 'web', '2026-10-15 18:56:02', '2026-10-15 18:56:02'),
(89, 'Update:Tag', 'web', '2026-10-15 18:56:02', '2026-10-15 18:56:02'),
(90, 'Delete:Tag', 'web', '2026-10-15 18:56:02', '2026-10-15 18:56:02'),
(91, 'DeleteAny:Tag', 'web', '2026-10-15 18:56:02', '2026-10-15 18:56:02'),
(92, 'Restore:Tag', 'web', '2026-10-15 18:56:02', '2026-10-15 18:56:02'),
(93, 'ForceDelete:Tag', 'web', '2026-10-15 18:56:02', '2026-10-15 18:56:02'),
(94, 'ForceDeleteAny:Tag', 'web', '2026-10-15 18:56:02', '2026-10-15 18:56:02'),
(95, 'RestoreAny:Tag', 'web', '2026-10-15 18:56:02', '2026-10-15 18:56:02'),
(96, 'Replicate:Tag', 'web', '2026-10-15 18:56:02', '2026-10-15 18:56:02'),
(97, 'Reorder:Tag', 'web', '2026-10-15 18:56:02', '2026-10-15 18:56:02');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'super_admin', 'web', '2026-05-20 20:52:33', '2026-05-20 20:52:33'),
(2, 'usuario-test', 'web', '2026-06-18 16:31:39', '2026-06-18 16:31:39'),
(3, 'admines', 'web', '2026-06-18 17:38:42', '2026-06-18 17:38:42');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `role_has_permissions`
--

INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 1),
(2, 3),
(3, 1),
(3, 3),
(4, 1),
(4, 3),
(5, 1),
(5, 3),
(6, 1),
(6, 3),
(7, 1),
(7, 3),
(8, 1),
(8, 3),
(9, 1),
(9, 3),
(10, 1),
(10, 3),
(11, 1),
(11, 3),
(12, 1),
(12, 3),
(13, 1),
(13, 2),
(13, 3),
(14, 1),
(14, 3),
(15, 1),
(15, 3),
(16, 1),
(16, 3),
(17, 1),
(17, 3),
(18, 1),
(18, 3),
(19, 1),
(19, 3),
(20, 1),
(20, 3),
(21, 1),
(21, 3),
(22, 1),
(22, 3),
(23, 1),
(23, 3),
(24, 1),
(24, 3),
(25, 1),
(26, 1),
(27, 1),
(28, 1),
(29, 1),
(30, 1),
(31, 1),
(32, 1),
(33, 1),
(34, 1),
(35, 1),
(36, 1),
(37, 1),
(37, 2),
(37, 3),
(38, 1),
(38, 3),
(39, 1),
(39, 3),
(40, 1),
(40, 3),
(41, 1),
(41, 3),
(42, 1),
(42, 3),
(43, 1),
(43, 3),
(44, 1),
(44, 3),
(45, 1),
(45, 3),
(46, 1),
(46, 3),
(47, 1),
(47, 3),
(48, 1),
(48, 3),
(49, 1),
(50, 1),
(50, 2),
(51, 1),
(52, 1),
(53, 1),
(54, 1),
(55, 1),
(56, 1),
(57, 1),
(58, 1),
(59, 1),
(60, 1),
(61, 1),
(62, 1),
(63, 1),
(64, 1),
(65, 1),
(66, 1),
(67, 1),
(68, 1),
(69, 1),
(70, 1),
(71, 1),
(72, 1),
(73, 1),
(74, 1),
(75, 1),
(76, 1),
(77, 1),
(78, 1),
(79, 1),
(80, 1),
(81, 1),
(82, 1),
(83, 1),
(84, 1),
(85, 1),
(86, 1),
(87, 1),
(88, 1),
(89, 1),
(90, 1),
(91, 1),
(92, 1),
(93, 1),
(94, 1),
(95, 1),
(96, 1),
(97, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('33Wzgdj1xNWMko9ni0vEEXxT5aEnAv0qFdf6ZpDK', 1, '127.0.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiIwWmt1WUFRWU5Vc3VHaUNnR0NOcXkwUlJndHA4aEFDZFVtamh3eWxyIiwidXJsIjpbXSwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cLzEyNy4wLjAuMTo4MDAwXC8/cGFnZT0xIiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX0sImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjoxLCJwYXNzd29yZF9oYXNoX3dlYiI6IjI5MmMwNzdjODAyZTZkNTFmMmViYjdiODg2NmU1NWNlNTVlM2FhNjQ4MDY3Y2EwNWNhZDgyNTdjZDA0ZmRmMjgiLCJ0YWJsZXMiOnsiZjc0Yjc1YmU1ODM1NzYzMTMzNWI4YzZiMzFhMjEzMTRfY29sdW1ucyI6W3sidHlwZSI6ImNvbHVtbiIsIm5hbWUiOiJ0aXR1bG8iLCJsYWJlbCI6IlRcdTAwZWR0dWxvIiwiaXNIaWRkZW4iOmZhbHNlLCJpc1RvZ2dsZWQiOnRydWUsImlzVG9nZ2xlYWJsZSI6ZmFsc2UsImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI6bnVsbH0seyJ0eXBlIjoiY29sdW1uIiwibmFtZSI6Im51bWVybyIsImxhYmVsIjoiTlx1MDBmYW1lcm8iLCJpc0hpZGRlbiI6ZmFsc2UsImlzVG9nZ2xlZCI6dHJ1ZSwiaXNUb2dnbGVhYmxlIjpmYWxzZSwiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjpudWxsfSx7InR5cGUiOiJjb2x1bW4iLCJuYW1lIjoiYW5pbyIsImxhYmVsIjoiQVx1MDBmMW8iLCJpc0hpZGRlbiI6ZmFsc2UsImlzVG9nZ2xlZCI6dHJ1ZSwiaXNUb2dnbGVhYmxlIjpmYWxzZSwiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjpudWxsfSx7InR5cGUiOiJjb2x1bW4iLCJuYW1lIjoidGlwby5ub21icmUiLCJsYWJlbCI6IlRpcG8iLCJpc0hpZGRlbiI6ZmFsc2UsImlzVG9nZ2xlZCI6dHJ1ZSwiaXNUb2dnbGVhYmxlIjpmYWxzZSwiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjpudWxsfSx7InR5cGUiOiJjb2x1bW4iLCJuYW1lIjoiY2F0ZWdvcmlhLm5vbWJyZSIsImxhYmVsIjoiQ2F0ZWdvclx1MDBlZGEiLCJpc0hpZGRlbiI6ZmFsc2UsImlzVG9nZ2xlZCI6dHJ1ZSwiaXNUb2dnbGVhYmxlIjpmYWxzZSwiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjpudWxsfSx7InR5cGUiOiJjb2x1bW4iLCJuYW1lIjoiZGVzY3JpcGNpb24iLCJsYWJlbCI6IkRlc2NyaXBjaVx1MDBmM24iLCJpc0hpZGRlbiI6ZmFsc2UsImlzVG9nZ2xlZCI6dHJ1ZSwiaXNUb2dnbGVhYmxlIjpmYWxzZSwiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjpudWxsfV0sIjU3MzZhMzMyNjBmY2QzOWFhNzJjY2IzZmE4MDIxOWMyX2NvbHVtbnMiOlt7InR5cGUiOiJjb2x1bW4iLCJuYW1lIjoidGl0dWxvIiwibGFiZWwiOiJUXHUwMGVkdHVsbyIsImlzSGlkZGVuIjpmYWxzZSwiaXNUb2dnbGVkIjp0cnVlLCJpc1RvZ2dsZWFibGUiOmZhbHNlLCJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiOm51bGx9LHsidHlwZSI6ImNvbHVtbiIsIm5hbWUiOiJudW1lcm8iLCJsYWJlbCI6Ik5cdTAwZmFtZXJvIiwiaXNIaWRkZW4iOmZhbHNlLCJpc1RvZ2dsZWQiOnRydWUsImlzVG9nZ2xlYWJsZSI6ZmFsc2UsImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI6bnVsbH0seyJ0eXBlIjoiY29sdW1uIiwibmFtZSI6ImFuaW8iLCJsYWJlbCI6IkFcdTAwZjFvIiwiaXNIaWRkZW4iOmZhbHNlLCJpc1RvZ2dsZWQiOnRydWUsImlzVG9nZ2xlYWJsZSI6ZmFsc2UsImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI6bnVsbH0seyJ0eXBlIjoiY29sdW1uIiwibmFtZSI6InRpcG8ubm9tYnJlIiwibGFiZWwiOiJUaXBvIiwiaXNIaWRkZW4iOmZhbHNlLCJpc1RvZ2dsZWQiOnRydWUsImlzVG9nZ2xlYWJsZSI6ZmFsc2UsImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI6bnVsbH0seyJ0eXBlIjoiY29sdW1uIiwibmFtZSI6ImNhdGVnb3JpYS5ub21icmUiLCJsYWJlbCI6IkNhdGVnb3JcdTAwZWRhIiwiaXNIaWRkZW4iOmZhbHNlLCJpc1RvZ2dsZWQiOnRydWUsImlzVG9nZ2xlYWJsZSI6ZmFsc2UsImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI6bnVsbH0seyJ0eXBlIjoiY29sdW1uIiwibmFtZSI6ImRlc2NyaXBjaW9uIiwibGFiZWwiOiJEZXNjcmlwY2lcdTAwZjNuIiwiaXNIaWRkZW4iOmZhbHNlLCJpc1RvZ2dsZWQiOnRydWUsImlzVG9nZ2xlYWJsZSI6ZmFsc2UsImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI6bnVsbH1dLCI1NzRhMDk2NzRmNzk0MDlmNTczYTA0ZDExZmE1NjEyZV9jb2x1bW5zIjpbeyJ0eXBlIjoiY29sdW1uIiwibmFtZSI6Im5vbWJyZSIsImxhYmVsIjoiTm9tYnJlIiwiaXNIaWRkZW4iOmZhbHNlLCJpc1RvZ2dsZWQiOnRydWUsImlzVG9nZ2xlYWJsZSI6ZmFsc2UsImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI6bnVsbH0seyJ0eXBlIjoiY29sdW1uIiwibmFtZSI6ImNvbG9yIiwibGFiZWwiOiJDb2xvciIsImlzSGlkZGVuIjpmYWxzZSwiaXNUb2dnbGVkIjp0cnVlLCJpc1RvZ2dsZWFibGUiOmZhbHNlLCJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiOm51bGx9LHsidHlwZSI6ImNvbHVtbiIsIm5hbWUiOiJkZXNjcmlwY2lvbiIsImxhYmVsIjoiRGVzY3JpcGNpXHUwMGYzbiIsImlzSGlkZGVuIjpmYWxzZSwiaXNUb2dnbGVkIjp0cnVlLCJpc1RvZ2dsZWFibGUiOmZhbHNlLCJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiOm51bGx9LHsidHlwZSI6ImNvbHVtbiIsIm5hbWUiOiJjcmVhdGVkX2F0IiwibGFiZWwiOiJDcmVhdGVkIGF0IiwiaXNIaWRkZW4iOmZhbHNlLCJpc1RvZ2dsZWQiOmZhbHNlLCJpc1RvZ2dsZWFibGUiOnRydWUsImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI6dHJ1ZX1dLCIzMjNmNjA1OWNhZDA0YjZhMjQ4N2M0M2FjMzg4NzQ0Y19jb2x1bW5zIjpbeyJ0eXBlIjoiY29sdW1uIiwibmFtZSI6Im5vbWJyZSIsImxhYmVsIjoiTm9tYnJlIiwiaXNIaWRkZW4iOmZhbHNlLCJpc1RvZ2dsZWQiOnRydWUsImlzVG9nZ2xlYWJsZSI6ZmFsc2UsImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI6bnVsbH0seyJ0eXBlIjoiY29sdW1uIiwibmFtZSI6ImNvbG9yIiwibGFiZWwiOiJDb2xvciIsImlzSGlkZGVuIjpmYWxzZSwiaXNUb2dnbGVkIjp0cnVlLCJpc1RvZ2dsZWFibGUiOmZhbHNlLCJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiOm51bGx9LHsidHlwZSI6ImNvbHVtbiIsIm5hbWUiOiJkZXNjcmlwY2lvbiIsImxhYmVsIjoiRGVzY3JpcGNpXHUwMGYzbiIsImlzSGlkZGVuIjpmYWxzZSwiaXNUb2dnbGVkIjp0cnVlLCJpc1RvZ2dsZWFibGUiOmZhbHNlLCJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiOm51bGx9LHsidHlwZSI6ImNvbHVtbiIsIm5hbWUiOiJjcmVhdGVkX2F0IiwibGFiZWwiOiJDcmVhdGVkIGF0IiwiaXNIaWRkZW4iOmZhbHNlLCJpc1RvZ2dsZWQiOmZhbHNlLCJpc1RvZ2dsZWFibGUiOnRydWUsImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI6dHJ1ZX1dLCI5ODA4MmY0MGZjOWQ5OWZhZTAzNTkwNmM1YWFhZjMzMF9jb2x1bW5zIjpbeyJ0eXBlIjoiY29sdW1uIiwibmFtZSI6Im5hbWUiLCJsYWJlbCI6Ik5hbWUiLCJpc0hpZGRlbiI6ZmFsc2UsImlzVG9nZ2xlZCI6dHJ1ZSwiaXNUb2dnbGVhYmxlIjpmYWxzZSwiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjpudWxsfSx7InR5cGUiOiJjb2x1bW4iLCJuYW1lIjoidHlwZSIsImxhYmVsIjoiVHlwZSIsImlzSGlkZGVuIjpmYWxzZSwiaXNUb2dnbGVkIjp0cnVlLCJpc1RvZ2dsZWFibGUiOmZhbHNlLCJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiOm51bGx9LHsidHlwZSI6ImNvbHVtbiIsIm5hbWUiOiJzbHVnIiwibGFiZWwiOiJTbHVnIiwiaXNIaWRkZW4iOmZhbHNlLCJpc1RvZ2dsZWQiOnRydWUsImlzVG9nZ2xlYWJsZSI6ZmFsc2UsImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI6bnVsbH1dfSwiZmlsYW1lbnQiOltdfQ==', 1792602692);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `taggables`
--

CREATE TABLE `taggables` (
  `tag_id` bigint(20) UNSIGNED NOT NULL,
  `taggable_type` varchar(255) NOT NULL,
  `taggable_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `taggables`
--

INSERT INTO `taggables` (`tag_id`, `taggable_type`, `taggable_id`) VALUES
(5, 'App\\Models\\Documento', 1),
(5, 'App\\Models\\Documento', 2),
(5, 'App\\Models\\Documento', 3),
(5, 'App\\Models\\Documento', 4),
(5, 'App\\Models\\Documento', 5),
(5, 'App\\Models\\Documento', 7),
(5, 'App\\Models\\Documento', 9),
(5, 'App\\Models\\Documento', 10),
(5, 'App\\Models\\Documento', 11),
(5, 'App\\Models\\Documento', 15),
(5, 'App\\Models\\Documento', 17),
(5, 'App\\Models\\Documento', 18),
(5, 'App\\Models\\Documento', 19),
(5, 'App\\Models\\Documento', 22),
(5, 'App\\Models\\Documento', 24),
(5, 'App\\Models\\Documento', 25),
(5, 'App\\Models\\Documento', 26),
(5, 'App\\Models\\Documento', 27),
(5, 'App\\Models\\Documento', 31),
(5, 'App\\Models\\Documento', 32),
(5, 'App\\Models\\Documento', 34),
(5, 'App\\Models\\Documento', 35),
(5, 'App\\Models\\Documento', 36),
(5, 'App\\Models\\Documento', 37),
(5, 'App\\Models\\Documento', 38),
(5, 'App\\Models\\Documento', 39),
(5, 'App\\Models\\Documento', 40),
(5, 'App\\Models\\Documento', 41),
(5, 'App\\Models\\Documento', 42),
(5, 'App\\Models\\Documento', 43),
(5, 'App\\Models\\Documento', 45),
(5, 'App\\Models\\Documento', 46),
(5, 'App\\Models\\Documento', 47),
(5, 'App\\Models\\Documento', 48),
(5, 'App\\Models\\Documento', 49),
(5, 'App\\Models\\Documento', 50),
(5, 'App\\Models\\Documento', 51),
(5, 'App\\Models\\Documento', 52),
(5, 'App\\Models\\Documento', 54),
(5, 'App\\Models\\Documento', 55),
(5, 'App\\Models\\Documento', 56),
(5, 'App\\Models\\Documento', 60),
(5, 'App\\Models\\Documento', 61),
(5, 'App\\Models\\Documento', 63),
(5, 'App\\Models\\Documento', 64),
(5, 'App\\Models\\Documento', 65),
(5, 'App\\Models\\Documento', 66),
(5, 'App\\Models\\Documento', 67),
(5, 'App\\Models\\Documento', 68),
(5, 'App\\Models\\Documento', 71),
(5, 'App\\Models\\Documento', 73),
(5, 'App\\Models\\Documento', 74),
(5, 'App\\Models\\Documento', 75),
(5, 'App\\Models\\Documento', 77),
(5, 'App\\Models\\Documento', 78),
(5, 'App\\Models\\Documento', 79),
(5, 'App\\Models\\Documento', 80),
(5, 'App\\Models\\Documento', 81),
(5, 'App\\Models\\Documento', 82),
(5, 'App\\Models\\Documento', 83),
(5, 'App\\Models\\Documento', 84),
(5, 'App\\Models\\Documento', 85),
(5, 'App\\Models\\Documento', 87),
(5, 'App\\Models\\Documento', 88),
(5, 'App\\Models\\Documento', 89),
(5, 'App\\Models\\Documento', 90),
(5, 'App\\Models\\Documento', 91),
(5, 'App\\Models\\Documento', 93),
(5, 'App\\Models\\Documento', 94),
(5, 'App\\Models\\Documento', 95),
(5, 'App\\Models\\Documento', 97),
(5, 'App\\Models\\Documento', 98),
(5, 'App\\Models\\Documento', 102),
(5, 'App\\Models\\Documento', 103),
(5, 'App\\Models\\Documento', 104),
(5, 'App\\Models\\Documento', 105),
(5, 'App\\Models\\Documento', 106),
(5, 'App\\Models\\Documento', 109),
(5, 'App\\Models\\Documento', 110),
(5, 'App\\Models\\Documento', 112),
(5, 'App\\Models\\Documento', 113),
(5, 'App\\Models\\Documento', 114),
(5, 'App\\Models\\Documento', 116),
(5, 'App\\Models\\Documento', 117),
(5, 'App\\Models\\Documento', 118),
(5, 'App\\Models\\Documento', 119),
(5, 'App\\Models\\Documento', 120),
(5, 'App\\Models\\Documento', 122),
(5, 'App\\Models\\Documento', 123),
(5, 'App\\Models\\Documento', 126),
(5, 'App\\Models\\Documento', 127),
(5, 'App\\Models\\Documento', 129),
(5, 'App\\Models\\Documento', 132),
(5, 'App\\Models\\Documento', 133),
(5, 'App\\Models\\Documento', 135),
(5, 'App\\Models\\Documento', 136),
(5, 'App\\Models\\Documento', 137),
(5, 'App\\Models\\Documento', 139),
(5, 'App\\Models\\Documento', 140),
(5, 'App\\Models\\Documento', 142),
(5, 'App\\Models\\Documento', 143),
(5, 'App\\Models\\Documento', 144),
(5, 'App\\Models\\Documento', 145),
(5, 'App\\Models\\Documento', 147),
(5, 'App\\Models\\Documento', 148),
(5, 'App\\Models\\Documento', 149),
(5, 'App\\Models\\Documento', 150),
(5, 'App\\Models\\Documento', 151),
(5, 'App\\Models\\Documento', 152),
(5, 'App\\Models\\Documento', 153),
(5, 'App\\Models\\Documento', 158),
(5, 'App\\Models\\Documento', 160),
(5, 'App\\Models\\Documento', 161),
(5, 'App\\Models\\Documento', 162),
(5, 'App\\Models\\Documento', 163),
(5, 'App\\Models\\Documento', 164),
(5, 'App\\Models\\Documento', 165),
(5, 'App\\Models\\Documento', 166),
(5, 'App\\Models\\Documento', 167),
(5, 'App\\Models\\Documento', 168),
(5, 'App\\Models\\Documento', 169),
(5, 'App\\Models\\Documento', 170),
(5, 'App\\Models\\Documento', 173),
(5, 'App\\Models\\Documento', 174),
(5, 'App\\Models\\Documento', 175),
(5, 'App\\Models\\Documento', 178),
(5, 'App\\Models\\Documento', 180),
(5, 'App\\Models\\Documento', 181),
(5, 'App\\Models\\Documento', 182),
(5, 'App\\Models\\Documento', 183),
(5, 'App\\Models\\Documento', 184),
(5, 'App\\Models\\Documento', 185),
(5, 'App\\Models\\Documento', 188),
(5, 'App\\Models\\Documento', 189),
(5, 'App\\Models\\Documento', 190),
(5, 'App\\Models\\Documento', 193),
(5, 'App\\Models\\Documento', 194),
(5, 'App\\Models\\Documento', 195),
(5, 'App\\Models\\Documento', 196),
(5, 'App\\Models\\Documento', 197),
(5, 'App\\Models\\Documento', 199),
(5, 'App\\Models\\Documento', 201),
(5, 'App\\Models\\Documento', 202),
(5, 'App\\Models\\Documento', 204),
(5, 'App\\Models\\Documento', 205),
(5, 'App\\Models\\Documento', 206),
(5, 'App\\Models\\Documento', 207),
(5, 'App\\Models\\Documento', 208),
(5, 'App\\Models\\Documento', 209),
(5, 'App\\Models\\Documento', 210),
(5, 'App\\Models\\Documento', 213),
(5, 'App\\Models\\Documento', 214),
(5, 'App\\Models\\Documento', 215),
(5, 'App\\Models\\Documento', 219),
(5, 'App\\Models\\Documento', 220),
(5, 'App\\Models\\Documento', 221),
(5, 'App\\Models\\Documento', 223),
(5, 'App\\Models\\Documento', 224),
(5, 'App\\Models\\Documento', 225),
(5, 'App\\Models\\Documento', 226),
(5, 'App\\Models\\Documento', 227),
(5, 'App\\Models\\Documento', 228),
(5, 'App\\Models\\Documento', 229),
(5, 'App\\Models\\Documento', 231),
(5, 'App\\Models\\Documento', 232),
(5, 'App\\Models\\Documento', 233),
(5, 'App\\Models\\Documento', 234),
(5, 'App\\Models\\Documento', 235),
(5, 'App\\Models\\Documento', 236),
(5, 'App\\Models\\Documento', 240),
(5, 'App\\Models\\Documento', 241),
(5, 'App\\Models\\Documento', 242),
(5, 'App\\Models\\Documento', 244),
(5, 'App\\Models\\Documento', 245),
(5, 'App\\Models\\Documento', 246),
(5, 'App\\Models\\Documento', 247),
(5, 'App\\Models\\Documento', 248),
(5, 'App\\Models\\Documento', 250),
(5, 'App\\Models\\Documento', 251),
(5, 'App\\Models\\Documento', 255),
(5, 'App\\Models\\Documento', 256),
(5, 'App\\Models\\Documento', 257),
(5, 'App\\Models\\Documento', 259),
(5, 'App\\Models\\Documento', 260),
(5, 'App\\Models\\Documento', 261),
(5, 'App\\Models\\Documento', 263),
(5, 'App\\Models\\Documento', 264),
(5, 'App\\Models\\Documento', 265),
(5, 'App\\Models\\Documento', 266),
(5, 'App\\Models\\Documento', 267),
(5, 'App\\Models\\Documento', 268),
(5, 'App\\Models\\Documento', 269),
(5, 'App\\Models\\Documento', 270),
(5, 'App\\Models\\Documento', 271),
(5, 'App\\Models\\Documento', 272),
(5, 'App\\Models\\Documento', 273),
(5, 'App\\Models\\Documento', 274),
(5, 'App\\Models\\Documento', 275),
(5, 'App\\Models\\Documento', 277),
(5, 'App\\Models\\Documento', 278),
(5, 'App\\Models\\Documento', 280),
(5, 'App\\Models\\Documento', 282),
(5, 'App\\Models\\Documento', 283),
(5, 'App\\Models\\Documento', 284),
(5, 'App\\Models\\Documento', 285),
(5, 'App\\Models\\Documento', 288),
(5, 'App\\Models\\Documento', 289),
(5, 'App\\Models\\Documento', 290),
(5, 'App\\Models\\Documento', 291),
(5, 'App\\Models\\Documento', 292),
(5, 'App\\Models\\Documento', 294),
(5, 'App\\Models\\Documento', 295),
(5, 'App\\Models\\Documento', 296),
(5, 'App\\Models\\Documento', 297),
(5, 'App\\Models\\Documento', 298),
(5, 'App\\Models\\Documento', 300),
(5, 'App\\Models\\Documento', 301),
(6, 'App\\Models\\Documento', 2),
(6, 'App\\Models\\Documento', 3),
(6, 'App\\Models\\Documento', 4),
(6, 'App\\Models\\Documento', 5),
(6, 'App\\Models\\Documento', 6),
(6, 'App\\Models\\Documento', 7),
(6, 'App\\Models\\Documento', 8),
(6, 'App\\Models\\Documento', 9),
(6, 'App\\Models\\Documento', 11),
(6, 'App\\Models\\Documento', 12),
(6, 'App\\Models\\Documento', 13),
(6, 'App\\Models\\Documento', 14),
(6, 'App\\Models\\Documento', 16),
(6, 'App\\Models\\Documento', 17),
(6, 'App\\Models\\Documento', 18),
(6, 'App\\Models\\Documento', 20),
(6, 'App\\Models\\Documento', 21),
(6, 'App\\Models\\Documento', 22),
(6, 'App\\Models\\Documento', 23),
(6, 'App\\Models\\Documento', 26),
(6, 'App\\Models\\Documento', 27),
(6, 'App\\Models\\Documento', 28),
(6, 'App\\Models\\Documento', 29),
(6, 'App\\Models\\Documento', 30),
(6, 'App\\Models\\Documento', 32),
(6, 'App\\Models\\Documento', 33),
(6, 'App\\Models\\Documento', 35),
(6, 'App\\Models\\Documento', 36),
(6, 'App\\Models\\Documento', 37),
(6, 'App\\Models\\Documento', 38),
(6, 'App\\Models\\Documento', 39),
(6, 'App\\Models\\Documento', 41),
(6, 'App\\Models\\Documento', 42),
(6, 'App\\Models\\Documento', 44),
(6, 'App\\Models\\Documento', 50),
(6, 'App\\Models\\Documento', 53),
(6, 'App\\Models\\Documento', 55),
(6, 'App\\Models\\Documento', 57),
(6, 'App\\Models\\Documento', 58),
(6, 'App\\Models\\Documento', 59),
(6, 'App\\Models\\Documento', 62),
(6, 'App\\Models\\Documento', 64),
(6, 'App\\Models\\Documento', 65),
(6, 'App\\Models\\Documento', 66),
(6, 'App\\Models\\Documento', 68),
(6, 'App\\Models\\Documento', 69),
(6, 'App\\Models\\Documento', 70),
(6, 'App\\Models\\Documento', 71),
(6, 'App\\Models\\Documento', 72),
(6, 'App\\Models\\Documento', 75),
(6, 'App\\Models\\Documento', 76),
(6, 'App\\Models\\Documento', 79),
(6, 'App\\Models\\Documento', 84),
(6, 'App\\Models\\Documento', 85),
(6, 'App\\Models\\Documento', 86),
(6, 'App\\Models\\Documento', 89),
(6, 'App\\Models\\Documento', 90),
(6, 'App\\Models\\Documento', 91),
(6, 'App\\Models\\Documento', 92),
(6, 'App\\Models\\Documento', 94),
(6, 'App\\Models\\Documento', 95),
(6, 'App\\Models\\Documento', 96),
(6, 'App\\Models\\Documento', 97),
(6, 'App\\Models\\Documento', 98),
(6, 'App\\Models\\Documento', 99),
(6, 'App\\Models\\Documento', 100),
(6, 'App\\Models\\Documento', 101),
(6, 'App\\Models\\Documento', 104),
(6, 'App\\Models\\Documento', 106),
(6, 'App\\Models\\Documento', 107),
(6, 'App\\Models\\Documento', 108),
(6, 'App\\Models\\Documento', 109),
(6, 'App\\Models\\Documento', 111),
(6, 'App\\Models\\Documento', 112),
(6, 'App\\Models\\Documento', 115),
(6, 'App\\Models\\Documento', 116),
(6, 'App\\Models\\Documento', 117),
(6, 'App\\Models\\Documento', 118),
(6, 'App\\Models\\Documento', 119),
(6, 'App\\Models\\Documento', 121),
(6, 'App\\Models\\Documento', 124),
(6, 'App\\Models\\Documento', 125),
(6, 'App\\Models\\Documento', 126),
(6, 'App\\Models\\Documento', 127),
(6, 'App\\Models\\Documento', 128),
(6, 'App\\Models\\Documento', 129),
(6, 'App\\Models\\Documento', 130),
(6, 'App\\Models\\Documento', 131),
(6, 'App\\Models\\Documento', 132),
(6, 'App\\Models\\Documento', 134),
(6, 'App\\Models\\Documento', 135),
(6, 'App\\Models\\Documento', 138),
(6, 'App\\Models\\Documento', 140),
(6, 'App\\Models\\Documento', 141),
(6, 'App\\Models\\Documento', 143),
(6, 'App\\Models\\Documento', 144),
(6, 'App\\Models\\Documento', 146),
(6, 'App\\Models\\Documento', 148),
(6, 'App\\Models\\Documento', 149),
(6, 'App\\Models\\Documento', 154),
(6, 'App\\Models\\Documento', 155),
(6, 'App\\Models\\Documento', 156),
(6, 'App\\Models\\Documento', 157),
(6, 'App\\Models\\Documento', 158),
(6, 'App\\Models\\Documento', 159),
(6, 'App\\Models\\Documento', 160),
(6, 'App\\Models\\Documento', 162),
(6, 'App\\Models\\Documento', 163),
(6, 'App\\Models\\Documento', 164),
(6, 'App\\Models\\Documento', 165),
(6, 'App\\Models\\Documento', 166),
(6, 'App\\Models\\Documento', 168),
(6, 'App\\Models\\Documento', 170),
(6, 'App\\Models\\Documento', 171),
(6, 'App\\Models\\Documento', 172),
(6, 'App\\Models\\Documento', 173),
(6, 'App\\Models\\Documento', 174),
(6, 'App\\Models\\Documento', 175),
(6, 'App\\Models\\Documento', 176),
(6, 'App\\Models\\Documento', 177),
(6, 'App\\Models\\Documento', 178),
(6, 'App\\Models\\Documento', 179),
(6, 'App\\Models\\Documento', 180),
(6, 'App\\Models\\Documento', 185),
(6, 'App\\Models\\Documento', 186),
(6, 'App\\Models\\Documento', 187),
(6, 'App\\Models\\Documento', 188),
(6, 'App\\Models\\Documento', 189),
(6, 'App\\Models\\Documento', 190),
(6, 'App\\Models\\Documento', 191),
(6, 'App\\Models\\Documento', 192),
(6, 'App\\Models\\Documento', 193),
(6, 'App\\Models\\Documento', 195),
(6, 'App\\Models\\Documento', 198),
(6, 'App\\Models\\Documento', 199),
(6, 'App\\Models\\Documento', 200),
(6, 'App\\Models\\Documento', 203),
(6, 'App\\Models\\Documento', 204),
(6, 'App\\Models\\Documento', 205),
(6, 'App\\Models\\Documento', 206),
(6, 'App\\Models\\Documento', 207),
(6, 'App\\Models\\Documento', 208),
(6, 'App\\Models\\Documento', 210),
(6, 'App\\Models\\Documento', 211),
(6, 'App\\Models\\Documento', 212),
(6, 'App\\Models\\Documento', 216),
(6, 'App\\Models\\Documento', 217),
(6, 'App\\Models\\Documento', 218),
(6, 'App\\Models\\Documento', 221),
(6, 'App\\Models\\Documento', 222),
(6, 'App\\Models\\Documento', 225),
(6, 'App\\Models\\Documento', 226),
(6, 'App\\Models\\Documento', 228),
(6, 'App\\Models\\Documento', 230),
(6, 'App\\Models\\Documento', 232),
(6, 'App\\Models\\Documento', 233),
(6, 'App\\Models\\Documento', 235),
(6, 'App\\Models\\Documento', 236),
(6, 'App\\Models\\Documento', 237),
(6, 'App\\Models\\Documento', 238),
(6, 'App\\Models\\Documento', 239),
(6, 'App\\Models\\Documento', 243),
(6, 'App\\Models\\Documento', 244),
(6, 'App\\Models\\Documento', 245),
(6, 'App\\Models\\Documento', 247),
(6, 'App\\Models\\Documento', 248),
(6, 'App\\Models\\Documento', 249),
(6, 'App\\Models\\Documento', 251),
(6, 'App\\Models\\Documento', 252),
(6, 'App\\Models\\Documento', 253),
(6, 'App\\Models\\Documento', 254),
(6, 'App\\Models\\Documento', 255),
(6, 'App\\Models\\Documento', 257),
(6, 'App\\Models\\Documento', 258),
(6, 'App\\Models\\Documento', 261),
(6, 'App\\Models\\Documento', 262),
(6, 'App\\Models\\Documento', 263),
(6, 'App\\Models\\Documento', 265),
(6, 'App\\Models\\Documento', 268),
(6, 'App\\Models\\Documento', 270),
(6, 'App\\Models\\Documento', 271),
(6, 'App\\Models\\Documento', 272),
(6, 'App\\Models\\Documento', 276),
(6, 'App\\Models\\Documento', 277),
(6, 'App\\Models\\Documento', 278),
(6, 'App\\Models\\Documento', 279),
(6, 'App\\Models\\Documento', 281),
(6, 'App\\Models\\Documento', 285),
(6, 'App\\Models\\Documento', 286),
(6, 'App\\Models\\Documento', 287),
(6, 'App\\Models\\Documento', 290),
(6, 'App\\Models\\Documento', 292),
(6, 'App\\Models\\Documento', 293),
(6, 'App\\Models\\Documento', 295),
(6, 'App\\Models\\Documento', 296),
(6, 'App\\Models\\Documento', 299),
(6, 'App\\Models\\Documento', 300),
(6, 'App\\Models\\Documento', 302),
(7, 'App\\Models\\Documento', 1),
(7, 'App\\Models\\Documento', 6),
(7, 'App\\Models\\Documento', 8),
(7, 'App\\Models\\Documento', 10),
(7, 'App\\Models\\Documento', 12),
(7, 'App\\Models\\Documento', 13),
(7, 'App\\Models\\Documento', 14),
(7, 'App\\Models\\Documento', 15),
(7, 'App\\Models\\Documento', 16),
(7, 'App\\Models\\Documento', 19),
(7, 'App\\Models\\Documento', 20),
(7, 'App\\Models\\Documento', 21),
(7, 'App\\Models\\Documento', 23),
(7, 'App\\Models\\Documento', 24),
(7, 'App\\Models\\Documento', 25),
(7, 'App\\Models\\Documento', 28),
(7, 'App\\Models\\Documento', 29),
(7, 'App\\Models\\Documento', 30),
(7, 'App\\Models\\Documento', 31),
(7, 'App\\Models\\Documento', 33),
(7, 'App\\Models\\Documento', 34),
(7, 'App\\Models\\Documento', 40),
(7, 'App\\Models\\Documento', 43),
(7, 'App\\Models\\Documento', 44),
(7, 'App\\Models\\Documento', 45),
(7, 'App\\Models\\Documento', 46),
(7, 'App\\Models\\Documento', 47),
(7, 'App\\Models\\Documento', 48),
(7, 'App\\Models\\Documento', 49),
(7, 'App\\Models\\Documento', 51),
(7, 'App\\Models\\Documento', 52),
(7, 'App\\Models\\Documento', 53),
(7, 'App\\Models\\Documento', 54),
(7, 'App\\Models\\Documento', 56),
(7, 'App\\Models\\Documento', 57),
(7, 'App\\Models\\Documento', 58),
(7, 'App\\Models\\Documento', 59),
(7, 'App\\Models\\Documento', 60),
(7, 'App\\Models\\Documento', 61),
(7, 'App\\Models\\Documento', 62),
(7, 'App\\Models\\Documento', 63),
(7, 'App\\Models\\Documento', 67),
(7, 'App\\Models\\Documento', 69),
(7, 'App\\Models\\Documento', 70),
(7, 'App\\Models\\Documento', 72),
(7, 'App\\Models\\Documento', 73),
(7, 'App\\Models\\Documento', 74),
(7, 'App\\Models\\Documento', 76),
(7, 'App\\Models\\Documento', 77),
(7, 'App\\Models\\Documento', 78),
(7, 'App\\Models\\Documento', 80),
(7, 'App\\Models\\Documento', 81),
(7, 'App\\Models\\Documento', 82),
(7, 'App\\Models\\Documento', 83),
(7, 'App\\Models\\Documento', 86),
(7, 'App\\Models\\Documento', 87),
(7, 'App\\Models\\Documento', 88),
(7, 'App\\Models\\Documento', 92),
(7, 'App\\Models\\Documento', 93),
(7, 'App\\Models\\Documento', 96),
(7, 'App\\Models\\Documento', 99),
(7, 'App\\Models\\Documento', 100),
(7, 'App\\Models\\Documento', 101),
(7, 'App\\Models\\Documento', 102),
(7, 'App\\Models\\Documento', 103),
(7, 'App\\Models\\Documento', 105),
(7, 'App\\Models\\Documento', 107),
(7, 'App\\Models\\Documento', 108),
(7, 'App\\Models\\Documento', 110),
(7, 'App\\Models\\Documento', 111),
(7, 'App\\Models\\Documento', 113),
(7, 'App\\Models\\Documento', 114),
(7, 'App\\Models\\Documento', 115),
(7, 'App\\Models\\Documento', 120),
(7, 'App\\Models\\Documento', 121),
(7, 'App\\Models\\Documento', 122),
(7, 'App\\Models\\Documento', 123),
(7, 'App\\Models\\Documento', 124),
(7, 'App\\Models\\Documento', 125),
(7, 'App\\Models\\Documento', 128),
(7, 'App\\Models\\Documento', 130),
(7, 'App\\Models\\Documento', 131),
(7, 'App\\Models\\Documento', 133),
(7, 'App\\Models\\Documento', 134),
(7, 'App\\Models\\Documento', 136),
(7, 'App\\Models\\Documento', 137),
(7, 'App\\Models\\Documento', 138),
(7, 'App\\Models\\Documento', 139),
(7, 'App\\Models\\Documento', 141),
(7, 'App\\Models\\Documento', 142),
(7, 'App\\Models\\Documento', 145),
(7, 'App\\Models\\Documento', 146),
(7, 'App\\Models\\Documento', 147),
(7, 'App\\Models\\Documento', 150),
(7, 'App\\Models\\Documento', 151),
(7, 'App\\Models\\Documento', 152),
(7, 'App\\Models\\Documento', 153),
(7, 'App\\Models\\Documento', 154),
(7, 'App\\Models\\Documento', 155),
(7, 'App\\Models\\Documento', 156),
(7, 'App\\Models\\Documento', 157),
(7, 'App\\Models\\Documento', 159),
(7, 'App\\Models\\Documento', 161),
(7, 'App\\Models\\Documento', 167),
(7, 'App\\Models\\Documento', 169),
(7, 'App\\Models\\Documento', 171),
(7, 'App\\Models\\Documento', 172),
(7, 'App\\Models\\Documento', 176),
(7, 'App\\Models\\Documento', 177),
(7, 'App\\Models\\Documento', 179),
(7, 'App\\Models\\Documento', 181),
(7, 'App\\Models\\Documento', 182),
(7, 'App\\Models\\Documento', 183),
(7, 'App\\Models\\Documento', 184),
(7, 'App\\Models\\Documento', 186),
(7, 'App\\Models\\Documento', 187),
(7, 'App\\Models\\Documento', 191),
(7, 'App\\Models\\Documento', 192),
(7, 'App\\Models\\Documento', 194),
(7, 'App\\Models\\Documento', 196),
(7, 'App\\Models\\Documento', 197),
(7, 'App\\Models\\Documento', 198),
(7, 'App\\Models\\Documento', 200),
(7, 'App\\Models\\Documento', 201),
(7, 'App\\Models\\Documento', 202),
(7, 'App\\Models\\Documento', 203),
(7, 'App\\Models\\Documento', 209),
(7, 'App\\Models\\Documento', 211),
(7, 'App\\Models\\Documento', 212),
(7, 'App\\Models\\Documento', 213),
(7, 'App\\Models\\Documento', 214),
(7, 'App\\Models\\Documento', 215),
(7, 'App\\Models\\Documento', 216),
(7, 'App\\Models\\Documento', 217),
(7, 'App\\Models\\Documento', 218),
(7, 'App\\Models\\Documento', 219),
(7, 'App\\Models\\Documento', 220),
(7, 'App\\Models\\Documento', 222),
(7, 'App\\Models\\Documento', 223),
(7, 'App\\Models\\Documento', 224),
(7, 'App\\Models\\Documento', 227),
(7, 'App\\Models\\Documento', 229),
(7, 'App\\Models\\Documento', 230),
(7, 'App\\Models\\Documento', 231),
(7, 'App\\Models\\Documento', 234),
(7, 'App\\Models\\Documento', 237),
(7, 'App\\Models\\Documento', 238),
(7, 'App\\Models\\Documento', 239),
(7, 'App\\Models\\Documento', 240),
(7, 'App\\Models\\Documento', 241),
(7, 'App\\Models\\Documento', 242),
(7, 'App\\Models\\Documento', 243),
(7, 'App\\Models\\Documento', 246),
(7, 'App\\Models\\Documento', 249),
(7, 'App\\Models\\Documento', 250),
(7, 'App\\Models\\Documento', 252),
(7, 'App\\Models\\Documento', 253),
(7, 'App\\Models\\Documento', 254),
(7, 'App\\Models\\Documento', 256),
(7, 'App\\Models\\Documento', 258),
(7, 'App\\Models\\Documento', 259),
(7, 'App\\Models\\Documento', 260),
(7, 'App\\Models\\Documento', 262),
(7, 'App\\Models\\Documento', 264),
(7, 'App\\Models\\Documento', 266),
(7, 'App\\Models\\Documento', 267),
(7, 'App\\Models\\Documento', 269),
(7, 'App\\Models\\Documento', 273),
(7, 'App\\Models\\Documento', 274),
(7, 'App\\Models\\Documento', 275),
(7, 'App\\Models\\Documento', 276),
(7, 'App\\Models\\Documento', 279),
(7, 'App\\Models\\Documento', 280),
(7, 'App\\Models\\Documento', 281),
(7, 'App\\Models\\Documento', 282),
(7, 'App\\Models\\Documento', 283),
(7, 'App\\Models\\Documento', 284),
(7, 'App\\Models\\Documento', 286),
(7, 'App\\Models\\Documento', 287),
(7, 'App\\Models\\Documento', 288),
(7, 'App\\Models\\Documento', 289),
(7, 'App\\Models\\Documento', 291),
(7, 'App\\Models\\Documento', 293),
(7, 'App\\Models\\Documento', 294),
(7, 'App\\Models\\Documento', 297),
(7, 'App\\Models\\Documento', 298),
(7, 'App\\Models\\Documento', 299),
(7, 'App\\Models\\Documento', 300),
(7, 'App\\Models\\Documento', 301),
(7, 'App\\Models\\Documento', 302);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tags`
--

CREATE TABLE `tags` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`name`)),
  `slug` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`slug`)),
  `type` varchar(255) DEFAULT NULL,
  `order_column` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `tags`
--

INSERT INTO `tags` (`id`, `name`, `slug`, `type`, `order_column`, `created_at`, `updated_at`) VALUES
(5, '{\"es\":\"resoluci\\u00f3n\"}', '{\"es\":\"resolucion\"}', 'documento', 5, '2026-06-18 18:46:51', '2026-06-18 18:46:51'),
(6, '{\"es\":\"decreto\"}', '{\"es\":\"decreto\"}', 'documento', 6, '2026-06-18 18:46:51', '2026-06-18 18:46:51'),
(7, '{\"es\":\"memorandum\"}', '{\"es\":\"memorandum\"}', 'documento', 7, '2026-06-18 18:46:51', '2026-06-18 18:46:51');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_documentos`
--

CREATE TABLE `tipo_documentos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `color` varchar(255) NOT NULL DEFAULT '#f59e0b',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `descripcion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `tipo_documentos`
--

INSERT INTO `tipo_documentos` (`id`, `nombre`, `color`, `created_at`, `updated_at`, `descripcion`) VALUES
(1, 'Decreto', '#FF6B6B', '2026-06-18 19:01:11', '2026-06-18 19:01:11', NULL),
(2, 'Resolución', '#4ECDC4', '2026-06-18 19:01:11', '2026-06-18 19:01:11', NULL),
(3, 'Memorandum', '#45B7D1', '2026-06-18 19:01:11', '2026-06-18 19:01:11', NULL),
(4, 'Acuerdo', '#FFA07A', '2026-06-18 19:01:11', '2026-10-21 17:49:16', 'Tipo de doc acuerdo'),
(5, 'Ordenanza', '#98D8C8', '2026-06-18 19:01:11', '2026-06-18 19:01:11', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'admin@gmail.com', NULL, '$2y$12$8zZbotdVXHM11f5BJIREQOUYPucprG.5SPJqL1dcBMLwkK7ZK4OVW', NULL, '2026-05-18 15:51:26', '2026-05-18 15:51:26'),
(2, 'Test User', 'test@example.com', '2026-05-20 20:48:13', '$2y$12$q3qOa2KY2syHZpTd9RO7Guo.Idd80wmwSaU6l7Xvz.LhZ8qyDK/my', 'WJpkNAM2pAwsrSYUo5RVtX7mxKhLUjRGlpbP3FHIqmEpqd1r3rkQhsjKbgzY', '2026-05-20 20:48:13', '2026-06-18 17:11:41'),
(4, 'administrador', 'marcelo.fajardo@gmail.com', NULL, '$2y$12$AZj0AkwjVtawsPf5j2gfnurwMo1LCmtAIwCMxnd7RAO/7JDdpo4cq', 'ljzuzR8MooBkq3t5MsSoM1scs69cxw7pXU8VZLzzE2edPs7AtxSFjFGCnvf4', '2026-06-18 17:38:02', '2026-10-15 18:57:31'),
(5, 'user1', 'wqeqwe@gmail.com', NULL, '$2y$12$IyDTT.LpCSsMl.EbYx4tfOl/ZYa6QgwPwxeWMKHHHJBqMjnNa3hOq', NULL, '2026-10-15 18:54:30', '2026-10-15 18:54:30');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `ai_providers`
--
ALTER TABLE `ai_providers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ai_providers_enabled_priority_index` (`enabled`,`priority`);

--
-- Indices de la tabla `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_expiration_index` (`expiration`);

--
-- Indices de la tabla `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_locks_expiration_index` (`expiration`);

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `documentos`
--
ALTER TABLE `documentos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `documentos_categoria_id_foreign` (`categoria_id`),
  ADD KEY `documentos_titulo_index` (`titulo`),
  ADD KEY `documentos_tipo_id_categoria_id_index` (`tipo_id`,`categoria_id`),
  ADD KEY `documentos_anio_numero_index` (`anio`,`numero`);

--
-- Indices de la tabla `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`),
  ADD KEY `failed_jobs_connection_queue_failed_at_index` (`connection`,`queue`,`failed_at`);

--
-- Indices de la tabla `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indices de la tabla `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indices de la tabla `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indices de la tabla `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indices de la tabla `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indices de la tabla `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Indices de la tabla `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indices de la tabla `taggables`
--
ALTER TABLE `taggables`
  ADD UNIQUE KEY `taggables_tag_id_taggable_id_taggable_type_unique` (`tag_id`,`taggable_id`,`taggable_type`),
  ADD KEY `taggables_taggable_type_taggable_id_index` (`taggable_type`,`taggable_id`);

--
-- Indices de la tabla `tags`
--
ALTER TABLE `tags`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tipo_documentos`
--
ALTER TABLE `tipo_documentos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tipo_documentos_nombre_index` (`nombre`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `ai_providers`
--
ALTER TABLE `ai_providers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `documentos`
--
ALTER TABLE `documentos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=301;

--
-- AUTO_INCREMENT de la tabla `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=98;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tags`
--
ALTER TABLE `tags`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `tipo_documentos`
--
ALTER TABLE `tipo_documentos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `documentos`
--
ALTER TABLE `documentos`
  ADD CONSTRAINT `documentos_categoria_id_foreign` FOREIGN KEY (`categoria_id`) REFERENCES `categorias` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `documentos_tipo_id_foreign` FOREIGN KEY (`tipo_id`) REFERENCES `tipo_documentos` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `taggables`
--
ALTER TABLE `taggables`
  ADD CONSTRAINT `taggables_tag_id_foreign` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
