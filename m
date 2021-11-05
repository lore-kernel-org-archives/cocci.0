Return-Path: <SRS0=AtCD=PY=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01694C433F5
	for <cocci@archiver.kernel.org>; Fri,  5 Nov 2021 16:12:19 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19E0260F55
	for <cocci@archiver.kernel.org>; Fri,  5 Nov 2021 16:12:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 19E0260F55
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
X-IronPort-AV: E=Sophos;i="5.87,212,1631570400"; 
   d="scan'208";a="2222274"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Nov 2021 17:12:16 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8235AE006B; Fri,  5 Nov 2021 17:12:15 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id E84FBE004C
	for <cocci@sympa.inria.fr>; Fri,  5 Nov 2021 17:12:10 +0100 (CET)
Authentication-Results: mail2-smtp-roc.national.inria.fr; spf=None smtp.pra=vbabka@suse.cz; spf=Pass smtp.mailfrom=vbabka@suse.cz; spf=None smtp.helo=postmaster@smtp-out2.suse.de
IronPort-PHdr: =?us-ascii?q?A9a23=3ASw2cjh05tN8wlpJtsmDOTAQyDhhOgF0UFjAc5pd?=
 =?us-ascii?q?vsb9SaKPrp82kYBaGo60zxw+QFcWDsrQY0bKQ6/ihEUU7or+5+EgYd5JNUxJXw?=
 =?us-ascii?q?e43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQviPgR?=
 =?us-ascii?q?pOOv1BpTSj8Oq3Oyu5pHfeQpFiCSgbb9oMBm7rArdu8oLjYB/Lqo91gbFrmFHd?=
 =?us-ascii?q?uhI2W9kP06fkwr56syt4JNt7iNctu47+cVdS6v6ZaM4TbJZDDQiLW844dDguAf?=
 =?us-ascii?q?AQwWS+HYSS30anRVUDQfL6hH6RYrxvTDhtuVhwimaPNb5Qq4yVD+/8qpkUh7oi?=
 =?us-ascii?q?CMANz4k7GHaj9F7gaxHrB69oRF03ojZa5yXOvVjZKPQZdAUS2ROUclfSSJPAp6?=
 =?us-ascii?q?yYJcAAecaIeZVrZPwq0cSoRawBwShAv7kxD9Shn/x2K03y+suEQXc0ww7A9IOs?=
 =?us-ascii?q?XHUrNTxNKwPTO261rLHzTbZYPhL3jr99pPHfQo6rvGPR719atHRyVQ0FwzblFm?=
 =?us-ascii?q?ftY3kMiqT2+8QvGeV8/BuWvizi247tQ5xuD6vy98oh4fGmI4Z1EzI+TtlzYg7O?=
 =?us-ascii?q?9C1VFB3bcCrHpZStSyXNpZ7Tt48T2xqtig3yLIItJq7ciUL1pgq2gLTZvyFfoW?=
 =?us-ascii?q?U5B/oSeifITB9hH1/ebK/gQ6/8Uyuy+36TMW01khFrjZdntnPqH8NzRrT5daDS?=
 =?us-ascii?q?vdn+UehwzmP2gbO4e9HOUA5jbfXJpohz7Iqi5Yev0TOEjXolEnokKOabFso9+y?=
 =?us-ascii?q?u5u/6eLvpvIWcOJVxigzmMqQhhMi/AeMgPwgVWmib5fy82KTk/U3kXLVGkOc6k?=
 =?us-ascii?q?rLEsJDBO8sXvLO2DBFN3oYi7RawESum3cwFkXQDLF9JYg+LgobpNl3UPvz0E+u?=
 =?us-ascii?q?zj06ynDpv3/zGO6fuApTJLnjNirfherN95lZCyAUo199Q/JFUBasaLfLoR0/xr?=
 =?us-ascii?q?8LXAgUlPA212+rnEsly1psCWWKTBa+UKL/dsViU6e0zIumBf5QVuTb4K/g9/fH?=
 =?us-ascii?q?il345mVkHfamox5Qbcn64Hu41a3meNHHridwAOWYMpAs3CuLw23OYVjsGWXK7R?=
 =?us-ascii?q?L494zA/QKivB4TKDtSzirWL3y6TBYBNayZNGAbfQj/Ta4yYVqJUO2qpKch7n2l?=
 =?us-ascii?q?cPVBAY5QkyQnrsxLmkfx8M/HZvCEV58qLPD1d/PDImFc5524sZyxy+3qQVGwyl?=
 =?us-ascii?q?XFaHlcL?=
