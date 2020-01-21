Return-Path: <SRS0=kxF3=3K=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8DAC2D0CE
	for <cocci@archiver.kernel.org>; Tue, 21 Jan 2020 11:06:54 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B01E2253D
	for <cocci@archiver.kernel.org>; Tue, 21 Jan 2020 11:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qvEwnunb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B01E2253D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00LB6Xfk020383;
	Tue, 21 Jan 2020 12:06:33 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 6F14E77E4;
	Tue, 21 Jan 2020 12:06:33 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id C0C6077E1
 for <cocci@systeme.lip6.fr>; Tue, 21 Jan 2020 12:06:31 +0100 (CET)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1030])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00LB6PqN027850
 for <cocci@systeme.lip6.fr>; Tue, 21 Jan 2020 12:06:26 +0100 (CET)
Received: by mail-pj1-x1030.google.com with SMTP id d15so1203078pjw.1
 for <cocci@systeme.lip6.fr>; Tue, 21 Jan 2020 03:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=KUB30XAdc7IB4BdtXCNF01sVDM5GdqhhWV+6JnRgMBU=;
 b=qvEwnunb6AUWhBr+TmnbWYze9AWZurHoCMwubXWrfPQzM2blp+R+rfagOlfzpgNZk/
 bh0uof8JDlVOT1lq6H2FV99WvX2gHku7c3EQwsYUFIAtRlerTWSeoZalo1EzDiPZtLXq
 POqj5YU14cLdISVLQ+ghLaKnJQu67bTff/Bsu2wBKU6XWyWnEJ1nFBx24ZmiGArnBAb4
 6fdz7Yq6n35h6VuN4rNX/0VZygEFW4JpXIdPFZaHSSFoXnUuTJHGv03z+alqbcVrdUmH
 9phCQRI8IelDIeSDegrAFayZax8ng5901IFCHPYJpz0t/2jfgz7u7NUWhduHThtP5Yfi
 LRjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=KUB30XAdc7IB4BdtXCNF01sVDM5GdqhhWV+6JnRgMBU=;
 b=cPi4/stdiAtjhr0bPQUZZSPzdV65QEAm/u5a5IudYfTc6V9m8wp33F1Uqd82spnpp2
 RBERtL1fSJoBOC3mZefRnkQcg9JljppZHAOmDDjRWDm0kF6yhsiaU4EKTJZjI8Bqi/Fd
 xC8qN8B40dDZOhooP2w1g7iHbepn3aupiJgTYGB8qBSDy3dqzWFpxzw6218kyzDJx7Ai
 F+gsfOg0FZdZGQ6Q9Q/fM9VERcPOXezz7bkW5cL85tCHGAETSsx1XkuKazyp2YVWxL/c
 ro4YfX0q6tU/i5/aMbhS5+VU7T+tV8y2rp5CECI7h5PAlIFjERd/cVumMRz3TkALexoI
 /HlQ==
X-Gm-Message-State: APjAAAWWp7GwA1zdSy34x1ItJFzbJ6yxvk+leNRN+Nncw8N7mwD2Ur54
 aJg6v2qfhOEC1T4yfofsM9XGbeUe+14=
X-Google-Smtp-Source: APXvYqytP8OJzyACZoo7qO2IiAk7ev5SQNZReA9Gyb+SF9wDfu1vleZjQT4UaqJ6IfW9Xw5ICqKd7A==
X-Received: by 2002:a17:90a:bd82:: with SMTP id
 z2mr4852814pjr.17.1579604785238; 
 Tue, 21 Jan 2020 03:06:25 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:167e:da7:fcf8:ab67:c0bb:e29])
 by smtp.gmail.com with ESMTPSA id
 189sm43662103pfw.73.2020.01.21.03.06.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 03:06:24 -0800 (PST)
Message-ID: <7bb4650f42c2d5b25d5695bf6f9f257bc5407043.camel@gmail.com>
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
Date: Tue, 21 Jan 2020 16:36:20 +0530
In-Reply-To: <5bb2b304-96d9-c3e0-af31-5e918f1a8e40@web.de>
References: <5bb2b304-96d9-c3e0-af31-5e918f1a8e40@web.de>
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 21 Jan 2020 12:06:34 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 21 Jan 2020 12:06:26 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: "linux-kernel-mentees@lists.linuxfoundation.org"
 <linux-kernel-mentees@lists.linuxfoundation.org>,
        "cocci@systeme.lip6.fr" <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] [PATCH v2 2/3] parsing_hacks: Add bool to list of known
 typedefs
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

On Tue, 2020-01-21 at 11:10 +0100, Markus Elfring wrote:
> > Before:
> >   passed:bool
> 
> I wonder if subsequent duplicate information can really help to
> achieve a better understanding
> by the suggested description of a software situation.
> 

Hm, I thought it would but you're probably right. Should I just remove 
the second Before/After? The text above it about trace_kprobe.c
explains things anyway.

Cheers,
Jaskaran.

> Regards,
> Markus

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
