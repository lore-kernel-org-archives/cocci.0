Return-Path: <SRS0=CfGU=BZ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD4CC433DF
	for <cocci@archiver.kernel.org>; Sat, 15 Aug 2020 18:23:58 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC4F523C84
	for <cocci@archiver.kernel.org>; Sat, 15 Aug 2020 18:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="snPX6e/0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC4F523C84
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 07FINeAr019283;
	Sat, 15 Aug 2020 20:23:40 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 229547780;
	Sat, 15 Aug 2020 20:23:40 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 05AB15F8F
 for <cocci@systeme.lip6.fr>; Sat, 15 Aug 2020 20:23:38 +0200 (CEST)
Received: from shiva.jussieu.fr (shiva.jussieu.fr [134.157.0.129])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 07FINZ5S025983
 for <cocci@systeme.lip6.fr>; Sat, 15 Aug 2020 20:23:35 +0200 (CEST)
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by shiva.jussieu.fr (8.15.2/jtpda-5.4) with ESMTP id 07FINALB002242
 for <cocci@systeme.lip6.fr>; Sat, 15 Aug 2020 20:23:35 +0200 (CEST)
X-Ids: 164
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=XNnhqa1EUtqytFCfJSuJLhsT+WcSRC9k4ESXyMuhNTU=; b=snPX6e/0YVSp1IEqXQqMvaGXZs
 690Ej5IRXxO8q+ekbLWln56lZObyenBEZwB9gVI+Rgh/OVCz/ZK6rZ4jpBAcJvUQINLfYnI32NB5p
 Dl7iwSxgXobIfatecLrHb6exWfppgGaF3SGpXbQLu4fPe87kg12MUrlydN52Wf8nDfpUIrGdaWcm9
 nEkcMn9QTO9mtJWj80Edzz618rhyeqdm1gr9hKGSjB/YVI0REbzkZAS8LG+QCittA7Tuz1kyguuP9
 vu2LrGHht4+Mxd4hRkmteFllaPNl3oIQx7ZZSsMHMXUrA9YkY1I9D9vEraTU4PXR5N6qZ9FLEO40B
 Y0NFTu5w==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1k70pY-0004UB-36; Sat, 15 Aug 2020 18:23:00 +0000
Date: Sat, 15 Aug 2020 19:23:00 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Markus Elfring <Markus.Elfring@web.de>
Message-ID: <20200815182300.GZ17456@casper.infradead.org>
References: <2e717622-22ba-9947-c8df-520bdbb2e16f@web.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2e717622-22ba-9947-c8df-520bdbb2e16f@web.de>
X-Miltered: at jchkmail2.reseau.jussieu.fr with ID 5F38280E.000 by Joe's
 j-chkmail (http : // j-chkmail dot ensmp dot fr)!
X-j-chkmail-Enveloppe: 5F38280E.000 from
 casper.infradead.org/casper.infradead.org/90.155.50.34/casper.infradead.org/<willy@infradead.org>
X-Scores-Stats: 5F38280E.000 B=0.50000 L=0.31034 G=0.31034 Disagree Winner=PH
X-Label-Query: YES
X-j-chkmail-Score: MSGID : 5F38280E.000 on shiva.jussieu.fr : j-chkmail score
 : XX : R=. U=. O=. B=0.310 -> S=0.310
X-j-chkmail-Status: Unsure
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 15 Aug 2020 20:23:40 +0200 (CEST)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 15 Aug 2020 20:23:35 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, kernel-team@fb.com,
        Christoph Hellwig <hch@lst.de>, Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] [PATCH 2/2] tree-wide: rename vmemdup_user to
	kvmemdup_user
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

On Sat, Aug 15, 2020 at 03:10:12PM +0200, Markus Elfring wrote:
> > This helper uses kvmalloc, not vmalloc, so rename it to kvmemdup_user to
> > make it clear we're using kvmalloc() and will need to use kvfree().
> 
> Can the renaming of this function name trigger software updates
> for any more source files?

Why don't you find out, and if there are, submit your own patch?

> Example:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/coccinelle/api/memdup_user.cocci?id=c9c9735c46f589b9877b7fc00c89ef1b61a31e18#n18
> 
> Regards,
> Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
