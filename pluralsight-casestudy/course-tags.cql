Create table course_tags (
    tag text,
    course_id text,
    PRIMARY KEY (tag, course_id)
) WITH comment='Table to store course tags';

alter table courses add tags set<text> static;

BEGIN BATCH
  UPDATE courses SET tags = {'developer', 'open-source'} WHERE id = 'nodejs-big-picture';
  INSERT INTO course_tags (tag, course_id) VALUES ('developer', 'nodejs-big-picture');
  INSERT INTO course_tags (tag, course_id) VALUES ('open-source', 'nodejs-big-picture');
APPLY BATCH;
BEGIN BATCH
  UPDATE courses SET tags = {'javascript', 'advanced'} WHERE id = 'advanced-javascript';
  INSERT INTO course_tags (tag, course_id) VALUES ('javascript', 'advanced-javascript');
  INSERT INTO course_tags (tag, course_id) VALUES ('advanced', 'advanced-javascript');
APPLY BATCH;
BEGIN BATCH
  UPDATE courses SET tags = {'python', 'advanced'} WHERE id = 'advanced-python';
  INSERT INTO course_tags (tag, course_id) VALUES ('python', 'advanced-python');
  INSERT INTO course_tags (tag, course_id) VALUES ('advanced', 'advanced-python');
APPLY BATCH;        