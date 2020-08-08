Return-Path: <SRS0=2tmj=BS=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EAEC433DF
	for <cocci@archiver.kernel.org>; Sat,  8 Aug 2020 11:35:50 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F12C2065E
	for <cocci@archiver.kernel.org>; Sat,  8 Aug 2020 11:35:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F12C2065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 078BZSKl016707;
	Sat, 8 Aug 2020 13:35:28 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 839BB76BF;
	Sat,  8 Aug 2020 13:35:28 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A29A9428B
 for <cocci@systeme.lip6.fr>; Sat,  8 Aug 2020 13:35:27 +0200 (CEST)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 078BZQrA021115
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Sat, 8 Aug 2020 13:35:27 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: jaskaran_singh) with ESMTPSA id 94A172992E4
Message-ID: <e9cd0456be597be5c028c4173d2212f593efb3d3.camel@collabora.com>
From: Jaskaran Singh <jaskaran.singh@collabora.com>
To: Markus Elfring <Markus.Elfring@web.de>,
        Julia Lawall
 <julia.lawall@inria.fr>
Date: Sat, 08 Aug 2020 17:05:20 +0530
In-Reply-To: <04cb5eb3-bed8-9e8e-255b-fbae06144016@web.de>
References: <e4f3c4e8-03e8-dbc2-5871-0d111b3086a4@web.de>
 <alpine.DEB.2.22.394.2008020904310.2531@hadrien>
 <eead5e2a-da8d-83cd-eeb4-f193702b800f@web.de>
 <alpine.DEB.2.22.394.2008021348430.2531@hadrien>
 <82af6b44-ea09-b86f-81f7-e96e8594a31d@web.de>
 <alpine.DEB.2.22.394.2008021513010.2531@hadrien>
 <065fee88-5206-5d9b-c83c-4e6a20aefd85@web.de>
 <alpine.DEB.2.22.394.2008021632210.2531@hadrien>
 <8f357aa0-7811-a5b8-a061-814899654e88@web.de>
 <alpine.DEB.2.22.394.2008021733340.2531@hadrien>
 <c1822815-456f-316d-93b5-88beb55a0d69@web.de>
 <alpine.DEB.2.22.394.2008021814220.2531@hadrien>
 <74a5a472-4431-46e7-bd8b-95886f031c93@web.de>
 <alpine.DEB.2.22.394.2008021859010.2531@hadrien>
 <3474ebf5-c902-63e9-8244-08a0f3407b72@web.de>
 <ba1f8a2dc9e079bc01fc2037f1246f25cd956ee5.camel@collabora.com>
 <04cb5eb3-bed8-9e8e-255b-fbae06144016@web.de>
Organization: Collabora
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 08 Aug 2020 13:35:29 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sat, 08 Aug 2020 13:35:27 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] [00/43] cocci: Add support for meta attributes to SmPL
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

On Sat, 2020-08-08 at 13:33 +0200, Markus Elfring wrote:
> > Probably a pretty printing mistake. I'll fix this.
> 
> How do you think about to clarify any related software dependencies?
> 

What do you mean?

> Regards,
> Markus

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
