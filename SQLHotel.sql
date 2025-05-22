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

create table RoleUser(
	KD_Role_User Varchar(100) primary key,
    Nama_Role varchar(255)	
);

create table Karyawan(
	KD_Resepsionis varchar(100) primary key,
	Nama_Lengkap varchar(100),
    No_Telepon varchar(20),
	Jenis_Kelamin enum("L", "P"),
	KD_Role_User Varchar(100),
	Alamat varchar(255),
    foreign key (KD_Role_User) references RoleUser(KD_Role_User)
);

create table Fasilitas (
	 ID_Fasilitas varchar(10) primary key,
     nama_barang varchar(255)
);

create table TipeKamar(
	Kode_Tipe_Kamar varchar(8) primary key,
    Nama_Tipe_Kamar varchar(255),
    Ukuran_Kamar int
);

create table FasilitasKamar (
	ID_Fasilitas varchar(10),
    Kode_Tipe_Kamar varchar(8),
    foreign key (ID_Fasilitas) references Fasilitas(ID_Fasilitas),
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
    Kode_Kamar varchar(10),
    tanggal_cekin dateTime,
    tanggal_cekout dateTime,
    Status enum('check-in', 'check-out', 'dibatalkan'),
	foreign key (Kode_Kamar) references Kamar(Kode_Kamar)
);

create table LayananHotel(
	Kode_Jenis_Layanan varchar(6),
	Kode_Reservasi_Kamar varchar(100),
    foreign key (Kode_Reservasi_Kamar) references ReservasiKamar(Kode_Reservasi_Kamar),
	foreign key (Kode_Jenis_Layanan) references JenisLayanan(Kode_Jenis_Layanan)
);

create table Tagihan(
	Kd_Tagihan varchar(100),
    Kode_Reservasi_Kamar varchar(100) primary key,
    Total int,
    foreign key (Kode_Reservasi_Kamar) references ReservasiKamar(Kode_Reservasi_Kamar)
);

