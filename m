From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 11 Sep 2014 11:07:46 +0200 (CEST)
Subject: [Cocci] Matching literal strings
In-Reply-To: <87wq9aedwx.fsf@rasmusvillemoes.dk>
References: <87wq9aedwx.fsf@rasmusvillemoes.dk>
Message-ID: <alpine.DEB.2.10.1409111104070.2419@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Here is a semantic patch that iterates for the seq_puts case.  The rule
"a" may look a little strange.  It is just there so that Coccinelle knows
that nothing will happen with this semantic patch if there is no double
seq_puts in the code.  This makes a massive performance improvement,
because it doesn't have to parse every file.  In the non-iterative
version, it was able to figure this out as well, but the need to have the
flag added to determine whether a new iteration has already been asked for
for the current file makes that mroe obscure.

You should run this with the following options:

--no-includes --include-headers --in-place

julia

--------------------------------------------------------------------------

@initialize:ocaml@
@@

let added = ref false

let add_if_not_present file =
  if not !added
  then
    begin
      let it = new iteration() in
      it#set_files [file];
      it#register();
      added := true
    end

@a@
@@

seq_puts(...);
seq_puts(...);

@script:ocaml depends on a@
@@

added := false

@r@
position p;
@@

seq_puts(...);
seq_puts(...);
seq_puts at p(...);

@concat1@
expression s;
constant c1, c2;
position p1 != r.p, p2 != r.p;
@@
  seq_puts at p1(s, c1);
  seq_puts at p2(s, c2);

@script:ocaml@
p1 << concat1.p1;
@@

add_if_not_present (List.hd p1).file

@script:python concat2@
c1 << concat1.c1;
c2 << concat1.c2;
c3;
@@

// The indentation probably needs to be fixed manually
coccinelle.c3 = c1 + "\n\t" + c2

@concat3@
identifier concat2.c3;
expression concat1.s;
constant concat1.c1, concat1.c2;
position concat1.p1;
@@
- seq_puts@p1(s, c1);
- seq_puts(s, c2);
+ seq_puts(s, c3);
