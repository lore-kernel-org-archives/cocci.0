Return-Path: <SRS0=YDxQ=X7=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C1A4C4360C
	for <cocci@archiver.kernel.org>; Sun,  6 Oct 2019 11:10:07 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87BF62084B
	for <cocci@archiver.kernel.org>; Sun,  6 Oct 2019 11:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="TEnZSkbF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87BF62084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x96B9pYi020046;
	Sun, 6 Oct 2019 13:09:51 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 5A80F779A;
	Sun,  6 Oct 2019 13:09:51 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 8E0967792
 for <cocci@systeme.lip6.fr>; Sun,  6 Oct 2019 13:09:48 +0200 (CEST)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:342] (may be forged))
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x96B9jCr006797
 for <cocci@systeme.lip6.fr>; Sun, 6 Oct 2019 13:09:45 +0200 (CEST)
Received: by mail-wm1-x342.google.com with SMTP id 3so9672320wmi.3
 for <cocci@systeme.lip6.fr>; Sun, 06 Oct 2019 04:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=KNc82HtJTr2S9yPplsKQ29xKge0h6KdPsl2jhs4BKZo=;
 b=TEnZSkbFr2A7oUM78IHHed3IlgHh0tmkpH8RDssbiR0+mBCHkQe9H1Qxx+vWm2PofE
 sGToOgCFb6hXoCRurvp2anQnTqIH03RhsFu2lxcDV8uagaxEWpHnmGBp14zXgB7Ji5DK
 yQkA74rsANN+bsj7tBFGADqhxFVNGCwn0vccgfBJC0S4ul+XS2NGUWI8kKL36SXIEoGi
 Ys368zcUKr4s1+elLPyEJlWSfNOLEUzVoGLdBwmiXWNtuyUiFQ1CDc8EcteynP4OG/+P
 1JPy+3ec+C6ru4Rw7bsV4fQWWQz7c42N/jqxS6luY8aIfxhWUly2EHxSYvZRsFg+emn2
 lNOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=KNc82HtJTr2S9yPplsKQ29xKge0h6KdPsl2jhs4BKZo=;
 b=GnexO6eAW4KksJv7EgNXmr0/2qm4AnO0cVxOOtMLuLbHu267vjyBPFPqo18+VLP8zY
 dI5U9PXL1juLgtY8cBP27fqlFwhoj+oXeDGNEpgBoDi/a1tIus1VutCJ/TDaBUab2SUw
 9J2Y+3pICO+ebBYulpO+s6p7Mu2uFt6Y5mnhmcqurnujwErv5DZUOoA6DnneIfLltuML
 m8S7M60iVu1kprSvtPt/Q1ZF+m4C7DYK0/LseQp5d7ZvuKD4Qb0/ozOaD1p4eut7psMe
 ZHIttENV0PPjMsCDfjUWaDPv4NGVqRFCH6UH3vBqEVCIglbnz/4rzbLFagMqNhAtUfKU
 h1NA==
X-Gm-Message-State: APjAAAWQtCon1WaRTbAs5wDF3YcA5wXNYyZS7QBJc7M1QQplJWqslE5f
 J6H98JAboju7kglECoJcEho6MQ==
X-Google-Smtp-Source: APXvYqze9DN/H2RXzVEdSmtpoum+tTRMTWdWq6wiMUONDwQ1y3I9igSwjnOhiK6Ch9ZxdQYuTaIxmA==
X-Received: by 2002:a05:600c:2311:: with SMTP id
 17mr16465507wmo.39.1570360184748; 
 Sun, 06 Oct 2019 04:09:44 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:e8f7:125b:61e9:733d])
 by smtp.gmail.com with ESMTPSA id n1sm21203796wrg.67.2019.10.06.04.09.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Oct 2019 04:09:44 -0700 (PDT)
Date: Sun, 6 Oct 2019 12:09:43 +0100
From: Matthias Maennich <maennich@google.com>
To: YueHaibing <yuehaibing@huawei.com>
Message-ID: <20191006110943.GA172281@google.com>
References: <CAK7LNAS2K6i+s2A_xTyRq730M6_=tyjtfwHAnEHF37_nrJa4Eg@mail.gmail.com>
 <20191006044456.57608-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191006044456.57608-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 06 Oct 2019 13:09:52 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 06 Oct 2019 13:09:45 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: michal.lkml@markovi.net, gregkh@linuxfoundation.org, nicolas.palix@imag.fr,
        linux-kernel@vger.kernel.org, Markus.Elfring@web.de, jeyu@kernel.org,
        cocci@systeme.lip6.fr
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

Hi YueHaibing!

On Sun, Oct 06, 2019 at 12:44:56PM +0800, YueHaibing wrote:
>Now all scripts in scripts/coccinelle to be automatically called
>by coccicheck. However new adding add_namespace.cocci does not
>support report mode, which make coccicheck failed.
>This add "virtual report" to  make the coccicheck go ahead smoothly.
>
>Fixes: eb8305aecb95 ("scripts: Coccinelle script for namespace dependencies.")
>Acked-by: Julia Lawall <julia.lawall@lip6.fr>
>Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Thanks for fixing this!

Acked-by: Matthias Maennich <maennich@google.com>

Cheers,
Matthias

>---
> scripts/coccinelle/misc/add_namespace.cocci | 2 ++
> 1 file changed, 2 insertions(+)
>
>diff --git a/scripts/coccinelle/misc/add_namespace.cocci b/scripts/coccinelle/misc/add_namespace.cocci
>index c832bb6445a8..99e93a6c2e24 100644
>--- a/scripts/coccinelle/misc/add_namespace.cocci
>+++ b/scripts/coccinelle/misc/add_namespace.cocci
>@@ -6,6 +6,8 @@
> /// add a missing namespace tag to a module source file.
> ///
>
>+virtual report
>+
> @has_ns_import@
> declarer name MODULE_IMPORT_NS;
> identifier virtual.ns;
>-- 
>2.20.1
>
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
