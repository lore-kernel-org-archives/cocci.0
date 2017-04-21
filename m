From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 21 Apr 2017 08:31:45 +0200 (CEST)
Subject: [Cocci] Place ifdef around all the expressions that are using a
 particular macro
In-Reply-To: <CACUfuoubSEp11DmhKtyfAKv7b2C_f93HP=QeKa0Op-OW4Y8S=g@mail.gmail.com>
References: <CACUfuoubSEp11DmhKtyfAKv7b2C_f93HP=QeKa0Op-OW4Y8S=g@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1704210829310.2012@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 17 Apr 2017, Andrea Grandi wrote:

> Hello!
>
> I am back porting a set of old header files into a recent version of my C
> project. The old header files don't have the definition of various macros
> (i.e.?#define) that are currently used in the library. This is causing
> various compilation errors.
>
> I'd like to use Coccinelle to place?#if 0?around the expressions as a
> temporary?workaround?in order to fix the compilation errors.
>
> I know it's a very powerful tool, but I have just started using it and I
> would need some help writing the semantic patch.
>
> Here is a very simple example of what I have done so far:
>
> @@
> identifier a;
> expression P, N;
> @@
> -a = MACRO(P, N);
> +// TODO: MACRO does not exist in old header
> +#if 0
> +a = MACRO (P, N);
> +#endif
> +a = 0;
>
> In some case, the macro is used inside a function call. In order to catch
> this scenario I had to write something more verbose and?less generic?like:
>
> @@
> expression E, D, err, P;
> identifier f;
> @@
> -err = f(P, MACRO(E, 0), D);
> +// TODO: MACRO does not exist in old header
> +#if 0
> +err = f(P, MACRO(E, 0), D);
> +#endif
> +err = OK;
>
> Finally, there are cases where the macro is used inside an?if?condition. For
> example:
>
> if (a > MACRO(A, B)) {
>    // Various lines of code
> }
>
> What I'd like to do here would be to put?#if 0?around the whole block of
> code.
>
> #if 0
> if (a > MACRO(A, B)) {
>    // Various lines of code
> }
> #endif
>
> Is there a way in Coccinelle to cover all the three cases above with a
> single expression?

@bad@
statement S;
position p;
@@

MACRO(...)@S at p

@@
statement bad.S;
position bad.p;
@@

+#if 0
S at p
+#endif


>
> Also, considering that I should replace a number of macros, is there a way
> to create a generic semantic patch and use it multiple times by simply
> providing different macro names? Sort of like calling a function multiple
> times with different arguments.

Replace the first rule by:

@bad@
statement S;
position p;
identifier virtual.MACRO;
@@

MACRO(...)@S at p

Then on the command line, you can do -D MACRO=macro_name

julia
