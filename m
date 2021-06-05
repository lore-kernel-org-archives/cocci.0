Return-Path: <SRS0=Fsbo=LB=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_20,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1386C48BCD
	for <cocci@archiver.kernel.org>; Mon,  7 Jun 2021 05:32:05 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AB836120F
	for <cocci@archiver.kernel.org>; Mon,  7 Jun 2021 05:32:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AB836120F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 1575W0O3024308;
	Mon, 7 Jun 2021 07:32:02 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 9A97D77FD;
	Mon,  7 Jun 2021 07:32:02 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7A8E27666
 for <cocci@systeme.lip6.fr>; Mon,  7 Jun 2021 07:31:58 +0200 (CEST)
Received: from mail.zx2c4.com (mail.zx2c4.com [104.131.123.232])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 1575VuUg016504
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 7 Jun 2021 07:31:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105; 
 t=1622928264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rUm0lLPeGOL0/CKXHPraF1NifX2A5DVKRqqF+Bdz1l4=;
 b=Gq3OW9TnmsDfxpubKJ5/zN18b8MMmi10ulGGUuFv6hYQde9SuELSIhHrOLBbALC0KLy6NJ
 t3T2FmQBtB5+K3ivu1O8zv+A8uxJfqNa57gUkL03BTRaSK5gpQcnGPLzFHWnBwL1a/Mc+u
 TXCFlmQuSFEpRJEBInBCPIaZxAre4wU=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b808761a
 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO) for <cocci@systeme.lip6.fr>;
 Sat, 5 Jun 2021 21:24:24 +0000 (UTC)
Received: by mail-yb1-f180.google.com with SMTP id g38so18975256ybi.12
 for <cocci@systeme.lip6.fr>; Sat, 05 Jun 2021 14:24:24 -0700 (PDT)
X-Gm-Message-State: AOAM531YOehet6uRn9P/aGYUyDRG0fc28CvTkxb95x4cuWHVnnuzcO9v
 wOn/F+aXEAPzQ4L38yGYrYzedB25/esalG5IMXk=
X-Google-Smtp-Source: ABdhPJwqQOcBSbGL5OMQfJbZ6OXqo+cLHFxzxWLqcMizD8RSG3SFWVTyc27+DliOr+AL/EW73D5E5JAbm3my20s4NK4=
X-Received: by 2002:a25:b8d:: with SMTP id 135mr13605014ybl.49.1622928263946; 
 Sat, 05 Jun 2021 14:24:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9rRQmSLkU6ELNiC=pr-D7CGjdyw27_oXdBp+hMdn8WQ5Q@mail.gmail.com>
 <alpine.DEB.2.22.394.2106051335410.25155@hadrien> <YLvDVI9TCEVoL16r@zx2c4.com>
 <alpine.DEB.2.22.394.2106052149580.32368@hadrien>
 <CAHmME9qukRfmo9ooa4O-2Z1CbdZaGxY70JiHgwD4QiaYTr100g@mail.gmail.com>
 <alpine.DEB.2.22.394.2106052248370.32368@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2106052248370.32368@hadrien>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Sat, 5 Jun 2021 23:24:13 +0200
X-Gmail-Original-Message-ID: <CAHmME9pYTPZwuro-L+hHTd1NFG2v9hvx=2i43BNw2f-1ywkJxg@mail.gmail.com>
Message-ID: <CAHmME9pYTPZwuro-L+hHTd1NFG2v9hvx=2i43BNw2f-1ywkJxg@mail.gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 07 Jun 2021 07:32:02 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 07 Jun 2021 07:31:58 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] struct type renaming in the absence of certain function
	calls on members
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

That makes sense. Thank you so much for your help. Committed here (and
credited you as co-author):
https://git.zx2c4.com/wireguard-freebsd/commit/?id=b13579613ffcbe56c28df79972a74025007a85b7

Jason
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
