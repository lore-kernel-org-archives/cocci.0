From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 5 Oct 2016 07:51:07 +0200
Subject: [Cocci] Replacing one (specific!) type with another
In-Reply-To: <87r37vzd8j.fsf@vostro.rath.org>
References: <87r37vzd8j.fsf@vostro.rath.org>
Message-ID: <ab724929-bb12-347e-cb36-77b229683098@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Based on the LWN articles that I've read, this seems like the perfect
> use-case for coccinelle.

I would expect this also if you are interested in the simple replacement
for the data type of a function parameter.


> However, somehow I'm struggling to write a patch for this.

Are you exploring the software development possibilities together with
the semantic patch language?


> All the documentation that I could get my hands on seems to describe
> more abstract changes that require the use of variables

SmPL metavariables have got their purposes. How do you think about
to discuss a bit more if you will eventually use them also?


> - but as far as I can tell, I need something much simpler:

There are some improvement opportunities in this approach.


> @@
> "struct fasel_foo must be a type name!"
> @@

How did you get the idea to place this test string there?


> - struct fasel_foo
> + struct fasel_bar
> 
> 
> ...if only I knew what to put between the @@.

Are the other parts of this source code search pattern also incomplete so far?


> Can someone point me in the right direction?

I hope so.

Would the following small SmPL script fit to your expectations?


@data_type_replacement@
@@
 char* fasel_foo_print(
-struct fasel_foo
+struct fasel_bar
                       *ptr) {
    // ...
   return "this struct fasel_foo string should not change";
}



Regards,
Markus
