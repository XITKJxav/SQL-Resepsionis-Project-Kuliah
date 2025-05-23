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

-- isi tabel
INSERT INTO Tamu VALUES
('T001', 'KTP', 'Budi Santoso', '1671xxxxxxxxx40', 'L', 'budi.santoso@email.com', 'Jl. Merdeka No. 10, Jakarta', 'Indonesia'),
('T002', 'Paspor', 'Sarah Johnson', '444xxxxxx450', 'P', 'sarah.j@email.com', '123 Main St, New York', 'USA'),
('T003', 'KTP', 'Dewi Lestari', '1671xxxxxxxxx24', 'P', 'dewi.lestari@email.com', 'Jl. Sudirman No. 45, Bandung', 'Indonesia'),
('T004', 'KTP', 'Andi Wijaya', '1671xxxxxxxxx01', 'L', 'andi.w@email.com', 'Jl. Gatot Subroto No. 22, Surabaya', 'Indonesia'),
('T005', 'Paspor', 'Michael Chen', 'S123xxxxxxxx1B', 'L', 'michael.chen@email.com', '88 Queen Street, Singapore', 'Singapore'); 

INSERT INTO RoleUser VALUES 
('R001', 'Manager'),
('R002', 'Resepsionis'),
('R003', 'Housekeeping'),
('R004', 'Room Service'),
('R005', 'Maintenance');

INSERT INTO Karyawan VALUES 
('K001', 'Ahmad Fauzi', '081122334455', 'L', 'R001', 'Jl. Pahlawan No. 5, Jakarta'),
('K002', 'Dina Marlina', '082233445566', 'P', 'R002', 'Jl. Melati No. 12, Jakarta'),
('K003', 'Rudi Hermawan', '083344556677', 'L', 'R003', 'Jl. Anggrek No. 8, Jakarta'),
('K004', 'Siti Rahayu', '084455667788', 'P', 'R002', 'Jl. Mawar No. 3, Jakarta'),
('K005', 'Bambang Sutrisno', '085566778899', 'L', 'R004', 'Jl. Kenanga No. 7, Jakarta');

INSERT INTO Fasilitas VALUES 
('F001', 'Single Bed'),
('F002', 'Double Bed'),
('F003', 'Twin Bed'),
('F004', 'Kamar Mandi Pribadi'),
('F005', 'AC'),
('F006', 'TV'),
('F007', 'TV LED'),
('F008', 'Telepon'),
('F009', 'Perlengkapan Mandi'),
('F010', 'WiFi'),
('F011', 'Shower'),
('F012', 'Bathtub'),
('F013', 'Meja Kerja'),
('F014', 'Lemari'),
('F015', 'Pembuat Kopi/Teh'),
('F016', 'Minibar'),
('F017', 'Safe Deposit Box'),
('F018', 'Pengering Rambut'),
('F019', 'Sambungan IDD'),
('F020', 'Area Tempat Duduk'),
('F021', 'Ruang Tamu Terpisah'),
('F022', 'Dapur Mini/Pantry'),
('F023', 'Kotak Penyimpanan Barang Berharga');

INSERT INTO TipeKamar VALUES 
('STR-R101', 'Standard Room', 28),
('SPR-R201', 'Superior Room', 35),
('DLX-R301', 'Deluxe Room', 45),
('SUR-R401', 'Suite Room', 80);

-- Standard Room
INSERT INTO FasilitasKamar VALUES 
('F001', 'STR-R101'), -- Single Bed
('F004', 'STR-R101'), -- Kamar Mandi Pribadi
('F005', 'STR-R101'), -- AC
('F006', 'STR-R101'), -- TV
('F008', 'STR-R101'), -- Telepon
('F009', 'STR-R101'), -- Perlengkapan Mandi
('F011', 'STR-R101'); -- Shower

-- Superior Room
INSERT INTO FasilitasKamar VALUES 
('F002', 'SPR-R201'), -- Double Bed
('F005', 'SPR-R201'), -- AC
('F007', 'SPR-R201'), -- TV LED
('F010', 'SPR-R201'), -- WiFi
('F011', 'SPR-R201'), -- Shower
('F012', 'SPR-R201'), -- Bathtub
('F009', 'SPR-R201'), -- Perlengkapan Mandi
('F013', 'SPR-R201'), -- Meja Kerja
('F014', 'SPR-R201'), -- Lemari
('F015', 'SPR-R201'); -- Pembuat Kopi/Teh

