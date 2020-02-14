Return-Path: <SRS0=ztE1=4C=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 611A0C2BA83
	for <cocci@archiver.kernel.org>; Fri, 14 Feb 2020 12:13:38 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04D132086A
	for <cocci@archiver.kernel.org>; Fri, 14 Feb 2020 12:13:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04D132086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=users.sourceforge.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 01ECDQvh009970;
	Fri, 14 Feb 2020 13:13:26 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id F3D737802;
	Fri, 14 Feb 2020 13:13:25 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 1F28977F4
 for <cocci@systeme.lip6.fr>; Fri, 14 Feb 2020 13:13:24 +0100 (CET)
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.141])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 01ECDM3o009606
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <cocci@systeme.lip6.fr>; Fri, 14 Feb 2020 13:13:23 +0100 (CET)
Received: from submission (posteo.de [89.146.220.130]) 
 by mout01.posteo.de (Postfix) with ESMTPS id 483BE160064
 for <cocci@systeme.lip6.fr>; Fri, 14 Feb 2020 13:05:37 +0100 (CET)
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 48JsXJ3Mzrz6tmN;
 Fri, 14 Feb 2020 13:05:36 +0100 (CET)
Date: Fri, 14 Feb 2020 13:05:35 +0100
From: Michele Martone <michelemartone@users.sourceforge.net>
To: Markus Elfring <Markus.Elfring@web.de>
Message-ID: <20200214120535.GC4691@localhost>
Mail-Followup-To: Markus Elfring <Markus.Elfring@web.de>, cocci@systeme.lip6.fr
References: <138939dd-ff5b-2b85-946d-891d028bb3fa@web.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <138939dd-ff5b-2b85-946d-891d028bb3fa@web.de>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 14 Feb 2020 13:13:26 +0100 (CET)
X-Greylist: Delayed for 00:07:45 by milter-greylist-4.4.3 (isis.lip6.fr
 [132.227.60.2]); Fri, 14 Feb 2020 13:13:23 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Supporting Coccinelle software
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

On 20200214@12:52, Markus Elfring wrote:
> > And because Coccinelle is free software, I could inspect
> > Coccinelle and even adapt a few minimal things to my needs!
> Would you like to share a bit more information about such adjustments?
I cloned coccinelle's GIT repository, I suggested a patch, and 
the patch has been accepted.
That is not possible with non-free software.
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
