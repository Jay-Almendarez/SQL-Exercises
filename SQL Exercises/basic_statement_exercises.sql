SHOW DATABASES;
USE albums_db;
SHOW TABLES;
SELECT * FROM albums;
SELECT * FROM albums WHERE release_date BETWEEN 1990 AND 1999;

SELECT name, sales AS low_selling_albums FROM albums WHERE sales <20 ;
/* What is the primary key for the albums table?
ID is the primary key since in some entries, the name and artist are the same.

What does the column named 'name' represent?
'Name' represents a string type column.

What do you think the sales column represents?
The total revenue gained from the albums, indicating overall success

Find the name of all albums by Pink Floyd.
The Dark Side of The Moon
The Wall

What is the year Sgt. Pepper's Lonely Hearts Club Band was released?
1967

What is the genre for the album Nevermind?
Grunge, Alternative rock

Which albums were released in the 1990s?
Supernatural, Nevermind, Metallica, Titanic: Music from the Motion Picture, The Immaculate Collection,
Dangerous, Let's Talk About Love, Falling into You, Come On Over, Jagged Little Pill, The Bodyguard

Which albums had less than 20 million certified sales? Rename this column as low_selling_albums.
Grease: The Original Soundtrack from the Motion Picture, Sgt. Pepper's Lonely Hearts Club Band, 
Dirty Dancing, Let's Talk About Love, Dangerous, The Immaculate Collection, Abbey Road, Born in the U.S.A., 
Brothers in Arms, Titanic: Music from the Motion Picture, Nevermind, The Wall