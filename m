Return-Path: <SRS0=/h8Y=B6=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA2EC433E1
	for <cocci@archiver.kernel.org>; Thu, 20 Aug 2020 06:13:42 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76C112078D
	for <cocci@archiver.kernel.org>; Thu, 20 Aug 2020 06:13:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76C112078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 07K6DSFZ006725;
	Thu, 20 Aug 2020 08:13:28 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 2BEC1758C;
	Thu, 20 Aug 2020 08:13:28 +0200 (CEST)
Received: from osiris.lip6.fr (osiris.lip6.fr [132.227.60.30])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B4519428B
 for <cocci@systeme.lip6.fr>; Thu, 20 Aug 2020 08:13:26 +0200 (CEST)
Received: from smtprelay.hostedemail.com (smtprelay0123.hostedemail.com
 [216.40.44.123])
 by osiris.lip6.fr (8.15.2/8.15.2) with ESMTPS id 07K6DMBa012701
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Thu, 20 Aug 2020 08:13:23 +0200 (CEST)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave05.hostedemail.com (Postfix) with ESMTP id 3225E1802851E
 for <cocci@systeme.lip6.fr>; Wed, 19 Aug 2020 23:07:29 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay07.hostedemail.com (Postfix) with ESMTP id 9A0AF181D3030;
 Wed, 19 Aug 2020 23:07:25 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: veil80_52063782702b
X-Filterd-Recvd-Size: 2464
Received: from XPS-9350.home (unknown [47.151.133.149])
 (Authenticated sender: joe@perches.com)
 by omf05.hostedemail.com (Postfix) with ESMTPA;
 Wed, 19 Aug 2020 23:07:24 +0000 (UTC)
Message-ID: <b0fd63e4b379eda69ee85ab098353582b8c054bb.camel@perches.com>
From: Joe Perches <joe@perches.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Julia Lawall
 <julia.lawall@lip6.fr>, cocci <cocci@systeme.lip6.fr>
Date: Wed, 19 Aug 2020 16:07:23 -0700
In-Reply-To: <3bf27caf462007dfa75647b040ab3191374a59de.camel@perches.com>
References: <20200818184107.f8af232fb58b17160c570874@linux-foundation.org>
 <3bf27caf462007dfa75647b040ab3191374a59de.camel@perches.com>
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 20 Aug 2020 08:13:28 +0200 (CEST)
X-Greylist: Delayed for 07:05:54 by milter-greylist-4.4.3 (osiris.lip6.fr
 [132.227.60.30]); Thu, 20 Aug 2020 08:13:23 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.30
Cc: Giuseppe Scrivano <gscrivan@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, Andy Whitcroft <apw@shadowen.org>
Subject: [Cocci] coccinelle: Convert comma to semicolons (was Re: [PATCH]
 checkpatch: Add test for comma use that should be semicolon)
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

On Wed, 2020-08-19 at 14:22 -0700, Joe Perches wrote:
> There are commas used as statement terminations that should typically
> have used semicolons instead.  Only direct assignments or use of a single
> function or value on a single line are detected by this test.
> 
> e.g.:
> 	foo = bar(),		/* typical use is semicolon not comma */
> 	bar = baz();
> 
> Add an imperfect test to detect these comma uses.
> 
> No false positives were found in testing, but many types of false negatives
> are possible.
> 
> e.g.:
> 	foo = bar() + 1,	/* comma use, but not direct assignment */
> 	bar = baz();

Hi.

I recently added a test for this condition to linux's checkpatch.

A similar coccinelle script might be:

$ cat comma.cocci
@@
expression e1;
expression e2;
@@

	e1
-	,
+	;
	e2;
$

This works reasonably well but it has several false positives
for declarations like:

$ spatch --sp-file comma.cocci mm/huge_memory.c
diff -u -p a/huge_memory.c b/huge_memory.c
--- a/huge_memory.c
+++ b/huge_memory.c
@@ -2778,7 +2778,7 @@ static unsigned long deferred_split_scan
 	struct pglist_data *pgdata = NODE_DATA(sc->nid);
 	struct deferred_split *ds_queue = &pgdata->deferred_split_queue;
 	unsigned long flags;
-	LIST_HEAD(list), *pos, *next;
+	LIST_HEAD(list), *pos; *next;
 	struct page *page;
 	int split = 0;
$

Any script improvement suggestions?


_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
