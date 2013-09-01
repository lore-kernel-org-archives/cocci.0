From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 1 Sep 2013 12:15:30 +0200 (CEST)
Subject: [Cocci] already tagged fake token
In-Reply-To: <1377773643.3212.47.camel@zamolxis.metaware.tm.fr>
References: <1377773643.3212.47.camel@zamolxis.metaware.tm.fr>
Message-ID: <alpine.DEB.2.02.1309011214560.2017@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

A patch to fix this is attached.  There is no need for ++

julia

On Thu, 29 Aug 2013, Nic Volanschi (R&D) wrote:

> Hi,
> 
> I stumbled against another issue when trying to apply the following rule
> on nested if/else if/.../else structures:
> 
> --- trace.cocci:
> @@ statement s1, s2; @@
>  if(...)
>   s1
>  else
> +{trace("ifelel");
>   s2
> +}
> 
> --- test.c:
> void GetInfoDestTV(short sNoFo)
> {
>   if(sNoFo == 1)
>     printf("one");
>   else if(sNoFo == 2)
>     printf("two");
>   else
>     printf("other");
> }
> 
> 
> Applying the patch results in:
> faketoken/$ spatch -c trace.cocci test.c
> init_defs_builtins: /usr/local/share/coccinelle/standard.h
> HANDLING: test.c     
> previous modification:
> CONTEXT
>   >>> }
> According to environment 0:
> current modification:
> CONTEXT
>   >>> }
> According to environment 0:
> Fatal error: exception Failure("rule starting on line 1: already tagged
> fake token
> ")
> 
> I can see that the problem comes from the fact that the rule tries to
> add several "}" after the last ";" which is the ending token for both
> the inside and the outside if.
> Indeed, if I add braces around the inside if, the problem disappears, as
> there are now different tokens ending the inside and the outside if.
> 
> I tried to change the "+" markers to "++" in the patch, but this doesn't
> help.
> So is there a known way to get around this error?
> 
> Nic.
> 
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
> 
-------------- next part --------------
diff --git a/parsing_cocci/context_neg.ml b/parsing_cocci/context_neg.ml
index 9df052b..2d6fb96 100644
--- a/parsing_cocci/context_neg.ml
+++ b/parsing_cocci/context_neg.ml
@@ -413,12 +413,21 @@ let classify is_minus all_marked table code =
       |	Ast0.FunDecl((info,bef),_,_,_,_,_,_,_,_)
       | Ast0.Decl((info,bef),_) ->
 	  bind (nc_mcode ((),(),info,bef,(),-1)) (k s)
-      | Ast0.IfThen(_,_,_,_,_,(info,aft,adj))
-      | Ast0.IfThenElse(_,_,_,_,_,_,_,(info,aft,adj))
-      | Ast0.Iterator(_,_,_,_,_,(info,aft,adj))
-      | Ast0.While(_,_,_,_,_,(info,aft,adj))
-      | Ast0.For(_,_,_,_,_,_,_,_,(info,aft,adj)) ->
-	  bind (k s) (nc_mcode ((),(),info,aft,(),adj))
+      (* For these, the info of the aft mcode is derived from the else
+	 branch.  These might not correspond for a context if, eg if
+	 only the else branch is replaced.  Thus we take instead the
+	 info of the starting keyword.  In a context case, these will be
+	 the same on the - and + sides.  All that is used as an offset,
+	 and it is only used as a key, so this is safe to do. For an
+         iterator, we take the left parenthesis, which should have the
+	 same property. *)
+      | Ast0.IfThen(start,_,_,_,_,(info,aft,adj))
+      | Ast0.IfThenElse(start,_,_,_,_,_,_,(info,aft,adj))
+      | Ast0.Iterator(_,start,_,_,_,(info,aft,adj))
+      | Ast0.While(start,_,_,_,_,(info,aft,adj))
+      | Ast0.For(start,_,_,_,_,_,_,_,(info,aft,adj)) ->
+	  let mcode_info (_,_,info,_,_,_) = info in
+	  bind (k s) (nc_mcode ((),(),mcode_info start,aft,(),adj))
       |	_ -> k s
 
 ) in
