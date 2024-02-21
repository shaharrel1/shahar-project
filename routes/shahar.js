var express = require('express');
var router = express.Router();

/* GET users listing. */
router.get('/', function(req, res, next) {
  // Send HTML content with a smiley face emoji
  res.send('<h1 style="text-align: center;">😊</h1>');
});

module.exports = router;