IronPort-Data: =?us-ascii?q?A9a23=3AGiBst6jUnQQAu4NbFyOO7yIuX161IBEKZh0ujC4?=
 =?us-ascii?q?5NGQNrF6WrkVTyTFLXGiFPfneYGr2Lt93aI6//E0Ov8CByIJjT1c6+1hgHilAw?=
 =?us-ascii?q?SbnLYTAfx2oZ0t+DeWaERk5t51GAjX4wXFdokb0/n9BCZC86ykjvU20buCkUre?=
 =?us-ascii?q?dY3gsHVQMpBoJ0HqPpcZp2uaEvvDiW2thifuqyyHuEAfNNwxcagr42IrfwP9bh?=
 =?us-ascii?q?8kejRtD1rAIiV+ni3eF/5UdJMp3yahctBIUSKEMdgKxb76rIL1UYgrkExkR5tO?=
 =?us-ascii?q?Nyt4Xc2URR6LKeA+TliAQQLW5j15Oq0Te0I5iZadaMBwKzW/Tx5Yrmb2htrToI?=
 =?us-ascii?q?estFrPGke4eWjFDDjpze6ZUkFPCCSLl65bJlxeun3zEmaoyUxhtVWECwc58Bmp?=
 =?us-ascii?q?F9NQDOTUVZ1aCgfi3yfS1UIFRam4LOJG+YcVFrig1lXeBGaxzGdaaE/uU8YQNh?=
 =?us-ascii?q?HFtkp8bNOj4TM8/RTpJTR3mXwdpLg5PXcp6xPPAamLXaDhEsBeSuLZtpXPO1wE?=
 =?us-ascii?q?33LWFDTYcQfTSLe09o6pSjjiuE6XF7hAm2Bi30j+Z6jerm/OV2zjmQ49UGLDQG?=
 =?us-ascii?q?jtC6LGM7jR7NfHUfQLTTTqFZoqWQM9EJgof6ELCaIAsoVezQICVswKQ+Ra5U91?=
 =?us-ascii?q?1ZzaUO/Yn8wzLwbi8D8OxboQbZmYpVeHKf/PaidDnOpFlUj8p6fFSXGWpdE+g?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Ad55Il6MStC0lCcBcTgqjsMiBIKoaSvp037BL?=
 =?us-ascii?q?7TEJdTV+dMuEm8ey2P4f3QXv4QxhIE3I9urwX5VoLUm9yXcX2/h2AV7dZnichI?=
 =?us-ascii?q?LAFugLhuGO/9TdIUzDH4VmupuIHZITNDSJNykZsS4tiDPXLz5xqOP3k5yAtKPX?=
 =?us-ascii?q?xGt2QUVhbaZ85w1lYzzrdnFedU1PGYc5UICZ+9MCuyCtYh0sH6GGOkU=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0AOAAD4VoVhmB3ch8NaHAEBAQEBAQcBA?=
 =?us-ascii?q?RIBAQQEAQFAgUYGAQELAYMgVgEBATgxhEeObIF3LpwzgXwLAQMBDTcKBAEBh1c?=
 =?us-ascii?q?CHQcBBDEIDgECBBUBAQUBAQECAQMDBAETAQEBAQEBAQEJCxAGOiSFaA2CNSKEF?=
 =?us-ascii?q?QQZAQE4NAImAmwIAQGCbQGDCwurIH8ygQGCCAEBBoE+AQsBgQ+DDxyBWgmBECo?=
 =?us-ascii?q?BjSJ6JxyBSUSBFSeCVAGDOBcBAxiEXoJljyQ+NRwcECJRCB1rAZJMjkeceYEkg?=
 =?us-ascii?q?0IFg1WGdJQbBg8FLZVkDpE2lhCMdJk4gWMBghEzGggwO4JpCRYyGQ+OIAwNCYN?=
 =?us-ascii?q?4hDE7hUtAAQEBMAI2AgYLAQEDCY9uAQE?=
