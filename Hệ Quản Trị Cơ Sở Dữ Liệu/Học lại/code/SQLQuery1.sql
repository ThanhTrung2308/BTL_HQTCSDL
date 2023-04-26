create database QLSV
On Primary(
	Name = QLSV ,
	FileName = 'D:\HQTCSDL\lesson1\QLSV.mdf',
	Size = 10MB,
	MaxSize = 50MB
	
)
Log On(
	Name = QLSV_log,
	FileName ='D:\HQTCSDL\lesson1\QLSV.ldf' ,
	Size = 5MB ,
	MaxSize = 25MB 
)

AlTER database QLSV modify name = QLCT

alter database QLCT
modify file (
	Name = QLCT, 
	Size = 60MB
)

alter database QLCT
add file (
	FileName = 'D:\HQTCSDL\lesson1\QLSV2.ldf',
	Size = 2mb
)