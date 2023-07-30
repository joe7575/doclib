return {
  titles = {
    "1,Demo Title",
    "2,Firt Steps",
  },
  texts = {
    "This is some demo text to demonstrate the generation of ingame manuals from\n"..
    "markdown files.\n"..
    "\n"..
    "An advantage of this solution is the dual use of the documentation:\n"..
    "\n"..
    "  - The markdown file as web solution e. g. on GitHub\n"..
    "  - The lua code for the ingame manual\n"..
    "\n",
    "After you have placed the Signs Bot Box\\, you can start the bot by means of the\n"..
    "'On' button in the box menu. If the bot returns to its box right away\\,\n"..
    "you will need to charge it with electrical energy (techage) first.\n"..
    "The bot then runs straight up until it reaches an obstacle\n"..
    "(a step with two or more blocks up or down or a sign.)\n"..
    "\n"..
    "    jump <label>    -- jump command\\, <label> is a word from the characters a-z or A-Z\n"..
    "    <label>:        -- jump label / start of a function\n"..
    "    return          -- return from a function\n"..
    "    repeat <num>    -- start of a loop block\\, <num> is a number 1..999\n"..
    "    end             -- end of a loop block\n"..
    "    call <label>    -- call of a function (with return via the command 'return')\n"..
    "\n",
  },
  images = {
    "",
    "",
  },
  plans = {
    "",
    "",
  }
}