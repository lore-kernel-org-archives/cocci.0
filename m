From: rjones@redhat.com (Richard W.M. Jones)
Date: Thu, 14 Jan 2016 10:28:02 +0000
Subject: [Cocci] Build failure on ppc64le: Failure("dump: impossible tag
 (1002)")
In-Reply-To: <alpine.DEB.2.10.1601131701500.5214@hadrien>
References: <20160113134818.GA30557@redhat.com>
 <alpine.DEB.2.10.1601131516180.5214@hadrien>
 <20160113142304.GL1766@redhat.com>
 <alpine.DEB.2.10.1601131701500.5214@hadrien>
Message-ID: <20160114102802.GX1766@redhat.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, Jan 13, 2016 at 05:02:21PM +0100, Julia Lawall wrote:
> Here is a patch that should avoid the problem.

Yes this fixes it for me.

I'm attaching the actual patch as applied/rebased by me since the
patch you sent didn't apply cleanly on top of the coccinelle github
repo.

Thanks,

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-df lists disk usage of guests without needing to install any
software inside the virtual machine.  Supports Linux and Windows.
http://people.redhat.com/~rjones/virt-df/
-------------- next part --------------
>From 511a9641f1d124fdaf8de7852f61549693065cbf Mon Sep 17 00:00:00 2001
From: Julia Lawall <julia.lawall@lip6.fr>
Date: Wed, 13 Jan 2016 17:02:21 +0100
Subject: [PATCH] Build failure on ppc64le: Failure("dump: impossible tag
 (1002)")

Here is a patch that should avoid the problem.

julia
---
 parsing_cocci/iso_compile.ml | 39 +++++++++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/parsing_cocci/iso_compile.ml b/parsing_cocci/iso_compile.ml
index 53845d1..6fb9fdd 100644
--- a/parsing_cocci/iso_compile.ml
+++ b/parsing_cocci/iso_compile.ml
@@ -14,17 +14,44 @@ isomorphism.  This is allowed if all elements of an isomorphism have only
 one token or if we can somehow match up equal tokens of all of the
 isomorphic variants. *)
 
+type mcodeinfo =
+    MetaName of Ast.meta_name
+  | Str of string
+  | Cst of Ast.constant
+  | SAOp of Ast0.simpleAssignOp
+  | FixOp of Ast.fixOp
+  | UnOp of Ast.unaryOp
+  | ArOp of Ast.arithOp
+  | LogOp of Ast.logicalOp
+  | CV of Ast.const_vol
+  | Sign of Ast.sign
+  | Struct of Ast.structUnion
+  | Store of Ast.storage
+  | Inc of Ast.inc_file
+
 let sequence_tokens =
-  let mcode x =
-    (* sort of unpleasant to convert the token representation to a string
-       but we can't make a list of mcodes otherwise because the types are all
-       different *)
-    [(Dumper.dump (Ast0.unwrap_mcode x),Ast0.get_pos_ref x)] in
+  let mcode f x =
+    (* have to convert the mcodes to a common type so that we can make a list
+       out of them *)
+    [(f x,Ast0.get_pos_ref x)] in
   let donothing r k e = k e in
   let bind x y = x @ y in
   let option_default = [] in
   V0.flat_combiner bind option_default
-    mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode mcode
+    (mcode (function x -> MetaName (Ast0.unwrap_mcode x)))
+    (mcode (function x -> Str (Ast0.unwrap_mcode x)))
+    (mcode (function x -> Cst (Ast0.unwrap_mcode x)))
+    (mcode (function x -> SAOp (Ast0.unwrap_mcode x)))
+    (mcode (function x -> ArOp (Ast0.unwrap_mcode x)))
+    (mcode (function x -> FixOp (Ast0.unwrap_mcode x)))
+    (mcode (function x -> UnOp (Ast0.unwrap_mcode x)))
+    (mcode (function x -> ArOp (Ast0.unwrap_mcode x)))
+    (mcode (function x -> LogOp (Ast0.unwrap_mcode x)))
+    (mcode (function x -> CV (Ast0.unwrap_mcode x)))
+    (mcode (function x -> Sign (Ast0.unwrap_mcode x)))
+    (mcode (function x -> Struct (Ast0.unwrap_mcode x)))
+    (mcode (function x -> Store (Ast0.unwrap_mcode x)))
+    (mcode (function x -> Inc (Ast0.unwrap_mcode x)))
     donothing donothing donothing donothing donothing donothing donothing
     donothing donothing donothing donothing donothing
     donothing donothing donothing donothing donothing donothing donothing
-- 
2.5.0
