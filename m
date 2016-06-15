From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 15 Jun 2016 10:43:30 +0200 (CEST)
Subject: [Cocci] [PATCH 4/4] scripts/coccinelle: require coccinelle >=
 1.0.4 on device_node_continue.cocci
In-Reply-To: <1465942217-14452-5-git-send-email-mcgrof@kernel.org>
References: <1465942217-14452-1-git-send-email-mcgrof@kernel.org>
 <1465942217-14452-5-git-send-email-mcgrof@kernel.org>
Message-ID: <alpine.DEB.2.10.1606151042080.2887@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

How about the following, since Coccinelle knows what its version is?
This could of course be implemented in python as well.

julia

diff --git a/docs/Coccilib.3cocci b/docs/Coccilib.3cocci
index 0e4fbb8..ca5b061 100644
--- a/docs/Coccilib.3cocci
+++ b/docs/Coccilib.3cocci
@@ -232,6 +232,15 @@ is the empty list if spatch is not currently working on any file (eg,
 in an initialize or finalize rule).
 .sp

+.I val cocci_version
+:
+.B unit -> string
+.sp
+Returns the a string indicating the current version.  Note that if
+Coccinelle has been modified since a release, the version number will be
+postfixed with "-dirty".
+.sp
+
 .I val print_main
 :
 .B ?color:string -> string -> pos list -> unit
diff --git a/ocaml/coccilib.ml b/ocaml/coccilib.ml
index f60c6b2..2f352d8 100644
--- a/ocaml/coccilib.ml
+++ b/ocaml/coccilib.ml
@@ -168,6 +168,8 @@ let dir () = !Flag.dir

 let files () = !Flag.currentfiles

+let cocci_version () = Config.version
+
 (* ---------------------------------------------------------------------- *)
 (* org mode *)
