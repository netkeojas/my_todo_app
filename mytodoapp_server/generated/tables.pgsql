--
-- Class Todo as table todo
--

CREATE TABLE "todo" (
  "id" serial,
  "task" text NOT NULL,
  "description" text NOT NULL,
  "done" boolean NOT NULL
);

ALTER TABLE ONLY "todo"
  ADD CONSTRAINT todo_pkey PRIMARY KEY (id);


