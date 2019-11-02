# Timesheets

This is the Web Timesheets application. Here are some choices and justifications that I made during the implementation.

 * Database Design: I created 4 tables. They are "users", "tasks", "jobs", and "timesheets". I combined Manager and
   user in one sheets, because they basically have the same fields. And their difference is indicated by the id of 
   their manager. For manager, their manager's id is -1. On the other hand, for workers the manager field will be the
   id of their assigned manager. I separate tasks, jobs and timesheets because they have difference fields. And job
   and tasks have one to many relationship. The same with timesheets and tasks.
 * UI Design: I made sure that for both manager and worker, they can always easily navigate to all the page that they
   need. I always add related link at the end of the page based on the role of users.
 * Page Design: For each page, I designed the page based on users' role. For example, workers should not be able to 
   modify the job in any shape of form, etc...


To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
