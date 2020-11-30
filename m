Return-Path: <SRS0=DeXm=FE=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB96C63777
	for <cocci@archiver.kernel.org>; Mon, 30 Nov 2020 19:19:46 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16FB22076E
	for <cocci@archiver.kernel.org>; Mon, 30 Nov 2020 19:19:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16FB22076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0AUJJCnb013954;
	Mon, 30 Nov 2020 20:19:12 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id CB8E67539;
	Mon, 30 Nov 2020 20:19:12 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id F11A4620
 for <cocci@systeme.lip6.fr>; Mon, 30 Nov 2020 20:19:10 +0100 (CET)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0AUJJ8eD024258
 for <cocci@systeme.lip6.fr>; Mon, 30 Nov 2020 20:19:09 +0100 (CET)
IronPort-SDR: ip01nZKHg2ApfjpkulwpdGfHXO82gEfmx9E/fOTwd6vaRh6yM+osbbzKzClzFNL/f+WTTbqCmV
 QD7DlBxnArZg==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="190883713"
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; d="scan'208";a="190883713"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Nov 2020 11:19:05 -0800
IronPort-SDR: 2mtm+kBMM/i6lk0BOB+t5tDdKACq6+yhdVtQ+S+L1rLUZmMM1750meehEOdqukiXE92AaDWPxK
 kNTabjBwGDqw==
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; d="scan'208";a="334775014"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Nov 2020 11:19:04 -0800
Date: Mon, 30 Nov 2020 11:19:04 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Julia Lawall <julia.lawall@inria.fr>
Message-ID: <20201130191904.GQ1161629@iweiny-DESK2.sc.intel.com>
References: <20201128054145.GP1161629@iweiny-DESK2.sc.intel.com>
 <alpine.DEB.2.22.394.2011280849310.2725@hadrien>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2011280849310.2725@hadrien>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 30 Nov 2020 20:19:13 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 30 Nov 2020 20:19:10 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Itterating matches
X-BeenThere: cocci@systeme.lip6.fr
X-Mailman-Version: 2.1.13
Precedence: list
List-Id: <cocci.systeme.lip6.fr>
List-Unsubscribe: <https://systeme.lip6.fr/mailman/options/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=unsubscribe>
List-Archive: <https://systeme.lip6.fr/pipermail/cocci>
List-Post: <mailto:cocci@systeme.lip6.fr>
List-Help: <mailto:cocci-request@systeme.lip6.fr?subject=help>
List-Subscribe: <https://systeme.lip6.fr/mailman/listinfo/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

On Sat, Nov 28, 2020 at 08:55:16AM +0100, Julia Lawall wrote:
> 
> 
> On Fri, 27 Nov 2020, Ira Weiny wrote:
> 
> > I have been looking for a way to help automate my kmap/mem*/kunmap
> > transformation.[1]  I'm very new to coccinelle and I'm having some trouble.
> >
> > I have tried to build up a script[2][3] to do this while also learning coccinelle
> > but I'm not getting a couple of points.
> >
> > 1) How do I get matches to iterate?
> 
> What do you mean by iterate?
> 
> > 	1a) What is the difference between '<+... ...+>' and '<... ...>'?
> 
> <+... P ...+> requires P to appear one or more times
> <... P ...>  allows P to occur 0 or more times

Great that is what I thought but I was getting confused.  See the examples
below for details.

> 
> > 2) Why can't I get the type declaration (type VP;) matched correctly.  It works
> >    some times but not always.  It also matches a lot of random declarations?
> > 	2a) and for some reason in the more advanced script[3] it completely
> > 	    breaks.  Which is very confusing because fundamentally it does not
> >             seem to be any different from [2]?
> 
> I haven't tried running the scripts to see why the declaration breaks.
> but I think that the declaration is not what you want.  ptr could be used
> in some other case.  It would be better to have one rule that makes the
> rest of the changes in the code, and the another rule that removes the ptr
> declaration when there is no remaining use of the variable:
> 
> @r1@
> identifier ptr;
> ...
> @@
> 
> remove kmaps etc
> 
> @@
> identifier r1.ptr;
> type T;
> @@
> 
> - T ptr;
>   ... when != ptr
> 
> This will allow you to get rid of lines 8 and 28 in [2].

Ok this helps a lot.   Thank you!

That said it does not seem to work.  I have a better example now.

https://elixir.bootlin.com/linux/v5.10-rc6/source/fs/btrfs/compression.c

fs/btrfs/compression.c:

 571                 if (page->index == end_index) {
 572                         char *userpage;
 573                         size_t zero_offset = offset_in_page(isize);
 574 
 575                         if (zero_offset) {
 576                                 int zeros;
 577                                 zeros = PAGE_SIZE - zero_offset;
 578                                 userpage = kmap_atomic(page);
 579                                 memset(userpage + zero_offset, 0, zeros);
 580                                 flush_dcache_page(page);
 581                                 kunmap_atomic(userpage);
 582                         }
 583                 }

<script>
@ r1 @
identifier page;
identifier ptr;
expression L;
expression Off;
@@

-ptr = kmap_atomic(page);
...
-memset(ptr + Off, 0, L);
+zero_user(page, Off, L);
...
-kunmap_atomic(ptr);


@@
identifier r1.ptr;
type VP;
@@

-VP ptr;
        ... when != ptr;
</script>

Results in:

--- fs/btrfs/compression.c
+++ /tmp/cocci-output-1442863-cb5dd7-compression.c
@@ -575,10 +575,8 @@ static noinline int add_ra_bio_pages(str
                        if (zero_offset) {
                                int zeros;
                                zeros = PAGE_SIZE - zero_offset;
-                               userpage = kmap_atomic(page);
-                               memset(userpage + zero_offset, 0, zeros);
+                               zero_user(page, zero_offset, zeros);
                                flush_dcache_page(page);
-                               kunmap_atomic(userpage);
                        }
                }


