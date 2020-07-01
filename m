Return-Path: <SRS0=uwmw=AM=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8072C433E0
	for <cocci@archiver.kernel.org>; Wed,  1 Jul 2020 19:15:53 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47A4120720
	for <cocci@archiver.kernel.org>; Wed,  1 Jul 2020 19:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2jwLCb2E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47A4120720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 061JFUph001801;
	Wed, 1 Jul 2020 21:15:30 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 7192E776E;
	Wed,  1 Jul 2020 21:15:30 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 24804742B
 for <cocci@systeme.lip6.fr>; Wed,  1 Jul 2020 21:15:29 +0200 (CEST)
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231:0:0:0:1])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 061JFQD2015622
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 1 Jul 2020 21:15:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=/3mRpXE2WcpFPbt8RSkz8DlUCIiHtqfq+9DvEmy0pvA=; b=2jwLCb2EtCbo46BZ516z1Y4MhP
 oQ1EQW+ka/hrtaxfJd+ftPtbKiFiwrwZkMbQBdWcpvAfpyqQZeOygY2fCzZnB5M+CpXWqkUh/cWxs
 YWnnMToUVStyEXobc4jV1IXdLnbkjp2qrVDx31lDwxoTqB7yCOz3blmFIl30ePGyjVArK/FGFHlHt
 fzOkRjayoadft1Gk9ttVHK7aqUJlsFZc1tVXgECrAfFfxwPD9e8oD/ewj6vqwQ7iiCUUa+9ixK9b0
 CfLH1/MvtjeYDbT/teQaAdo2NLFYuNiG/USfrdID5E0F39G3DOA/MHvy9qj5J8RiyBgc9DCjJpNRR
 y2EAR8hg==;
Received: from [2601:1c0:6280:3f0::19c2]
 by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqiCV-0004hm-3Q; Wed, 01 Jul 2020 19:15:19 +0000
To: Markus Elfring <Markus.Elfring@web.de>, linux-doc@vger.kernel.org,
        Coccinelle <cocci@systeme.lip6.fr>
References: <0616dd0c-bb86-be2b-3dc6-1c695a92c3ca@infradead.org>
 <c2c1dec0-2bd1-b0e2-1aa4-38d0e954d5ba@web.de>
 <efc8b0c9-db3b-3c9c-d876-897b53a9e278@infradead.org>
 <2a3940de-6a81-1aff-8109-53c1c5a6aa1b@web.de>
 <f2aaa91a-f935-bc2d-26f2-712576c1bbd7@infradead.org>
 <2f80fb10-dc7f-29be-dc3e-2715f8bafc6d@web.de>
 <dfa2ed9f-fe68-58d1-c3d0-ac436f9bee09@infradead.org>
 <648d287e-3636-1858-1439-103d317f8571@web.de>
 <34065299-03cf-5b62-db37-0acc9830be72@infradead.org>
 <65db3f88-1ac8-374d-e3fe-2ea0970ffd67@web.de>
 <30b722ca-1bd8-2b96-ca41-1e9bc7212b66@infradead.org>
 <bd4033cd-f564-0414-4dbf-4ff58f841648@web.de>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <05f8cb2b-c76e-e2ba-24a8-5676c1792255@infradead.org>
Date: Wed, 1 Jul 2020 12:15:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <bd4033cd-f564-0414-4dbf-4ff58f841648@web.de>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 01 Jul 2020 21:15:30 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Wed, 01 Jul 2020 21:15:28 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: Michal Marek <michal.lkml@markovi.net>,
        Gilles Muller <Gilles.Muller@lip6.fr>, kernel-janitors@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        LKML <linux-kernel@vger.kernel.org>,
        Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [Cocci] [v2] Documentation: Coccinelle: fix typos and command
	example
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

On 7/1/20 10:32 AM, Markus Elfring wrote:
>> None of that has anything to do with the current patch.
> 
> Did you test the specified make command for the display
> of expected data processing results?

Markus, if something doesn't work, just say so, OK?
Don't go all obtuse on us.

> How much do you distinguish desired effects according to
> the specification of file extensions for such build commands?

I don't grok that.


@Jon, Julia-
I plan to submit a v3 without the addition of "path/to/file.c" in 2 places.


However, I thought that this:
  To apply Coccinelle on a file basis, instead of a directory basis, the
  following command may be used::

    make C=1 CHECK="scripts/coccicheck"

meant that someone could run coccicheck on one source file, but I cannot
get that to work.

Julia, Markus- can you tell me how to run coccicheck on one source file?


Thanks.
-- 
~Randy

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
