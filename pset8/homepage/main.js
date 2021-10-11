/**
 * Toggle between adding and removing the "responsive" class to topnav when the user clicks on the icon 
 */
function Tooggle() {
    var x = document.getElementById("myTopnav");
    if (x.className === "topnav") {
      x.className += " responsive";
    } else {
      x.className = "topnav";
    }
}

/**
 * creates Readability class to make all the calculations
 */
function checkReadbility() {
  var input = document.querySelector('#input'); // get input text
  Readability(input.value, document.querySelector('#info-grade'), document.querySelector('#info-meta'));
}

/**
 * Shows or hides the toggeld group
 * @param {string} id id of elemt to drop down
 */
function dropdown(id) {
    var elem = document.querySelector(`#${id}`);
    elem.hidden = !elem.hidden;
}

/**
 * Class for readability calculations with the Coleman-Liau index
 */
class Readability {
  /**
   * 
   * @param {string} s text to check
   * @param {HTMLElement} elem Element to display grad in
   * @param {HTMLElement} meta Element to display meta information in
   */
  constructor(s, elem, meta) {
    this.text = s;
    var letters = this.countLetters();
    var words = this.countWords();
    var sen = this.countSentences();

    // calculating values
    var L = (letters / words) * 100;
    var S = (sen / words) * 100;
    // now the index
    this.index = 0.0588 * L - 0.296 * S - 15.8;
    elem.hidden = false;
    
    // now present the results
    while( elem.firstChild ) {
      elem.removeChild( elem.firstChild );
    }

    if (this.index > 16) {
      elem.appendChild( document.createTextNode("Grade 16+") );
    }
    else if (this.index < 1) {
      elem.appendChild( document.createTextNode("Before Grade 1") );
    }
    else {
      elem.appendChild( document.createTextNode(`Grade ${Math.round(this.index)}`) );
    }

    meta.hidden = false;
    while( meta.firstChild ) {
      meta.removeChild( meta.firstChild );
    }
    meta.appendChild( document.createTextNode(`Letters: ${letters} Words: ${words} Sentences: ${sen}`) );
  }

  /**
   * Counts letters in member string
   * @returns number of letters
   */
  countLetters() {
    return this.text.replace(/[^A-Z]/gi, "").length;
  }

  /**
   * Counts words in member string
   * @returns number of words
   */
  countWords() {
     return this.text.match(/(\w+)/g).length;
  }

  /**
   * Counts sentences in member string
   * @returns number of sentences
   */
  countSentences() {
    return this.text.match(/[\w|\)][.?!](\s|$)/g).length
  }
  
}