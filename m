From: Nikolaus@rath.org (Nikolaus Rath)
Date: Fri, 07 Oct 2016 21:22:08 -0700
Subject: [Cocci] Replacing one (specific!) type with another
In-Reply-To: <alpine.DEB.2.10.1610052158110.3130@hadrien> (Julia Lawall's
 message of "Wed, 5 Oct 2016 22:02:21 +0200 (CEST)")
References: <87r37vzd8j.fsf@vostro.rath.org>
 <alpine.DEB.2.10.1610050744460.3061@hadrien>
 <87shsa7p71.fsf@thinkpad.rath.org>
 <alpine.DEB.2.10.1610052158110.3130@hadrien>
Message-ID: <8760p3jwr3.fsf@vostro.rath.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Oct 05 2016, Julia Lawall <julia.lawall@lip6.fr> wrote:
>>
>> 2. ..and how would I go about if instead of the type, I want to replace
>>    a variable name? (my_type *ptr --> my_type *pointer).
>
> I'm not completely sure what the issue is here.  Do you specifically want
> to convert ptr to pointer?  Is the type important?  To make exactly what
> you have written, you could put:
>
> @@
> typedef my_type;
> idexpression mytype * p1;
> @@
>
> - ptr at p1
> + pointer
>
> This checks for the word ptr, and also checks that it is an identifier of
> the right type.  I haven't tested it, so let me know if there is any
> problem.

It workes somewhat... but not completely.

Here's what I wanted to do: I merged two structures (struct fuse_session
and struct fuse_ll) into one (struct fuse_session). I've first replaced
all the type names, and then manually fixed the cases where this
resulted in bogus/redundant code (typically in functions that used to
work with both structs).

Now my project compiles and runs fine, but I the variable naming is
inconsistent: in some cases the struct fuse_session pointer is called
*se (these were the variables that were always of type struct
fuse_session), and in other cases the pointer is called *f (these were
the variables that were previously of type struct fuse_ll).

I'd like to fix this too, and always refer call fuse_session pointers
"se" (except where this name is already used for something else, but
I'll just fix this up by hand afterwards). I tried the following patch:

$ cat se-name.cocci 
@@
idexpression struct fuse_session *p1;
@@
- f at p1
+ se

but it resulted in these changes:

 	struct fuse_session *f = req->se;
-	struct cuse_data *cd = f->cuse_data;
-	size_t bufsize = f->bufsize;
+	struct cuse_data *cd = se->cuse_data;
+	size_t bufsize = se->bufsize;

So it seems to replace the variable where its used, but not where it's
defined.

Is there a way to catch the definitions too?


Best,
-Nikolaus


-- 
GPG encrypted emails preferred. Key id: 0xD113FCAC3C4E599F
Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F

             ?Time flies like an arrow, fruit flies like a Banana.?
