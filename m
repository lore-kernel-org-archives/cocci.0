From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 17 Feb 2015 07:56:05 +0100 (CET)
Subject: [Cocci] remove typedefs from struct
In-Reply-To: <fa1325f6cb734f9cb7b8dfc39054bdf8@BN1BFFO11FD021.protection.gbl>
References: <2bb2afa2a75f464b900af8506ddc84dd@BN1BFFO11FD029.protection.gbl>
 <alpine.DEB.2.10.1502141955040.6185@hadrien>
 <db4839c19266450b88ea802a7c5ab597@BL2FFO11FD013.protection.gbl>
 <alpine.DEB.2.02.1502151036100.2033@localhost6.localdomain6>
 <4f675e42e0b446d8829a42c5cc9a8dfd@BL2FFO11FD036.protection.gbl>
 <alpine.DEB.2.02.1502152207560.2278@localhost6.localdomain6>
 <88f4915b894e471aa3e551a6287e5d17@BY2FFO11FD031.protection.gbl>
 <alpine.DEB.2.02.1502152238270.2278@localhost6.localdomain6>
 <d20b2eea04ee429e9daa382827d052f8@BY2FFO11FD001.protection.gbl>
 <alpine.DEB.2.02.1502152254560.2278@localhost6.localdomain6>
 <fa1325f6cb734f9cb7b8dfc39054bdf8@BN1BFFO11FD021.protection.gbl>
Message-ID: <alpine.DEB.2.02.1502170754400.2079@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Another patch is below.  With this the code parses, and the transformation 
can be made.  However, it considers this to be a duplicate const 
annotation, so I'm not sure that the const is being associated in the 
right way by the parser.

julia

diff --git a/parsing_c/parsing_hacks.ml b/parsing_c/parsing_hacks.ml
index 4e8335e..2dd867e 100644
--- a/parsing_c/parsing_hacks.ml
+++ b/parsing_c/parsing_hacks.ml
@@ -1997,6 +1997,14 @@ let lookahead2 ~pass next before =
     when !Flag.c_plus_plus ->
 	  TCommentCpp (Token_c.CppDirective, i1)
 
+  (* const ident const: ident must be a type *)
+  | (TIdent (s, i1)::Tconst _::_,  Tconst _::_)
+      when not_struct_enum before
+      && ok_typedef s
+        ->
+      msg_typedef s i1 38; LP.add_typedef_root s;
+      TypedefIdent (s, i1)
+
 	(* xx const tt *)
   | (TIdent (s, i1)::(Tconst _|Tvolatile _|Trestrict _)::type_::_  , _)
     when not_struct_enum before
