

DROP TABLE CONTRACT CASCADE CONSTRAINTS;

DROP TABLE TASK CASCADE CONSTRAINTS;

 

CREATE TABLE TASK (

TaskID CHAR(3),

TaskName VARCHAR(20),

ContractCount NUMERIC(1,0) DEFAULT 0,

CONSTRAINT PK_TASK PRIMARY KEY (TaskID)

);

 

CREATE TABLE CONTRACT

(

TaskID CHAR(3),

WorkerID CHAR(7),

Payment NUMERIC(6,2),

CONSTRAINT PK_CONTRACT PRIMARY KEY (TaskID, WorkerID),

CONSTRAINT FK_CONTRACTTASK FOREIGN KEY (TaskID) REFERENCES TASK (TaskID)

);

 

INSERT INTO TASK (TaskID, TaskName) VALUES ('333', 'Security' );

INSERT INTO TASK (TaskID, TaskName) VALUES ('322', 'Infrastructure');

INSERT INTO TASK (TaskID, TaskName) VALUES ('896', 'Compliance' );

 

SELECT * FROM TASK;

COMMIT;

CREATE OR REPLACE TRIGGER NewContract
BEFORE INSERT ON CONTRACT
FOR EACH ROW
DECLARE
  cc  NUMERIC(1,0);
BEGIN
  SELECT ContractCount INTO cc
    FROM TASK
   WHERE TaskID = :new.TaskID;
  IF cc = 3 THEN
    raise_application_error(-20001, 'Rejected new contract. Task full');
  ELSE
    UPDATE TASK
    SET ContractCount = ContractCount + 1
    WHERE TaskID = :new.TaskID;
  END IF;
END;

CREATE OR REPLACE TRIGGER EndContract
AFTER DELETE ON CONTRACT
FOR EACH ROW
BEGIN
  UPDATE TASK
  SET ContractCount = ContractCount - 1
  WHERE TaskID = :old.TaskID;
END;

CREATE OR REPLACE TRIGGER NoChanges
BEFORE UPDATE ON CONTRACT
BEGIN
    raise_application_error(-20002, 'No updates are permitted to existing rows');
END;

INSERT INTO CONTRACT (TaskID, WorkerID, Payment) VALUES ('333', '11', 1.0 );
INSERT INTO CONTRACT (TaskID, WorkerID, Payment) VALUES ('333', '22', 2.0 );
INSERT INTO CONTRACT (TaskID, WorkerID, Payment) VALUES ('333', '33', 3.0 );
INSERT INTO CONTRACT (TaskID, WorkerID, Payment) VALUES ('333', '44', 4.0 );

UPDATE CONTRACT SET Payment = 4.0 WHERE WorkerID = '11';

DELETE FROM CONTRACT WHERE taskid = '333';