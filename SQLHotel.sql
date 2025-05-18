create database dbHotel;
use dbHotel;

create table Tamu (
	ID_Tamu varchar(15) Primary key,
    Jenis_Identitas enum('KTP', 'Paspor'),
    Nama_Lengkap varchar(100),
    No_Telepon varchar(20),
    Jenis_Kelamin enum("L", "P"),
    Email varchar(200),
    Alamat varchar(255),
    Kewarganegaraan varchar(100)
);

create table Fasilitas (
	 ID_Fasilitas_Kamar varchar(10) primary key,
     nama_barang varchar(255)
);

create table TipeKamar(
	Kode_Tipe_Kamar varchar(8) primary key,
    Nama_Tipe_Kamar varchar(255),
    Ukuran_Kamar int
);

create table FasilitasKamar (
	ID_Fasilitas_Kamar varchar(10),
    Kode_Tipe_Kamar varchar(8),
    foreign key (ID_Fasilitas_Kamar) references Fasilitas(ID_Fasilitas_Kamar),
    foreign key (Kode_Tipe_Kamar) references TipeKamar(Kode_Tipe_Kamar)
);

create table Kamar (
	Kode_Kamar varchar(10) primary key,
	Kode_Tipe_Kamar varchar(8),
	Status_Kamar enum("Available", "Reserved", "Occupied"),
    Harga_per_Malam int,
    foreign key (Kode_Tipe_Kamar) references TipeKamar(Kode_Tipe_Kamar)
);

create table JenisLayanan(
	Kode_Jenis_Layanan Varchar(6) primary key,
    Nama_Jenis_Layanan varchar(100),
    Harga_Layanan_Hotel int
);

create table ReservasiKamar(
	Kode_Reservasi_Kamar varchar(100) primary key,
    Kode_Kamar varchar(10) primary key,
    tanggal_cekin dateTime,
    tanggal_cekout dateTime,
    Status enum('check-in', 'check-out', 'dibatalkan')
);

create table LayananHotel(
	Kode_Reservasi_Kamar varchar(100),
    Kode_Layanan_Hotel varchar(6),
    foreign key (Kode_Reservasi_Kamar) references JenisLayanan(Kode_Reservasi_Kamar),
	foreign key (Kode_Layanan_Hotel) references JenisLayanan(Kode_Jenis_Layanan)
);

create table Tagihan(
	Kd_Tagihan varchar(100),
    Kode_Reservasi_Kamar varchar(100) primary key,
    Total int,
    foreign key (Kode_Reservasi_Kamar) references JenisLayanan(Kode_Reservasi_Kamar)
);