X-IPAS-Result: =?us-ascii?q?A0AOAAD4VoVhmB3ch8NaHAEBAQEBAQcBARIBAQQEAQFAgUY?=
 =?us-ascii?q?GAQELAYMgVgEBATgxhEeObIF3LpwzgXwLAQMBDTcKBAEBh1cCHQcBBDEIDgECB?=
 =?us-ascii?q?BUBAQUBAQECAQMDBAETAQEBAQEBAQEJCxAGOiSFaA2CNSKEFQQZAQE4NAImAmw?=
 =?us-ascii?q?IAQGCbQGDCwurIH8ygQGCCAEBBoE+AQsBgQ+DDxyBWgmBECoBjSJ6JxyBSUSBF?=
 =?us-ascii?q?SeCVAGDOBcBAxiEXoJljyQ+NRwcECJRCB1rAZJMjkeceYEkg0IFg1WGdJQbBg8?=
 =?us-ascii?q?FLZVkDpE2lhCMdJk4gWMBghEzGggwO4JpCRYyGQ+OIAwNCYN4hDE7hUtAAQEBM?=
 =?us-ascii?q?AI2AgYLAQEDCY9uAQE?=
X-IronPort-AV: E=Sophos;i="5.87,212,1631570400"; 
   d="scan'208";a="2222202"
X-MGA-submission: =?us-ascii?q?MDFx6lZx2D7FpePIizP3Dy/X0e7SCVaHADwZeV?=
 =?us-ascii?q?XPtlM4BQbuw9IaU036M37v7U9I7+VQhKXr55SfeTYpgpnx8nI7Lg+zCt?=
 =?us-ascii?q?+1jlVDQrmPF0d2wLVlpdBj9OHz+AhC9+EXJea03EKDP3ML4Fii5XQJ6D?=
 =?us-ascii?q?64mqB899BSu3nFAuamam2Qnw=3D=3D?=
Received: from smtp-out2.suse.de ([195.135.220.29])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2021 17:12:11 +0100
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1CFDB1FD37
	for <cocci@inria.fr>; Fri,  5 Nov 2021 16:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1636128730; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0++cssi97M7aYGNFafhJRajjG9C6j/fD0t/0W8YywDU=;
	b=khyfSDLiKAc0eDPZrRjen97vSP6uCQE4oeaawVGf28hokQTzAzTbr0NWiZ2QMqpsNsw5ni
	oEk21PCrVcsgRKkDC+oXCkyox7R78eW09Nq+ovBIN0Gx6z1FUyyItDI9opSx57FPvm1xd8
	AmASGFdAHSs1bK5/LYbHmUDybEGxh1Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1636128730;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0++cssi97M7aYGNFafhJRajjG9C6j/fD0t/0W8YywDU=;
	b=igFBkNBEFX92H3BkUIpV9cg448rudhlkyQJGehrt8I/fPc5gGAuCvIBPd0TV8skbLzrtYR
	dXXsi45Fult+2VAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0788F1400B
	for <cocci@inria.fr>; Fri,  5 Nov 2021 16:12:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id Ba3NANpXhWG7PQAAMHmgww
	(envelope-from <vbabka@suse.cz>)
	for <cocci@inria.fr>; Fri, 05 Nov 2021 16:12:10 +0000
