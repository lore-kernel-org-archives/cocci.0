Return-Path: <SRS0=WSfn=SS=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83F2C10F13
	for <cocci@archiver.kernel.org>; Tue, 16 Apr 2019 21:39:03 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F91420684
	for <cocci@archiver.kernel.org>; Tue, 16 Apr 2019 21:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WnjOEGYu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F91420684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3GLcV6c001162
          ; Tue, 16 Apr 2019 23:38:31 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 166A77735;
	Tue, 16 Apr 2019 23:38:31 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 6A27D7728
 for <cocci@systeme.lip6.fr>; Tue, 16 Apr 2019 23:38:29 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3GLcSg0001870
 for <cocci@systeme.lip6.fr>; Tue, 16 Apr 2019 23:38:28 +0200 (CEST)
X-pt: isis.lip6.fr
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DF97320684
 for <cocci@systeme.lip6.fr>; Tue, 16 Apr 2019 21:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1555450707;
 bh=eWn6yvLqtsiPS7skuv8Cd/emApEb7++8aCUILm0Q0Yo=;
 h=From:Date:Subject:To:From;
 b=WnjOEGYur7Ynd4ToEQcE7b5crHKZRcn9VOONdgQMKAv8Cdn/ZzFYZG5R37o6nSFXU
 ndh7p72NXUmDXHiRkWYMEeyzQkGz5GS4PrMT6jhH8kkdVvRGec+aKDyY2zUoAOaBVg
 7iV3GpLQ3YaW2hxvjGhZNky0BiN2csNTW8B66IxU=
Received: by mail-wr1-f41.google.com with SMTP id w10so29131899wrm.4
 for <cocci@systeme.lip6.fr>; Tue, 16 Apr 2019 14:38:26 -0700 (PDT)
X-Gm-Message-State: APjAAAV1M9eQbTGV3AWfkHZJRS2rqbdpIFa+TEZQoRSHhAwNTcN9JHCt
 8h4uyUB6q6AkHsUO7zYKw7zIt4HNSimVqlGlETI=
X-Google-Smtp-Source: APXvYqyh8FTYrggdIYXKPCROq+fKwcu0UEqox75Qg1U4ecNHbTrXtjyvgNWx0Y/PjKJKg8ZelcsjM0EJRqjXbJemANM=
X-Received: by 2002:a05:6000:12c8:: with SMTP id
 l8mr52310167wrx.80.1555450705578; 
 Tue, 16 Apr 2019 14:38:25 -0700 (PDT)
MIME-Version: 1.0
From: Timur Tabi <timur@kernel.org>
Date: Tue, 16 Apr 2019 16:37:48 -0500
X-Gmail-Original-Message-ID: <CAOZdJXUtiVjHf2zPZFkhP9j4xcZHAwnyQiZ5Q9d4Jg3Cb6jQ=Q@mail.gmail.com>
Message-ID: <CAOZdJXUtiVjHf2zPZFkhP9j4xcZHAwnyQiZ5Q9d4Jg3Cb6jQ=Q@mail.gmail.com>
To: cocci <cocci@systeme.lip6.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 16 Apr 2019 23:38:31 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 16 Apr 2019 23:38:28 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] Can coccinelle differentiate between a string literal and a
	string variable?
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

I have a macro that requires one of the parameters to be a string
literal, rather than a variable (e.g. char x[] or char *x).

Can a coccinelle rule differentiate between the two?
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
