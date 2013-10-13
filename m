From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 13 Oct 2013 17:47:18 +0200 (CEST)
Subject: [Cocci] [bug] file not found with id-utils and include-headers
In-Reply-To: <20131013133031.GA6372@katana>
References: <20131013133031.GA6372@katana>
Message-ID: <alpine.DEB.2.02.1310131746260.6463@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sun, 13 Oct 2013, Wolfram Sang wrote:

> Hi,
> 
> using the latest Debian package from testing (rc18) and the following
> spatch on the Linux Kernel:
> 
> @@
> expression e;
> @@
> -	INIT_COMPLETION(e);
> +	reinit_completion(&e);
> 
> 
> Running with:
> 
> spatch --sp-file /tmp/reinit_completion.cocci --use-idutils --include-headers ./
> 
> I get:
> 
> init_defs_builtins: /usr/share/coccinelle/standard.h
> got files
> HANDLING: INIT_COMPLETION drivers/hid/hid-wiimote.h
> egrep: INIT_COMPLETION: No such file or directory

Idutils seems to put the matched pattern at the beginning of the first 
line of output, if there is any.  This is fixed by the patch below.

julia

diff --git a/parsing_cocci/id_utils.ml b/parsing_cocci/id_utils.ml
index d7052dc..a121be9 100644
--- a/parsing_cocci/id_utils.ml
+++ b/parsing_cocci/id_utils.ml
@@ -19,7 +19,15 @@ let rec interpret dir exp =
 	    let cmd =
 	      Printf.sprintf "lid -f %s/%s -l %s -S newline"
 		dir !Flag_parsing_cocci.id_utils_index oo in
-	    Common.cmd_to_list cmd
+	    (* lid puts the matched word at the beginning of the first line of
+	       the output... *)
+	    (match Common.cmd_to_list cmd with
+	      [] -> []
+	    | x::xs ->
+		(match Str.split (Str.regexp "[ \t]+") x with
+		  [oop;file] when oo = oop ->
+		    file :: xs
+		| _ -> failwith (Printf.sprintf "unexpected output of %s" cmd)))
 	| GC.And l ->
 	    let rec loop = function
 		[] -> failwith "bad and"
