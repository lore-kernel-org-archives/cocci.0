From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 8 Jul 2016 14:36:56 +0200 (CEST)
Subject: [Cocci] Add a parameter to function
In-Reply-To: <f2e0fa46cc354563ae8bfd52fc5f35fa@vprd-opci0018.b-com.local>
References: <f2e0fa46cc354563ae8bfd52fc5f35fa@vprd-opci0018.b-com.local>
Message-ID: <alpine.DEB.2.10.1607081432310.3097@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 8 Jul 2016, Fr?d?ric LEROY (ext) wrote:

> Hello,
>
> I made a test case, I try to add a parameter S to a function :
> --------8<----------------8<----------------8<--------
> void a();
> void z(void);
> void b(int i);
> void c(int i, char c);
>
>
> void a() {
>     int b=5;
> }
>
> void z(void) {
>     int b=5;
> }
>
>
> void b(int i) {
>     int b = 5 + i;
> }
>
> void c(int i, char c) {
>     int b = i + c;
> }
> --------8<----------------8<----------------8<--------
>
> The problem I have is when I have a void or empty declaration.
> The only way I found is to rely rule dependencies :
>
> --------8<----------------8<----------------8<--------
> @ rule1 @
> identifier fn;
> parameter list pl;
> @@
>
> - fn(void)
> + fn(int s)
> { ... }
>
> @ rule2 @
> identifier fn;
> parameter list pl;
> @@
>
> - fn()
> + fn(int s)
> { ... }
>
> @ depends on !(rule1 || rule2) @
> identifier fn;
> parameter list pl;
> @@
>
> - fn(pl)
> + fn(int s, pl)
> { ... }

This doesn't work, for more or less the same reason that you needed the
barfn rule previously.  Currently there is no environment associated with
your not liking rule1 or rule2, and so they tests mean, does thie rule
apply at all.  You want to know if it applies for a specific environment
binding.  So you need a rule to establish that binding first.

It may be the case that Coccinelle will take care of the case for rule2
with rule 3, where pl is empty.  It should manage the lack of comma by
itself.  On the other hand, in the void case you want to do something
different, so that needs a separate rule.

julia


> --------8<----------------8<----------------8<--------
>
> Is there a better way to achieve this ?
>
> Kind regards,
>
> Fr?d?ric
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
