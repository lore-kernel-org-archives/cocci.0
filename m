From: eliseomarmol@gmail.com (=?utf-8?Q?Eliseo_Mart=C3=ADnez?=)
Date: Sat, 20 Dec 2014 21:21:17 +0100
Subject: [Cocci] Change function invocations argument
Message-ID: <F51E5D4A-BD27-4192-95B7-2164D25A4380@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi, 

For a given function, I want to change all invocations in this way:
Turn the second argument of the form ?(long_u)(expression)? into ?(uintmax_t)expression?.
I?ve done a patch for that but is failing with a not very much informative message error.
Here is it:

```
eliseo at ubuntu:~/projects/os/neovim/neovim$ cat sample.cocci 
@@ expression e1, e2, e3; @@

  put_bytes(
    e1,
-   (long_u)(e2),
+   (uintmax_t)e2,
    e3)

eliseo at ubuntu:~/projects/os/neovim/neovim$ spatch --parse-cocci sample.cocci 
init_defs_builtins: /usr/share/coccinelle/standard.h
84 86
Fatal error: exception Failure("plus: parse error: 
 = File "sample.cocci", line 6, column 15,  charpos = 84
    around = 'e2', whole content = +   (uintmax_t)e2,
?)
```

What I?m doing wrong here??
Thanks.
