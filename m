From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 4 Aug 2016 19:10:52 +0200 (CEST)
Subject: [Cocci] Q: stdint format specifiers
In-Reply-To: <57A37175.7070801@a1.net>
References: <57A36D97.9070402@a1.net>
 <alpine.DEB.2.10.1608041833290.7967@hadrien> <57A37175.7070801@a1.net>
Message-ID: <alpine.DEB.2.10.1608041854360.7967@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 4 Aug 2016, Johann Klammer wrote:

> On 08/04/2016 06:33 PM, Julia Lawall wrote:
> > On Thu, 4 Aug 2016, Johann Klammer wrote:
> >
> >> Does anyone have a coccinelle script to fixup *printf format specifiers to
> >> those pesky PRI*** ones? I could not find one on coccinellery <http://coccinellery.org/>.
> >
> > Could you give a more precise example of what you want to do?
> >
> > thanks,
> > julia
>
> I was getting a gcc warning:
>
> > make[1]: Entering directory '/home/klammerj/projects/FPGA/src/fpgatools/libs'
> >   CC        floorplan.o
> > floorplan.c: In function ?printf_LOGIC?:
> > floorplan.c:369:17: warning: format ?%lX? expects argument of type ?long unsigned int?, but argument 6 has type ?uint64_t {aka long long unsigned int}? [-Wformat=]
> >       fprintf(f, "%s%s\"%c6_lut_val\" : \"0x%016lX\" }",
>
> I've fixed those by hand, but I think not all cases will give
> warnings, because int etc are often aliases for those stdint things.
> ..same width signedness..
> Thus I'd like to run coccinelle on the .c files, to look for printfs
> which have uintxx intxx type arguments and replace the corresponding
> specifiers by the ones suggested in the C standard:

Coccinelle makes a small effort to help with parsing format strings, but
it doesn't support the PRI things you mention.  What you could do is
something like this:

@r@
{suspicious_type1,suspicious_type2,...} x;
type T;
T y;
expression list[n] es;
constant char[] c;
identifier f;
position p;
@@

f(...,c at p,es,x at y,...)

@script:python s@
T << r.T;  // the type of the argument of interest
c << r.c;  // the format string
n << r.n;  // the offset of the argument of interest, counted from 0
c2;
@@

Now use python to compute a new format string for your type.
coccinelle.c2 = the format string with extra quotes around it

@@
expression e;
position r.p;
identifier s.c2;
@@

- e at p
+ c2

Unfortunately, however, this will not work if you have a print with two
suspicious arguments.  Indeed, Coccinelle will completely crash on that
file, because it has no way to merge two changes made for independent
reasons.

If the problem arises frequently and you are willing to do some work by
hand, then you could just let the format strings accumulate before the
calls and replace/merge them by hand.  The third rule would become:

@@
expression e;
position r.p;
identifier r.f,s.c2;
@@

++c2;
  f(...,e at p,...);

If that is not acceptable, you can use a hash table to collect all the
changes that are needed in a particular format string, and then work on
them all at once.  The second rule would put the T n p and c information
in a hashtable (you would need to add the declaration p << r.p; for this),
and then you would need another python rule with only the metavariable p
<< r.p; and the variale c2 that would collect the information relevant to
the position p from the hash table and make the appropriate format string.
The last rule would be just

@@
expression e;
position r.p;
identifier s.c2;
@@

- e@p
+ c2

in that case.

I can elaborate more if needed on any of the above options.

julia

>
>
>
> > 7.8.1 Macros for format specifiers
> > 1 Each of the following object-like macros expands to a character string literal containing a
> > conversion specifier, possibly modified by a length modifier, suitable for use within the
> > format argument of a formatted input/output function when converting the corresponding
> > integer type. These macro names have the general form of PRI (character string literals
> > for the fprintf and fwprintf family) or SCN (character string literals for the
> > fscanf and fwscanf family), 220) followed by the conversion specifier, followed by a
> > name corresponding to a similar type name in 7.20.1. In these names, N represents the
> > width of the type as described in 7.20.1. For example, PRIdFAST32 can be used in a
> > format string to print the value of an integer of type int_fast32_t.
> > 2 The fprintf macros for signed integers are:
> > PRIdN
> > PRIiN
> > 3
> > PRIdFASTN
> > PRIiFASTN
> > PRIdMAX
> > PRIiMAX PRIdPTR
> > PRIiPTR
> > PRIoMAX
> > PRIuMAX
> > PRIxMAX
> > PRIXMAX PRIoPTR
> > PRIuPTR
> > PRIxPTR
> > PRIXPTR
> > The fprintf macros for unsigned integers are:
> > PRIoN
> > PRIuN
> > PRIxN
> > PRIXN
> > 4
> > PRIdLEASTN
> > PRIiLEASTN
> > PRIoLEASTN
> > PRIuLEASTN
> > PRIxLEASTN
> > PRIXLEASTN
> > PRIoFASTN
> > PRIuFASTN
> > PRIxFASTN
> > PRIXFASTN
> > The fscanf macros for signed integers are:
> [...]
>
> result something along the lines of:
>
> > diff --git a/libs/floorplan.c b/libs/floorplan.c
> > index 2b9b27a..fb27edb 100644
> > --- a/libs/floorplan.c
> > +++ b/libs/floorplan.c
> > @@ -366,7 +366,7 @@ int printf_LOGIC(FILE* f, struct fpga_model* model,
> >                         if (cfg->a2d[j].flags & LUT6VAL_SET) {
> >                                 RC_ASSERT(model, !ULL_HIGH32(cfg->a2d[j].lut6_val));
> >                                 if (print_hex_vals)
> > -                                       fprintf(f, "%s%s\"%c6_lut_val\" : \"0x%016lX\" }",
> > +                                       fprintf(f, "%s%s\"%c6_lut_val\" : \"0x%016"PRIX64"\" }",
> >                                                 first_line ? "" : ",\n", pref, 'A'+j, cfg->a2d[j].lut6_val);
> >                                 else {
> >                                         str = bool_bits2str(cfg->a2d[j].lut6_val, 32);
> > @@ -389,7 +389,7 @@ int printf_LOGIC(FILE* f, struct fpga_model* model,
> >                 } else {
> >                         if (cfg->a2d[j].flags & LUT6VAL_SET) {
> >                                 if (print_hex_vals)
> > -                                       fprintf(f, "%s%s\"%c6_lut_val\" : \"0x%016lX\" }",
> > +                                       fprintf(f, "%s%s\"%c6_lut_val\" : \"0x%016"PRIX64"\" }",
> >                                                 first_line ? "" : ",\n", pref, 'A'+j, cfg->a2d[j].lut6_val);
> >                                 else {
> >                                         str = bool_bits2str(cfg->a2d[j].lut6_val, 64);
>
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
