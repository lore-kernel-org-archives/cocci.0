Return-Path: <SRS0=Cozf=YA=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA10C47404
	for <cocci@archiver.kernel.org>; Mon,  7 Oct 2019 20:42:49 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3547B2084D
	for <cocci@archiver.kernel.org>; Mon,  7 Oct 2019 20:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="thZqMFMs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3547B2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x97Kgag1011579;
	Mon, 7 Oct 2019 22:42:36 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 8863A77A9;
	Mon,  7 Oct 2019 22:42:36 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 922CB76ED
 for <cocci@systeme.lip6.fr>; Mon,  7 Oct 2019 15:15:54 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x97DFqNk020184
 for <cocci@systeme.lip6.fr>; Mon, 7 Oct 2019 15:15:52 +0200 (CEST)
Received: from linux-8ccs (ip5f5ade87.dynamic.kabel-deutschland.de
 [95.90.222.135])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 07A032084D;
 Mon,  7 Oct 2019 13:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1570454151;
 bh=yaGiBdsMqATrOurcaKLKqrYg43AY7Q6N3F9F+dL0RI8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=thZqMFMsagBTGSCXcSjKL/6nXbiyrTIcKSMg69+btrs+dfxzO9yHnezGb63jHXhoy
 mUcG0ZUANN3GoFS44ixg7JzGIi+XqRgMCarou3TuSu8lzwOf45KQui+OnokRmvQ8Ti
 O4ZsT2wgXBbV2Gf/rAVBpXVqrca2xB+GncwUKGTs=
Date: Mon, 7 Oct 2019 15:15:42 +0200
From: Jessica Yu <jeyu@kernel.org>
To: YueHaibing <yuehaibing@huawei.com>
Message-ID: <20191007131542.GA30078@linux-8ccs>
References: <CAK7LNAS2K6i+s2A_xTyRq730M6_=tyjtfwHAnEHF37_nrJa4Eg@mail.gmail.com>
 <20191006044456.57608-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191006044456.57608-1-yuehaibing@huawei.com>
X-OS: Linux linux-8ccs 4.12.14-lp150.12.28-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 07 Oct 2019 22:42:37 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 07 Oct 2019 15:15:52 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Mon, 07 Oct 2019 22:42:35 +0200
Cc: michal.lkml@markovi.net, nicolas.palix@imag.fr, maennich@google.com,
        linux-kernel@vger.kernel.org, Markus.Elfring@web.de,
        gregkh@linuxfoundation.org, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH] scripts: add_namespace: Fix coccicheck failed
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

+++ YueHaibing [06/10/19 12:44 +0800]:
>Now all scripts in scripts/coccinelle to be automatically called
>by coccicheck. However new adding add_namespace.cocci does not
>support report mode, which make coccicheck failed.
>This add "virtual report" to  make the coccicheck go ahead smoothly.
>
>Fixes: eb8305aecb95 ("scripts: Coccinelle script for namespace dependencies.")
>Acked-by: Julia Lawall <julia.lawall@lip6.fr>
>Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Thanks for the fix!

If there are no complaints, I'll queue this up in the modules tree for -rc3.

Jessica
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
