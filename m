Return-Path: <SRS0=Y1Te=ON=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A1FC04EB8
	for <cocci@archiver.kernel.org>; Tue,  4 Dec 2018 20:18:35 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16E48206B7
	for <cocci@archiver.kernel.org>; Tue,  4 Dec 2018 20:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9IrlQcm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16E48206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id wB4KIFe2004899
          ; Tue, 4 Dec 2018 21:18:15 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 0D81576D4;
	Tue,  4 Dec 2018 21:18:15 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B7E7575E8
 for <cocci@systeme.lip6.fr>; Tue,  4 Dec 2018 21:18:12 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id wB4KIBwb005231
 for <cocci@systeme.lip6.fr>; Tue, 4 Dec 2018 21:18:12 +0100 (CET)
X-pt: isis.lip6.fr
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com
 [209.85.210.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E27D620851
 for <cocci@systeme.lip6.fr>; Tue,  4 Dec 2018 20:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543954691;
 bh=2zFMAQBvuOtU6MUmvwBSFD+jO98Z3bBPD8jJ6znqIu8=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=h9IrlQcmffiIjO9ah212PjuVIds+7fBYzx6LgC2Nl0+WYLuiV/AqB2jDZs/IsF3FE
 G9hUzsD3L9Mc4pevUmifodgqqc6iUz/1UqvgevP5hWamOhTHifTC4bRz9L+fTIRWwF
 1urK6H/Lfnxmm7SkX7bib2eXH1rb7hZdCRjD7IYg=
Received: by mail-ot1-f53.google.com with SMTP id v23so16427617otk.9
 for <cocci@systeme.lip6.fr>; Tue, 04 Dec 2018 12:18:10 -0800 (PST)
X-Gm-Message-State: AA+aEWbDhXzAcWyz3/buOfZVsbOqDgskRFAwDyBA581BqWbkfpc3UaQj
 rvBJ787dRSNe0Vkt3DPXdrXq0hX/OTAWgReaT8Q=
X-Google-Smtp-Source: AFSGD/VoVIy5bziP8Nx4qjUjGAVjYQLSYg2wmT8rZWr0SlZZFQVhiRxXKWw7qhlxdx9x1/YgUE67H5HguKgSMsK9YRs=
X-Received: by 2002:a9d:6009:: with SMTP id h9mr14435208otj.349.1543954690199; 
 Tue, 04 Dec 2018 12:18:10 -0800 (PST)
MIME-Version: 1.0
References: <CAOZdJXVLMv-5_u1uOq6re+1O3vADsrTK0+J3Fat-XN4_2DEp4w@mail.gmail.com>
 <alpine.DEB.2.21.1811151327420.2372@hadrien>
In-Reply-To: <alpine.DEB.2.21.1811151327420.2372@hadrien>
From: Timur Tabi <timur@kernel.org>
Date: Tue, 4 Dec 2018 14:17:33 -0600
X-Gmail-Original-Message-ID: <CAOZdJXWD0L4Qwh2raJLF25Ax0=DR06vhfGWhpQVf804YQJ5jeA@mail.gmail.com>
Message-ID: <CAOZdJXWD0L4Qwh2raJLF25Ax0=DR06vhfGWhpQVf804YQJ5jeA@mail.gmail.com>
To: Julia Lawall <julia.lawall@lip6.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 04 Dec 2018 21:18:16 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 04 Dec 2018 21:18:12 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Can the current function name be passed to a Python
	snippet?
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

On Thu, Nov 15, 2018 at 3:29 PM Julia Lawall <julia.lawall@lip6.fr> wrote:

> The name of the current function at a given match is available in a
> position variable bound as part of that match.  A position variable should
> have a current_element field.

Unfortunately, I don't understand what you're saying.  I see some
examples referencing the "position" in a Python script, but they don't
make any sense to me, e.g.

http://coccinelle.lip6.fr/docs/main_grammar016.html#sec27

The example shows:

@ r exists @
local idexpression struct device_node *n;
position p1, p2;
statement S1,S2;
expression E,E1;

I assume when you say "position parameter", you're talking about the
"position p1, p2;" above.  If so, I'm completely confused.
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