Question: Is there something about userpage being declared in the outer block
which is causing the second rule to fail?


Back to the 'iteration issue'.  I've realized that I understood perfectly what
the iteration dot notations meant...  My bug was elsewhere.

For others who may be following along at home, I'll walk through this because
it brings up another issue with the removal of the pointer declaration which
I don't understand.

That same file (fs/btrfs/compression.c) has a second instance I'm trying to
match; except with memcpy().

1242         char *kaddr;
...
1267         /* copy bytes from the working buffer into the pages */
1268         while (working_bytes > 0) {
1269                 bytes = min_t(unsigned long, bvec.bv_len,
1270                                 PAGE_SIZE - (buf_offset % PAGE_SIZE));
1271                 bytes = min(bytes, working_bytes);
1272 
1273                 kaddr = kmap_atomic(bvec.bv_page);
1274                 memcpy(kaddr + bvec.bv_offset, buf + buf_offset, bytes);
1275                 kunmap_atomic(kaddr);
...


Here I added <... ...> (and even tried <+... ...+>) around the
k[un]map_atomic() in my script to try and catch the second instance along with
the memcpy() as an alternative match; thusly.

<script>
@ r1 @
identifier page;
identifier ptr;
expression L;
expression F;
expression B;
expression Off;
@@

<...
-ptr = kmap_atomic(page);
...
(
-memset(ptr + Off, 0, L);
+zero_user(page, Off, L);
|
-memcpy(ptr + Off, F, B);
+memcpy_to_page(page, Off, F, B);
)
...
-kunmap_atomic(ptr);
...>


@@
identifier r1.ptr;
type VP;
@@

-VP ptr;
        ... when != ptr;
</script>

Which results in:

--- fs/btrfs/compression.c
+++ /tmp/cocci-output-1443266-8381d0-compression.c
@@ -575,10 +575,8 @@ static noinline int add_ra_bio_pages(str
                        if (zero_offset) {
                                int zeros;
                                zeros = PAGE_SIZE - zero_offset;
-                               userpage = kmap_atomic(page);
-                               memset(userpage + zero_offset, 0, zeros);
+                               zero_user(page, zero_offset, zeros);
                                flush_dcache_page(page);
-                               kunmap_atomic(userpage);
                        }
                }
 
:-/

Finally, after thinking on this more I realized this was _not_ because the
_iteration_ was wrong.  Rather the second kmap_atomic uses 'bvec.bv_page' which
matches as an expression not an identifier.  The correct script is therefore:

<script>
10:59:30 > cat kmap-test.cocci 
@ r1 @
expression page;                <============ 'expression'
identifier ptr;
expression L;
expression F;
expression B;
expression Off;
@@

-ptr = kmap_atomic(page);
...
(
-memset(ptr + Off, 0, L);
+zero_user(page, Off, L);
|
-memcpy(ptr + Off, F, B);
+memcpy_to_page(page, Off, F, B);
)
...
-kunmap_atomic(ptr);


@@
identifier r1.ptr;
type VP;
@@

-VP ptr;
        ... when != ptr;
</script>

which results in...

--- fs/btrfs/compression.c
+++ /tmp/cocci-output-1443375-182695-compression.c
@@ -145,7 +145,6 @@ static int check_compressed_csum(struct
        const u16 csum_size = btrfs_super_csum_size(fs_info->super_copy);
        struct page *page;
        unsigned long i;
-       char *kaddr;
        u8 csum[BTRFS_CSUM_SIZE];
        struct compressed_bio *cb = bio->bi_private;
        u8 *cb_sum = cb->sums;
@@ -575,10 +574,8 @@ static noinline int add_ra_bio_pages(str
                        if (zero_offset) {
                                int zeros;
                                zeros = PAGE_SIZE - zero_offset;
-                               userpage = kmap_atomic(page);
-                               memset(userpage + zero_offset, 0, zeros);
+                               zero_user(page, zero_offset, zeros);
                                flush_dcache_page(page);
-                               kunmap_atomic(userpage);
                        }
                }
 
@@ -1239,7 +1236,6 @@ int btrfs_decompress_buf2page(const char
        unsigned long prev_start_byte;
        unsigned long working_bytes = total_out - buf_start;
        unsigned long bytes;
-       char *kaddr;
        struct bio_vec bvec = bio_iter_iovec(bio, bio->bi_iter);
 
        /*
@@ -1270,9 +1266,8 @@ int btrfs_decompress_buf2page(const char
                                PAGE_SIZE - (buf_offset % PAGE_SIZE));
                bytes = min(bytes, working_bytes);
 
-               kaddr = kmap_atomic(bvec.bv_page);
-               memcpy(kaddr + bvec.bv_offset, buf + buf_offset, bytes);
-               kunmap_atomic(kaddr);
+               memcpy_to_page(bvec.bv_page, bvec.bv_offset, buf + buf_offset,
+                              bytes);
                flush_dcache_page(bvec.bv_page);
 
                buf_offset += bytes;


Yay!!!  The 'iteration' is not even needed...  :-D  So sorry for bothering you
on that point.

However, I still have an issue with the second rule you specified.  It appears
to be too aggressive with removing kaddr; removing it from an entirely
unrelated function.  Why?  Is there a way to limit the scope of the second rule
to blocks and parent blocks?

And the final questoin is: Why is kaddr correctly removed from
btrfs_decompress_buf2page() while the previous match 'userpage' is not?  It
seems like exactly the same pattern...

So obviously don't fully understand.

Thanks so much for your help though!  :-D
Ira

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
