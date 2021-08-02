Return-Path: <SRS0=dEn7=MZ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67E7C4338F
	for <cocci@archiver.kernel.org>; Mon,  2 Aug 2021 23:40:02 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 000B660EE6
	for <cocci@archiver.kernel.org>; Mon,  2 Aug 2021 23:40:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 000B660EE6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 172NdvtJ011598;
	Tue, 3 Aug 2021 01:39:57 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1FE8D750F;
	Tue,  3 Aug 2021 01:39:57 +0200 (CEST)
Received: from osiris.lip6.fr (osiris.lip6.fr [132.227.60.30])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 4B7AB3783
 for <cocci@systeme.lip6.fr>; Tue,  3 Aug 2021 01:39:55 +0200 (CEST)
Received: from smtprelay.hostedemail.com (smtprelay0144.hostedemail.com
 [216.40.44.144])
 by osiris.lip6.fr (8.15.2/8.15.2) with ESMTPS id 172NdnOY025907
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Tue, 3 Aug 2021 01:39:50 +0200 (CEST)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave03.hostedemail.com (Postfix) with ESMTP id DA52B1801F2BB
 for <cocci@systeme.lip6.fr>; Mon,  2 Aug 2021 17:44:02 +0000 (UTC)
Received: from omf08.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
 by smtprelay03.hostedemail.com (Postfix) with ESMTP id 010B5837F24F;
 Mon,  2 Aug 2021 17:43:59 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by
 omf08.hostedemail.com (Postfix) with ESMTPA id 61DC41A29FD; 
 Mon,  2 Aug 2021 17:43:58 +0000 (UTC)
Message-ID: <5e170252bf759dc90888de34fbad3291a70b58de.camel@perches.com>
From: Joe Perches <joe@perches.com>
To: Julia Lawall <julia.lawall@inria.fr>
Date: Mon, 02 Aug 2021 10:43:56 -0700
In-Reply-To: <alpine.DEB.2.22.394.2108021933170.19470@hadrien>
References: <ab04588b3b0c2bfa6942beb9069754ce59f2551b.camel@perches.com>
 <alpine.DEB.2.22.394.2108021933170.19470@hadrien>
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 61DC41A29FD
X-Stat-Signature: nschi65mm597ix8tcjcptuujnpkhrmbr
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+56IcY2FLgKpdnN/afCM0+Msvs0Tl3G+0=
X-HE-Tag: 1627926238-586059
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 03 Aug 2021 01:39:58 +0200 (CEST)
X-Greylist: Delayed for 06:33:44 by milter-greylist-4.4.3 (osiris.lip6.fr
 [132.227.60.30]); Tue, 03 Aug 2021 01:39:51 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.30
Cc: cocci <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Coccinelle: Length/Size of char array?
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

On Mon, 2021-08-02 at 19:35 +0200, Julia Lawall wrote:
> 
> On Mon, 2 Aug 2021, Joe Perches wrote:
> 
> > Is it possible to determine the length of a matched char array and use
> > the length in a test?
> > 
> > For instance, add something like a test to show only the instances
> > where a src buffer overruns a dest buffer.
> > 
> > void foo(void)
> > {
> > 	char foo[5];
> > 
> > 	strcpy(foo, "fits");
> > }
> > 
> > it would be useful to see only the instances where the dest
> > buffer would be overrun like:
> > 
> > void foo(void)
> > {
> > 	char foo[5];
> > 
> > 	strcpy(foo, "doesn't fit");
> > }
> > 
> > ---
> > 
> > This would find all instances of a constant src array into non-pointer dst:
> > 
> > @@
> > char [] dest;
> > constant char [] src;
> > @@
> > 
> > *	strcpy(dest, src)
> > 
> > ---
> > 
> > Is there a mexhanism like:
> > 
> > @@
> > char [] dest;
> > constant char [] src;
> > @@
> > 
> > 	when (some cocci grammar testing length(dest) < length(src))
> > *	strcpy(dest, src)
> 
> You can match the size and the string, and then use python or ocaml code
> to do the needed comparisons.

Pardon the question, but how do you determine the size?

> Does it occur often enough that the string
> is explicit in the call to make it worth it?

The idea is just to find defects/buffer overruns.


_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
