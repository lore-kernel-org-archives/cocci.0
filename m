Return-Path: <SRS0=3TVc=OP=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5A0C04EB9
	for <cocci@archiver.kernel.org>; Thu,  6 Dec 2018 00:04:49 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E8CA2082B
	for <cocci@archiver.kernel.org>; Thu,  6 Dec 2018 00:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jkinGQa8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E8CA2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id wB604Ufh018531
          ; Thu, 6 Dec 2018 01:04:30 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 7092576DA;
	Thu,  6 Dec 2018 01:04:30 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 899F076D4
 for <cocci@systeme.lip6.fr>; Thu,  6 Dec 2018 01:04:29 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id wB604S1m009797
 for <cocci@systeme.lip6.fr>; Thu, 6 Dec 2018 01:04:28 +0100 (CET)
X-pt: isis.lip6.fr
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com
 [209.85.210.51])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1A4C32082B
 for <cocci@systeme.lip6.fr>; Thu,  6 Dec 2018 00:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544054668;
 bh=4J0CnBPeD2v5fK7DTu07xcy5/T8DGwbIQ//1ZLCT6fc=;
 h=From:Date:Subject:To:From;
 b=jkinGQa8MJkGff419t3e8ym5Y71VGWHqo5MR2yKAEN3V6MKXY8KOqAaTk+4nKKXrN
 4RouYRejUk+XerH60nvgXwZwvCyWg4cv2fOrCTgvGkkAkVEW8SLvobkLVRxvg1eeil
 /GI1FCSw0NLtVqFeAEQSrfSTH0F1psKnHJhf9YkE=
Received: by mail-ot1-f51.google.com with SMTP id v23so20395450otk.9
 for <cocci@systeme.lip6.fr>; Wed, 05 Dec 2018 16:04:28 -0800 (PST)
X-Gm-Message-State: AA+aEWaD3YZ9bcb2Gp78lHxNMBSyUIXXFhqlyTowVl+amvua3asI1TJL
 JAZZrfLWoyXZVkPZX5RfmQFM0m88zLxYOVyn8UU=
X-Google-Smtp-Source: AFSGD/Wrf+uUqzGB5lKdZmxF3j4yWarTvZ5ummDoCrVEaUI/PBdTDLxvCCkktEIoYZCNdfo5gPWWpYjJlC553DBFUQY=
X-Received: by 2002:a9d:4704:: with SMTP id a4mr17825552otf.325.1544054667411; 
 Wed, 05 Dec 2018 16:04:27 -0800 (PST)
MIME-Version: 1.0
From: Timur Tabi <timur@kernel.org>
Date: Wed, 5 Dec 2018 18:03:50 -0600
X-Gmail-Original-Message-ID: <CAOZdJXWcwzt-nKoU2_LG2F7+wvB2Z+qAE=rfYGdiPzksgeHqFQ@mail.gmail.com>
Message-ID: <CAOZdJXWcwzt-nKoU2_LG2F7+wvB2Z+qAE=rfYGdiPzksgeHqFQ@mail.gmail.com>
To: cocci <cocci@systeme.lip6.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 06 Dec 2018 01:04:31 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 06 Dec 2018 01:04:29 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] "llu" integer literal suffix confuses coccinelle
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

This line is rejected by coccinelle:

            NvU64      barSize   = pBus->PciBarSizes[i] * 0x100000llu;

If I change the "llu" to "ull", it works.  However, "llu" appears to
be valid C, so it should be accepted.  Or at least, gcc accepts it.  A
google search says that it's new in C++14.
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
