## Welcome to Active Books

### Process

Here's how we develop software.  Some high level goals are:
1. Iterate quickly - Deploy changes to production on a daily, not weekly basis.
2. Get better - Improve as a software developer every day.
3. Transparent and Open - It should be easy for any interested party to learn anything they want about the project.

### Git

#### Features

Decide what you want to work on. A feature from the backlog (we are using Trello) is a good place to start.

#### Branches
For each discrete feature or change, create a branch to work in.

The branch name should reflect who you are and what you're working on e.g. feature/name-of-the-feature(or number on Trello) or bug/name-of-the-bug(or number on Trello).

#### Tickets
Reference a ticket in every commit you make.

If there is no ticket for what you're working on, create a ticket for it.

#### Commits
Commit message should consist of title(or summary) and url to a user story.
```sh
  first line: the "summary" must be no more than 70-75 characters;
  next line:  the url to your feature on Trello
```

#### Pull requests
Push your code to github and make a PR early so that you can get feedback quickly.

Push the branch to github and make a pull request so you can start getting feedback on the code.
You don't have to wait until you want to merge the code to open the PR.
Open the PR as soon as you start working on a new branch so everyone can see what you're doing and has a place to comment on it.
90% of the time you will like and want to incorporate suggestions from the people reviewing your code.

#### Code review
Reviewing pending pull requests is your most urgent task at all times.

When you think you're done with branch, commit, or feature, alert QA and PM that there's work to review, deploy to the QA server.
When you see a PR go up, quickly get to a stopping point with what you're doing and review the code.
If everything looks good to them, i.e. somebody gives you a thumbs up or +1, merge the PR to master and deploy to production.

For changes that don't affect the UI, can skip the QA + PM approval step, since there isn't anything to see there.
The QA and PM are still welcome to review and comment on the PR.

#### Testing!
You should write tests for your code.

Tests
1. Let other developers have confidence your code works as advertised.
2. Help prevent regressions.
3. Provide clues about how to use and/or integrate with your code.

###Setup
```sh
 rake db:create
 rake db:migrate
```

Add references:
```sh
 rake activebooks:add_form_of_incorporation
 rake activebooks:add_kved
 rake activebooks:add_koatuu
 rake activebooks:add_form_of_article

 rake activebooks:add_tax_inspection

```
Run all rake tasks from activebooks namespace:
 ```sh
  rake activebooks:all
 ```

Create admin:
```sh
 rake db:seed
```

####Admin credentials:
- email: admin@example.com
- password: password


