Return-Path: <SRS0=bgdO=76=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B334C433DF
	for <cocci@archiver.kernel.org>; Wed, 17 Jun 2020 20:46:58 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E31E2212CC
	for <cocci@archiver.kernel.org>; Wed, 17 Jun 2020 20:46:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E31E2212CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 05HKklZ0024350;
	Wed, 17 Jun 2020 22:46:47 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 434A77577;
	Wed, 17 Jun 2020 22:46:47 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 22A3F3D0F
 for <cocci@systeme.lip6.fr>; Wed, 17 Jun 2020 22:46:46 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 05HKkjkc017441
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Wed, 17 Jun 2020 22:46:45 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.73,523,1583190000"; d="scan'208";a="351906452"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Jun 2020 22:46:14 +0200
Date: Wed, 17 Jun 2020 22:46:13 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Denis Efremov <efremov@linux.com>
In-Reply-To: <871aeea8-9b61-5eaa-4b0d-a377ba82c2d0@linux.com>
Message-ID: <alpine.DEB.2.22.394.2006172246010.3083@hadrien>
References: <20200615130242.11825-1-efremov@linux.com>
 <alpine.DEB.2.22.394.2006172225570.3083@hadrien>
 <871aeea8-9b61-5eaa-4b0d-a377ba82c2d0@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 17 Jun 2020 22:46:47 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 17 Jun 2020 22:46:45 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: linux-kernel@vger.kernel.org, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH] coccinelle: api: add device_attr_show script
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



On Wed, 17 Jun 2020, Denis Efremov wrote:

>
>
> On 6/17/20 11:27 PM, Julia Lawall wrote:
> >
> >
> > On Mon, 15 Jun 2020, Denis Efremov wrote:
> >
> >> According to the documentation[1] show() methods of device attributes
> >> should return the number of bytes printed into the buffer. This is
> >> the return value of scnprintf(). show() must not use snprintf()
> >> when formatting the value to be returned to user space. snprintf()
> >> returns the length the resulting string would be, assuming it all
> >> fit into the destination array[2]. scnprintf() return the length of
> >> the string actually created in buf. If one can guarantee that an
> >> overflow will never happen sprintf() can be used otherwise scnprintf().
> >
> > The semantic patch looks fine.  Do you have any accepted patches from
> > this?
>
> It's not my patches, but:
>
> 3f9f8daad342 cpuidle: sysfs: Fix the overlap for showing available governors
> 117e2cb3eeee sparc: use scnprintf() in show_pciobppath_attr() in vio.c
> 03a1b56f501e sparc: use scnprintf() in show_pciobppath_attr() in pci.c
> 3dee04262898 iio: tsl2772: Use scnprintf() for avoiding potential buffer overflow
> dbdd24eaac4e edd: Use scnprintf() for avoiding potential buffer overflow
> abdd9feb45ed btrfs: sysfs: Use scnprintf() instead of snprintf()
> f21431f2de33 thermal: int340x_thermal: Use scnprintf() for avoiding potential buffer overflow
> 40501c70e3f0 s390/zcrypt: replace snprintf/sprintf with scnprintf
> eb3e064b8dd1 s390/zcrypt: Use scnprintf() for avoiding potential buffer overflow
> 06b522d6de9d video: uvesafb: Use scnprintf() for avoiding potential buffer overflow
> bf1b615ad97e video: omapfb: Use scnprintf() for avoiding potential buffer overflow
> b40e288bfb53 platform/x86: sony-laptop: Use scnprintf() for avoiding potential buffer overflow
> ef21e1750158 ALSA: Use scnprintf() instead of snprintf() for show

Thanks.

julia

>
> and many more
>
> Thanks,
> Denis
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
