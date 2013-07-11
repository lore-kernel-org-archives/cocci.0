From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 11 Jul 2013 10:29:43 +0200 (CEST)
Subject: [Cocci] gboolean -> bool conversion
In-Reply-To: <51DE6A05.9050008@monom.org>
References: <51DE6A05.9050008@monom.org>
Message-ID: <alpine.DEB.2.02.1307111026390.2253@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, 11 Jul 2013, Daniel Wagner wrote:

> Hi,
>
> I'd like to convert a bunch of gboolean decleration to stdbool in our ConnMan
> code base. I am a noob with coccinelle. I have partial success so far but I do
> not thing I am doing the right thing. So any advice is welcome :)
>
>
> This here is my current coccinelle script for converting gboolean used as
> stack variable. I have also one for structs, which gave my good results.
> Another one is needed then for the function arguments. But let's first have a
> look on this part.
>
> @r1@
> position p;
> typedef gboolean;
> identifier func,x;
> @@
> func(...) {
> <...
> 	gboolean at p x;
> ...>
> }
>
> @r2@
> position r1.p;
> typedef bool;
> @@
> - gboolean at p
> + bool
>
> @r3@
> identifier r1.x;
> @@
> (
> - x = FALSE
> + x = false
> |
> - x = TRUE
> + x = true
> )
>
> int main(int argc, char *argv[])
> {
> 	gboolean b = TRUE;
>
> 	return 0;
> }
>
> results in
>
> int main(int argc, char *argv[])
> {
> -       gboolean b = TRUE;
> +       bool b = true;
>
>         return 0;
> }
>
> which is what I wanted. Now the problem is that I really have no clue to mach
> on things like
>
> int main(int argc, char *argv[])
> {
> 	gboolean b = TRUE, c = FALSE;
>
> 	return 0;
> }
>
> Any idea?

Did you try just

@@
@@

- gboolean
+ bool

Also, for yoru TRUE -> true rule, you could consider

@@
gboolean x;
@@

x =
- TRUE
+ true

That is, you don't have to find the type declaration and then the
identifier.  You can describe the type of an arbitrary expression x.

julia
