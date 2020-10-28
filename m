Return-Path: <SRS0=LC4W=ED=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF82C4363A
	for <cocci@archiver.kernel.org>; Wed, 28 Oct 2020 06:50:52 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8099D2222B
	for <cocci@archiver.kernel.org>; Wed, 28 Oct 2020 06:50:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8099D2222B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09S6oPeD016299;
	Wed, 28 Oct 2020 07:50:25 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id BA9EF5C2F;
	Wed, 28 Oct 2020 07:50:25 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 54C255C16
 for <cocci@systeme.lip6.fr>; Wed, 28 Oct 2020 07:50:23 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09S6oMnD020756
 for <cocci@systeme.lip6.fr>; Wed, 28 Oct 2020 07:50:22 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.77,425,1596492000"; d="scan'208";a="474618844"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 28 Oct 2020 07:50:22 +0100
Date: Wed, 28 Oct 2020 07:50:22 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <6fe4c63d-1b7e-b947-139c-423edc519d2f@web.de>
Message-ID: <alpine.DEB.2.22.394.2010280748440.2766@hadrien>
References: <78f8b08754dde286adf7e11e1eeb3bb8ad500d8b.camel@web.de>
 <acaed49b9195d47e252a0b67551f87e96324d004.camel@web.de>
 <alpine.DEB.2.22.394.2010221434210.5113@hadrien>
 <6fe4c63d-1b7e-b947-139c-423edc519d2f@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2051016452-1603867822=:2766"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 28 Oct 2020 07:50:26 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 28 Oct 2020 07:50:22 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Michal Marek <michal.lkml@markovi.net>,
        Gilles Muller <Gilles.Muller@lip6.fr>, kernel-janitors@vger.kernel.org,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] =?utf-8?q?Coccinelle=3A_Checking_the_influence_of_?=
 =?utf-8?b?4oCcR3JlcCBxdWVyeeKAnQ==?=
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

--8323329-2051016452-1603867822=:2766
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Tue, 27 Oct 2020, Markus Elfring wrote:

> > It doesn't matter.  The purpose is just to select files that are relevent
> > for consideration.  If a file is selected for two reasons instead of one
> > reason, it doesn't matter; it's still selected.
>
> The software “git grep” probably supports also short-circuit evaluation
> for the discussed use case (because command parameters were selected in the way
> that this special functionality would not be excluded).
> https://github.com/git/git/blob/e8ab941b671da6890181aea5b5755d1d9eea24ec/grep.c#L1294
>
> Under which circumstances would potentially measurable effects become more interesting
> so that the reordering of the mentioned identifiers would be reconsidered?
>
>
> elfring@Sonne:~/Projekte/Linux/next-patched> /usr/bin/time git grep --threads 4 -l -w -e 'for_each_node_by_type' -e 'for_each_matching_node_and_match' -e 'for_each_compatible_node' -e 'for_each_available_child_of_node' -e 'for_each_child_of_node' -e 'for_each_matching_node' -e 'for_each_node_by_name' -e 'for_each_node_with_property' -- '*.[ch]' > /dev/null
> 1.55user 0.74system 0:01.24elapsed 183%CPU (0avgtext+0avgdata 78760maxresident)k
> 216inputs+0outputs (3major+30006minor)pagefaults 0swaps
> elfring@Sonne:~/Projekte/Linux/next-patched> /usr/bin/time git grep --threads 4 -l -w -e 'for_each_child_of_node' -e 'for_each_available_child_of_node' -e 'for_each_compatible_node' -e 'for_each_node_by_name' -e 'for_each_node_by_type' -e 'for_each_matching_node' -e 'for_each_matching_node_and_match' -e 'for_each_node_with_property' -- '*.[ch]' > /dev/null
> 1.55user 0.72system 0:01.24elapsed 183%CPU (0avgtext+0avgdata 74380maxresident)k
> 0inputs+0outputs (0major+31030minor)pagefaults 0swaps

As far as I can see, you are showing that the times are the same.  Why are
you wasting your time on this?

Although I didn't know that git grep was parallelizable, although since
the used time and the elapsed time are almost the same, maybe it doesn't
help much.

julia
--8323329-2051016452-1603867822=:2766
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-2051016452-1603867822=:2766--
