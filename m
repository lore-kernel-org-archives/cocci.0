From: keescook@google.com (Kees Cook)
Date: Mon, 11 Jun 2018 16:17:32 -0700
Subject: [Cocci] Weird whitespace behavior?
Message-ID: <CAGXu5j+XA87CBA9Xbqb4C-wLndaNW+usPgA9043m4TDeFUcxpw@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

I've been doing some large treewide changes to the allocators, and I
notice that Coccinelle does something odd for a specific case. I have
two scripts, one operating on kmalloc() and one operating on
devm_kmalloc(). They are identical script except for the function
names, however, while kmalloc produces patches like this:

- foo = kmalloc(a * b, gfp);
+ foo = kmalloc_array(a, b, gfp);

the devm_kmalloc one produces:

- foo = devm_kmalloc(handle, a * b, gfp);
+ foo =devm_kmalloc_array(a, b, gfp);

I can't figure out why the space after "=" is missing and have been
manually fixing it up...

-Kees

-- 
Kees Cook
Pixel Security
