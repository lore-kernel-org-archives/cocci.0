From: keescook@chromium.org (Kees Cook)
Date: Fri, 18 Aug 2017 09:54:01 -0700
Subject: [Cocci] isomorphism for &(structure)->field vs struct.field
Message-ID: <CAGXu5jJygEODLuphzbxgiUQ_Box3LZy1kOBiHS7Fp5jAkpOVGQ@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

I'd like to have a rule that would match both:

function(ptr);
ptr->field = 7;

and

function(&obj);
obj.field = 7;

to produce:

new_function(ptr, 7);

and

new_function(&obj, 7);

respectively. The internal isomorphisms don't seem to cover this? Or
I'm maybe doing something wrong?

Thanks!

-Kees

-- 
Kees Cook
Pixel Security
