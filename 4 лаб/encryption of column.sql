--Certificates
CREATE DATABASE TestEnc;
USE TestEnc;
CREATE TABLE TableCertEnc1(Name nvarchar(100));

CREATE CERTIFICATE OurCert1
   ENCRYPTION BY PASSWORD = 'Konstantin1@#Password'
   WITH SUBJECT = 'example1';--определяет цель выдачи сертификата (его значением заполняется соответствующее поле сертификата в соответствии со стандартом X.509v1)

INSERT INTO TableCertEnc1
   values(EncryptByCert(Cert_ID('OurCert1'), N'Secret Name'));

--Delete from TableCertEnc1
Select * From TableCertEnc1

SELECT (Convert(Nvarchar(100), DecryptByCert(Cert_ID('OurCert1'), Name, N'Konstantin1@#Password'))) FROM TableCertEnc1;

--DecryptByCert - функция для расшифровки
-- 1ый параметр - идентификатор сертификата
-- 2ой параметр - строка, переменная или столбец для расшифровки
-- 3ий параметр - пароль указанный при создании сертификата



-- Асимметричный ключ
CREATE TABLE TableAsKey(Name nvarchar(100));

CREATE ASYMMETRIC KEY AsKey
   WITH ALGORITHM = RSA_512
   ENCRYPTION BY PASSWORD = 'Konstantin1@#Password';

INSERT INTO TableAsKey
   values(EncryptByAsymKey(AsymKey_ID('AsKey'), N'Secret Name'));
Select * from TableAsKey

SELECT (Convert(Nvarchar(100), DecryptByAsymKey(AsymKey_ID('AsKey'),Name, N'Konstantin1@#Password'))) FROM TableAsKey;


-- Симметричный ключ
CREATE TABLE TableSymKey(Name nvarchar(100));

CREATE SYMMETRIC KEY SymKey
   WITH ALGORITHM = AES_128
   ENCRYPTION BY PASSWORD = 'Konstantin1@#Password';

OPEN SYMMETRIC KEY SymKey DECRYPTION BY PASSWORD = 'Konstantin1@#Password';
INSERT INTO TableSymKey
   values(EncryptByKey(Key_GUID('SymKey'), N'Secret Name'));
select * from TableSymKey

SELECT (Convert(Nvarchar(100), DecryptByKey(Name))) FROM TableSymKey;

-- Шифрование с помощью пароля
CREATE TABLE TablePassword(Name nvarchar(100));
INSERT INTO TablePassword
   values(EncryptByPassphrase('Konstantin1@#Password', N'Secret Name'));
Select * from TablePassword

SELECT (Convert(Nvarchar(100), DecryptByPassphrase('Konstantin1@#Password', Name))) FROM TablePassword;



-- Защита симметричного ключа пользовательским сертификатом
--step 1
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'Konstantin?#%12345';
--DROP MASTER KEY

--step 2
CREATE TABLE Programmers
(Id int identity,
Name nvarchar(100),
Lang nvarchar(100),
Salary varbinary(128))
--Drop table Programmers

--step 3
CREATE CERTIFICATE Cert1
    WITH SUBJECT = 'Secret info - Salary';
GO

CREATE SYMMETRIC KEY SymKey
	WITH ALGORITHM = AES_256
	ENCRYPTION BY CERTIFICATE Cert1;
GO
--DROP SYMMETRIC KEY SymKey

--step 4
OPEN SYMMETRIC KEY SymKey
	DECRYPTION BY CERTIFICATE Cert1;
INSERT INTO Programmers VALUES
('Peter', 'C++', EncryptByKey(Key_GUID('SymKey'), '3000')),
('Mary', 'C++', EncryptByKey(Key_GUID('SymKey'), '2500')),
('Konstantin', 'Java', EncryptByKey(Key_GUID('SymKey'), '23415')),
('Vladimir', 'Java', EncryptByKey(Key_GUID('SymKey'), '56432')),
('Kate',  'C#', EncryptByKey(Key_GUID('SymKey'), '23456'))
--DELETE  FROM TABLE3
--step 5
SELECT *, CONVERT(varchar, DecryptByKey(Salary)) AS [Decrypted Salary]
FROM Programmers
SELECT * FROM Programmers

CLOSE SYMMETRIC KEY SymKey