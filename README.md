
# Description

Vacation planning tool for teams

# Installation

1. Install [elixir](http://elixir-lang.org/install.html)
2. Install [phoenix](http://www.phoenixframework.org/docs/installation)
3. Install [postgress](https://www.postgresql.org/download)
4. Install [elm](http://install.elm-lang.org/Elm-Platform-0.17.1.exe)
5. Install [nodejs](https://nodejs.org/en/) >= 5.0v
6. Install dependencies: 

```bash
    npm install
    mix deps.get
```
7. Create and update database:

``` 
    mix ecto.create # Run only if it is your first time. This command will create new database.
    mix ecto.migrate
```

8. Verify if everything is ok. Tests should pass:
```
    mix test
```

9. Start server:
```
    iex -S mix phoenix.server
```

10. Open http://localhost:4000/ in browser
11. If everything is ok you should see:
![Img](https://github.com/pchmiele/team_vacation_tool/blob/master/docs/main.png)