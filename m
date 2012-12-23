From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 23 Dec 2012 08:45:03 +0100 (CET)
Subject: [Cocci] Inter-procedural analysis.
In-Reply-To: <20121223001527.1af9e01b@vidarr>
References: <50D61A69.106@gmail.com>
 <alpine.DEB.2.02.1212222145390.1954@hadrien> <50D6269D.2060702@gmail.com>
 <20121223001527.1af9e01b@vidarr>
Message-ID: <alpine.DEB.2.02.1212230835400.2003@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sun, 23 Dec 2012, Rene Rydhof Hansen wrote:

> [...]
>
> One other thing you might consider is to first look for functions that
> acquire the lock and store the (names of) these functions in a
> hashtable, e.g., using the ocaml/python scripting capabilities of
> Coccinelle, and then use this hashtable to at least reduce the number
> of false positives.
>
> It doesn't solve all problems, but it's quick and easy to do.

Not so easy I think because there is no way to write a match that matches
any function that is stored in a hash table.  You would have to do
something like the following:

find unbalanced functions and store them in a hash table

find
   unlock at p1
   ... when any
       when != unlock
   f(...)
   ... when any
       when != unlock
   unlock at p

Look for f in the hash table.  If it is found, put p1,p2 in another hash
table.

find
   unlock at p1@p3
   ...
   unlock at p2@p4

Look up p1,p2 in the hash table.  If it is found, do
Coccilib.include_match false.

find
   unlock at p3
   ...
   unlock at p4

Report this as a bug.

But this is likely to be quite a bit slower to run than the previous
version, especially if there are a lot of function calls between locks.
And it only does one level of unfolding.

julia
