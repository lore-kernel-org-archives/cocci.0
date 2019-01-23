Return-Path: <SRS0=BkxN=P7=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D022CC282C0
	for <cocci@archiver.kernel.org>; Wed, 23 Jan 2019 17:49:41 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06A6221872
	for <cocci@archiver.kernel.org>; Wed, 23 Jan 2019 17:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNMVY/6c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06A6221872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x0NHnRrk019154
          ; Wed, 23 Jan 2019 18:49:27 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 218A876E9;
	Wed, 23 Jan 2019 18:49:27 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 1804876E3
 for <cocci@systeme.lip6.fr>; Wed, 23 Jan 2019 18:49:25 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:62b] (may be forged))
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x0NHnN3C008964
 for <cocci@systeme.lip6.fr>; Wed, 23 Jan 2019 18:49:24 +0100 (CET)
X-pt: isis.lip6.fr
Received: by mail-pl1-x62b.google.com with SMTP id e5so1531180plb.5
 for <cocci@systeme.lip6.fr>; Wed, 23 Jan 2019 09:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=nOgzuiDJISE5tuiSigjRBIWPo2d7t7VmMkLYTDXD45c=;
 b=ZNMVY/6c85WZNLJez+uCVSsvLBR791ZuycrRt9qpB/wdCT06TGsf9b6LfJKfEqKA9G
 Q3P3UorqcufKtBeGbrU/yavkhSB+0Icv0Rez0vN96m5QFxlixKLPsAEVNx1/TQ0PQqhX
 UGGXtxxwAqEXix7M23WouS4eVG3dndMfAJZzCGOeEWGKDTbKltl+r/6+YpC+AUKA4ssn
 60pVzElnzM2KHR7tJph5qRgznMzY9dxZajzBJWgT0856ziGsftzA2BYrWENguntlWN4O
 sJnNwKMCyee6+L88e8yRVL9KsUjALo/wgkWbNcdQV4Ek4DR4kzQj3B9vmjO7JKoOIDN7
 vD1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=nOgzuiDJISE5tuiSigjRBIWPo2d7t7VmMkLYTDXD45c=;
 b=VWzhtXBf3xXEWGMIxeOcX8/5IORi6LQywmegKGpTYP6rtO1lfGpDGnXB60YjIuGYaM
 e24Tvirx1SCyNCn0ysSVn6iE5orlzyUjlmY93zYmnx1jG+yEUwVzlYUihraNXJ1H0kZT
 26h0rhOiqY4ZPazQn1YUe/FHuzeIKl6P++h+KFBdru4N+zXL4YnzQfIA76gTbzVmiQnV
 tfb5fIapcJIuK7bN8lLR3rJ3Av26UPAfMmmOA0A32jbDOM90RIC+O0Ig4L4mp8+OIdv7
 3+76BgbzlUepMH5A2xP4wWI4lZaAJD8Vi/BMF8nwGm658U2JZB7ZeE9nM8KhZyrMOtoF
 GPoQ==
X-Gm-Message-State: AJcUukcxtfbe66L1VchaIcAwUS6d562WoCtiICgTPysuTHRcjZBxw0iW
 Ek+ncHUuCjG2tzTMLAhJE1WXJk5M
X-Google-Smtp-Source: ALg8bN6hw1ZW9FCGAQcFmYkJLNIWMZl/7U9lWpRBTcAomIgnf5yXyFINHgzv7X1d/r0bUGtB4kff1g==
X-Received: by 2002:a17:902:8306:: with SMTP id
 bd6mr3157778plb.217.1548265763290; 
 Wed, 23 Jan 2019 09:49:23 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id e123sm36963026pgc.58.2019.01.23.09.49.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 23 Jan 2019 09:49:22 -0800 (PST)
Date: Wed, 23 Jan 2019 09:49:21 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Julia Lawall <julia.lawall@lip6.fr>
Message-ID: <20190123174921.GA9781@roeck-us.net>
References: <405551ab-2417-dc55-f429-421ae79a5d06@roeck-us.net>
 <alpine.DEB.2.21.1901230731450.2762@hadrien>
 <f2ce5bb5-0956-2ee7-4165-ebcbbedd9020@roeck-us.net>
 <alpine.DEB.2.20.1901231540410.3584@hadrien>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1901231540410.3584@hadrien>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 23 Jan 2019 18:49:27 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Wed, 23 Jan 2019 18:49:24 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] matching concatenated preprocessor tokens
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

On Wed, Jan 23, 2019 at 03:41:24PM +0100, Julia Lawall wrote:
> 
> 
> On Wed, 23 Jan 2019, Guenter Roeck wrote:
> 
> > Hi Julia,
> >
> > On 1/22/19 10:35 PM, Julia Lawall wrote:
> > >
> > >
> > > On Tue, 22 Jan 2019, Guenter Roeck wrote:
> > >
> > > > Hi,
> > > >
> > > > I am trying to match a construct such as
> > > >
> > > > #define func(a,b,c) \
> > > >      some_call(a##b, c, NULL)
> > > >
> > > > to replace it with, for example,
> > > >
> > > > #define func(a,b,c) \
> > > >     some_other_call(a##b, c)
> > > >
> > > > Is this possible with coccinelle ?
> > > > I tried several variants, but I don't seem to be able to match "a##b".
> > >
> > > I doubt that ## is supported in the matching language.  I will add it.
> > >
> >
> > All I was able to find about the subject was in the Coccinelle change log:
> >
> > 20.4 Internals:
> > "reorganize the way we parse C identifiers, especially concatenated cpp
> >  identifiers as in a##b. This may lead to some regressions as we may not
> >  parse as much code as before."
> 
> Yeah, it's supported on the C side, but not on the pattern matching side.
> I'm working on that.
> 
Thanks!

Guenter
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
