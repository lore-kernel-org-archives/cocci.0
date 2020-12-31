Return-Path: <SRS0=ECaW=GD=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18AAEC433E0
	for <cocci@archiver.kernel.org>; Thu, 31 Dec 2020 23:53:54 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E19F206DF
	for <cocci@archiver.kernel.org>; Thu, 31 Dec 2020 23:53:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E19F206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0BVNrSGa016976;
	Fri, 1 Jan 2021 00:53:28 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 515CF3A53;
	Fri,  1 Jan 2021 00:53:28 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id F1247373F
 for <cocci@systeme.lip6.fr>; Fri,  1 Jan 2021 00:53:26 +0100 (CET)
Received: from smtprelay.hostedemail.com (smtprelay0113.hostedemail.com
 [216.40.44.113])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0BVNrOoJ007122
 for <cocci@systeme.lip6.fr>; Fri, 1 Jan 2021 00:53:24 +0100 (CET)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave03.hostedemail.com (Postfix) with ESMTP id 3C867181CAC61
 for <cocci@systeme.lip6.fr>; Thu, 31 Dec 2020 21:24:04 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay01.hostedemail.com (Postfix) with ESMTP id 64D91100E7B43;
 Thu, 31 Dec 2020 21:24:01 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: sofa78_14019a2274b0
X-Filterd-Recvd-Size: 1372
Received: from [192.168.1.159] (unknown [47.151.137.21])
 (Authenticated sender: joe@perches.com)
 by omf15.hostedemail.com (Postfix) with ESMTPA;
 Thu, 31 Dec 2020 21:24:00 +0000 (UTC)
Message-ID: <a3279a5772b2e49b57890cd75e97360b82890798.camel@perches.com>
From: Joe Perches <joe@perches.com>
To: Julia Lawall <julia.lawall@inria.fr>
Date: Thu, 31 Dec 2020 13:23:57 -0800
In-Reply-To: <alpine.DEB.2.22.394.2012312219520.20387@hadrien>
References: <58a84d03b714f71d231f9cac04af09a6b97c6f04.camel@perches.com>
 <cc5722eb472a0a94f3418f6081b10f3c4a7e156d.camel@perches.com>
 <alpine.DEB.2.22.394.2012312124290.20387@hadrien>
 <eaa30016de67722c9595c3233b32b94474280a0a.camel@perches.com>
 <alpine.DEB.2.22.394.2012312219520.20387@hadrien>
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 01 Jan 2021 00:53:28 -878300 (CET)
X-Greylist: Delayed for 03:39:46 by milter-greylist-4.4.3 (isis.lip6.fr
 [132.227.60.2]); Fri, 01 Jan 2021 00:53:25 -878300 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] cocci: missed strlcpy->strscpy conversion?
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

On Thu, 2020-12-31 at 22:21 +0100, Julia Lawall wrote:
> It seems that the problem is not really the for_each, but the * in front
> of a "function call" on the left side of an assignment.  Without the *,
> everything is fine.  So it is indeed probably not worth doing anything
> about.

Maybe a combination because if braces are added to the for_each,
the conversion also works.


_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
