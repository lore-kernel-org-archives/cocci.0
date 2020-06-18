Return-Path: <SRS0=v8PH=77=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1697C433E0
	for <cocci@archiver.kernel.org>; Thu, 18 Jun 2020 19:53:14 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F144220786
	for <cocci@archiver.kernel.org>; Thu, 18 Jun 2020 19:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X8DNTsRL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F144220786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 05IJquHK013567;
	Thu, 18 Jun 2020 21:52:56 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A4C567577;
	Thu, 18 Jun 2020 21:52:56 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 2F1E9402B
 for <cocci@systeme.lip6.fr>; Thu, 18 Jun 2020 21:52:55 +0200 (CEST)
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1044])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 05IJqr2H019936
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Thu, 18 Jun 2020 21:52:54 +0200 (CEST)
Received: by mail-pj1-x1044.google.com with SMTP id k2so3019155pjs.2
 for <cocci@systeme.lip6.fr>; Thu, 18 Jun 2020 12:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=wsf73Z126ojkOygBCc4JE/v/5dFQpgMKkylOyorJWhk=;
 b=X8DNTsRLlcjwcpnPXZ02CYGLyhuDa/Coid1MS0YeJwE+St1uYtDvyvpIQ4/eg2qvSq
 UVcCngx+X5B3YckTemLUfFSMNMXMHxHgSET2XcP3pa7R8iSLRGY7O8KhHyPVLQ35LzCy
 k2F7pI7wVFoOJO8abEXZyKjMSv6vhtyajlG/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=wsf73Z126ojkOygBCc4JE/v/5dFQpgMKkylOyorJWhk=;
 b=kAZ8CAa3WQGkbQN6oTBwO/gKoktsomHqBCBhaNZGxnYYUdWzoAV0M6Er1JGDdnbMhp
 M5DyX90qsjz4uSYl7rQQR2a6tn4+MhgcMjz427sO530ql7R2mtHERwsbh/nfCATaXWB3
 hmmU9juXOuVyhOtsatwNoueARCMjQ+Wn3O7DQdYLDPYmWE8Q7NY0tD4seyQzbtcDD0+i
 +zQhuPxKasr8ZysSAHzCcmN9QTwhfAyvqIyXKh4Ecl+vE2pJK7vD5kvAE1/4uL6BqjEv
 ZOA2Nqdmyxvk14nyPJcKY5zmFC5JP7tSE4WRcvL5XOtu6yAzqthpIN1KRv73SizwEHpS
 BOWA==
X-Gm-Message-State: AOAM533v5ZwoGLE+Xt7g0VGRSp9GY7sSHSBPv5YA8XyPsHFSIoiZynSm
 LvI85pMKnGCn1BgYX+tVGGUnLw==
X-Google-Smtp-Source: ABdhPJwchlPIfFZyBKCfWdWEuuZp6G9OPnXNNpMt6mchv2BAzKIeqvUM/wOIuYeL6wGs5Dio7uSDtw==
X-Received: by 2002:a17:90a:1b23:: with SMTP id q32mr7712pjq.14.1592509972918; 
 Thu, 18 Jun 2020 12:52:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id p5sm3839923pfg.162.2020.06.18.12.52.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2020 12:52:51 -0700 (PDT)
Date: Thu, 18 Jun 2020 12:52:50 -0700
From: Kees Cook <keescook@chromium.org>
To: Julia Lawall <julia.lawall@inria.fr>
Message-ID: <202006181249.8B826D9@keescook>
References: <20200615102045.4558-1-efremov@linux.com>
 <202006171103.327F86B1C@keescook>
 <alpine.DEB.2.22.394.2006172051280.3083@hadrien>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2006172051280.3083@hadrien>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 18 Jun 2020 21:52:57 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 18 Jun 2020 21:52:54 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: Julia Lawall <Julia.Lawall@lip6.fr>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH] coccinelle: misc: add array_size_dup script to
 detect missed overlow checks
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

On Wed, Jun 17, 2020 at 08:54:03PM +0200, Julia Lawall wrote:
> 
> 
> On Wed, 17 Jun 2020, Kees Cook wrote:
> 
> > On Mon, Jun 15, 2020 at 01:20:45PM +0300, Denis Efremov wrote:
> > > +@as@
> > > +expression E1, E2;
> > > +@@
> > > +
> > > +array_size(E1, E2)
> >
> > BTW, is there a way yet in Coccinelle to match a fully qualified (?)
> > identifier? For example, if I have two lines in C:
> >
> > A)
> > 	array_size(variable, 5);
> > B)
> > 	array_size(instance->member.size, 5);
> > C)
> > 	array_size(instance->member.size + 1, 5);
> > D)
> > 	array_size(function_call(variable), 5);
> >
> >
> > This matches A, B, C, and D:
> >
> > @@
> > expression ARG1;
> > expression ARG2;
> > @@
> >
> > array_size(ARG1, ARG2);
> >
> >
> > This matches only A:
> >
> > @@
> > identifier ARG1;
> > expression ARG2;
> > @@
> >
> > array_size(ARG1, ARG2);
> >
> >
> > How do I get something to match A and B but not C and D (i.e. I do not
> > want to match any operations, function calls, etc, only a variable,
> > which may be identified through dereference, array index, or struct
> > member access.)
> 
> \(i\|e.fld\|e->fld\)
> 
> would probably do what you want.  It will also match cases where e is a
> function/macr call, but that is unlikely.
> 
> If you want a single metavariable that contains the whole thing, you can
> have an expression metavariable E and then write:
> 
> \(\(i\|e.fld\|e->fld\) \& E\)

Can you give an example of how that would look for an @@ section?

The problem I have is that I don't know the depth or combination of such
metavariables. There are a lot of combinations:

a
	a.b
		a.b.c
			a.b.c.d
			a.b.c->d
		a.b->c
			a.b->c.d
			a.b->c->d
	a->b
		a->b.c
			a->b.c.d
			a->b.c->d
		a->b->c
			a->b->c.d
			a->b->c->d
...


-- 
Kees Cook
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
