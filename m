Return-Path: <SRS0=Oul2=6V=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB91C54E49
	for <cocci@archiver.kernel.org>; Thu,  7 May 2020 16:19:54 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B7DF2083B
	for <cocci@archiver.kernel.org>; Thu,  7 May 2020 16:19:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B7DF2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 047GJW7D016803;
	Thu, 7 May 2020 18:19:32 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A3E20775A;
	Thu,  7 May 2020 18:19:32 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id EE7253E68
 for <cocci@systeme.lip6.fr>; Thu,  7 May 2020 18:19:30 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 047GJT1T025071
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Thu, 7 May 2020 18:19:29 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.73,364,1583190000"; d="scan'208";a="448721220"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 07 May 2020 18:19:28 +0200
Date: Thu, 7 May 2020 18:19:28 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <60964864-2009-f78e-fd51-307cea4692cc@web.de>
Message-ID: <alpine.DEB.2.21.2005071818390.2505@hadrien>
References: <60964864-2009-f78e-fd51-307cea4692cc@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1298890365-1588868368=:2505"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 07 May 2020 18:19:32 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 07 May 2020 18:19:29 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci]
 =?utf-8?q?Checking_an_application_of_the_SmPL_construct_?=
 =?utf-8?b?4oCcPCsuLi4g4oCmIC4uLis+4oCd?=
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
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1298890365-1588868368=:2505
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Thu, 7 May 2020, Markus Elfring wrote:

> Hello,
>
> I have tried further script variants out for the semantic patch language
> (according to the software combination “Coccinelle 1.0.8-00087-g7cf2c23e”).
>
> Source code example:
> // SPDX-License-Identifier: GPL-2.0-only
> // deleted part
> static int sca3000_read_data(struct sca3000_state *st,
> 			     u8 reg_address_high,
> 			     u8 *rx,
> 			     int len)
> {
> 	int ret;
> 	struct spi_transfer xfer[2] = {
> 		{
> 			.len = 1,
> 			.tx_buf = st->tx,
> 		}, {
> 			.len = len,
> 			.rx_buf = rx,
> 		}
> 	};
> // deleted part
> 	ret = spi_sync_transfer(st->us, xfer, ARRAY_SIZE(xfer));
> 	if (ret) {
> 		dev_err(get_device(&st->us->dev), "problem reading register");
> 		return ret;
> 	}
>
> 	return 0;
> }
> // deleted part
>
>
> See also:
> https://lore.kernel.org/patchwork/patch/1236743/
> https://lore.kernel.org/linux-iio/20200506035206.192173-1-christophe.jaillet@wanadoo.fr/
>
>
> The following search approach points a questionable source code place out
> as expected.
>
> @display@
> @@
> (dev_err
> |dev_info
> )       (
> *        get_device(...),
>          ...
>         )
>
>
> elfring@Sonne:~/Projekte/Coccinelle/janitor> spatch show_get_device_as_message_parameter2.cocci ../Probe/sca3000-excerpt-20200505.c
> …
> @@ -18,7 +18,6 @@ static int sca3000_read_data(struct sca3
>  // deleted part
>  	ret = spi_sync_transfer(st->us, xfer, ARRAY_SIZE(xfer));
>  	if (ret) {
> -		dev_err(get_device(&st->us->dev), "problem reading register");
>  		return ret;
>  	}
>
>
> But I do not get the same output for the following SmPL script.
>
> @display@
> @@
> (dev_err
> |dev_info
> )       (
> *        <+... get_device(...) ...+>
>         )
>
>
> Is such a test result worth for further software development considerations?

No.

<+... ...+> as an expression matches a single expression.  The function
has multiple arguments.

julia

> Does the application of the SmPL nest construct need any more clarification?
> https://github.com/coccinelle/coccinelle/issues/114
>
> Regards,
> Markus
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
--8323329-1298890365-1588868368=:2505
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-1298890365-1588868368=:2505--
