Return-Path: <SRS0=mBJ9=EC=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6710C388F9
	for <cocci@archiver.kernel.org>; Tue, 27 Oct 2020 12:04:12 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D0C322264
	for <cocci@archiver.kernel.org>; Tue, 27 Oct 2020 12:04:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D0C322264
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09RC3gPP022729;
	Tue, 27 Oct 2020 13:03:42 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3E36B5C2F;
	Tue, 27 Oct 2020 13:03:42 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A3DDF5C18
 for <cocci@systeme.lip6.fr>; Tue, 27 Oct 2020 13:03:40 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09RC3cPY026558
 for <cocci@systeme.lip6.fr>; Tue, 27 Oct 2020 13:03:38 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.77,423,1596492000"; d="scan'208";a="474507552"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Oct 2020 13:03:35 +0100
Date: Tue, 27 Oct 2020 13:03:35 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <bfb3e786-a64f-ecaf-eb37-8bd6b53cf38a@web.de>
Message-ID: <alpine.DEB.2.22.394.2010271303190.2847@hadrien>
References: <78f8b08754dde286adf7e11e1eeb3bb8ad500d8b.camel@web.de>
 <acaed49b9195d47e252a0b67551f87e96324d004.camel@web.de>
 <45310257-201a-40ea-348f-b8e909c3775c@web.de>
 <alpine.DEB.2.22.394.2010271155330.2847@hadrien>
 <bfb3e786-a64f-ecaf-eb37-8bd6b53cf38a@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-410386229-1603800215=:2847"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 27 Oct 2020 13:03:42 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 27 Oct 2020 13:03:38 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Michal Marek <michal.lkml@markovi.net>,
        Gilles Muller <Gilles.Muller@lip6.fr>, kernel-janitors@vger.kernel.org,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci]
 =?utf-8?q?Coccinelle=3A_Checking_the_relevance_of_parenth?=
 =?utf-8?b?ZXNlcyBpbiDigJxnaXQgZ3JlcOKAnQ==?=
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

--8323329-410386229-1603800215=:2847
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Tue, 27 Oct 2020, Markus Elfring wrote:

> >> … git grep -l -w \( -e for_each_node_by_type … -e for_each_node_with_property \) -- '*.c'
> >>
> >>
> >> How do you think about to omit these parentheses here?
> >
> > Does it make a difference?
>
> I find that it can be nicer to avoid the passing of unnecessary characters.
>
> * The compilation of the affected OCaml source files can eventually benefit
>   from another bit of clean-up, can't it?

I have no idea what this means.

julia

> * The called software components do also not need to fiddle with such extra data then.
>
> Regards,
> Markus
>
--8323329-410386229-1603800215=:2847
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-410386229-1603800215=:2847--
