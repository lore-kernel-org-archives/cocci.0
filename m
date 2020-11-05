Return-Path: <SRS0=q7iJ=EL=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5B6C4741F
	for <cocci@archiver.kernel.org>; Thu,  5 Nov 2020 17:37:19 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B49E0206CA
	for <cocci@archiver.kernel.org>; Thu,  5 Nov 2020 17:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="mbaMDfWM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B49E0206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0A5HatEp016143;
	Thu, 5 Nov 2020 18:36:55 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 8FA7777A4;
	Thu,  5 Nov 2020 18:36:55 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id AEED67493
 for <cocci@systeme.lip6.fr>; Thu,  5 Nov 2020 17:32:08 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0A5GW8DA007503
 for <cocci@systeme.lip6.fr>; Thu, 5 Nov 2020 17:32:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1604593927;
 bh=uod7eQLJ69w1pWFykma7oHAJIzY7faUYzWAkjhOEajg=;
 h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
 b=mbaMDfWM3fogG6kVu2+sqJOThRgAk5fhHST1DM8zQo5z5V3dHMH/HCYLwxD8nQLY+
 0VKC/1MYJ1TOz/pQ7oIaX4vzmmPK+9aQ+CHK8OMgmQQObX+QBr80VUwAb3xIdSGKjw
 GxY6vzuyOq6C1ulLbbOhvm9Y7PpC5i2hRimn2p9s=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.49.129.92]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N2SL5-1kCPLE08id-013tan; Thu, 05
 Nov 2020 17:32:07 +0100
To: Julia Lawall <julia.lawall@inria.fr>
References: <7035a5fc-0a9f-09be-fb6a-c3418e98a953@web.de>
 <alpine.DEB.2.22.394.2011051648030.3219@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Message-ID: <7275826d-4c91-e3b8-c046-ec9f98cecac2@web.de>
Date: Thu, 5 Nov 2020 17:32:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2011051648030.3219@hadrien>
Content-Language: en-GB
X-Provags-ID: V03:K1:EW7QdeF+3VyZs1+gc2Ob2QXv1gBQoPDgIVgsTlGcOdb3EHxDGPU
 vRUD+DBPeWBzReAahQPe0vKAqiQlu7bEy7uFwj4bPZum33eJhZENte6LAye7ykyQPofo0Ma
 aYHKR5Jy5s4bghQ6c5Q1sYq9gRRFCfxQHvqom1Ur5G4sFkDkKEFdXrljAlM4/UzZium3Op5
 L30iRSijRBnb15hd08nOQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FzPpzxmbr0w=:gChAhZ2/8dxdD6B06Co3pO
 AM2mrCWKE0M8EdATuVN4cJIVUEetkrrHrIKoLe5UG8Jc6d5n+sY4DzvGcpKV6ndIgLXF6X2kE
 p4NS3HQEPfseF5n+A42fwnC259xVxUfUDtf8JT5AL3rRe19429ConBKa4J+d8XDdwNEWwYMwe
 I7qgj9QW9R2+mRnKqOvdFaoDjmG+QIQjZtBLp4VFELT65voozG6BMOYRdylWDIP5HmFEUZXvb
 Qz2V4p6j8QpqHuPBUnj+c8w4W68pxPUnXOMpmWPkJouqRYzyQqIdKfO7xILfsaI1Tdmkn9bsj
 7EikYo9+cKkdoTuBb45VWbirIWC8VuWMDDKWn6BdSeitsyDrQyqt89Zk+Z2i/5RwwMku+RE4w
 JLQcMdaTyL/36G7ogo1smRX5hdZdKwEDSe5jpvyMFrUIQB/Ourooe5PQzaXfF4yTL28Wnu88z
 MJ0ppXBRA/IHZwDYeX8kf9vpMRqP2Ojtyc7gvtVakMryCbGnblS4/eBIZN/5DboyH467/+vqC
 tKmv6KvbKt2BW9D+fNxFmaBVoCsthwDDGZKHIPXLyvU25St1yod3/Bi1DK4amSojKx2Rqxw1A
 384AVQiFqlKjkbseu33hShg3tTS1C8dxIyK8Y5o6nTkLt738rSCw+63G+9Af8vCsi1KC7kayT
 DF+hmvoBp5pMRtp5zgoKzLPEK9bRIIAKswLfdI8ZtsQy/JAr9BbJCEgljCdS66q7NZHjMmkhP
 dQqQlCRMC7wHdn6laapOS4/zB9dvefz2N7PNXCsuk3KxphoTjtjpKeDdJ8MCC3Bvbr7hK6jMY
 b7eBH4cP286MhUyIrBYTNTSptytG9pZ7eScRkuatcWYo9BuzX1vimaqtJs9WpdlGdIhVWd1s4
 czlInlG/fphPYdFGBZGA==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 05 Nov 2020 18:36:56 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 05 Nov 2020 17:32:08 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Thu, 05 Nov 2020 18:36:54 +0100
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Checking the handling of spaces before opening
 parentheses for source code transformations
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

> If you want to ensure that your generated code has such properties,
> you can use the argument --smpl-spacing.

It is nice that code additions can be influenced by such a parameter.


> If you want something more, you are welcome to implement it.

I imagine that adjustments for matched metavariables might need
further development considerations.
Would there be a need to reformat any expression code (for example)?

Which software places would become interesting for extensions of
source code layout algorithms?


> We only focus on the coding style of the Linux kernel.

How are the chances that interests will grow also for source files
of GNOME components?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
