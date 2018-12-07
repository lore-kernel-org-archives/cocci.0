Return-Path: <SRS0=vlGS=OQ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B950EC07E85
	for <cocci@archiver.kernel.org>; Fri,  7 Dec 2018 17:18:41 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EED12082D
	for <cocci@archiver.kernel.org>; Fri,  7 Dec 2018 17:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKV4NMiF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EED12082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id wB7HIPw8026769
          ; Fri, 7 Dec 2018 18:18:26 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A415B76D6;
	Fri,  7 Dec 2018 18:18:25 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 4F15376D4
 for <cocci@systeme.lip6.fr>; Fri,  7 Dec 2018 18:18:23 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id wB7HIM27027874
 for <cocci@systeme.lip6.fr>; Fri, 7 Dec 2018 18:18:22 +0100 (CET)
X-pt: isis.lip6.fr
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com
 [209.85.210.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1DCE12082D
 for <cocci@systeme.lip6.fr>; Fri,  7 Dec 2018 17:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544203101;
 bh=rjFwemFXUoTW8Rh0v9c0Q2GTkR4gJs9IT5QZN6RBujw=;
 h=From:Date:Subject:To:From;
 b=XKV4NMiFP6q+MmqS0f5bcEvkqzAbG1df8DpVWpIwctxFo2i24GJlY6V9of7KKLP+r
 N+XOgoc4E3VO5jS71RhDAf4XNHOiUv8q9y3XmTec9fD8R1IH1DQp7ruHdSJcaNsrS7
 DKYSOk99zqWvYWof0c3uUcviTk+OG7F2qUJU1Lrg=
Received: by mail-ot1-f42.google.com with SMTP id i20so4497119otl.0
 for <cocci@systeme.lip6.fr>; Fri, 07 Dec 2018 09:18:21 -0800 (PST)
X-Gm-Message-State: AA+aEWbNPrG969tHc73eihec+u4fSMgcoD4XJl5SzhN++wJ50DcH9FFp
 sCoAoezUr1LjJOhmKOOcXRZvfi7PSr1mtUen1yU=
X-Google-Smtp-Source: AFSGD/WreiC9rHuB1GJXLD2xmDW34LgO46WFVn0CjtKVGAsnc04xSINKZVa6Oep4qklBA7s5hlpiZ/jNwNiOffwiSis=
X-Received: by 2002:a9d:7c1:: with SMTP id 59mr2156267oto.191.1544203100438;
 Fri, 07 Dec 2018 09:18:20 -0800 (PST)
MIME-Version: 1.0
From: Timur Tabi <timur@kernel.org>
Date: Fri, 7 Dec 2018 11:17:44 -0600
X-Gmail-Original-Message-ID: <CAOZdJXW9XmFAPbhiSsejhFZ+9me=kHc25A-Qk0e=CrCnkkFuhw@mail.gmail.com>
Message-ID: <CAOZdJXW9XmFAPbhiSsejhFZ+9me=kHc25A-Qk0e=CrCnkkFuhw@mail.gmail.com>
To: cocci <cocci@systeme.lip6.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 07 Dec 2018 18:18:29 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 07 Dec 2018 18:18:22 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] Fatal error: exception File
 "engine/ctlcocci_integration.ml", line 361,
 characters 4-10: Assertion failed
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

spatch version 1.0.7-00117-g163d2058 compiled with OCaml version 4.05.0
Flags passed to the configure script: --disable-parmap
OCaml scripting support: yes
Python scripting support: yes
Syntax of regular expresssions: PCRE

Unfortunately, I can't share the C source file, and the --debug option
to spatch doesn't display anything.  This is a self-built spatch (with
parmap disabled), and line 361's assertion is:

  F.KeyMap.iter (fun nodei node ->
    assert (F.KeyEdgeSet.cardinal (!g#successors nodei) >= 1);
    ) !g#nodes;

I can't understand this code, so I can't debug it myself.
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
