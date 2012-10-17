From: itismohit@gmail.com (Mohit Gupta)
Date: Wed, 17 Oct 2012 17:33:17 +0000 (UTC)
Subject: [Cocci] Mysterious parsing issue.
Message-ID: <loom.20121017T191721-59@post.gmane.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

I am trying to parse this c file containing macros. ( C file and the macro file
is pasted below.)  This parses fine, if I uncomment the first line "STATIC int
abc;" 

If I uncomment the line but change the order so as to make the first line as "
INT funcf ARGS((char *));" . Then again it gives parsing issues.

Is the parsing supposed to be dependent on order of statements or preclusion of
another statement ? Are we looking at a potential bug ?

Kindly help. 

Thanks,Mohit

Command : spatch --parse-c simple.c --macro-file simple_macro

// simple.c :

//STATIC int abc;

INT funcf ARGS((char *));

char *g ARGS((char *));

INT funcf (char *c)
{
        return 1;
}

char *g (char *c)
{
        return "junk";
}


//end of simple.c

//simple_macro
#define ARGS(m)   m

#define STATIC static

#define INT int
//end of simple_macro


//parsing error :

(ONCE) CPP-MACRO: found known macro = INT
(ONCE) CPP-MACRO: found known macro = ARGS
TYPEDEF:_handle_typedef=false. Not normal if dont come from exn
ERROR-RECOV: found sync col 0 at line 7
parsing pass4: try again
TYPEDEF:_handle_typedef=false. Not normal if dont come from exn
ERROR-RECOV: found sync col 0 at line 7
semantic error two or more data types: t ((((0, 2)))) ii [((("INT", 21, 5, 0,
"simple.c")), (0), ((0, 0, 0, 0)))]
typeD Tag8 ((["funcf"; ((("funcf", 25, 5, 4, "simple.c")), (0), ((0, 0, 0,
0)))]), 0) ii2 0

 =File "simple.c", line 5, column 15,  charpos = 36
    around = '(', whole content = INT funcf ARGS((char *));
