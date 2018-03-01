From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 1 Mar 2018 20:46:26 +0100 (CET)
Subject: [Cocci] transform needing a calculation from a Python script
In-Reply-To: <804857E1F29AAC47BF68C404FC60A184ED57F7E8@ORSMSX105.amr.corp.intel.com>
References: <804857E1F29AAC47BF68C404FC60A184ED57F7E8@ORSMSX105.amr.corp.intel.com>
Message-ID: <alpine.DEB.2.20.1803012044390.3474@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 1 Mar 2018, Allan, Bruce W wrote:

>
> We have a macro that takes a right-justified contiguous set of bits and
> shifts it left to create a bitmask:
>
> ?
>
> #define FOO(m, s)??????????? (m) << (s)
>
> ?
>
> where m is in hex and s is an integer.? I?d like to transform occurrences of
> it to the Linux kernel?s GENMASK(high, low) macro (which creates a
> contiguous bitmask starting at bit position low and ending at position
> high), but am having problems trying to figure out how to do that.
>
> ?
>
> For example, I?d like to transform:
>
> ?????????????? #define BITMASK_A???????? FOO(0x3F, 4)?????????????????????
> /* 0x3F0 */
>
> to
>
> ?????????????? #define BITMASK_A???????? GENMASK(9, 4)? ?????????????? /*
> 0x3F0 */
>
> ?
>
> The value s in FOO() is the same as the value low in GENMASK(), but the
> value high in GENMASK() must be calculated from the values m and s in
> FOO().? One calculation would be to use the hamming weight (hweight) such as
> hweight(m) + s ? 1.? My Python-foo is non-existent but I have found online
> an example for calculating the hamming weight with the Python script ?def
> hweight(n): return bin(n).count("1")?.? Is it possible to use this (or
> another) Python script in a Coccinelle script to do this transform, and if
> so, what would that look like?? If the transform cannot use Python, is there
> another suggestion?

I think that you can follow the model of the following code
(demos/pythontococci.cocci).  Let me know if it is not clear.

julia

@a@
identifier x;
@@

foo(x);

@script:python b@
x << a.x;
y;
z;
@@

print y
coccinelle.y = x
coccinelle.z = "something"
print y

@c@
identifier b.y;
identifier b.z;
identifier a.x;
@@

- bar();
+ matched_bar(y,z,x);
