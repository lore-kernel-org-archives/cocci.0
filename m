Return-Path: <SRS0=x4mb=CF=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D5EC433E2
	for <cocci@archiver.kernel.org>; Thu, 27 Aug 2020 22:30:14 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B97B207F7
	for <cocci@archiver.kernel.org>; Thu, 27 Aug 2020 22:30:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B97B207F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 07RMSON5028886;
	Fri, 28 Aug 2020 00:28:24 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 8EA0C4316;
	Fri, 28 Aug 2020 00:28:24 +0200 (CEST)
Received: from osiris.lip6.fr (osiris.lip6.fr [132.227.60.30])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 317023C97
 for <cocci@systeme.lip6.fr>; Fri, 28 Aug 2020 00:28:23 +0200 (CEST)
Received: from smtprelay.hostedemail.com (smtprelay0093.hostedemail.com
 [216.40.44.93])
 by osiris.lip6.fr (8.15.2/8.15.2) with ESMTPS id 07RMSKmV027806
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Fri, 28 Aug 2020 00:28:22 +0200 (CEST)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave05.hostedemail.com (Postfix) with ESMTP id D7C0F1802F647
 for <cocci@systeme.lip6.fr>; Thu, 27 Aug 2020 22:12:03 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay08.hostedemail.com (Postfix) with ESMTP id 74415182CED34;
 Thu, 27 Aug 2020 22:12:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: fly24_1910e5127070
X-Filterd-Recvd-Size: 2747
Received: from XPS-9350.home (unknown [47.151.133.149])
 (Authenticated sender: joe@perches.com)
 by omf16.hostedemail.com (Postfix) with ESMTPA;
 Thu, 27 Aug 2020 22:11:58 +0000 (UTC)
Message-ID: <ca08f34a5aaa3e9031a934296dd97fc806dab66f.camel@perches.com>
From: Joe Perches <joe@perches.com>
To: David Laight <David.Laight@ACULAB.COM>,
        Julia Lawall
 <julia.lawall@inria.fr>
Date: Thu, 27 Aug 2020 15:11:57 -0700
In-Reply-To: <c3926f18f98e446daad957cd66a94890@AcuMS.aculab.com>
References: <20200824222322.22962-1-alex.dewar90@gmail.com>
 <48f2dc90-7852-eaf1-55d7-2c85cf954688@rasmusvillemoes.dk>
 <20200827071537.GA168593@kroah.com>
 <20200827131819.7rcl2f5js3hkoqj2@lenovo-laptop>
 <def24e9e-018c-9712-0d07-d4cbc84f07d9@rasmusvillemoes.dk>
 <20200827144846.yauuttjaqtxaldxg@lenovo-laptop>
 <5d1dfb9b031130d4d20763ec621233a19d6a88a2.camel@perches.com>
 <alpine.DEB.2.22.394.2008272141220.2482@hadrien>
 <cf9b1ea3716305447be43bffc8f90b7ef7292f5b.camel@perches.com>
 <c3926f18f98e446daad957cd66a94890@AcuMS.aculab.com>
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 28 Aug 2020 00:28:24 +0200 (CEST)
X-Greylist: Delayed for 04:12:26 by milter-greylist-4.4.3 (osiris.lip6.fr
 [132.227.60.30]); Fri, 28 Aug 2020 00:28:22 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.30
Cc: "Gustavo A.
 R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        cocci <cocci@systeme.lip6.fr>,
        "accessrunner-general@lists.sourceforge.net"
 <accessrunner-general@lists.sourceforge.net>,
        Alex Dewar <alex.dewar90@gmail.com>
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

On Thu, 2020-08-27 at 22:03 +0000, David Laight wrote:
> From: Joe Perches
> > Sent: 27 August 2020 21:30
> ...
> > Perhaps what's necessary is to find any
> > appropriate .show function and change
> > any use of strcpy/sprintf within those
> > function to some other name.
> > 
> > For instance:
> > 
> > drivers/isdn/mISDN/core.c-static ssize_t name_show(struct device *dev,
> > drivers/isdn/mISDN/core.c-                       struct device_attribute *attr, char *buf)
> > drivers/isdn/mISDN/core.c-{
> > drivers/isdn/mISDN/core.c:      strcpy(buf, dev_name(dev));
> > drivers/isdn/mISDN/core.c-      return strlen(buf);
> > drivers/isdn/mISDN/core.c-}
> > drivers/isdn/mISDN/core.c-static DEVICE_ATTR_RO(name);
> 
> That form ends up calculating the string length twice.
> Better would be:
> 	len = strlen(msg);
> 	memcpy(buf, msg, len);
> 	return len;

or given clang's requirement for stpcpy

	return stpcpy(buf, dev_name(dev)) - buf;

(I do not advocate for this ;)

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
