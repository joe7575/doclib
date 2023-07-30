DocLib[doclib]
==============

**A library to generate ingame manuals based on markdown files.**

Browse on: [GitHub](https://github.com/joe7575/doclib)

Download: [GitHub](https://github.com/joe7575/doclib/archive/master.zip)

![DocLib](https://github.com/joe7575/doclib/blob/master/screenshot.png)


### Introduction

DocLib is used to generate a manual as ingame documentation.
The manual content is generated based on markdown files.

An advantage of this solution is the dual use of the documentation:

- A markdown file as web solution e. g. on GitHub
- A book as ingame manual

To generate a manual for your mod:

- Create your documentation as markdown file
- Copy the python script `markdown_to_lua.py` to your mod folder
- Add your markdown file to the python script (the last few lines)
- Install mistune with `pip install mistune==0.8.4`
- Run the script with `python markdown_to_lua.py`
- Implement the book node according to `node.lua`


### Supported Markdown Markups

- Heading
- List
- Code block


### License

Copyright (C) 2023 Joachim Stolberg

Code: Licensed under the GNU AGPL version 3. See LICENSE.txt    
Textures: CC BY-SA 3.0 


### Dependencies 

none


### History

- 2023-07-30  V1.00  * First commit



