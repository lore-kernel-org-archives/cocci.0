From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 29 Aug 2017 07:17:58 +0200 (CEST)
Subject: [Cocci] cocci: remove unnecessary casts of void * while
 avoiding casts with __user or __force ?
In-Reply-To: <1503938959.2040.6.camel@perches.com>
References: <1503938959.2040.6.camel@perches.com>
Message-ID: <alpine.DEB.2.20.1708290700520.2035@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 28 Aug 2017, Joe Perches wrote:

> A simple cocci script that removes unnecessary casts of
> a void * will also remove casts with __force or __user

Unfortunately, attributes are currently not supported inside casts.  This
can be done in a hackish way (possible false negatives) as follows:

---

@initialize:ocaml@
@@

let close (p1,p2) =
  let r = (List.hd p1).line_end in
  let l = (List.hd p2).line in
  let rc = (List.hd p1).col_end in
  let lc = (List.hd p2).col in
  r = l && lc = rc+1

@r@
position p1,p2;
expression f,e;
type T;
@@

f(..., // generalize this rule as needed
 (T at p1 *@p2)
 e,...)

@@
position r.p2 : script:ocaml(r.p1) { close(p1,p2) };
position r.p1;
expression e;
type T;
@@

- (T at p1 *@p2)
  e

---

Basically, it assumes that if the type and the * are more than one space
apart then there is something important there, and the cast is not
removed.

julia
