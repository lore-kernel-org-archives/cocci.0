From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 10 May 2015 14:58:22 +0200 (CEST)
Subject: [Cocci] Question about the use of "...when !=" in SmPL
In-Reply-To: <BAY181-W739E92CD2131317A21ED42B8DF0@phx.gbl>
References: <BAY181-W739E92CD2131317A21ED42B8DF0@phx.gbl>
Message-ID: <alpine.DEB.2.10.1505101453460.2645@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Here is my solution for the switch without detection problem.  It is
probably pretty much the same as what Nicholas already proposed:

@ok exists@
position p;
expression E;
@@
switch at p (E) {
default: ...
}

@bad exists@
position p != ok.p;
expression E,e;
@@
switch at p (E) {
case e: ...
}

@script: python@
p<<bad.p;
@@
print p[0].file, p[0].line

-------------------------------------------------------------------------

As Nicholas noted, this currently gives false positives when the default
is hidden under another case.  A patch that fixes this problem is below.

julia

diff --git a/parsing_c/control_flow_c_build.ml b/parsing_c/control_flow_c_build.ml
index c0e8f52..2d353cd 100644
--- a/parsing_c/control_flow_c_build.ml
+++ b/parsing_c/control_flow_c_build.ml
@@ -486,6 +486,14 @@ let rec aux_statement : (nodei option * xinfo) -> statement -> nodei option =

       !g +> add_arc_opt (starti, newswitchi);

+      (* allows multiple case labels to stack up *)
+      let rec contains_default s =
+	match Ast_c.unwrap_st s with
+	  Labeled (Ast_c.Default _) -> true
+	| Labeled (Ast_c.Case(e,s)) -> contains_default s
+	| Labeled (Ast_c.CaseRange(e1,e2,s)) -> contains_default s
+	| _ -> false in
+
        (* call compound case. Need special info to pass to compound case
         * because we need to build a context_info that need some of the
         * information build inside the compound case: the nodei of {
@@ -512,11 +520,7 @@ let rec aux_statement : (nodei option * xinfo) -> statement -> nodei option =
                 * between start to end.
                 * todo? except if the case[range] coverthe whole spectrum
                 *)
-               if not (statxs +> List.exists (fun x ->
-                 match Ast_c.unwrap_st x with
-                 | Labeled (Ast_c.Default _) -> true
-                 | _ -> false
-               ))
+               if not (statxs +> List.exists contains_default)
                then begin
                  (* when there is no default, then a valid path is
                   * from the switchheader to the end. In between we
