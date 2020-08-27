Return-Path: <SRS0=x4mb=CF=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8C7C433E2
	for <cocci@archiver.kernel.org>; Thu, 27 Aug 2020 22:18:18 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8606207F7
	for <cocci@archiver.kernel.org>; Thu, 27 Aug 2020 22:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Sn1Xn765"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8606207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 07RMH3s3004414;
	Fri, 28 Aug 2020 00:17:03 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id C98524316;
	Fri, 28 Aug 2020 00:17:03 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B12D13C97
 for <cocci@systeme.lip6.fr>; Fri, 28 Aug 2020 00:17:02 +0200 (CEST)
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1043])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 07RMGxlp023407
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 28 Aug 2020 00:17:00 +0200 (CEST)
Received: by mail-pj1-x1043.google.com with SMTP id q93so3240346pjq.0
 for <cocci@systeme.lip6.fr>; Thu, 27 Aug 2020 15:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=lLmbzoSbX37WRFYQW3L/1ffMVUDf88bIb2L15ySX4bI=;
 b=Sn1Xn765zecNGssYNGAzm6wFGVk/ZUhv3yF24YKSHrrm6U0gqIZZZDxVzDAyNtP0T4
 cXAMTSit0hEdTaUdP8eWW8XSdX0PhQMN7+d7nso/G2BMTeqMHmL3Cdk9S54CZ6SMe7Zl
 DkBln/HezvkLX2GPBY0Q+sV4MPupwJjvZ0xzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=lLmbzoSbX37WRFYQW3L/1ffMVUDf88bIb2L15ySX4bI=;
 b=UpHss4QKnJ0n3o1jboBnx4Z9633a8dAeljzhwGnUkoefCOacZLTABbItFpd9xp0kiQ
 RX93aqtbNJuSlIbjpn3CCnS8E3MCWZqsL8Pq2AbqDkyn7gTuXWL4daAoH8mUlA5Q0YUD
 qy/acML2KHiQtELyuKE6DBHQxWRJxT6y3og6QyNCTGpzQecP8ED4sW2an+/REwY3JXoU
 nwyj3rua4Eo/rRxeruLKfN8HCUrRdPwt7cbvWBnRgD7veB8nxfnqo/Wevo61ylbOPXEl
 nps6Eqw2UGlk6c7/RcdexufiP2PxYw3l4U13f0QQEswCRqyyukpDQATFQitbIYrJ9kaj
 RskQ==
X-Gm-Message-State: AOAM533pltWd04jCLRsLkmvPeshUKzrbL6cYv/sEkFPaHN69pDeCCHE8
 WqiKe6I59OnBdF2CO1hBeCfw0Q==
X-Google-Smtp-Source: ABdhPJxc4Utn2CJ+IfyCfdMPjgDjTvD7I3FRBoJwWEMSO3xb8hDq51v6hjQN8kpG25RPcBppMWR8wg==
X-Received: by 2002:a17:90a:19c2:: with SMTP id 2mr845122pjj.6.1598566618642; 
 Thu, 27 Aug 2020 15:16:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id lw2sm3005169pjb.34.2020.08.27.15.16.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2020 15:16:57 -0700 (PDT)
Date: Thu, 27 Aug 2020 15:16:56 -0700
From: Kees Cook <keescook@chromium.org>
To: Joe Perches <joe@perches.com>
Message-ID: <202008271516.ED209B68@keescook>
References: <48f2dc90-7852-eaf1-55d7-2c85cf954688@rasmusvillemoes.dk>
 <20200827071537.GA168593@kroah.com>
 <20200827131819.7rcl2f5js3hkoqj2@lenovo-laptop>
 <def24e9e-018c-9712-0d07-d4cbc84f07d9@rasmusvillemoes.dk>
 <20200827144846.yauuttjaqtxaldxg@lenovo-laptop>
 <5d1dfb9b031130d4d20763ec621233a19d6a88a2.camel@perches.com>
 <alpine.DEB.2.22.394.2008272141220.2482@hadrien>
 <cf9b1ea3716305447be43bffc8f90b7ef7292f5b.camel@perches.com>
 <c3926f18f98e446daad957cd66a94890@AcuMS.aculab.com>
 <ca08f34a5aaa3e9031a934296dd97fc806dab66f.camel@perches.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ca08f34a5aaa3e9031a934296dd97fc806dab66f.camel@perches.com>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 28 Aug 2020 00:17:05 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 28 Aug 2020 00:17:00 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        cocci <cocci@systeme.lip6.fr>, David Laight <David.Laight@ACULAB.COM>,
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

On Thu, Aug 27, 2020 at 03:11:57PM -0700, Joe Perches wrote:
> On Thu, 2020-08-27 at 22:03 +0000, David Laight wrote:
> > From: Joe Perches
> > > Sent: 27 August 2020 21:30
> > ...
> > > Perhaps what's necessary is to find any
> > > appropriate .show function and change
> > > any use of strcpy/sprintf within those
> > > function to some other name.
> > > 
> > > For instance:
> > > 
> > > drivers/isdn/mISDN/core.c-static ssize_t name_show(struct device *dev,
> > > drivers/isdn/mISDN/core.c-                       struct device_attribute *attr, char *buf)
> > > drivers/isdn/mISDN/core.c-{
> > > drivers/isdn/mISDN/core.c:      strcpy(buf, dev_name(dev));
> > > drivers/isdn/mISDN/core.c-      return strlen(buf);
> > > drivers/isdn/mISDN/core.c-}
> > > drivers/isdn/mISDN/core.c-static DEVICE_ATTR_RO(name);
> > 
> > That form ends up calculating the string length twice.
> > Better would be:
> > 	len = strlen(msg);
> > 	memcpy(buf, msg, len);
> > 	return len;
> 
> or given clang's requirement for stpcpy
> 
> 	return stpcpy(buf, dev_name(dev)) - buf;
> 
> (I do not advocate for this ;)

Heh. And humans aren't allowed to use stpcpy() in the kernel. :)

-- 
Kees Cook
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
