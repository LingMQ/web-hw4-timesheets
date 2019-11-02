# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Timesheets.Repo.insert!(%Timesheets.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Timesheets.Repo
alias Timesheets.Users.User


pw1 = Argon2.hash_pwd_salt("password1234")
pw2 = Argon2.hash_pwd_salt("password5678")

Repo.insert!(%User{id: 4, name: "manager1", email: "m1@timesheet.com", manager: true, manager_id: -1, password_hash: pw1})
Repo.insert!(%User{id: 5, name: "manager2", email: "m2@timesheet.com", manager: true, manager_id: -1, password_hash: pw1})

Repo.insert!(%User{id: 6, name: "worker1", email: "w1@timesheet.com", manager: false, manager_id: 4, password_hash: pw2})
Repo.insert!(%User{id: 7, name: "worker2", email: "w2@timesheet.com", manager: false, manager_id: 4, password_hash: pw2})
Repo.insert!(%User{id: 8, name: "worker3", email: "w3@timesheet.com", manager: false, manager_id: 4, password_hash: pw2})