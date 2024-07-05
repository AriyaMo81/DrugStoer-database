use drg

CREATE TABLE level_of_expertise(
	loe# int NOT NULL,
	title varchar(100) UNIQUE NOT NULL,
	PRIMARY KEY (loe#)
)

INSERT INTO level_of_expertise VALUES(1, N'متخصص دندانپزشکی کودکان');
INSERT INTO level_of_expertise VALUES(2, N'متخصص کلیه و مجاری ادراری');

INSERT INTO level_of_expertise VALUES(3, N'متخصص دندانپزشکی کودکان و نوجوانان');


CREATE TABLE doctor(
	d# int NOT NULL,
	doc_name varchar(30) NOT NULL,
	mobile varchar(11) NOT NULL,
	office_address nvarchar(150),
	city varchar(15),
	postal_code varchar(12),
	office_phone varchar(11),
	PRIMARY KEY(d#)
	)


INSERT INTO doctor VALUES(1, N'علی بهزادی', '09136209801', N'خیابان آپادانا اول، حدفاصل مسجد بهشت تا خیابان سجاد، ساختمان آرین، پلاک ۶۱، طبقه چهارم، مطب دکتر علی بهزادی', 'Isfahan', '8184998715', '03136410449');
INSERT INTO doctor VALUES(2, N'امیر جاوید', '09106391932', N'اصفهان ، خیابان شمس آبادی ، روبروی بانک ملت ، جنب داروخانه دکتر رفیعی نیا، مجتمع صبا واحد ۵', 'Isfahan', '8184998716', '');
INSERT INTO doctor VALUES(3, N'بهاره شقایقی', '09915329771', N'خ بزرگمهر جنب رکن الدوله ساختمان امیتیس طبقه اول واحد ۱۰۲', 'Isfahan', '8184998711', '');







CREATE TABLE rel_table_doc_and_level(
	id int IDENTITY(1,1),
	d# int not null,
	loe# int not null,

	PRIMARY KEY(id),
	FOREIGN KEY (d#) REFERENCES doctor(d#) ON DELETE CASCADE,
	FOREIGN KEY (loe#) REFERENCES level_of_expertise(loe#) ON DELETE CASCADE
)

INSERT INTO rel_table_doc_and_level VALUES(1,1);
INSERT INTO rel_table_doc_and_level VALUES(2, 2);
INSERT INTO rel_table_doc_and_level VALUES(3, 3);


CREATE TABLE pharmacy(
	ph# int NOT NULL,
	w_time varchar(25),
	phone varchar(13),
	ph_name varchar(100),
	city varchar(15),
	ph_address nvarchar(150),
	ph_type varchar(10),
	postal_code varchar(12),
	
	PRIMARY KEY(ph#)
)

INSERT INTO pharmacy VALUES(1,N'8 تا 12 شب', '03137755950', N'داروخانه دکتر ترابی', 'Isfahan', N'اصفهان، بلوار کشاورز نرسیده به پمپ بنزین قائمیه', N'خصوصی', '8486997984');
INSERT INTO pharmacy VALUES(2,N'8 تا 12 شب', '03134482100', N'داروخانه دکتر ذاکری	', 'Isfahan', N'اصفهان، خ کاوه، میدان 25 آبان	', N'خصوصی', '8486997984');
INSERT INTO pharmacy VALUES(3,N'8 تا 12 شب', '03132225547', N'داروخانه داروخانه فارابی	', 'Isfahan', N'اصفهان، فلکه فلسطین ابتدای خیابان امادگاه	', N'خصوصی', '8486997983');


CREATE TABLE compony(
	comp# int NOT NULL,
	city varchar(10) NOT NULL,
	comp_name varchar(100) NOT NULL,
	postal_code varchar(15) ,
	establishment_date DATE NOT NULL,
	phone varchar(12) NOT NULL,
	comp_address nvarchar(150) NOT NULL,
	
	PRIMARY KEY (comp#)
)

INSERT INTO compony VALUES(1,'Isfahan', N'شرکت نانو الوند آراد', '9877486918', CAST('2015-12-25' AS Date), '03134457960', N' اصفهان، خیابان چهارباغ پایین، ساختمان لاله، طبقه اول');
INSERT INTO compony VALUES(2,'Isfahan', N'شرکت شفا گسترآیریک', '9878486918', CAST('2017-10-15' AS Date), '03123323775', N' اصفهان، خیابان وحید، ساختمان امین، طبقه پنجم، واحد 43');
INSERT INTO compony VALUES(3,'Isfahan', N'شرکت گستر نیا', '9878486916', '2015-10-15', '03123323785', N' اصفهان، خیابان هشت بهشت، ساختمان امین، طبقه اول، واحد 3');


CREATE TABLE medicine(
	med# int NOT NULL,
	med_name varchar(100) NOT NULL,
	inventory int NOT NULL,
	price int ,
	date_of_manufacture DATE NOT NULL,
	expire_date DATE NOT NULL,
	med_description nvarchar(300) NOT NULL,
	manufacturer int,

	PRIMARY KEY(med#),

	FOREIGN KEY (manufacturer) REFERENCES compony(comp#) ON DELETE CASCADE
)


INSERT INTO medicine VALUES(1, N'ضد عفونی و ترمیم کننده زخم نیواشا', 10,50000, '2023-10-25', '2024-10-25', N'این اسپری به منظور درمان آسیبهای پوستی و ترمیم آثار به جای مانده از جوش،ضربه ، جراحی ، تغیر رنگ موضعی پوست ناشی از سوختگی ، تماس با مواد آسیب رسان پوستی و بیماری های مختلف پوستی و همچنین به منظور پانسمان موضع زخم ، پس از عمل های جراحی زیبایی (جراحی پلاستیک) کاربرد فوق العاده ای دارد', 1);
INSERT INTO medicine VALUES(2, N'کرم مرطوب کننده پوست', 30,100000, '2023-11-10', '2025-11-10', N'کرم مناسب برای پوست های خشک و دارای لک', 2);
INSERT INTO medicine VALUES(3, N'قرص سرما خوردگی', 30,100000, '2022-11-10', '2023-11-10', N'مناسب برای سرما خوردگی', 3);

CREATE TABLE patient(
	p# int NOT NULL,
	p_first_name varchar(100) NOT NULL,
	p_last_name varchar(100) NOT NULL,
	gender VARCHAR(6) NOT NULL CHECK (gender IN('male', 'female')),
	type_of_insurance varchar(100),
	birthdate DATE,
	national_code varchar(15) UNIQUE NOT NULL,
	phone varchar(12) ,
	mobile varchar(12),
	p_address nvarchar(150) NOT NULL, 
	city varchar(15) NOT NULL,
	postal_code varchar(12),
	details nvarchar(150),
	PRIMARY KEY (p#)
	) 

INSERT INTO patient VALUES(1, N'علیرضا', N'فتاحی', 'male', N'تامین اجتماعی', '2001-1-05' , '1279689450','03132698708', '09352214108', 'اصفهان خیابان صائب .....', 'Isfahan', '8789665718', '')
INSERT INTO patient VALUES(2, N'آریا', N'مختارپور', 'male', N'تامین اجتماعی', '2002-1-05', '1276989470', '03132698708', '09352215908', 'شهر کرد .....', 'Isfahan', '8789765718', '')



CREATE TABLE invoice(
	i# int NOT NULL,
	med# int NOT NULL,
	p# int NOT NULL,
	amount int NOT NULL,
	date_of_manufacture DATE NOT NULL,
	invoice_status varchar(10) NOT NULL CHECK (invoice_status IN('pending', 'accepted', 'canceled', 'rejected')),
	payment_type varchar(100) NOT NULL,
	invoice_description nvarchar(150) ,

	PRIMARY KEY (i#),
	FOREIGN KEY (med#) REFERENCES medicine(med#) ON DELETE CASCADE,
	FOREIGN KEY (p#) REFERENCES patient(p#) ON DELETE CASCADE
)

INSERT INTO invoice VALUES(1, 1, 1, 150000, '2023-12-25', 'accepted', N'نقدی', N'پرداخت فاکتور دارو ها')
INSERT INTO invoice VALUES(2, 2, 2, 200000, '2023-12-26', 'accepted', N'نقدی', N'پرداخت فاکتور دارو ها')
INSERT INTO invoice VALUES(3, 3, 2, 300000, '2024-01-01', 'accepted', N'نقدی', N'پرداخت فاکتور دارو ها')


CREATE TABLE medical_center(
	mc# int NOT NULL,
	mc_type varchar(20),
	phone varchar(13),
	mc_name varchar(100),
	city varchar(15),
	mc_address nvarchar(150),
	postal_code varchar(12),
	PRIMARY KEY(mc#)
)

INSERT INTO medical_center VALUES(1,N'شبانه روزی', '03137755950', N'درمانگاه شبانه روزی ابوالفضل', 'Isfahan', N'اصفهان، خیابان کاوه',  '8486997984');
INSERT INTO medical_center VALUES(2,N'بیمارستان', '03137755950', N'بیمارستان الزهرا', 'Isfahan', N'بلوار صفه – مرکز آموزشی درمانی الزهرا(س)',  '8486997984');


/* not complete */
CREATE TABLE employee(
	em# int NOT NULL,
	mc# int,
	ph# int,
	employee_name varchar(100) NOT NULL,
	gender VARCHAR(6) NOT NULL CHECK (gender IN('male', 'female')),
	last_educational_certificate varchar(100),
	job_title varchar(100) NOT NULL,
	national_code varchar(15),
	mobile varchar(11),
	phone varchar(11),
	emp_address nvarchar(150),
	city varchar(15),
	postal_code varchar(10),
	birthdate Date,
	date_of_employeement DATE,
	PRIMARY KEY (em#),
	FOREIGN KEY (mc#) REFERENCES medical_center(mc#) ON DELETE CASCADE,
	FOREIGN KEY (ph#) REFERENCES pharmacy(ph#) ON DELETE CASCADE
	) 


INSERT INTO employee VALUES(1, null, 1, N'علی علوی', 'male', 'دکتری داروسازی', N'دکتر داروساز', '1276989470', '09352215908', '03132698708', N'اصفهان .....', 'Isfahan', '8789765718', CAST('1998-1-05' AS Date), CAST('2019-1-05' AS Date))
INSERT INTO employee VALUES(2, null, 2, N'مهناز صادقی', 'female','دکتری داروسازی', N'دکتر داروساز', '1276989580', '09352215508', '03132698708', N'اصفهان .....', 'Isfahan', '8789765718', CAST('1990-1-05' AS Date), CAST('2020-1-05' AS Date))
INSERT INTO employee VALUES(3, null, 3, N'مریم جلالی', 'female','فوق لیسانس حساب داری', N'صندوق دار', '1276989588', '09356698702', '03132698799', N'اصفهان .....', 'Isfahan', '8789765748', CAST('1996-3-21' AS Date), CAST('2022-1-05' AS Date))


/* medicine and invoice */
CREATE TABLE rel_table_inv_med(
	med# int NOT NULL,
	i# int NOT NULL,
	med_count int NOT NULL,

	FOREIGN KEY (med#) REFERENCES medicine(med#),
	FOREIGN KEY (i#) REFERENCES invoice(i#)

)

INSERT INTO rel_table_inv_med VALUES(1, 1 ,3)
INSERT INTO rel_table_inv_med VALUES(1,  2, 4)
INSERT INTO rel_table_inv_med VALUES(3,  3,2 )
INSERT INTO rel_table_inv_med VALUES(2,  3,1 )


CREATE TABLE rel_table_med_center_doc(
	id int IDENTITY(1,1),
	d# int NOT NULL,
	mc# int NOT NULL

	PRIMARY KEY(id),
	FOREIGN KEY (mc#) REFERENCES medical_center(mc#),
	FOREIGN KEY (d#) REFERENCES doctor(d#)

)

INSERT INTO rel_table_med_center_doc VALUES(1, 1)
INSERT INTO rel_table_med_center_doc VALUES(2,  2)


CREATE TABLE rel_table_patient_doc(
	id int IDENTITY(1,1),
	d# int NOT NULL,
	p# int NOT NULL,
	v_date DATE,

	PRIMARY KEY(id),
	FOREIGN KEY (d#) REFERENCES doctor(d#) ON DELETE CASCADE,
	FOREIGN KEY (p#) REFERENCES patient(p#) ON DELETE CASCADE

)

INSERT INTO rel_table_patient_doc VALUES(1, 1, CAST('2023-1-05' AS Date))
INSERT INTO rel_table_patient_doc VALUES(2, 1, CAST('2023-10-15' AS Date))




/* alireza */

/* داروهایی که کاربر خریده */
SELECT p.p_first_name, p.p_last_name, i.i#, i.amount,COUNT(r.med#) AS med_count, STRING_AGG(m.med_name, ', ') AS med_names
FROM patient p
INNER JOIN invoice i ON p.p# = i.p#
LEFT JOIN rel_table_inv_med r ON i.i# = r.i#
LEFT JOIN medicine m ON r.med# = m.med#
GROUP BY p.p_first_name, p.p_last_name, i.i#, i.amount
/* داروهایی که کاربر خریده */



SELECT p_first_name , p_last_name FROM patient WHERE p_first_name LIKE '%ali%' OR p_first_name LIKE '%reza%'

SELECT AVG(amount) as sum_amount FROM invoice

/* دکتر ها همراه با سطح تخصص */
SELECT d.doc_name, d.mobile, d.office_address, STRING_AGG(l.title, ', ') AS exertise_titles FROM doctor d
LEFT JOIN rel_table_doc_and_level r ON d.d# = r.d#
LEFT JOIN level_of_expertise l ON l.loe# = r.loe#
GROUP BY d.doc_name, d.mobile, d.office_address
/* دکتر ها همراه با سطح تخصص */
/* alireza */


/* arya */
SELECT AVG(amount) as sum_amount FROM invoice WHERE date_of_manufacture < '2023-12-29'

SELECT p.p_first_name, p.p_last_name,
SUM(i.amount) as sum_amount 
FROM 
patient p
INNER JOIN invoice i ON p.p# = i.p#
GROUP BY p.p_first_name, p.p_last_name

SELECT p.p_first_name, p.p_last_name FROM  patient p
INNER JOIN rel_table_patient_doc r ON p.p# = r.p#
INNER JOIN doctor d ON d.d# = r.d# WHERE d.d# = 1
/* arya */

