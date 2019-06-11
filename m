Return-Path: <SRS0=MjcO=UK=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6266DC31E44
	for <cocci@archiver.kernel.org>; Tue, 11 Jun 2019 21:59:14 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7EE7205ED
	for <cocci@archiver.kernel.org>; Tue, 11 Jun 2019 21:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTAX2VIs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7EE7205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5BLx11d026229;
	Tue, 11 Jun 2019 23:59:01 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 7D241775F;
	Tue, 11 Jun 2019 23:59:01 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 2CB9B775D
 for <cocci@systeme.lip6.fr>; Tue, 11 Jun 2019 23:59:00 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5BLwwt1024861
 for <cocci@systeme.lip6.fr>; Tue, 11 Jun 2019 23:58:59 +0200 (CEST)
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com
 [209.85.167.170])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4B60C20874
 for <cocci@systeme.lip6.fr>; Tue, 11 Jun 2019 21:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1560290338;
 bh=+Q+DpiqjxMs67p5eCFvu/K8gC0BG9/+i1hnZwFFCe6k=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=RTAX2VIs5um/IiicgQdCg+oF+4Ra1X1gTvD9RRRsj9RdzYYYMwE2fbGun2vudusxp
 Ggj+grbqWLN/WroFcdPDWqRAu0g5XmXcDRb04M2Pdi9/gsDgxTPW4lyEvf7mQi3ED+
 0XBCQDmH7peVOEAV2ed8SSYpTLTFHGwHHeu0zVXI=
Received: by mail-oi1-f170.google.com with SMTP id e189so10144857oib.11
 for <cocci@systeme.lip6.fr>; Tue, 11 Jun 2019 14:58:58 -0700 (PDT)
X-Gm-Message-State: APjAAAXNz0Vhk/473WXzP0GWjKQqivl/c5dPxqtihi9k8ooxWGsyJKGt
 WG1GaUSYFSQmMJL+PBlDMU4lMp56ijJFbzAm87s=
X-Google-Smtp-Source: APXvYqwXclKRwgsEDRKoyy7OUtOkFhvGxVJ8pp6yDyw+cCDcnprz0qZJp0Z6VyRlBBouy0PZjrPmuyNwVRVEOpxQ2fw=
X-Received: by 2002:aca:de44:: with SMTP id v65mr15713821oig.135.1560290337583; 
 Tue, 11 Jun 2019 14:58:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAOZdJXWVyC3o6vVbNEakhr8p4vX4j3wkkSyJg77-hcQ7Nqhf=g@mail.gmail.com>
 <CAOZdJXWja4mBf-gKSZ-HQaPs3c3x1ur2=BgPh6MnPx+eN7EgYQ@mail.gmail.com>
 <alpine.DEB.2.21.1905242138280.2514@hadrien>
 <CAOZdJXVsdJHZyWSXzOsJTTOj8R=UZcD4yZVxXBB1TELJLT1wSA@mail.gmail.com>
In-Reply-To: <CAOZdJXVsdJHZyWSXzOsJTTOj8R=UZcD4yZVxXBB1TELJLT1wSA@mail.gmail.com>
From: Timur Tabi <timur@kernel.org>
Date: Tue, 11 Jun 2019 16:58:21 -0500
X-Gmail-Original-Message-ID: <CAOZdJXXrKJdD-wvrASVv1OY2z16n0UKwkWK26w+uQfkgqFORgw@mail.gmail.com>
Message-ID: <CAOZdJXXrKJdD-wvrASVv1OY2z16n0UKwkWK26w+uQfkgqFORgw@mail.gmail.com>
To: Timur Tabi <timur@kernel.org>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 11 Jun 2019 23:59:01 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 11 Jun 2019 23:58:59 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] How to concatenate identifier with text?
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

On Tue, Jun 11, 2019 at 4:51 PM Timur Tabi <timur@kernel.org> wrote:
> but I get this error:
>
> 18: unexpected use of a fresh identifier label
>
> What am I missing?

Apparently I'm missing this obscure line in the documentation:

"Fresh identifier metavariables must only be used in + code."

Any suggestions on how to work around this, other than use Python?
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
