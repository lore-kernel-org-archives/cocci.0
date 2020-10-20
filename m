Return-Path: <SRS0=QPwM=D3=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B27C433DF
	for <cocci@archiver.kernel.org>; Tue, 20 Oct 2020 09:44:49 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 473E4206DC
	for <cocci@archiver.kernel.org>; Tue, 20 Oct 2020 09:44:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 473E4206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09K9iGLp015782;
	Tue, 20 Oct 2020 11:44:16 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id CBCEF75B4;
	Tue, 20 Oct 2020 11:44:16 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 9E7B445D8
 for <cocci@systeme.lip6.fr>; Tue, 20 Oct 2020 11:44:15 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09K9iFMJ016404
 for <cocci@systeme.lip6.fr>; Tue, 20 Oct 2020 11:44:15 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.77,396,1596492000"; d="scan'208";a="362273034"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 20 Oct 2020 11:44:14 +0200
Date: Tue, 20 Oct 2020 11:44:14 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Peng Liang <liangpeng10@huawei.com>
In-Reply-To: <ab7c6405-6384-9454-1219-08666b51c5c7@huawei.com>
Message-ID: <alpine.DEB.2.22.394.2010201143330.2736@hadrien>
References: <ab7c6405-6384-9454-1219-08666b51c5c7@huawei.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 20 Oct 2020 11:44:17 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 20 Oct 2020 11:44:15 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr, xiexiangyou 00584000 <xiexiangyou@huawei.com>
Subject: Re: [Cocci] spatch issue with compound literals
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



On Tue, 20 Oct 2020, Peng Liang wrote:

> Hi,
> I tried to use coccinelle to add an empty element to compound literals
> using spatch version 1.0.8 compiled with OCaml version 4.10.0.
>
> Here is my script:
> @@
> identifier a;
> identifier fld;
> expression E;
> @@
>  struct A a = {
>      ...,
>      .fld = (struct B[]) {
>          ...,
>          { ..., E, ... },
> +        {  }
>      },
>      ...,
>  };
>
> And I received the following error:
> minus: parse error:
>   File "add-end-of-list.cocci", line 8, column 21, charpos = 97
>   around = '[',
>   whole content =      .fld = (struct B[]) {
>
> Am I missing something?

I don't think it is supported.  Even if I put [...] instead of [], it just
complains about something else (the {).  I will see if it is possible to
fix.

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
