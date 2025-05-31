 CREATE TABLE usr (
  id        INTEGER,
  name      VARCHAR(24),
  creation  DATE,
  isAdmin   BOOLEAN,
  cue       VARCHAR(10),
  
  CONSTRAINT usr_pk
    PRIMARY KEY(usrid)
)
;

CREATE TABLE quiz (
  id        INTEGER,
  name      VARCHAR(150),
  type      VARCHAR(25),
  creation  DATE,
  
  CONSTRAINT quiz_pk 
    PRIMARY KEY(lbid)
  CONSTRAINT quiztype_fk_types
    FOREIGN KEY (type) REFERENCES types(typshort)
)
;

CREATE TABLE types (
  typshort  VARCHAR(5),
  type      VARCHAR(25),

  CONSTRAINT types_pk
    PRIMARY KEY(typshort)
)
;

CREATE TABLE question (
  id        INTEGER,
  text      VARCHAR(150),
  quizid    INTEGER,
  
  CONSTRAINT question_pk
    PRIMARY KEY(quizid,id)
    
  CONSTRAINT question_fk_quizid
    FOREIGN KEY(quizid) REFERENCES quiz(id)
)
;

CREATE TABLE answer (
  id        INTEGER,
  questid   INTEGER,
  isRight   BOOLEAN,
  
  CONSTRAINT answer_pk 
    PRIMARY KEY(questid,id),
    
  CONSTRAINT answer_fk_questid
    FOREIGN KEY(questid) REFERENCES question(id)
)
;

CREATE TABLE attempt (
  id        INTEGER,
  timetaken INTEGER,
  wrongs    INTEGER,
  rights    INTEGER,
  
  usrid     INTEGER,
  quizid    INTEGER,
  
  CONSTRAINT attempt_pk
    PRIMARY KEY(usrid,quizid,attemptid),
    
  CONSTRAINT attempt_fk_usr
    FOREIGN KEY(usrid) REFERENCES usr(id),
    
  CONSTRAINT attempt_fk_lb
    FOREIGN KEY(quizid) REFERENCES quiz(id)
)
;

CREATE TABLE author (
  usrid     INTEGER,
  quizid    INTEGER,
  
  CONSTRAINT author_pk
    PRIMARY KEY(quizid),
    
  CONSTRAINT author_fk_usr
    FOREIGN KEY(usrid) REFERENCES usr(id),
    
  CONSTRAINT author_fk_lb
    FOREIGN KEY(quizid) REFERENCES quiz(id)
)
;

INSERT INTO types(typshort, type) VALUES
    ('t-spo','Sport'),
    ('t-cmo','Culture Moderne'),
    ('t-cge','Culture Générale'),
    ('t-lan','Langues'),
    ('t-geo','Géographie'),
    ('t-his','Histoire'),
    ('t-fef','Faune et Flore'),
    ('t-sci','Sciences'),
    ('t-aut','Autres')
;


INSERT INTO usr(id,name,creation,isAdmin,cue) values
  (1,'ashley','2025-02-01',true,'skibidi'),
  (2,'doryan','2025-04-29',false,'gyatt')
;

INSERT INTO quiz(id,name,creation) values
  (1,'italian brainrot name guesser','2025-03-04'),
  (2,'guess the celebrity feet','2025-04-29')
;

INSERT INTO author(quizid,usrid) values
  (1,1),
  (2,1)
;

INSERT INTO attempt(quizid,usrid,attemptid,timetaken,wrongs,rights) values
  (1,1,1,504,1,13),
  (1,2,1,572,6,8),
  (1,1,2,492,0,14)
;
  
SELECT * FROM quiz;
SELECT * FROM usr;
SELECT usr.name, qz.name, att.attemptid, att.rights, att.wrongs, att.timetaken
FROM usr 
INNER JOIN attempt att
ON att.usrid = usr.usrid
INNER JOIN quiz qz 
ON lb.lbid = att.lbid
ORDER BY att.timetaken
;
