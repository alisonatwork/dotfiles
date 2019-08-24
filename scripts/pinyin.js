#!/usr/bin/env node

const EOL = require('os').EOL;
const readline = require('readline');

const MODES = {
  'n2m': numberToMark
};

const MARK_LOOKUP = {
  'a': ['ā', 'á', 'ǎ', 'à'],
  'e': ['ē', 'é', 'ě', 'è'],
  'i': ['ī', 'í', 'ǐ', 'ì'],
  'o': ['ō', 'ó', 'ǒ', 'ò'],
  'u': ['ū', 'ú', 'ǔ', 'ù'],
  'ü': ['ǖ', 'ǘ', 'ǚ', 'ǜ'],
  'A': ['Ā', 'Á', 'Ǎ', 'À'],
  'E': ['Ē', 'É', 'Ě', 'È'],
  'I': ['Ī', 'Í', 'Ǐ', 'Ì'],
  'O': ['Ō', 'Ó', 'Ǒ', 'Ò'],
  'U': ['Ū', 'Ú', 'Ǔ', 'Ù'],
  'Ü': ['Ǖ', 'Ǘ', 'Ǚ', 'Ǜ'],
};

function numberToMark(match, vowels, p2, suffix, tone) {
  const newvowels = vowels.replace(/(v|u:)/g, 'ü').replace(/(V|U:)/g, 'Ü');
  if (tone === '5') return newvowels + suffix;
  const vowel = (newvowels.length == 1 || /[aeo]/gi.test(newvowels[0])) ? newvowels[0] : newvowels[1];
  return newvowels.replace(vowel, MARK_LOOKUP[vowel][tone - 1]) + suffix;
}

const mode = process.argv[2] || 'n2m';
if (!MODES[mode]) {
  process.stderr.write(`Bad mode: ${mode}${EOL}`);
  process.exit(1);
}

const rl = readline.createInterface({
  input: process.stdin
});
rl.on('line', (input) => {
  process.stdout.write(input.replace(/(([aeiouüv]|[uU]:){1,3})(n?g?r?)([12345])/gi, MODES[mode]));
  process.stdout.write(EOL);
});
