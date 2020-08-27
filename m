Return-Path: <SRS0=x4mb=CF=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3737C433E2
	for <cocci@archiver.kernel.org>; Thu, 27 Aug 2020 22:21:33 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D070207F7
	for <cocci@archiver.kernel.org>; Thu, 27 Aug 2020 22:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ACj55gMS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D070207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 07RML1TR013337;
	Fri, 28 Aug 2020 00:21:01 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 972AC4316;
	Fri, 28 Aug 2020 00:21:01 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 69B553C97
 for <cocci@systeme.lip6.fr>; Fri, 28 Aug 2020 00:20:59 +0200 (CEST)
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1044])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 07RMKvuu015964
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 28 Aug 2020 00:20:58 +0200 (CEST)
Received: by mail-pj1-x1044.google.com with SMTP id 2so3370578pjx.5
 for <cocci@systeme.lip6.fr>; Thu, 27 Aug 2020 15:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=7HOc3TOrUpk73yXJpqK5BG9QB3E4q5q24T2BiM8h4ig=;
 b=ACj55gMSyHznOPm+7Nt6RAuwvbljxgVA4RJ1jcyPkH2RJrl54y3SfzL7sTPYXgXrz+
 7vVqFXQIV4YKln3ufrm1yzzL4F9GNLkhNZhKEWo0r814lT9QIkar6GT7VFgy7eUUkVeL
 H2VEyQhdACFwDVovcCSKufyBRGAAOoUbEQJgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=7HOc3TOrUpk73yXJpqK5BG9QB3E4q5q24T2BiM8h4ig=;
 b=WAUl+h96n2w/dJl2GADg8W8SKunuREsBaZrPU1oieEw05Rhrbdum4iE+5kVImDwnL0
 /ZeVwnasT0vTKoS4vIDRFsxIUxHq8qNn3DmW+LYEQwhkSaAWboJ3JFsmNnoyE0fu+I63
 GFrmdsuJcluB5RSiKAdBNIBVGwzCH0pgXI4oDCtZzGq8tNMTuxPOFW+WmiOzIPLc6NYP
 b89Iww2RggBhombnuayW7qqrK0bmVAqfz4rkwyhxagtUy+H6J6frLuYLSRNo4qjzG/CZ
 RDA0iFce0Sklb5Vpf0GgyCinYsYfh1TlWc6KbQRInfkMSs+FI8EKR208nr3MX/k6wa6A
 k/+g==
X-Gm-Message-State: AOAM533F4SgXof9Kzv8h3N0uvM1ptEtyImMLFCc9teFcizebgnR341qI
 TVZeplc7nlo8kreOr1HVlLaxiw==
X-Google-Smtp-Source: ABdhPJwGjzZLQ60AqhrpovvKnVZnmp/yETv8BkRDFYa73Hr7/msOUJUwKUrmeYNOEzO2CReThQJVpg==
X-Received: by 2002:a17:90b:696:: with SMTP id
 m22mr886476pjz.158.1598566856643; 
 Thu, 27 Aug 2020 15:20:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id a13sm3327169pjq.36.2020.08.27.15.20.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2020 15:20:55 -0700 (PDT)
Date: Thu, 27 Aug 2020 15:20:54 -0700
From: Kees Cook <keescook@chromium.org>
To: Denis Efremov <efremov@linux.com>
Message-ID: <202008271517.ECC1F1F8F@keescook>
References: <20200824222322.22962-1-alex.dewar90@gmail.com>
 <48f2dc90-7852-eaf1-55d7-2c85cf954688@rasmusvillemoes.dk>
 <20200827071537.GA168593@kroah.com>
 <20200827131819.7rcl2f5js3hkoqj2@lenovo-laptop>
 <def24e9e-018c-9712-0d07-d4cbc84f07d9@rasmusvillemoes.dk>
 <20200827144846.yauuttjaqtxaldxg@lenovo-laptop>
 <5d1dfb9b031130d4d20763ec621233a19d6a88a2.camel@perches.com>
 <alpine.DEB.2.22.394.2008272141220.2482@hadrien>
 <5853c58e-7d26-2cf9-6cbf-698ecd93cbf9@linux.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5853c58e-7d26-2cf9-6cbf-698ecd93cbf9@linux.com>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 28 Aug 2020 00:21:01 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 28 Aug 2020 00:20:58 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
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

On Fri, Aug 28, 2020 at 12:01:34AM +0300, Denis Efremov wrote:
> Just FYI, I've send an addition to the device_attr_show.cocci script[1] to turn
> simple cases of snprintf (e.g. "%i") to sprintf. Looks like many developers would
> like it more than changing snprintf to scnprintf. As for me, I don't like the idea
> of automated altering of the original logic from bounded snprint to unbouded one
> with sprintf.

Agreed. This just makes me cringe. If the API design declares that when
a show() callback starts, buf has been allocated with PAGE_SIZE bytes,
then that's how the logic should proceed, and it should be using
scnprintf...

show(...) {
	size_t remaining = PAGE_SIZE;

	...
	remaining -= scnprintf(buf, remaining, "fmt", var args ...);
	remaining -= scnprintf(buf, remaining, "fmt", var args ...);
	remaining -= scnprintf(buf, remaining, "fmt", var args ...);

	return PAGE_SIZE - remaining;
}

-- 
Kees Cook
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