-- Deluxe Room
INSERT INTO FasilitasKamar VALUES 
('F003', 'DLX-R301'), -- Twin Bed (pilihan)
('F002', 'DLX-R301'), -- Double Bed (pilihan)
('F016', 'DLX-R301'), -- Minibar
('F015', 'DLX-R301'), -- Fasilitas teh dan kopi
('F013', 'DLX-R301'), -- Meja kerja luas
('F020', 'DLX-R301'), -- Area tempat duduk
('F010', 'DLX-R301'), -- WiFi gratis
('F007', 'DLX-R301'), -- TV LED
('F017', 'DLX-R301'), -- Safe deposit box
('F018', 'DLX-R301'), -- Pengering rambut
('F005', 'DLX-R301'), -- AC
('F008', 'DLX-R301'), -- Telepon
('F019', 'DLX-R301'), -- Sambungan IDD
('F023', 'DLX-R301'), -- Kotak penyimpanan barang berharga
('F009', 'DLX-R301'), -- Perlengkapan mandi
('F011', 'DLX-R301'), -- Shower
('F012', 'DLX-R301'); -- Bathtub

-- Suite Room
INSERT INTO FasilitasKamar VALUES 
('F021', 'SUR-R401'), -- Ruang tamu terpisah
('F002', 'SUR-R401'), -- Double Bed (pilihan)
('F003', 'SUR-R401'), -- Twin Bed (pilihan)
('F013', 'SUR-R401'), -- Meja kerja
('F016', 'SUR-R401'), -- Mini bar
('F022', 'SUR-R401'), -- Dapur mini/pantry
('F005', 'SUR-R401'), -- AC
('F007', 'SUR-R401'), -- TV LED
('F010', 'SUR-R401'), -- WiFi
('F011', 'SUR-R401'), -- Shower
('F012', 'SUR-R401'), -- Bathtub
('F009', 'SUR-R401'), -- Perlengkapan mandi
('F017', 'SUR-R401'), -- Safe deposit box
('F018', 'SUR-R401'); -- Pengering rambut

-- Update data kamar yang sudah ada atau tambahkan baru
INSERT INTO Kamar VALUES 
('K-101', 'STR-R101', 'Available', 500000),
('K-201', 'SPR-R201', 'Occupied', 750000),
('K-301', 'DLX-R301', 'Reserved', 1200000),
('K-401', 'SUR-R401', 'Available', 2000000);

INSERT INTO JenisLayanan VALUES 
('LYN001', 'Breakfast Buffet', 150000),
('LYN002', 'Laundry Express (4 jam)', 120000),
('LYN003', 'Laundry Regular (24 jam)', 80000),
('LYN004', 'Transfer Bandara (1-4 orang)', 300000),
('LYN005', 'Massage Spa (60 menit)', 450000),
('LYN006', 'Late Check-out (hingga 14:00)', 200000),
('LYN007', 'Early Check-in (dari 08:00)', 200000),
('LYN008', 'Tambahan Bed Extra', 350000),
('LYN009', 'Makan Malam Romantis', 650000),
('LYN010', 'Tur Kota (setengah hari)', 500000);

INSERT INTO ReservasiKamar VALUES 
('RSV202311001', 'K-101','2023-11-15 14:00:00', '2023-11-17 12:00:00', 'check-out'),
('RSV202311002', 'K-201','2023-11-16 14:00:00', '2023-11-19 12:00:00', 'check-in'),
('RSV202311003', 'K-301','2023-11-10 14:00:00', '2023-11-15 12:00:00', 'check-in'),
('RSV202311004', 'K-401','2023-11-20 14:00:00', '2023-11-22 12:00:00', 'dibatalkan'),
('RSV202311005', 'K-101','2023-11-18 14:00:00', '2023-11-20 12:00:00', 'check-out');

-- Data layanan tambahan untuk setiap reservasi
INSERT INTO LayananHotel VALUES 
('LYN001', 'RSV202311001'), -- Breakfast untuk RSV001
('LYN004', 'RSV202311001'), -- Transfer bandara untuk RSV001
('LYN001', 'RSV202311002'), -- Breakfast untuk RSV002
('LYN002', 'RSV202311003'), -- Laundry express untuk RSV003
('LYN005', 'RSV202311005'), -- Spa untuk RSV005
('LYN006', 'RSV202311005'); -- Late check-out untuk RSV005-- Tagihan dengan perhitungan yang akurat

INSERT INTO Tagihan VALUES 
('TAG202311001', 'RSV202311001', 1450000),  -- 2 malam Standard + breakfast + transfer
('TAG202311002', 'RSV202311002', 2400000),  -- 3 malam Superior + breakfast
('TAG202311003', 'RSV202311003', 6120000),  -- 5 malam Deluxe + laundry express
('TAG202311004', 'RSV202311004', 0),        -- Dibatalkan
('TAG202311005', 'RSV202311005', 1650000);  -- 2 malam Standard + spa + late check-out

