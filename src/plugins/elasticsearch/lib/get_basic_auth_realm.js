'use strict';

module.exports = function getBasicAuthRealm(message) {
  if (!message || typeof message !== 'string') return null;

  var parts = message.match(/Basic\ realm=\\"(.*)\\"/);
  if (parts && parts.length === 2) return parts[1];else return null;
};
