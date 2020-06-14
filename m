Return-Path: <SRS0=yQoC=73=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A0BC433E0
	for <cocci@archiver.kernel.org>; Sun, 14 Jun 2020 21:18:00 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A63D8206D7
	for <cocci@archiver.kernel.org>; Sun, 14 Jun 2020 21:17:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A63D8206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 05ELHtBm004075;
	Sun, 14 Jun 2020 23:17:55 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 80E987760;
	Sun, 14 Jun 2020 23:17:55 +0200 (CEST)
Received: from osiris.lip6.fr (osiris.lip6.fr [132.227.60.30])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A1E0A44A7
 for <cocci@systeme.lip6.fr>; Sun, 14 Jun 2020 23:17:53 +0200 (CEST)
Received: from smtprelay.hostedemail.com (smtprelay0221.hostedemail.com
 [216.40.44.221])
 by osiris.lip6.fr (8.15.2/8.15.2) with ESMTPS id 05ELHnDL008380
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Sun, 14 Jun 2020 23:17:50 +0200 (CEST)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave01.hostedemail.com (Postfix) with ESMTP id A085A1813B78C
 for <cocci@systeme.lip6.fr>; Sun, 14 Jun 2020 20:01:58 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay02.hostedemail.com (Postfix) with ESMTP id ABA7C15C6;
 Sun, 14 Jun 2020 20:01:54 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: light02_2e08cc026df0
X-Filterd-Recvd-Size: 1857
Received: from XPS-9350.home (unknown [47.151.136.130])
 (Authenticated sender: joe@perches.com)
 by omf07.hostedemail.com (Postfix) with ESMTPA;
 Sun, 14 Jun 2020 20:01:53 +0000 (UTC)
Message-ID: <803557cc672ef0bcd9565c7d5d78e7053388f5d7.camel@perches.com>
From: Joe Perches <joe@perches.com>
To: efremov@linux.com, Julia Lawall <Julia.Lawall@lip6.fr>,
        Dan Carpenter
 <dan.carpenter@oracle.com>
Date: Sun, 14 Jun 2020 13:01:51 -0700
In-Reply-To: <345c783b-a8cf-9dd1-29c6-d32b9b29053f@linux.com>
References: <20200604140805.111613-1-efremov@linux.com>
 <e4981fd76a88e18376c4e634c235501b57d321e7.camel@perches.com>
 <345c783b-a8cf-9dd1-29c6-d32b9b29053f@linux.com>
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 14 Jun 2020 23:17:55 +0200 (CEST)
X-Greylist: Delayed for 01:09:59 by milter-greylist-4.4.3 (osiris.lip6.fr
 [132.227.60.30]); Sun, 14 Jun 2020 23:17:50 +0200 (CEST)
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

On Sun, 2020-06-14 at 22:42 +0300, Denis Efremov wrote:
> On 6/4/20 7:27 PM, Joe Perches wrote:
> > On Thu, 2020-06-04 at 17:08 +0300, Denis Efremov wrote:
> > > Check for memset() with 0 followed by kfree().
> > 
> > Perhaps those uses should be memzero_explicit or kvfree_sensitive.
> > 
> Is it safe to suggest to use kzfree instead of memzero_explicit && kfree?
> Or it would be better to use kvfree_sensitive in this case.
> kzfree uses memset(0) with no barrier_data.
> 
> For example:
> diff -u -p a/drivers/crypto/inside-secure/safexcel_hash.c b/drivers/crypto/inside-secure/safexcel_hash.c
[]
> @@ -1081,8 +1081,7 @@ static int safexcel_hmac_init_pad(struct
>                 }
>  
>                 /* Avoid leaking */
> -               memzero_explicit(keydup, keylen);
> -               kfree(keydup);
> +               kzfree(keydup);

It would be better to use kvfree_sensitive()


_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
