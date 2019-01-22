Return-Path: <SRS0=An1N=P6=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66A3C282C3
	for <cocci@archiver.kernel.org>; Tue, 22 Jan 2019 22:06:58 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0982120870
	for <cocci@archiver.kernel.org>; Tue, 22 Jan 2019 22:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PESPNnEN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0982120870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x0MM6hh7026649
          ; Tue, 22 Jan 2019 23:06:43 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 29B0776F2;
	Tue, 22 Jan 2019 23:06:43 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 988EE76EA
 for <cocci@systeme.lip6.fr>; Tue, 22 Jan 2019 23:06:41 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x0MM6eDQ005017
 for <cocci@systeme.lip6.fr>; Tue, 22 Jan 2019 23:06:40 +0100 (CET)
X-pt: isis.lip6.fr
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com
 [209.85.210.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CD63E20870
 for <cocci@systeme.lip6.fr>; Tue, 22 Jan 2019 22:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548194799;
 bh=xEsQrwKfg43dDcK3k7q+m6E2cFmGJ/IqqsF5DyUodz8=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=PESPNnENEu5Ys5YCMskKKxSxxBgcjiXyleffuVd/rgy6SfgIlcpm3tLVVy3WMgtxD
 r4AxUEN0GlXyuIqu3Ym1m/yq57zxbGR5zzbYsbCeAOSFP19zV6poQrdLqQHViGZkQj
 CLzz9Uipjn+e1/g4YBZJIRLpcDKzC8cwjHsFsImc=
Received: by mail-ot1-f52.google.com with SMTP id 81so133439otj.2
 for <cocci@systeme.lip6.fr>; Tue, 22 Jan 2019 14:06:39 -0800 (PST)
X-Gm-Message-State: AJcUukcpf3G4mIBkI6FwVGhd1LcmYiPrDqSW4+iOY0acmdonA33Ohcw+
 0tRxMI00yCjbANZ72vL3mpOz44jioER+ivJbC58=
X-Google-Smtp-Source: ALg8bN5j+RTEODqgGA0Epy3GrQzoaEGjNsxf2bCT5/AJMFpiDi4vAxcZedMXBoiqdmhjX6gaSE4DUIBwjQMwSsLTAPE=
X-Received: by 2002:a9d:6009:: with SMTP id h9mr1613280otj.349.1548194799162; 
 Tue, 22 Jan 2019 14:06:39 -0800 (PST)
MIME-Version: 1.0
References: <CAOZdJXUhfSskY8+i3Juf8t4-obp9nu=c0CXriNbPBoGj6ZMeVQ@mail.gmail.com>
 <alpine.DEB.2.21.1901222040260.2519@hadrien>
 <CAOZdJXVpZ4a0owZ1byCoU6_mRPwBjrn4Z5ZSQi93GHm+Wui_qA@mail.gmail.com>
 <alpine.DEB.2.21.1901222147550.2519@hadrien>
In-Reply-To: <alpine.DEB.2.21.1901222147550.2519@hadrien>
From: Timur Tabi <timur@kernel.org>
Date: Tue, 22 Jan 2019 16:06:02 -0600
X-Gmail-Original-Message-ID: <CAOZdJXWTzvTJFrdUnWD-YPPj6o=k2Xum5PR6enZKutv_+TRrEQ@mail.gmail.com>
Message-ID: <CAOZdJXWTzvTJFrdUnWD-YPPj6o=k2Xum5PR6enZKutv_+TRrEQ@mail.gmail.com>
To: Julia Lawall <julia.lawall@lip6.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 22 Jan 2019 23:06:43 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 22 Jan 2019 23:06:41 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci <cocci@systeme.lip6.fr>, Timur Tabi <timur@kernel.org>
Subject: Re: [Cocci] Fatal exception in spatch when #include file does not
	exist
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

On Tue, Jan 22, 2019 at 2:48 PM Julia Lawall <julia.lawall@lip6.fr> wrote:
> It finds type information.  It also matches your rules against the
> definitions found in the header files, just like it matches the rules
> against the definitions found in the .c files.

What happens when it matches a rule in a header file?  Does that mean
that it will try to edit the header file as well?

It seems to me for my DBG_PRINTF changes, I definitely want --no-includes.
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
