From: lars@metafoo.de (Lars-Peter Clausen)
Date: Sun, 30 Sep 2018 17:06:22 +0200
Subject: [Cocci] =~ runtime improvements?
In-Reply-To: <CAGXu5jLfBk6BAiQiKHJdxAFnP72xe_qtBDOizoSaAgYvsxTkVQ@mail.gmail.com>
References: <CAGXu5jLfBk6BAiQiKHJdxAFnP72xe_qtBDOizoSaAgYvsxTkVQ@mail.gmail.com>
Message-ID: <c8d1021e-998c-2e55-e793-f787b2bca503@metafoo.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 09/27/2018 08:51 PM, Kees Cook wrote:
> Hi,
> 
> This .cocci takes a VERY long time to run against the kernel, and I'd
> love to know what I could do to improve it. I assume it's related to
> the use of the "=~" operand:
> 

Maybe I'm missing something, but do you need all of those variations? An
expression should match an identifier. I'd expect ((ECOUNT)) *
((ESTRIDE)) * ((ESIZE)) matches the superset of all the other statements
with ICOUNT, ISIZE and ISTRIDE in them. So you only need two rules one
for array_size and one for array3_size.

> // Replace multi-factor out-of-line products with array_size() usage.
> @@
> identifier alloc =~ ".*alloc.*";
> constant C1, C2, C3;
> identifier ISTRIDE, ISIZE, ICOUNT;
> expression ESTRIDE, ESIZE, ECOUNT;
> expression PRODUCT, OTHER;
> @@
> 
> (
>   PRODUCT = ((C1)) * ((C2)) * ((C3))
> |
>   PRODUCT = ((C1)) * ((C2))
> |
> - PRODUCT = ((ICOUNT)) * ((ISTRIDE)) * ((ISIZE))
> + PRODUCT = array3_size(ICOUNT, ISTRIDE, ISIZE)
> |
> - PRODUCT = ((ICOUNT)) * ((ISTRIDE)) * ((ESIZE))
> + PRODUCT = array3_size(ICOUNT, ISTRIDE, ESIZE)
> |
> - PRODUCT = ((ICOUNT)) * ((ESTRIDE)) * ((ESIZE))
> + PRODUCT = array3_size(ICOUNT, ESTRIDE, ESIZE)
> |
> - PRODUCT = ((ECOUNT)) * ((ESTRIDE)) * ((ESIZE))
> + PRODUCT = array3_size(ECOUNT, ESTRIDE, ESIZE)
> |
> - PRODUCT = ((ICOUNT)) * ((ISIZE))
> + PRODUCT = array_size(ICOUNT, ISTRIDE, ISIZE)
> |
> - PRODUCT = ((ICOUNT)) * ((ESIZE))
> + PRODUCT = array_size(ICOUNT, ESIZE)
> |
> - PRODUCT = ((ECOUNT)) * ((ESIZE))
> + PRODUCT = array_size(ECOUNT, ESIZE)
> )
>   ... when != PRODUCT = OTHER
>   alloc(..., PRODUCT, ...)
> 
> Thanks!
> 
> -Kees
> 
