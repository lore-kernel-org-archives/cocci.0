From: eliseomarmol@gmail.com (=?utf-8?Q?Eliseo_Mart=C3=ADnez?=)
Date: Sun, 21 Dec 2014 11:43:43 +0100
Subject: [Cocci] Change function invocations argument
In-Reply-To: <alpine.DEB.2.02.1412202147460.2098@localhost6.localdomain6>
References: <F51E5D4A-BD27-4192-95B7-2164D25A4380@gmail.com>
 <alpine.DEB.2.02.1412202131540.2098@localhost6.localdomain6>
 <254A1CAA-2FA6-4546-91BD-5E0C449C7F94@gmail.com>
 <alpine.DEB.2.02.1412202147460.2098@localhost6.localdomain6>
Message-ID: <D2F6C23B-F5FF-41DE-86B3-8C7210DA61BD@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Ok. Finally I have it working. There?s still a gotcha, though.
The first version of my spatch contained these rules:

```
@@ typedef long_u, uintmax_t; expression e1, e2, e3; @@

-   put_bytes(e1, (long_u)(e2), e3)
+   put_bytes(e1, (uintmax_t)e2, e3)

@@ expression e1, e2, e3; @@

-   put_bytes(e1, (long_u)e2, e3)
+   put_bytes(e1, (uintmax_t)e2, e3)

@@ expression e1, e2, e3; @@

-   put_bytes(e1, e2, (int)(e3))
+   put_bytes(e1, e2, (unsigned int)e3)

@@ expression e1, e2, e3; @@

-   put_bytes(e1, e2, (int)e3)
+   put_bytes(e1, e2, (unsigned int)e3)

```

Those work ok.
Then, I tried a second version, trying to compact those rules into a single, more expressive one:

```
@@ typedef long_u, uintmax_t; expression e1, e2, e3; @@

    put_bytes(
        e1,
(
-       (long_u)(e2)
|
-       (long_u)e2
)
+       (uintmax_t)e2
        ,
(
-       (int)(e3)
|
-       (int)e3
)
+       (unsigned int)e3
    )

```

That parses ok but just does nothing. So, it seems it doesn?t match anything, but I don?t understand why.
Could you please explain?

> On 20 Dec 2014, at 21:51, Julia Lawall <julia.lawall@lip6.fr> wrote:
> 
> 
> 
> On Sat, 20 Dec 2014, Eliseo Mart?nez wrote:
> 
>> Great. That worked. Just one more thing, please.
>> Some of the replacements done by the rule before leave literals of the form ?(uintmax_t)34?.
>> I would like to use an unsigned constant in those cases. This is, something like ?34u?. 
>> So I add the following rule:
>> 
>> ```
>> @@ expression e1, e3; constant c2; @@
>> 30 
>> 31 - put_bytes(e1, (uintmax_t)c2, e3)
>> 32 + put_bytes(e1, c2, e3)
>> ```
>> 
>> That does the work, except adding the ?u?. How could I do that?
>> Is it possible adding something literally in the output?
>> Is it possible to somehow say in line 32 ?render c2 but with u suffix??
> 
> It is possible, but somewhat awkward.  Here is a simpler example that you 
> can adapt to your case:
> 
> @r@
> typedef uintmax_t;
> constant c;
> @@
> 
> (uintmax_t)c
> 
> @script:python s@
> c << r.c;
> cu;
> @@
> 
> coccinelle.cu = "%su" % (c)
> 
> @@
> constant r.c;
> identifier s.cu;
> @@
> 
> - (uintmax_t)c
> + cu
> 
> julia
