From: linux@rasmusvillemoes.dk (Rasmus Villemoes)
Date: Thu, 11 Sep 2014 11:09:03 +0200
Subject: [Cocci] Matching literal strings
In-Reply-To: <alpine.DEB.2.10.1409111054500.2419@hadrien> (Julia Lawall's
 message of "Thu, 11 Sep 2014 11:02:55 +0200 (CEST)")
References: <87wq9aedwx.fsf@rasmusvillemoes.dk>
 <alpine.DEB.2.10.1409111054500.2419@hadrien>
Message-ID: <87sijyed74.fsf@rasmusvillemoes.dk>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, Sep 11 2014, Julia Lawall <julia.lawall@lip6.fr> wrote:

> On Thu, 11 Sep 2014, Rasmus Villemoes wrote:
>
>>
>> which is obviously wrong. What should I do to make coccinelle match a
>> specific string literal? I guess I could introduce 'constant c =~
>> "^\"%s\"$";', but there might be a more canonical way.
>
> It looks like a bug.  There have been some improvements in the handling of
> format strings, but perhaps the changes have not all been positive...

In that case you might like to know

$ spatch --version
spatch version 1.0.0-rc21 with Python support and with PCRE support

Note that it shouldn't really matter that "%s" is a format
string (which is why I didn't attempt to use a "format" variable; I
don't really understand those); I just want to find instances where
seq_printf is called with a specific string literal as its second argument.

> I will end the iterative version shortly.  You will need a version of
> coccinelle that supports ocaml scripting, which seems to mean that you
> need to have ocamlfind installed on your machine at the time when you
> make coccinelle.

OK, thanks for working on it.

Rasmus
