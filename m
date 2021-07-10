Return-Path: <SRS0=WlPR=MC=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5B5C07E9E
	for <cocci@archiver.kernel.org>; Sat, 10 Jul 2021 20:02:46 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 196366128C
	for <cocci@archiver.kernel.org>; Sat, 10 Jul 2021 20:02:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 196366128C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 16AK2hYU010049;
	Sat, 10 Jul 2021 22:02:43 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 0EE9A42CB;
	Sat, 10 Jul 2021 22:02:43 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 990504065
 for <cocci@systeme.lip6.fr>; Sat, 10 Jul 2021 22:02:41 +0200 (CEST)
Received: from smtprelay.hostedemail.com (smtprelay0001.hostedemail.com
 [216.40.44.1])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 16AK2dH2000641
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Sat, 10 Jul 2021 22:02:41 +0200 (CEST)
Received: from omf08.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
 by smtprelay08.hostedemail.com (Postfix) with ESMTP id 06BE1182CED2A;
 Sat, 10 Jul 2021 20:02:39 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by
 omf08.hostedemail.com (Postfix) with ESMTPA id 2B7C51A29F9; 
 Sat, 10 Jul 2021 20:02:38 +0000 (UTC)
Message-ID: <afd3a282ca57a4a400c8bae9879a7c57bc507c59.camel@perches.com>
From: Joe Perches <joe@perches.com>
To: Julia Lawall <julia.lawall@inria.fr>
Date: Sat, 10 Jul 2021 13:02:36 -0700
In-Reply-To: <alpine.DEB.2.22.394.2107102149140.46528@hadrien>
References: <08b89608cfb1280624d1a89ead6547069f9a4c31.camel@perches.com>
 <alpine.DEB.2.22.394.2107102149140.46528@hadrien>
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
X-Stat-Signature: acaiyyzxzs3uxyr8edc374hez41ejw4g
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 2B7C51A29F9
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+IOF/X85f5HAaZl7mOKJZ2SwAmuy46KrU=
X-HE-Tag: 1625947358-191922
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 10 Jul 2021 22:02:43 +0200 (CEST)
X-Greylist: Delayed for 20:54:32 by milter-greylist-4.4.3 (isis.lip6.fr
 [132.227.60.2]); Sat, 10 Jul 2021 22:02:41 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: kernel-janitors@vger.kernel.org, cocci <cocci@systeme.lip6.fr>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Cocci] cocci script to convert linux-kernel allocs with
 BITS_TO_LONGS to bitmap_alloc
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

On Sat, 2021-07-10 at 21:50 +0200, Julia Lawall wrote:
> On Fri, 9 Jul 2021, Joe Perches wrote:
> 
> > Here is a cocci script to convert various types of bitmap allocations
> > that use BITS_TO_LONGS to the more typical bitmap_alloc functions.
> > 
> > Perhaps something like it could be added to scripts/coccinelle.
> > The diff produced by the script is also below.
> > 
> > $ cat bitmap_allocs.cocci
> > // typical uses of bitmap allocations
[]
> > @@
> > expression val;
> > expression e1;
> > expression e2;
> > @@
> > 
> > -	val = kcalloc(BITS_TO_LONGS(e1), sizeof(*val), e2)
> > +	val = bitmap_zalloc(e1, e2)
> 
> Is there something that guarantees that val has a type that has a size that
> is the same as a long?

no, but afaict, all do.


_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
