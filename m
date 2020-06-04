Return-Path: <SRS0=OH0s=7R=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4734C433DF
	for <cocci@archiver.kernel.org>; Thu,  4 Jun 2020 20:02:56 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C1D72075B
	for <cocci@archiver.kernel.org>; Thu,  4 Jun 2020 20:02:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C1D72075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 054K2rkH025004;
	Thu, 4 Jun 2020 22:02:53 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 0D1157567;
	Thu,  4 Jun 2020 22:02:53 +0200 (CEST)
Received: from osiris.lip6.fr (osiris.lip6.fr [132.227.60.30])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 18C575D47
 for <cocci@systeme.lip6.fr>; Thu,  4 Jun 2020 22:02:52 +0200 (CEST)
Received: from smtprelay.hostedemail.com (smtprelay0238.hostedemail.com
 [216.40.44.238])
 by osiris.lip6.fr (8.15.2/8.15.2) with ESMTPS id 054K2nVK022207
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Thu, 4 Jun 2020 22:02:51 +0200 (CEST)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave01.hostedemail.com (Postfix) with ESMTP id 2BA3918043DDF
 for <cocci@systeme.lip6.fr>; Thu,  4 Jun 2020 17:37:02 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay08.hostedemail.com (Postfix) with ESMTP id EBE1F181B2466;
 Thu,  4 Jun 2020 17:36:58 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bulb68_170feaa26d99
X-Filterd-Recvd-Size: 1947
Received: from XPS-9350.home (unknown [47.151.136.130])
 (Authenticated sender: joe@perches.com)
 by omf10.hostedemail.com (Postfix) with ESMTPA;
 Thu,  4 Jun 2020 17:36:58 +0000 (UTC)
Message-ID: <7ea2fe7105006f74337498549f167e01d0fd5fc3.camel@perches.com>
From: Joe Perches <joe@perches.com>
To: efremov@linux.com, Julia Lawall <Julia.Lawall@lip6.fr>
Date: Thu, 04 Jun 2020 10:36:56 -0700
In-Reply-To: <d0fced31-f1d7-9e0b-1a58-f441891fcbc7@linux.com>
References: <20200604140805.111613-1-efremov@linux.com>
 <e4981fd76a88e18376c4e634c235501b57d321e7.camel@perches.com>
 <d0fced31-f1d7-9e0b-1a58-f441891fcbc7@linux.com>
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 04 Jun 2020 22:02:53 +0200 (CEST)
X-Greylist: Delayed for 02:16:52 by milter-greylist-4.4.3 (osiris.lip6.fr
 [132.227.60.30]); Thu, 04 Jun 2020 22:02:51 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.30
Cc: cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH] coccinelle: api: add kzfree script
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

On Thu, 2020-06-04 at 20:30 +0300, Denis Efremov wrote:
> 
> On 6/4/20 7:27 PM, Joe Perches wrote:
> > On Thu, 2020-06-04 at 17:08 +0300, Denis Efremov wrote:
> > > Check for memset() with 0 followed by kfree().
> > 
> > Perhaps those uses should be memzero_explicit or kvfree_sensitive.
> 
> Thanks, I will add memzero_explicit(). However, I can't find kvfree_sensitive().
> Is it in next already?

Yes

$ git grep kvfree_sensitive
include/linux/mm.h:extern void kvfree_sensitive(const void *addr, size_t len);
mm/util.c: * kvfree_sensitive - Free a data object containing sensitive information.
mm/util.c:void kvfree_sensitive(const void *addr, size_t len)
mm/util.c:EXPORT_SYMBOL(kvfree_sensitive);
security/keys/keyctl.c: kvfree_sensitive(payload, plen);
security/keys/keyctl.c: kvfree_sensitive(payload, plen);
security/keys/keyctl.c:                         kvfree_sensitive(key_data, key_data_len);
security/keys/keyctl.c: kvfree_sensitive(key_data, key_data_len);
security/keys/keyctl.c: kvfree_sensitive(payload, plen);


_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
