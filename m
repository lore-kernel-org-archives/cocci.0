From: bruce.w.allan@intel.com (Allan, Bruce W)
Date: Thu, 1 Mar 2018 19:13:45 +0000
Subject: [Cocci] transform needing a calculation from a Python script
Message-ID: <804857E1F29AAC47BF68C404FC60A184ED57F7E8@ORSMSX105.amr.corp.intel.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

We have a macro that takes a right-justified contiguous set of bits and shifts it left to create a bitmask:

#define FOO(m, s)            (m) << (s)

where m is in hex and s is an integer.  I'd like to transform occurrences of it to the Linux kernel's GENMASK(high, low) macro (which creates a contiguous bitmask starting at bit position low and ending@position high), but am having problems trying to figure out how to do that.

For example, I'd like to transform:
               #define BITMASK_A         FOO(0x3F, 4)                      /* 0x3F0 */
to
               #define BITMASK_A         GENMASK(9, 4)                 /* 0x3F0 */

The value s in FOO() is the same as the value low in GENMASK(), but the value high in GENMASK() must be calculated from the values m and s in FOO().  One calculation would be to use the hamming weight (hweight) such as hweight(m) + s - 1.  My Python-foo is non-existent but I have found online an example for calculating the hamming weight with the Python script 'def hweight(n): return bin(n).count("1")'.  Is it possible to use this (or another) Python script in a Coccinelle script to do this transform, and if so, what would that look like?  If the transform cannot use Python, is there another suggestion?

Thanks,
Bruce.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20180301/d114de3a/attachment.html>
