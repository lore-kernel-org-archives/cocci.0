From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 11 Jul 2015 10:16:22 -0400 (EDT)
Subject: [Cocci] binary operator matching on v1.0.1
In-Reply-To: <CAMy_N609w3sYYyn54z4MTzPifpZVSaZ7gDPGPCcxajdbw=hhOA@mail.gmail.com>
References: <CAMy_N609w3sYYyn54z4MTzPifpZVSaZ7gDPGPCcxajdbw=hhOA@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1507111015350.2551@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, 9 Jul 2015, Kris Borer wrote:

> I was able to get some basic binary operator matching working with version
> 1.0.1, but got stuck with the following example. Any advice would be
> appreciated.

Here is a patch.  Thanks again for the helpful bug report,

julia

diff --git a/parsing_cocci/iso_pattern.ml b/parsing_cocci/iso_pattern.ml
index 3cbaf37..5967039 100644
--- a/parsing_cocci/iso_pattern.ml
+++ b/parsing_cocci/iso_pattern.ml
@@ -2184,9 +2184,10 @@ let copy_minus printer minusify model e =
     Ast0.MINUS(mc) -> minusify e
   | Ast0.CONTEXT(mc) -> e
   | Ast0.MIXED(_) ->
-      if !Flag.sgrep_mode2
-      then e
-      else failwith "not possible 8"
+      (* This is possible if the model of an isomorphism is a single
+	 metavariable, and this metavariable matches mixed code.
+	 Previously, this failed with impossible if not in sgrep mode. *)
+      e
   | Ast0.PLUS _ -> failwith "not possible 9"

 let whencode_allowed prev_ecount prev_icount prev_dcount
