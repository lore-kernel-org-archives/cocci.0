Return-Path: <SRS0=lNp3=32=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB7CC2D0B1
	for <cocci@archiver.kernel.org>; Thu,  6 Feb 2020 11:58:47 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2955A20661
	for <cocci@archiver.kernel.org>; Thu,  6 Feb 2020 11:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYt/uJEg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2955A20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 016BwVdL002661;
	Thu, 6 Feb 2020 12:58:31 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 8F81877F9;
	Thu,  6 Feb 2020 12:58:31 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 83B9777EE
 for <cocci@systeme.lip6.fr>; Thu,  6 Feb 2020 12:58:30 +0100 (CET)
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1042])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 016BwSAb009629
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Thu, 6 Feb 2020 12:58:29 +0100 (CET)
Received: by mail-pj1-x1042.google.com with SMTP id dw13so2393370pjb.4
 for <cocci@systeme.lip6.fr>; Thu, 06 Feb 2020 03:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=vZDWu0hisuBiJ1Oltuw8JrByh92q2F8SlvjmiuEPDJc=;
 b=XYt/uJEgRutP6xckcAck0RRpMfbNSa6CJ/+Y3aFAfrrt8bJxJeacm5Vc/WNTl0HLnT
 q8xI5/Wtp+QOjpQyeQ0psuRwQcX4VsCQ02mZv8gY4bu8qxEjw/X0gnLinsonbZ5HaJno
 6p12noTNXTny+82o7Tx2e50kBnFWrFL6AUhCm9npJgW+XFUr1YDH1NF7PwmUQrqNn/xs
 ol1CWqrUlyPSlvxPt8e8WFy+2gtqmE0wInJu/ngdSTHugDPwsp/gfklXp5mv08Hb9dyq
 VBHHDkenqhFZZ41rV20hxl2Y3LXKKQpLhfF65WW60audPkbQRIixTtmUUGw4k8RisKuW
 2GrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=vZDWu0hisuBiJ1Oltuw8JrByh92q2F8SlvjmiuEPDJc=;
 b=AfXpr1RHvwz9O+wHk/C1xwcRNNXoUhVFIyfctImAtsyv0kLn198c/4ONJOY7LychH4
 LMzpcIOpGEI41E5CmH/zpM1Qcdsx8pIRBfvrZ4l/7nZVOg9lGXQx6vDMe84NgS2KDjT9
 wthPKM7lrlco91rS8EtJu2vb0ESsWFOn2lU9MF0oYKjmXt8nVirJ/LYcEjTM60+zP2I2
 YkFJhUVOiMTx1T02n2N71IK2lA1DO0q6HtycqF6s78G7gFYMka8uMMqt+WURQtCK6ok+
 Ad3YZa+CTZ+LPsh24b0RJz8hX3qQMfa+37i/JSAzsV/Y2HKTPSeroL/wc2+KPtWHUgBm
 H4og==
X-Gm-Message-State: APjAAAV7L44iy9XVsjYCwOHd07umCajrkcE2NCWDBYHcsOnoQs314bzb
 9/uH8ZLxc/lIVmOOINT4dhg=
X-Google-Smtp-Source: APXvYqygfJic+daovqKvub5/+UtE6+ltJrudkFwaQOKHEKliAa3dQ/IylpL7fk9PQcz2oCo7KMkHnQ==
X-Received: by 2002:a17:902:e789:: with SMTP id
 cp9mr3290745plb.85.1580990308274; 
 Thu, 06 Feb 2020 03:58:28 -0800 (PST)
Received: from localhost.localdomain ([2405:204:30e:4a31:b268:7a3:7dc6:f288])
 by smtp.gmail.com with ESMTPSA id
 b65sm3663359pgc.18.2020.02.06.03.58.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 03:58:27 -0800 (PST)
Message-ID: <f7da90d8cc0e609a2a81e7a041cc98afedb215b6.camel@gmail.com>
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
Date: Thu, 06 Feb 2020 17:28:23 +0530
In-Reply-To: <132f414d-397f-fb9a-ff6e-5360df827147@web.de>
References: <132f414d-397f-fb9a-ff6e-5360df827147@web.de>
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 06 Feb 2020 12:58:32 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 06 Feb 2020 12:58:30 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
        "cocci@systeme.lip6.fr" <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] [PATCH 2/2] tests: Add test case for matching pointers
 to const pointers (and variants)
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

On Wed, 2020-02-05 at 19:55 +0100, Markus Elfring wrote:
> Would you like to avoid any abbreviations in the patch subject?
> 

I used abbreviations to keep the patch subject short but still clear.

Would the following be a better subject?

"tests: Add test case to match const pointer variants"

Cheers,
Jaskaran.

> 
> > These types would not match previously.
> 
> I imagine that this information can be improved for a nicer patch
> description,
> can't it?
> 
> Regards,
> Markus

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
