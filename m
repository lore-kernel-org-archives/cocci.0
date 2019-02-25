Return-Path: <SRS0=6Fm5=RA=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED90C43381
	for <cocci@archiver.kernel.org>; Mon, 25 Feb 2019 22:56:56 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4B65217F5
	for <cocci@archiver.kernel.org>; Mon, 25 Feb 2019 22:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GxkVb3Yx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4B65217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1PMueLk009243
          ; Mon, 25 Feb 2019 23:56:41 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id CBA7C7709;
	Mon, 25 Feb 2019 23:56:40 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7040976FD
 for <cocci@systeme.lip6.fr>; Mon, 25 Feb 2019 23:56:39 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1PMucaf028224
 for <cocci@systeme.lip6.fr>; Mon, 25 Feb 2019 23:56:38 +0100 (CET)
X-pt: isis.lip6.fr
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com
 [209.85.210.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4E9D6217F5
 for <cocci@systeme.lip6.fr>; Mon, 25 Feb 2019 22:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1551135397;
 bh=RsEzrEW2/DAkSceiYEvYyrtS0qFOaAn9rcFOEbDiEig=;
 h=From:Date:Subject:To:From;
 b=GxkVb3Yxpb5c/OnQrm6ggM2nRpul6Tk5zkEwHzqkgP4O9PcrhnTrfWqGWPfkJ3mOk
 NuDA3TVa5Wu7EccAQMW7FwoHjLeCLm6AocQQb1Ux5X0wwuHbpLZxNi4tPg6qNQbcCS
 vXgq/i92rCFkej+UZqbzIiFf9zYO580MNDVZDfu4=
Received: by mail-ot1-f47.google.com with SMTP id 98so9471830oty.1
 for <cocci@systeme.lip6.fr>; Mon, 25 Feb 2019 14:56:37 -0800 (PST)
X-Gm-Message-State: AHQUAuZJURv7xGgI+DCGaoW1Jv/7HW8mtC388Q8xfIppSAbpYpM46dB1
 tiFkzdbvABTEINsfC2NMEs8bK9yaPILF1s35Qoo=
X-Google-Smtp-Source: AHgI3Iba9pdpJhOPnvvhEDZbopQsCzZkx+/cC3qyv+gHMQfrcA2DJ4kXZ4qtZ4wF5HwEMzLJthXusKf1q16Oo5h31tQ=
X-Received: by 2002:a05:6830:1651:: with SMTP id
 h17mr12681053otr.173.1551135396637; 
 Mon, 25 Feb 2019 14:56:36 -0800 (PST)
MIME-Version: 1.0
From: Timur Tabi <timur@kernel.org>
Date: Mon, 25 Feb 2019 16:56:00 -0600
X-Gmail-Original-Message-ID: <CAOZdJXU3eTe7MS+_pb6ou4rXQFqM7P_ZYQAFd2F0P-aEGXVM7g@mail.gmail.com>
Message-ID: <CAOZdJXU3eTe7MS+_pb6ou4rXQFqM7P_ZYQAFd2F0P-aEGXVM7g@mail.gmail.com>
To: cocci <cocci@systeme.lip6.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 25 Feb 2019 23:56:41 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 25 Feb 2019 23:56:38 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] Octal constants confuse spatch
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

The following test confuses spatch:

void func(void)
{
    x = FLD_SET_DRF(0080, 1, 2, 3, 4);

    DBG_PRINTF((DBG_MODULE_PERFCTL, DBG_LEVEL_INFO, "hello\n"));
}

This gives me:

ERROR-RECOV: found sync '}' at line 7

If I change the "0080" to "80", it works fine.  I tried adding this line:

#define FLD_TEST_DRF(a, b, c, d, e)             1

But it didn't help.
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
