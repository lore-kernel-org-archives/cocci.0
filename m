Return-Path: <SRS0=An1N=P6=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4B9C282C3
	for <cocci@archiver.kernel.org>; Tue, 22 Jan 2019 20:40:01 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5598020870
	for <cocci@archiver.kernel.org>; Tue, 22 Jan 2019 20:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ylxEyUmn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5598020870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x0MKdme9029191
          ; Tue, 22 Jan 2019 21:39:48 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 70A4076F2;
	Tue, 22 Jan 2019 21:39:48 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id EFCB876EA
 for <cocci@systeme.lip6.fr>; Tue, 22 Jan 2019 21:39:46 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x0MKdjMv025689
 for <cocci@systeme.lip6.fr>; Tue, 22 Jan 2019 21:39:46 +0100 (CET)
X-pt: isis.lip6.fr
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com
 [209.85.167.169])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 224AC20870
 for <cocci@systeme.lip6.fr>; Tue, 22 Jan 2019 20:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548189585;
 bh=v7fCARnodwART1CSAllE/A2W5eVg8d0PVzaw9hczYTA=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=ylxEyUmnPLFooBDYs+cpmAwJ+DWbxm9Oq593k/YV6WQrHKSVGFuiKXgNzV2ATIXOy
 7G+LK7hdGbtFJZO7yreQ8MvxlsoGsIVC6NnvnlXmgpKPz0+5p2VLgWEvTQ2tUiSw6i
 o/Myt91D3/rEaWbrUiybdGpQ9CtKCrEhANo9eSfw=
Received: by mail-oi1-f169.google.com with SMTP id c206so18644144oib.0
 for <cocci@systeme.lip6.fr>; Tue, 22 Jan 2019 12:39:45 -0800 (PST)
X-Gm-Message-State: AJcUukfm28/Edryw5FBaSD6nYj4SnKiLg6z1dtfghdY9bNvP/jisyB7d
 +XfMJDPFt8NQEnOpl9TYQlhRLIJhRZZrzGJO+FU=
X-Google-Smtp-Source: ALg8bN52l7WqYPf7ZWDce1Z5Ud4Gd13HJyGtOWSedi4T5Pt7Fefra94dy5rtH25RWFRrlSpEvGQdvMvjX7Vf0SORGyU=
X-Received: by 2002:aca:5117:: with SMTP id f23mr9627433oib.72.1548189584456; 
 Tue, 22 Jan 2019 12:39:44 -0800 (PST)
MIME-Version: 1.0
References: <CAOZdJXUhfSskY8+i3Juf8t4-obp9nu=c0CXriNbPBoGj6ZMeVQ@mail.gmail.com>
 <alpine.DEB.2.21.1901222040260.2519@hadrien>
In-Reply-To: <alpine.DEB.2.21.1901222040260.2519@hadrien>
From: Timur Tabi <timur@kernel.org>
Date: Tue, 22 Jan 2019 14:39:07 -0600
X-Gmail-Original-Message-ID: <CAOZdJXVpZ4a0owZ1byCoU6_mRPwBjrn4Z5ZSQi93GHm+Wui_qA@mail.gmail.com>
Message-ID: <CAOZdJXVpZ4a0owZ1byCoU6_mRPwBjrn4Z5ZSQi93GHm+Wui_qA@mail.gmail.com>
To: Julia Lawall <julia.lawall@lip6.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 22 Jan 2019 21:39:49 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 22 Jan 2019 21:39:46 +0100 (CET)
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

On Tue, Jan 22, 2019 at 1:53 PM Julia Lawall <julia.lawall@lip6.fr> wrote:

> If you want all the header files to be ignored, just give the argument
> --no-includes.

What does spatch actually do with the header files that it reads?
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
