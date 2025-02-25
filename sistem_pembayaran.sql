-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Feb 25, 2025 at 08:54 AM
-- Server version: 8.0.30
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sistem_pembayaran`
--

-- --------------------------------------------------------

--
-- Table structure for table `kewajiban`
--

CREATE TABLE `kewajiban` (
  `id_kwj` int NOT NULL,
  `id_kode` int NOT NULL,
  `nama_kewajiban` varchar(150) NOT NULL,
  `jml_bayar` int DEFAULT NULL,
  `jml_angsuran` int DEFAULT NULL,
  `jml_bayar_total` int DEFAULT NULL,
  `fix_bayar` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `kewajiban_siswa`
--

CREATE TABLE `kewajiban_siswa` (
  `id_kwj_siswa` int NOT NULL,
  `siswa_ids` int NOT NULL,
  `id_kwj` int NOT NULL,
  `discount` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `kode_kewajiban`
--

CREATE TABLE `kode_kewajiban` (
  `id_kode` int NOT NULL,
  `nama_kode` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pembayaran`
--

CREATE TABLE `pembayaran` (
  `id_bayar` int NOT NULL,
  `id_kwj_siswa` int NOT NULL,
  `jml_bayar` int NOT NULL,
  `tgl_bayar` datetime NOT NULL,
  `ket` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `siswa`
--

CREATE TABLE `siswa` (
  `ids` int NOT NULL,
  `nis` varchar(8) NOT NULL,
  `nama` varchar(250) NOT NULL,
  `jk` varchar(1) DEFAULT NULL,
  `tempat_lahir` varchar(250) DEFAULT NULL,
  `tgl_lahir` date DEFAULT NULL,
  `anak_ke` int DEFAULT NULL,
  `dari_saudara` int DEFAULT NULL,
  `nama_ayah` varchar(45) DEFAULT NULL,
  `simpan` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transaksi`
--

CREATE TABLE `transaksi` (
  `id_transaksi` int NOT NULL,
  `ids` int NOT NULL,
  `tgl_transaksi` datetime DEFAULT NULL,
  `jumlah` int DEFAULT NULL,
  `sumber_data` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `kewajiban`
--
ALTER TABLE `kewajiban`
  ADD PRIMARY KEY (`id_kwj`),
  ADD KEY `fk_kewajiban_kodekewajiban` (`id_kode`);

--
-- Indexes for table `kewajiban_siswa`
--
ALTER TABLE `kewajiban_siswa`
  ADD PRIMARY KEY (`id_kwj_siswa`),
  ADD KEY `id_kwj` (`id_kwj`),
  ADD KEY `siswa_ids` (`siswa_ids`);

--
-- Indexes for table `kode_kewajiban`
--
ALTER TABLE `kode_kewajiban`
  ADD PRIMARY KEY (`id_kode`);

--
-- Indexes for table `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD PRIMARY KEY (`id_bayar`),
  ADD KEY `fk_pembayaran_kewajiban_siswa1_idx` (`id_kwj_siswa`);

--
-- Indexes for table `siswa`
--
ALTER TABLE `siswa`
  ADD PRIMARY KEY (`ids`);

--
-- Indexes for table `transaksi`
--
ALTER TABLE `transaksi`
  ADD PRIMARY KEY (`id_transaksi`),
  ADD KEY `fk_transaksi_siswa1` (`ids`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `kewajiban`
--
ALTER TABLE `kewajiban`
  MODIFY `id_kwj` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kewajiban_siswa`
--
ALTER TABLE `kewajiban_siswa`
  MODIFY `id_kwj_siswa` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kode_kewajiban`
--
ALTER TABLE `kode_kewajiban`
  MODIFY `id_kode` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pembayaran`
--
ALTER TABLE `pembayaran`
  MODIFY `id_bayar` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `siswa`
--
ALTER TABLE `siswa`
  MODIFY `ids` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `transaksi`
--
ALTER TABLE `transaksi`
  MODIFY `id_transaksi` int NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `kewajiban`
--
ALTER TABLE `kewajiban`
  ADD CONSTRAINT `fk_kewajiban_kodekewajiban` FOREIGN KEY (`id_kode`) REFERENCES `kode_kewajiban` (`id_kode`);

--
-- Constraints for table `kewajiban_siswa`
--
ALTER TABLE `kewajiban_siswa`
  ADD CONSTRAINT `fk_siswa_has_kewajiban_kewajiban1` FOREIGN KEY (`id_kwj`) REFERENCES `kewajiban` (`id_kwj`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_siswa_has_kewajiban_siswa1` FOREIGN KEY (`siswa_ids`) REFERENCES `siswa` (`ids`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD CONSTRAINT `fk_pembayaran_kewajiban_siswa1` FOREIGN KEY (`id_kwj_siswa`) REFERENCES `kewajiban_siswa` (`id_kwj_siswa`);

--
-- Constraints for table `transaksi`
--
ALTER TABLE `transaksi`
  ADD CONSTRAINT `fk_transaksi_siswa1` FOREIGN KEY (`ids`) REFERENCES `siswa` (`ids`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
