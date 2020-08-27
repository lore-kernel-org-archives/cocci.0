Return-Path: <SRS0=x4mb=CF=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54F6C433E2
	for <cocci@archiver.kernel.org>; Thu, 27 Aug 2020 21:44:26 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 680982075B
	for <cocci@archiver.kernel.org>; Thu, 27 Aug 2020 21:44:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 680982075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 07RLiCUS010015;
	Thu, 27 Aug 2020 23:44:12 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A9F5E4316;
	Thu, 27 Aug 2020 23:44:12 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 05D163C97
 for <cocci@systeme.lip6.fr>; Thu, 27 Aug 2020 23:44:11 +0200 (CEST)
Received: from smtprelay.hostedemail.com (smtprelay0149.hostedemail.com
 [216.40.44.149])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 07RLi912025225
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Thu, 27 Aug 2020 23:44:10 +0200 (CEST)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave03.hostedemail.com (Postfix) with ESMTP id DFF93181CA762
 for <cocci@systeme.lip6.fr>; Thu, 27 Aug 2020 21:44:08 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay07.hostedemail.com (Postfix) with ESMTP id B0C1F181D337B;
 Thu, 27 Aug 2020 21:44:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: paper52_5f066c127070
X-Filterd-Recvd-Size: 4701
Received: from XPS-9350.home (unknown [47.151.133.149])
 (Authenticated sender: joe@perches.com)
 by omf09.hostedemail.com (Postfix) with ESMTPA;
 Thu, 27 Aug 2020 21:44:02 +0000 (UTC)
Message-ID: <d6d5836196208d5280cedf5837952096c3518852.camel@perches.com>
From: Joe Perches <joe@perches.com>
To: Julia Lawall <julia.lawall@inria.fr>, Denis Efremov <efremov@linux.com>
Date: Thu, 27 Aug 2020 14:44:01 -0700
In-Reply-To: <alpine.DEB.2.22.394.2008272334500.2482@hadrien>
References: <20200824222322.22962-1-alex.dewar90@gmail.com>
 <48f2dc90-7852-eaf1-55d7-2c85cf954688@rasmusvillemoes.dk>
 <20200827071537.GA168593@kroah.com>
 <20200827131819.7rcl2f5js3hkoqj2@lenovo-laptop>
 <def24e9e-018c-9712-0d07-d4cbc84f07d9@rasmusvillemoes.dk>
 <20200827144846.yauuttjaqtxaldxg@lenovo-laptop>
 <5d1dfb9b031130d4d20763ec621233a19d6a88a2.camel@perches.com>
 <alpine.DEB.2.22.394.2008272141220.2482@hadrien>
 <5853c58e-7d26-2cf9-6cbf-698ecd93cbf9@linux.com>
 <alpine.DEB.2.22.394.2008272334500.2482@hadrien>
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 27 Aug 2020 23:44:13 +0200 (CEST)
X-Greylist: Delayed for 04:38:10 by milter-greylist-4.4.3 (isis.lip6.fr
 [132.227.60.2]); Thu, 27 Aug 2020 23:44:10 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, Alex Dewar <alex.dewar90@gmail.com>,
        accessrunner-general@lists.sourceforge.net,
        cocci <cocci@systeme.lip6.fr>
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

On Thu, 2020-08-27 at 23:36 +0200, Julia Lawall wrote:
> On Fri, 28 Aug 2020, Denis Efremov wrote:
[]
> Regarding current device_attr_show.cocci implementation, it detects the functions
> > by declaration:
> > ssize_t any_name(struct device *dev, struct device_attribute *attr, char *buf)
> > 
> > and I limited the check to:
> > "return snprintf"
> > pattern because there are already too many warnings.
> > 
> > Actually, it looks more correct to check for:
> > ssize_t show(struct device *dev, struct device_attribute *attr, char *buf)
> > {
> >         <...
> > *       snprintf@p(...);
> >         ...>
> > }
> > 
> > This pattern should also highlight the snprintf calls there we save returned
> > value in a var, e.g.:
> > 
> > ret += snprintf(...);
> > ...
> > ret += snprintf(...);
> > ...
> > ret += snprintf(...);
> > 
> > return ret;
> > 
> > > Something like
> > > 
> > > identifier f;
> > > fresh identifier = "sysfs" ## f;
> > > 
> > > may be useful.  Let me know if further help is needed.
> > 
> > Initially, I wrote the rule to search for DEVICE_ATTR(..., ..., func_name, ...)
> 
> This is what I would have expected.
> 
> > functions. However, it looks like matching function prototype is enough. At least,
> > I failed to find false positives. I rejected the initial DEVICE_ATTR() searching
> > because I thought that it's impossible to handle DEVICE_ATTR_RO()/DEVICE_ATTR_RW()
> > macroses with coccinelle as they "generate" function names internally with
> > "##". "fresh identifier" should really help here, but now I doubt it's required in
> > device_attr_show.cocci, function prototype is enough.
> 
> It's true that it is probably unique enough.

I tried:
@@
identifier f_show =~ "^.*_show$";
identifier dev, attr, buf;
const char *chr;
@@
ssize_t f_show(struct device *dev, struct device_attribute *attr, char
*buf)
{
	<...
(
-	sprintf
+	sysfs_sprintf
	(...);
|
-	snprintf(buf, PAGE_SIZE,
+	sysfs_sprintf(buf,
	...);
|
-	scnprintf(buf, PAGE_SIZE,
+	sysfs_sprintf(buf,
	...);
|
	strcpy(buf, chr);
	sysfs_strcpy(buf, chr);
)
	...>
}

which finds direct statements without an assign
but that doesn't find

arch/arm/common/dmabounce.c:static ssize_t dmabounce_show(struct device *dev, struct device_attribute *attr, char *buf)
arch/arm/common/dmabounce.c-{
arch/arm/common/dmabounce.c-    struct dmabounce_device_info *device_info = dev->archdata.dmabounce;
arch/arm/common/dmabounce.c-    return sprintf(buf, "%lu %lu %lu %lu %lu %lu\n",
arch/arm/common/dmabounce.c-            device_info->small.allocs,
arch/arm/common/dmabounce.c-            device_info->large.allocs,
arch/arm/common/dmabounce.c-            device_info->total_allocs - device_info->small.allocs -
arch/arm/common/dmabounce.c-                    device_info->large.allocs,
arch/arm/common/dmabounce.c-            device_info->total_allocs,
arch/arm/common/dmabounce.c-            device_info->map_op_count,
arch/arm/common/dmabounce.c-            device_info->bounce_count);
arch/arm/common/dmabounce.c-}


_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
