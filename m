Return-Path: <SRS0=VML6=QU=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00540C282CA
	for <cocci@archiver.kernel.org>; Wed, 13 Feb 2019 19:52:45 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B9FE222D0
	for <cocci@archiver.kernel.org>; Wed, 13 Feb 2019 19:52:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B9FE222D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1DJqRu1009527
          ; Wed, 13 Feb 2019 20:52:27 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 8FA8876F4;
	Wed, 13 Feb 2019 20:52:27 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 209EB76F3
 for <cocci@systeme.lip6.fr>; Wed, 13 Feb 2019 20:52:23 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1DJqM7Z012862
 for <cocci@systeme.lip6.fr>; Wed, 13 Feb 2019 20:52:22 +0100 (CET)
X-pt: isis.lip6.fr
X-Addr-Warning: ATTENTION - Votre correspondant a fourni une adresse
 d'enveloppe @lip6.fr, mais ce message ne provient pas
 de lip6.fr ! postmaster@lip6.fr.
X-IronPort-AV: E=Sophos;i="5.58,366,1544482800"; d="scan'208";a="369313067"
Received: from abo-58-107-68.mrs.modulonet.fr (HELO hadrien) ([85.68.107.58])
 by mail2-relais-roc.national.inria.fr with
 ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2019 20:52:21 +0100
Date: Wed, 13 Feb 2019 20:52:21 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <c10e0bf1-4830-7ee4-5b21-70b521dd6c36@web.de>
Message-ID: <alpine.DEB.2.21.1902132050200.2655@hadrien>
References: <1550039015-5587-1-git-send-email-wen.yang99@zte.com.cn>
 <c10e0bf1-4830-7ee4-5b21-70b521dd6c36@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 13 Feb 2019 20:52:28 +0100 (CET)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Wed, 13 Feb 2019 20:52:22 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Yi Wang <wang.yi59@zte.com.cn>, kernel-janitors@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Wen Yang <yellowriver2010@hotmail.com>,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        Coccinelle <cocci@systeme.lip6.fr>,
        Xue Zhihong <xue.zhihong@zte.com.cn>, Wen Yang <wen.yang99@zte.com.cn>
Subject: Re: [Cocci] [PATCH v3] Coccinelle: semantic patch for missing
	put_device()
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



On Wed, 13 Feb 2019, Markus Elfring wrote:

> > The of_find_device_by_node() takes a reference to the underlying device
> > structure, we should release that reference.
>
> I have got another concern for further software development considerations.
>
> How do you think about to describe here if it can be determined
> by source code analysis that the desired release should be performed
> only in the same function implementation (or not)?
>
> How much does this aspect influence the source code search confidence?
>
>
> > +    when != e1 = (T)id
> > +    when != e2 = &id->dev
> > +    when != e3 = get_device(&id->dev)
> > +    when != e4 = (T1)platform_get_drvdata(id)
>
> I have got another idea for a bit of software fine-tuning at such a place.
> I am unsure if it can become relevant to reduce the number of metavariables
> here by introducing a SmPL disjunction.
>
> +    when != ex = \( (T)id \| &id->dev \| get_device(&id->dev) \| (T1)platform_get_drvdata(id) \)

There is no need for the disjunction.  There is also no need for the
different variables.  Different variables are only needed when the when
conditions are on different ...s

julia

>
>
> Regards,
> Markus
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
