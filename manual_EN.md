# Demo Title

This is some demo text to demonstrate the generation of ingame manuals from
markdown files.

An advantage of this solution is the dual use of the documentation:

- The markdown file as web solution e. g. on GitHub
- The lua code for the ingame manual

## Firt Steps

After you have placed the Signs Bot Box, you can start the bot by means of the
'On' button in the box menu. If the bot returns to its box right away,
you will need to charge it with electrical energy (techage) first.
The bot then runs straight up until it reaches an obstacle
(a step with two or more blocks up or down or a sign.)

```
jump <label>    -- jump command, <label> is a word from the characters a-z or A-Z
<label>:        -- jump label / start of a function
return          -- return from a function
repeat <num>    -- start of a loop block, <num> is a number 1..999
end             -- end of a loop block
call <label>    -- call of a function (with return via the command 'return')
```

