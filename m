Return-Path: <SRS0=twh3=75=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03116C433DF
	for <cocci@archiver.kernel.org>; Tue, 16 Jun 2020 16:24:47 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 792EB20882
	for <cocci@archiver.kernel.org>; Tue, 16 Jun 2020 16:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oh85dvXp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 792EB20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 05GGOSFv007968;
	Tue, 16 Jun 2020 18:24:28 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 90A967577;
	Tue, 16 Jun 2020 18:24:28 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 567DE438E
 for <cocci@systeme.lip6.fr>; Tue, 16 Jun 2020 18:14:33 +0200 (CEST)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1034])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 05GGEVRM020893
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Tue, 16 Jun 2020 18:14:32 +0200 (CEST)
Received: by mail-pj1-x1034.google.com with SMTP id h22so1826838pjf.1
 for <cocci@systeme.lip6.fr>; Tue, 16 Jun 2020 09:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=+CSUOL0MxWjOFxOE+yfqWPyharEVJGFKivIoWdZf1n0=;
 b=Oh85dvXpAF31tkRY9Pa7gBL0xTt3XJBbljuzTg95JTcLgNvKAGv0vTnYRbTcY95m7g
 2mSqmstA76TJjh0ATBE1IQJNqe1Uug0OyG3SC4tLn3sv5ay2KYrnVZckieozu97n1C9x
 4wWA9IS5XTdwN6BQCciiN/pgBVIGfQHtEPckOeQjZD0Cnr/U6bYc8wbO/3NhHF6kd0Y2
 uH+LVVCz0KNfqea69DOK7NHrZpWbT7HKT8F2jbikGZgQuH/LxQAMHo8HzaQxe5O0k1Oj
 gil94SlpxIbox6QoH0yc0EEJmAQhHSxYoQTcNNlNPH93gmk1CI6tiRKlWWg2WG5zkCUx
 kYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=+CSUOL0MxWjOFxOE+yfqWPyharEVJGFKivIoWdZf1n0=;
 b=V2Z5933X+oFn3IkrZQWtjTutjYHLTtUQjVwn7mvY2G+LSMJi5nT0lCHJ/EvSmZRdZ+
 3fzMT+5sJ3LiUzFLXK+91Lx9lTCLe8fSySYL5tNUyey9xi5Q1kDPIuuXkJwld+YyCtRp
 KbR4BRdzPZvNmhoBwVFxR5u+E3OLR2bWWyI9x9KtsY1qZFQCS+gbvNRFoHJTYUwkYJP2
 JjeGdSttvDT0gjv+p888qkcSBqoA5WeZB2OKnsNuiJHfw43AHe8wFZ9FQAMPhSijGzCq
 lg9N/Zi9y1Nq07GHb++0gfen32BVN0bpMa4zIMEqRM7uWjIeGNPrWEKFn7DEMb8aTV35
 moSw==
X-Gm-Message-State: AOAM5326WHAkLBuy9rzKN6JCE/+hsZ5SoPY+3OZTNneJgAgu/2uwD0k1
 spIVUl6NvQwh8Wj4YGPDV3byZ0xV83MZIWsT/VD+tsb3
X-Google-Smtp-Source: ABdhPJwMIA2pctstKe9MCBYj9e5j1tbvIneJiREAGptTJDCuvn58VmzgXupvTwoDucv2TpkRna4dZWWENXxLkFWKfuA=
X-Received: by 2002:a17:90a:d18c:: with SMTP id
 fu12mr3716605pjb.232.1592324071047; 
 Tue, 16 Jun 2020 09:14:31 -0700 (PDT)
MIME-Version: 1.0
From: Thomas Calderon <calderon.thomas@gmail.com>
Date: Tue, 16 Jun 2020 17:14:20 +0100
Message-ID: <CA+1ewKbOb7uv+dYDgPHrTsuAWOMt1+CudcwGcdttGZHCvcAtLA@mail.gmail.com>
To: cocci@systeme.lip6.fr
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 16 Jun 2020 18:24:28 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 16 Jun 2020 18:14:33 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
X-Mailman-Approved-At: Tue, 16 Jun 2020 18:24:26 +0200
Subject: [Cocci] Ubuntu Focal release for Coccinelle
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
Content-Type: multipart/mixed; boundary="===============0605014648=="
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

--===============0605014648==
Content-Type: multipart/alternative; boundary="0000000000009f525705a835d6fd"

--0000000000009f525705a835d6fd
Content-Type: text/plain; charset="UTF-8"

Hello,

I was wondering if there is a package available for Coccinelle for Ubuntu
20.04?

Many thanks,

Thomas

--0000000000009f525705a835d6fd
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">Hello,<div><br></div><div>I was wondering if there is a package available for Coccinelle for Ubuntu 20.04?</div><div><br></div><div>Many thanks,</div><div><br></div><div>Thomas</div></div>

--0000000000009f525705a835d6fd--

--===============0605014648==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--===============0605014648==--
