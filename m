From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 28 Jul 2013 12:48:48 +0200 (CEST)
Subject: [Cocci] Formatting issues
In-Reply-To: <51E6B08E.9030600@monom.org>
References: <51E6B08E.9030600@monom.org>
Message-ID: <alpine.DEB.2.02.1307281248230.2028@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, 17 Jul 2013, Daniel Wagner wrote:

> Hi,
> 
> I have found another small issue. Not a big thing. I have following rule
> 
> @@
> identifier f =~ "^(__)?connman_.*" ;
> @@
> 
> f(...,
> (
> - FALSE
> + false
> |
> - TRUE
> + true
> )
>  ,...)
> 
> 
> And this little C example:
> 
> bool __connman_bar(bool baz);
> int connman_foo(int val, bool bar);
> 
> int main(int argc, char *argv)
> {
> 	int err;
> 
> 	if (__connman_bar(FALSE) == TRUE)
> 		err = connman_a_rather_long_line(2434, TRUE);
> 
> 	return 0;
> }
> 
> 
> Running coccinelle on this results in the not so nicely formated patch:
> 
> @@ -5,8 +5,9 @@ int main(int argc, char *argv)
>  {
>         int err;
>  
> -       if (__connman_bar(FALSE) == TRUE)
> -               err = connman_a_rather_long_line(2434, TRUE);
> +       if (__connman_bar(false) == TRUE)
> +               err = connman_a_rather_long_line(2434,
> +                                                                         true);
>  
>         return 0;
>  }
> 
> When connman_a_rather_long_line() is not sooo long then it works as
> expected, that means not additional line is introduced. Any ideas
> what is going wrong?

A patch is below.

julia

diff --git a/parsing_c/unparse_c.ml b/parsing_c/unparse_c.ml
index 971024a..9e03343 100644
--- a/parsing_c/unparse_c.ml
+++ b/parsing_c/unparse_c.ml
@@ -1071,7 +1071,7 @@ let add_newlines toks tabbing_unit =
             let (newcount,newstack,newspacecell) =
               start_box stack space_cell newcount "{" in
             front @ loop (newstack,newspacecell) newcount ixs
-          | s -> a :: loop info (string_length s count) xs
+          | _ -> a :: loop info (string_length s count) xs
           )
         | _ -> a :: loop info (string_length s count) xs
         )
@@ -1114,8 +1114,7 @@ let add_newlines toks tabbing_unit =
           | [x] ->
             (match check_for_newline count x space_cell with
             | Some count -> loop (stack,Some (x,sp)) count xs
-            | None -> loop (stack,Some (count,sp)) count xs
-	    )
+            | None -> loop (stack,Some (count,sp)) count xs)
           | _ -> loop info count xs
           ) in
       a :: rest