Message-ID: <17a7a40f-b736-e0ea-02ae-1b03ef4483bf@suse.cz>
Date: Fri, 5 Nov 2021 17:12:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Content-Language: en-US
To: cocci@inria.fr
From: Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [cocci] Need some help with spatch
Reply-To: Vlastimil Babka <vbabka@suse.cz>
X-Loop: cocci@inria.fr
X-Sequence: 73
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-11/17a7a40f-b736-e0ea-02ae-1b03ef4483bf%40suse.cz>

Hi all,

I'm working on a patchset originally by Matthew Wilcox that replaces "struct
page" with "struct slab" in slab allocators [1].
Because a lot of the changes there are mechanistic, I thought it would be a
good idea to perform them via coccinelle semantic patch. But it's my first
attempt at large real usage of spatch, and it probably shows.

Overal I have managed to do what I wanted, but encountered some issues that
required workarounds so I will list them here and would welcome any help. I
assume most are from my inexperience and it's possible to adjust the
semantic patches so the workarounds are not needed.

The current development snapshot of the series is at [2], git clone url [3]
branch slab-struct_slab-v1r8

There are 3 semantic patches used in the series. For easier development, the
respective commits add a .cocci file in addition to applying it (when
finalized, the .cocci content would be moved to changelog as usual):

184d9494c1a4 ("mm/slub: mass conversion of struct page to struct slab by
spatch") adds slub.cocci

ccd7da3f3888 ("mm/slab: mass conversion of struct page to struct slab by
spatch") adds slab.cocci

0c60a4fcc1b2 ("mm: spatch conversion of struct page to struct slab for
subsystems interacting with slab") adds slab_shared.cocci

So here are the issues I encountered:

1) patching complex variable declarations;

I need to perform changes such as:
-struct page *page;
+struct slab *slab;

This I was able to somehow specify in the .cocci, but not for situations
where the original declarations looks like this:

struct page *page, *page2;

or

struct page *page = NULL;

Therefore, for 2 of the 3 semantic patches I have a "prerequisite" commits
that change those declarations to split multiple variables or initial assinment:
f15698e1c920 ("mm/slub: prepare for struct patch conversion by spatch")
8a685ebb3b2a ("mm/slab: prepare for struct patch conversion by spatch")

It would be nice to eliminate those, if possible, but I don't know how
to adjust the respective .cocci for that.

2) for the SLUB cocci patch, some places where the semantic patch should
change something are "missed" even though other similar places are not

It can be seen in this commit that fixes them up:

d12d641854a8 ("mm/slub: fix up places that spatch missed")

for example the cocci patch is supposed to change all "page" to "slab", but
some lines are patched like this:

-       __free_slab(page->slab_cache, page);
+       __free_slab(page->slab_cache, slab);

so it missed the first 'page' and commit d12d641854a8 has to fix that up. I
don't know why. It seems it's mainly places where two different changes
would be applicable to a single line? Maybe the .cocci rules should be
written differently to handle this?

3) eliminated whitespace including newlines

This is stylistic but will require some postprocessing fixups if not solved.
There seem to be several cases like this where whitespace including newlines
is eliminated between two lines that are patched by the spatch:

-       struct page *page;
-
-       page = container_of(h, struct page, rcu_head);
+       struct slab *slab;slab = container_of(h, struct page, rcu_head);

4) unnecessary indentation changes for multiline function declarations or calls

This is the least critical, but maybe there's a way to preserve original
indentation and not do reindenting like this?

-static inline bool cmpxchg_double_slab(struct kmem_cache *s, struct page *page,
-               void *freelist_old, unsigned long counters_old,
-               void *freelist_new, unsigned long counters_new,
-               const char *n)
+static inline bool cmpxchg_double_slab(struct kmem_cache *s,
+                                      struct slab *slab,
+                                      void *freelist_old,
+                                      unsigned long counters_old,
+                                      void *freelist_new,
+                                      unsigned long counters_new,
+                                      const char *n)

Thanks in advance for any hints!

[1] https://lwn.net/Articles/871982/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slab-struct_slab-v1r8
[3] git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git
