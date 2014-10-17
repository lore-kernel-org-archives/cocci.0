From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 17 Oct 2014 07:53:02 +0200 (CEST)
Subject: [Cocci] string parameter concatenation
In-Reply-To: <20141006102500.GC8551@rei.suse.cz>
References: <20141001130215.GB4701@rei.suse.cz>
 <alpine.DEB.2.02.1410021858360.2062@localhost6.localdomain6>
 <20141006102500.GC8551@rei.suse.cz>
Message-ID: <alpine.DEB.2.10.1410170752240.2654@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> It's better but it produces changes like this:
>
> @@ -250,9 +250,14 @@ void l_seek(int fdesc, off_t offset, int whence, off_t checkoff)
>         off_t offloc;
>
>         if ((offloc = lseek(fdesc, offset, whence)) != checkoff) {
> -               tst_resm(TFAIL, "(%ld = lseek(%d, %ld, %d)) != %ld) errno = %d",
> -                        offloc, fdesc, offset, whence, checkoff, errno);
> -               tst_exit();
> +               tst_brkm(TFAIL, NULL,
> +                        "(%ld = lseek(%d, %ld, %d)) != %ld) errno = %d",
> +                        offloc,
> +                        fdesc,
> +                        offset,
> +                        whence,
> +                        checkoff,
> +                        errno);
>         }
>  }
>
> Which seems to be waste of vertical space to me.

This may be solved by the following patch:

diff --git a/parsing_c/unparse_c.ml b/parsing_c/unparse_c.ml
index 3c54c33..77c23bb 100644
--- a/parsing_c/unparse_c.ml
+++ b/parsing_c/unparse_c.ml
@@ -1288,14 +1288,12 @@ let add_newlines toks tabbing_unit =
     | _ -> (count,List.tl stack,space_cell,seen_cocci) in
   let update_by_stack s count stack sp space_cell seen_cocci =
     let count = simple_string_length s (count + 1 (*space*)) in
-    let newinfo =
-      match stack with
-      | [(x,tustack)] ->
-          (match check_for_newline count x tustack space_cell with
-          | Some count -> (stack,Some (x,sp), seen_cocci)
-          | None -> (stack,Some (count,sp),seen_cocci))
-      | _ -> (stack,space_cell,seen_cocci) in
-    (newinfo,count) in
+    match stack with
+    | [(x,tustack)] ->
+        (match check_for_newline count x tustack space_cell with
+        | Some count -> ((stack,Some (x,sp), seen_cocci),count)
+        | None -> ((stack,Some (count,sp),seen_cocci),count))
+    | _ -> ((stack,space_cell,seen_cocci),count) in
   let rec loop ((stack,space_cell,seen_cocci) as info) count seeneq =
     function
     | [] -> []
