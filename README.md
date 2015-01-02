```sh
 rake db:create 
 rake db:migrate
```

Add references:
```sh
 rake activebooks:add_form_of_incorporation
 rake activebooks:add_form_of_invoice
 rake activebooks:add_kved
 rake activebooks:add_koatuu
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

#Admin credentials:

- email: admin@example.com
- password: password
