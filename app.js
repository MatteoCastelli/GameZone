const express = require('express');
const mysql = require('mysql2');
const ejs = require('ejs');
const app = express();

const port = 3000;
const host = '127.0.0.1';


///////////////////////////////////////////// Sessione utente
const session = require('express-session');

app.use(session({
  secret: 'secret',
  resave: false,
  saveUninitialized: false
}));
/////////////////////////////////////////////////////////////

app.use(express.static('public'));
app.use(express.urlencoded({ extended: true }));
app.set('view engine', 'ejs');
app.locals.baseUrl = 'http://' + host + ':' + port + '/';

const db = mysql.createConnection({
  host: '127.0.0.1',
  user: 'root',
  password: '',
  database: 'game_zone' // <-- nome del tuo database
});

db.connect((err) => {
  if (err) {
    console.error('Errore di connessione al database:', err);
    return;
  }
  console.log('Connesso al database MySQL!');
});

app.get(['/', '/login'], (req, res) => {
  res.render('login', {});
});

app.get('/register', (req, res) => {
  res.render('register', {});
});

app.get('/homepage', (req, res) => {

  const perPage = 8;
  const currentPage = parseInt(req.query.page) || 1;
  const offset = (currentPage - 1) * perPage;

  const sql = `SELECT COUNT(*) AS count FROM giochi`;

  db.query(sql, (err, count) => {

    if (err) {
      res.status(500).send('Errore durante la query.');
      return;
    }

    const totalPages = Math.ceil(count[0].count / perPage);

    const sql = 'SELECT * FROM giochi ORDER BY titolo ASC LIMIT ? OFFSET ?';
    db.query(sql, [perPage, offset], (err, games) => {
      if (err) {
        res.status(500).send('Errore durante la query.');
        return;
      }
      res.render('homepage', {
        games: games,
        currentPage: currentPage,
        totalPages: totalPages,
        user: req.session.user || null
      });
    });
  })
});

app.get('/recensioni', (req, res) => {
  const gameId = parseInt(req.query.id);

  if (!gameId) {
    res.status(400).send('ID gioco non valido.');
    return;
  }

  const sql = 'SELECT * FROM giochi WHERE id = ?';
  db.query(sql, [gameId], (err, results) => {

    if (err) {
      res.status(500).send('Errore durante la query.');
      return;
    }

    if (results.length === 0) {
      res.status(404).send('Gioco non trovato.');
      return;
    }

    const sql = ` 
      SELECT r.voto, r.commento, r.data, u.username 
      FROM recensioni r 
      JOIN utenti u ON r.utente_id = u.id 
      WHERE r.gioco_id = ?
      ORDER BY r.data DESC
    `;

    db.query(sql, [gameId], (err, recensioni) => {
      if (err) {
        res.status(500).send('Errore durante la query.');
        return;
      }

      res.render('recensioni', {
        game: results[0],
        recensioni: recensioni,
        user: req.session.user
      });
    });
  });
});

app.post('/recensioni', (req, res) => {

  let gioco_id = req.body.gioco_id;
  let utente_id = req.body.utente_id;
  let voto = req.body.voto;
  let commento = req.body.commento;
  let data = new Date();

  const sql = `INSERT INTO recensioni (gioco_id, utente_id, voto, commento, data) VALUES (?, ?, ?, ?, ?)`;

  db.query(sql, [gioco_id, utente_id, voto, commento, data], (err, result) => {

    if (err) {
      res.status(500).send("Errore durante la query");
      return;
    }

    res.redirect('/homepage');

  })
})

app.post('/login', (req, res) => {

  let login = req.body.login.trim();
  let password = req.body.password.trim();

  const sql = `SELECT * FROM utenti WHERE (username = ? OR email = ?) AND password = ?`;

  db.query(sql, [login, login, password], (err, user) => {

    if (err) {
      res.status(500).send('Errore durante la query.');
      return;
    }

    if (user.length > 0) {
      req.session.user = user[0]; // salva i dati utente nella sessione
      res.redirect('/homepage');
    } else {
      res.render('login', { error: 'Credenziali non valide' });
    }
  });
})

app.post('/register', (req, res) => {

  let username = req.body.username.trim();
  let password = req.body.password.trim();
  let email = req.body.email.trim();

  const sql = `SELECT * FROM utenti WHERE username = ? OR email = ?`;

  db.query(sql, [username, email], (err, results) => {

    if (err) {
      res.status(500).send("Errore durante la query");
      return;
    }

    if (results.length > 0) {
      res.render('register', { error: 'Credenziali non valide' });
      return;
    }

    const sql = 'INSERT INTO utenti (username, email, password, active) VALUES (?, ?, ?, 1)';

    db.query(sql, [username, email, password], (err, result) => {
      if (err) {
        res.status(500).send('Errore durante la registrazione.');
        return;
      }

      res.redirect('/login');
    });
  })
})

app.get('/logout', (req, res) => {
  req.session.destroy(err => {
    res.redirect('/login');
  });
});

app.listen(port, host, () => {
  console.log('Server avviato su http://' + host + ':' + port + '/');
});