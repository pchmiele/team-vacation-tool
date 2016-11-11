
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

7. Verify if everything is ok. Tests should pass:
```
    mix test
```

8. Start server:
```
    iex -S mix phoenix.server
```

9. Open http://localhost:4000/ in browser
10. If everything is ok you should see:
![Img](.\docs\main.png)