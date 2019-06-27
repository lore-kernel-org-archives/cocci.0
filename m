Return-Path: <SRS0=nFVp=U2=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2FCC48BD7
	for <cocci@archiver.kernel.org>; Thu, 27 Jun 2019 14:54:29 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A4DA20663
	for <cocci@archiver.kernel.org>; Thu, 27 Jun 2019 14:54:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A4DA20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5REsFIt008370;
	Thu, 27 Jun 2019 16:54:15 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E98FF7782;
	Thu, 27 Jun 2019 16:54:14 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 4E7E27772
 for <cocci@systeme.lip6.fr>; Thu, 27 Jun 2019 16:54:12 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5REsBd4015775
 for <cocci@systeme.lip6.fr>; Thu, 27 Jun 2019 16:54:11 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.63,424,1557180000"; d="scan'208";a="311648070"
Received: from abo-12-105-68.mrs.modulonet.fr (HELO hadrien) ([85.68.105.12])
 by mail3-relais-sop.national.inria.fr with
 ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jun 2019 16:54:11 +0200
Date: Thu, 27 Jun 2019 16:54:11 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ddc47c39-1977-fa90-2f93-72acb2303d6c@web.de>
Message-ID: <alpine.DEB.2.21.1906271653410.2627@hadrien>
References: <708207db-69d7-8962-e507-cd705142d0c4@web.de>
 <f79ae892-a674-5f69-1d25-88594a89ebff@web.de>
 <alpine.DEB.2.21.1906271332240.2627@hadrien>
 <f84bb58a-916b-0d6b-64fd-7805bd8db827@web.de>
 <alpine.DEB.2.21.1906271427250.2627@hadrien>
 <ddc47c39-1977-fa90-2f93-72acb2303d6c@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1263177741-1561647251=:2627"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 27 Jun 2019 16:54:15 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Thu, 27 Jun 2019 16:54:11 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Moving exception handling code to the end of a function
 implementation with SmPL?
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

--8323329-1263177741-1561647251=:2627
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Thu, 27 Jun 2019, Markus Elfring wrote:

> >> replacement: already tagged token:
> >
> > You try to add two things one one token, which is not allowed.
>
> How do you think about to clarify why a source file adjustment
> like the following can let my SmPL script succeed in a test configuration?
>
> elfring@Sonne:~/Projekte/Coccinelle/Probe> diff -u megaraid_sas-excerpt1.c megaraid_sas-excerpt2.c
> …
> @@ -32,24 +32,7 @@
>  		goto out_kfree_ioc;
>  	}
>
> -	if (instance->unload == 1) {
> -		error = -ENODEV;
> -		goto out_kfree_ioc;
> -	}
> -
> -	if (down_interruptible(&instance->ioctl_sem)) {
> -		error = -ERESTARTSYS;
> -		goto out_kfree_ioc;
> -	}
> -
> -	if  (megasas_wait_for_adapter_operational(instance)) {
> -		error = -ENODEV;
> -		goto out_up;
> -	}
> -
> -	error = megasas_mgmt_fw_ioctl(instance, user_ioc, ioc);
> -out_up:
> -	up(&instance->ioctl_sem);
> +// Deleted part
>
>  out_kfree_ioc:
>  	kfree(ioc);
>
>
> Where did the Coccinelle software get the impression that anything
> would be added too often at the end of such a function implementation?

Without the semantic patch and the C source code, I can't answer the
question.

julia
--8323329-1263177741-1561647251=:2627
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-1263177741-1561647251=:2627--
