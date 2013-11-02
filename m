From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 2 Nov 2013 15:27:35 +0100 (CET)
Subject: [Cocci] Matching an absence of statements before the closing
 brace of a function?
In-Reply-To: <20131102133648.GA4190@leaf>
References: <20131102133648.GA4190@leaf>
Message-ID: <alpine.DEB.2.02.1311021455070.2261@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, 2 Nov 2013, Josh Triplett wrote:

> I wanted to write a semantic patch that matched (and removed) "return;"
> at the end of a void function.  I've attached the full .cocci file
> written for coccicheck, but the key bit looks like this:
>
> @@
> identifier fn;
> @@
> void fn ( ... )
> {
> ...
> - return;
> }
>
> However, that patch also produces results like this:
>
> --- a/drivers/scsi/aacraid/dpcsup.c
> +++ b/drivers/scsi/aacraid/dpcsup.c
> @@ -255,7 +255,6 @@ static void aac_aif_callback(void *conte
>  	    cpu_to_le32(NoMoreAifDataAvailable)) {
>  		aac_fib_complete(fibptr);
>  		aac_fib_free(fibptr);
> -		return;
>  	}
>
>  	aac_intr_normal(dev, 0, 1, 0, fibptr->hw_fib_va);
>
> I'm guessing that either coccinelle didn't pair the braces (so that the
> '}' matches close braces other than the one matching fn's opening brace)
> or coccinelle allowed extra statements before the logical end of the
> function despite the lack of '...'.

The problem is that Coccinlle works on control-flow paths, and a return is
always at the end of a control-flow path...

> How can I write this patch such that it requires an absence of
> statements between the return and the end of the function?
>
> Note that matching the "return;" in the following would be fine from a
> control-flow perspective:
>
> void f(void)
> {
> 	if (e) {
> 		return;
> 	}
> }
>
> But matching the "return;" in the following is not OK:
>
> void f(void)
> {
> 	if (e) {
> 		return;
> 	}
> 	f2();
> }

Try the following:

@start@
identifier f;
position p;
@@
f(...) {@p ... }

@bad@
position p, s != start.p;
@@

{@s <... return;@p ...> }

@ef@
position p;
statement S;
@@

(
while (...) return;@p
|
if (...) return;@p else S
)

@@
position p != {bad.p,ef.p};
@@

- return;@p

julia
