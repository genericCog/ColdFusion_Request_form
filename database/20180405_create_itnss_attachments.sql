USE vaintradb
GO

DROP TABLE itnss_attachments

--Create table to hold information about files associated with an ITNSS request, 
--use a fk reference to itnss_requirement table id column to allow many-to-one
--relationship
--require values for referenced requirement, filepath, and uploaded by and on
--modified values can be left null, queries to table can use an if statement
--to select the modified by and date values if not null, uploaded values otherwise
CREATE TABLE itnss_attachments (
	id						INT				PRIMARY KEY IDENTITY,
	itnss_requirement_id	int				NOT NULL REFERENCES itnss_requirement(itnss_requirement_id),
	directory				varchar(1000)	NOT NULL,
	name					varchar(1000)	NOT NULL,
	size					int				NOT NULL DEFAULT 0,
	uploaded_on				DATETIME		NOT NULL DEFAULT(GETDATE()),
	uploaded_by				int				NOT NULL REFERENCES account_info(id),
	modified_on				DATETIME		NULL,
	modified_by				int				NULL REFERENCES account_info(id)
)