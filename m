Return-Path: <SRS0=YDxQ=X7=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35B6C10F14
	for <cocci@archiver.kernel.org>; Sun,  6 Oct 2019 07:30:35 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E1F520835
	for <cocci@archiver.kernel.org>; Sun,  6 Oct 2019 07:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEnevVVz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E1F520835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x967UNr2029600;
	Sun, 6 Oct 2019 09:30:23 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id AD0ED779A;
	Sun,  6 Oct 2019 09:30:23 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0709D7792
 for <cocci@systeme.lip6.fr>; Sun,  6 Oct 2019 09:30:20 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x967UJdR006074
 for <cocci@systeme.lip6.fr>; Sun, 6 Oct 2019 09:30:19 +0200 (CEST)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A718B20835;
 Sun,  6 Oct 2019 07:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1570347018;
 bh=o2oRi+v2tANAFGZ+liBCnnpn2Juw9vAh8Vep/Ky/EWE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WEnevVVzWB+o8BpPpJNZtP1LkrKDMAk5txnLgbmNPUU6G23ee6tIIWrbOGM6qMNbi
 /xsaw4YAPwUI4TxWcBOVSI5G3rsUEWy+qJDUiRF9qJTAttRk+mLHo7vL9lYhLpUNeP
 Z8KkNUzs/KvNI+LlDdHD2LB8yAPNpyks3pZpRA/A=
Date: Sun, 6 Oct 2019 09:30:16 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Markus Elfring <Markus.Elfring@web.de>
Message-ID: <20191006073016.GA2133217@kroah.com>
References: <CAK7LNAS2K6i+s2A_xTyRq730M6_=tyjtfwHAnEHF37_nrJa4Eg@mail.gmail.com>
 <21684307-d05c-1856-c849-95436aedeb86@web.de>
 <alpine.DEB.2.21.1910051425050.2653@hadrien>
 <f64fc086-7852-b074-6247-108b753dc272@web.de>
 <alpine.DEB.2.21.1910060727580.4623@hadrien>
 <8390d1f8-1907-ef19-c527-6bdb380d96c9@web.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8390d1f8-1907-ef19-c527-6bdb380d96c9@web.de>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 06 Oct 2019 09:30:24 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 06 Oct 2019 09:30:19 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Michal Marek <michal.lkml@markovi.net>,
        Yue Haibing <yuehaibing@huawei.com>,
        Matthias =?iso-8859-1?Q?M=E4nnich?= <maennich@google.com>,
        Nicolas Palix <nicolas.palix@imag.fr>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jessica Yu <jeyu@kernel.org>,
        Martijn Coenen <maco@android.com>, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [RFC] scripts: Fix coccicheck failed
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

On Sun, Oct 06, 2019 at 07:34:49AM +0200, Markus Elfring wrote:
> >> Would you like to increase your software development attention for
> >> efficient system configuration on this issue?
> >
> > No.
> 
> Thanks for this information.
> 
> I am still curious if other contributors will care more for this aspect.

No.  Please stop.

greg k-h
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
