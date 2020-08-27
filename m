Return-Path: <SRS0=x4mb=CF=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D4EC433E2
	for <cocci@archiver.kernel.org>; Thu, 27 Aug 2020 21:36:50 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 414D42075B
	for <cocci@archiver.kernel.org>; Thu, 27 Aug 2020 21:36:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 414D42075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 07RLaV6o028209;
	Thu, 27 Aug 2020 23:36:31 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id C58614316;
	Thu, 27 Aug 2020 23:36:31 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 831BC3C97
 for <cocci@systeme.lip6.fr>; Thu, 27 Aug 2020 23:36:30 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 07RLaTCL022506
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Thu, 27 Aug 2020 23:36:29 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.76,359,1592863200"; d="scan'208";a="357458750"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Aug 2020 23:36:29 +0200
Date: Thu, 27 Aug 2020 23:36:28 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Denis Efremov <efremov@linux.com>
In-Reply-To: <5853c58e-7d26-2cf9-6cbf-698ecd93cbf9@linux.com>
Message-ID: <alpine.DEB.2.22.394.2008272334500.2482@hadrien>
References: <20200824222322.22962-1-alex.dewar90@gmail.com>
 <48f2dc90-7852-eaf1-55d7-2c85cf954688@rasmusvillemoes.dk>
 <20200827071537.GA168593@kroah.com>
 <20200827131819.7rcl2f5js3hkoqj2@lenovo-laptop>
 <def24e9e-018c-9712-0d07-d4cbc84f07d9@rasmusvillemoes.dk>
 <20200827144846.yauuttjaqtxaldxg@lenovo-laptop>
 <5d1dfb9b031130d4d20763ec621233a19d6a88a2.camel@perches.com>
 <alpine.DEB.2.22.394.2008272141220.2482@hadrien>
 <5853c58e-7d26-2cf9-6cbf-698ecd93cbf9@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 27 Aug 2020 23:36:32 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 27 Aug 2020 23:36:29 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, Alex Dewar <alex.dewar90@gmail.com>,
        accessrunner-general@lists.sourceforge.net,
        Joe Perches <joe@perches.com>, cocci <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] [PATCH] usb: atm: don't use snprintf() for sysfs attrs
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



On Fri, 28 Aug 2020, Denis Efremov wrote:

> Hi all,
>
> On 8/27/20 10:42 PM, Julia Lawall wrote:
> >
> >
> > On Thu, 27 Aug 2020, Joe Perches wrote:
> >
> >> On Thu, 2020-08-27 at 15:48 +0100, Alex Dewar wrote:
> >>> On Thu, Aug 27, 2020 at 03:41:06PM +0200, Rasmus Villemoes wrote:
> >>>> On 27/08/2020 15.18, Alex Dewar wrote:
> >>>>> On Thu, Aug 27, 2020 at 09:15:37AM +0200, Greg Kroah-Hartman wrote:
> >>>>>> On Thu, Aug 27, 2020 at 08:42:06AM +0200, Rasmus Villemoes wrote:
> >>>>>>> On 25/08/2020 00.23, Alex Dewar wrote:
> >>>>>>>> kernel/cpu.c: don't use snprintf() for sysfs attrs
> >>>>>>>>
> >>>>>>>> As per the documentation (Documentation/filesystems/sysfs.rst),
> >>>>>>>> snprintf() should not be used for formatting values returned by sysfs.
>
> Just FYI, I've send an addition to the device_attr_show.cocci script[1] to turn
> simple cases of snprintf (e.g. "%i") to sprintf. Looks like many developers would
> like it more than changing snprintf to scnprintf. As for me, I don't like the idea
> of automated altering of the original logic from bounded snprint to unbouded one
> with sprintf.
>
> [1] https://lkml.org/lkml/2020/8/13/786
>
> Regarding current device_attr_show.cocci implementation, it detects the functions
> by declaration:
> ssize_t any_name(struct device *dev, struct device_attribute *attr, char *buf)
>
> and I limited the check to:
> "return snprintf"
> pattern because there are already too many warnings.
>
> Actually, it looks more correct to check for:
> ssize_t show(struct device *dev, struct device_attribute *attr, char *buf)
> {
>         <...
> *       snprintf@p(...);
>         ...>
> }
>
> This pattern should also highlight the snprintf calls there we save returned
> value in a var, e.g.:
>
> ret += snprintf(...);
> ...
> ret += snprintf(...);
> ...
> ret += snprintf(...);
>
> return ret;
>
> >
> > Something like
> >
> > identifier f;
> > fresh identifier = "sysfs" ## f;
> >
> > may be useful.  Let me know if further help is needed.
>
> Initially, I wrote the rule to search for DEVICE_ATTR(..., ..., func_name, ...)

This is what I would have expected.

> functions. However, it looks like matching function prototype is enough. At least,
> I failed to find false positives. I rejected the initial DEVICE_ATTR() searching
> because I thought that it's impossible to handle DEVICE_ATTR_RO()/DEVICE_ATTR_RW()
> macroses with coccinelle as they "generate" function names internally with
> "##". "fresh identifier" should really help here, but now I doubt it's required in
> device_attr_show.cocci, function prototype is enough.

It's true that it is probably unique enough.

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
