From: maxclausen@gmail.com (Christian Clausen)
Date: Thu, 06 Dec 2012 18:24:35 +0100
Subject: [Cocci] Adding names to arguments in function prototypes
In-Reply-To: <alpine.DEB.2.02.1212051036060.2115@hadrien>
References: <CAACXqO_0dmB+CvJA+DgtnNcOpc2NKHdj9YK-+0uz2ur8q9Gg_A@mail.gmail.com>
 <alpine.DEB.2.02.1212051027460.2115@hadrien>
 <CAACXqO_J90_i++zeP+Eb1jz-2Ce5rkvqBKnGKbTwE8cwphNupg@mail.gmail.com>
 <alpine.DEB.2.02.1212051036060.2115@hadrien>
Message-ID: <50C0D4D3.3000906@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi H?kon,

The problem is in rule2 where you are inheriting the ps from rule1. The 
only value ps can have in both rule1 and rule2 is the list of named 
variables, and further more they need to have the same names. The fix is 
to remove the rule1.ps and use a new ps, while still having it be the 
same length as in rule one. It should be:
parameter list[rule1.n] ps;

As for the other problem, here is a patch that should fix it.

Best regards

Christian Clausen


On 05-12-2012 10:36, Julia Lawall wrote:
> On Wed, 5 Dec 2012, H?kon L?vdal wrote:
>
>> On 5 December 2012 10:28, Julia Lawall <julia.lawall@lip6.fr> wrote:
>>> Looking quickly, I think you need to inherit the parameter list length n
>>> from one rule to the next.  In the rules after the first one, put rule1.n,
>>> not just n.
>> Thanks, that sounds reasonable. However it made no difference for
>> neither abc.c nor xyz.c.
> OK, thanks.  I will look into it.
>
> julia
>
>
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20121206/90dea800/attachment.html>
-------------- next part --------------
diff --git a/parsing_c/parsing_hacks.ml b/parsing_c/parsing_hacks.ml
index 9d05efe..bd61492 100755
--- a/parsing_c/parsing_hacks.ml
+++ b/parsing_c/parsing_hacks.ml
@@ -1695,6 +1695,36 @@ let ident = function
     TIdent _ -> true
   | _ -> false
 
+let is_type = function
+  | TypedefIdent _ 
+  | Tvoid _
+  | Tchar _
+  | Tfloat _
+  | Tdouble _
+
+  | Tsize_t _
+  | Tssize_t _
+  | Tptrdiff_t _
+
+  | Tint _
+  | Tlong _
+  | Tshort _ -> true
+  | _ -> false
+
+let is_cparen = function (TCPar _) -> true | _ -> false
+let is_oparen = function (TOPar _) -> true | _ -> false
+
+let rec not_has_type_before f xs =
+  match xs with
+  | [] -> raise Impossible
+  | x :: xs ->
+      if f x then
+	true
+      else if is_type x then
+	false
+      else
+	not_has_type_before f xs
+
 (* This function is inefficient, because it will look over a K&R header,
 or function prototype multiple times.  At least when we see a , and are in a
 parameter list, we know we will eventually see a close paren, and it
@@ -1776,9 +1806,11 @@ let lookahead2 ~pass next before =
 
   (* [,(] xx [,)] AND param decl *)
   | (TIdent (s, i1)::(((TComma _|TCPar _)::_) as rest) ,
-     (TComma _ |TOPar _)::_ )
+     ((TComma _ |TOPar _)::_ as bef))
     when not_struct_enum before && (LP.current_context() =*= LP.InParameter)
       && k_and_r rest
+      && not_has_type_before is_cparen rest 
+      && not_has_type_before is_oparen bef
       ->
 	TKRParam(s,i1)
 
