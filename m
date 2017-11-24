From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 24 Nov 2017 19:29:56 +0100 (CET)
Subject: [Cocci] Why some changes are not done ?
In-Reply-To: <0354068f-de98-bcc8-79de-6a8da305b29d@orange.fr>
References: <764056da-dd1d-ee19-e6fb-d70b5447ca59@orange.fr>
 <alpine.DEB.2.20.1711241122300.3316@hadrien>
 <8c4c920c-8828-082f-005c-695748e95397@orange.fr>
 <alpine.DEB.2.20.1711241159010.3316@hadrien>
 <d674d520-3787-4833-c477-d67aa529684b@orange.fr>
 <alpine.DEB.2.20.1711241234570.3316@hadrien>
 <0354068f-de98-bcc8-79de-6a8da305b29d@orange.fr>
Message-ID: <alpine.DEB.2.20.1711241929270.2086@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 24 Nov 2017, Francois-Xavier Le Bail wrote:

> On 24/11/2017 12:35, Julia Lawall wrote:
> >
> >
> > On Fri, 24 Nov 2017, Francois-Xavier Le Bail wrote:
> >
> >> On 24/11/2017 12:00, Julia Lawall wrote:
> >>>
> >>>
> >>> On Fri, 24 Nov 2017, Francois-Xavier Le Bail wrote:
> >>>
> >>>> On 24/11/2017 11:23, Julia Lawall wrote:
> >>>>> On Fri, 24 Nov 2017, Francois-Xavier Le Bail wrote:
> >>>>>> I use the following Coccinelle script to rename some macros:
> >>>>>> @@
> >>>>>> expression E;
> >>>>>> @@
> >>>>>> (
> >>>>>> -EXTRACT_16BITS(E)
> >>>>>> +EXTRACT_BE_16BITS(E)
> >>>>>> |
> >>>>>> -EXTRACT_32BITS(E)
> >>>>>> +EXTRACT_BE_32BITS(E)
> >>>>>> )
> >> The reason for this source is that the macro is defined in a function body.
> >> Why not applying change in that case?
> >
> > Macros defined in function bodies are ignored.  Coccinelle works on a
> > control-flow graph, and the #define is not part of the control-flow of the
> > function.  Since it's not clear what to do with it, it is just skipped.
>
> Ok, it is clear.
>
> I have another macro definition case with no change, outside of all functions.
> I got "FLOW: cant jump to trunc: because we can't find this label"
>
> Code:
> #define VECOUT(MAX) { u_char *sp; \
>                         u_char s[AFSNAMEMAX]; \
>                         int k; \
>                         if ((MAX) + 1 > sizeof(s)) \
>                                 goto trunc; \
>                         ND_TCHECK2(bp[0], (MAX) * sizeof(int32_t)); \
>                         sp = s; \
>                         for (k = 0; k < (MAX); k++) { \
>                                 *sp++ = (u_char) EXTRACT_32BITS(bp); \
>                                 bp += sizeof(int32_t); \
>                         } \
>                         s[(MAX)] = '\0'; \
>                         ND_PRINT((ndo, " \"")); \
>                         fn_print(ndo, s, NULL); \
>                         ND_PRINT((ndo, "\"")); \
>                 }
>
> Is there a solution for similar cases?

No.  It can't create a control-flow graph for the code if the goto
destination is missing.

julia
