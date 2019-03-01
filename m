Return-Path: <SRS0=9e6n=RE=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760EFC43381
	for <cocci@archiver.kernel.org>; Fri,  1 Mar 2019 22:41:28 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF1102083E
	for <cocci@archiver.kernel.org>; Fri,  1 Mar 2019 22:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GL1Ooh/N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF1102083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x21MfB6B028750
          ; Fri, 1 Mar 2019 23:41:11 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D920E7701;
	Fri,  1 Mar 2019 23:41:10 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id C0FB276FE
 for <cocci@systeme.lip6.fr>; Fri,  1 Mar 2019 23:41:08 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x21Mf7SE027938
 for <cocci@systeme.lip6.fr>; Fri, 1 Mar 2019 23:41:08 +0100 (CET)
X-pt: isis.lip6.fr
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com
 [209.85.167.179])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8EA5620848
 for <cocci@systeme.lip6.fr>; Fri,  1 Mar 2019 22:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1551480066;
 bh=/AkWFyx0Jl77xlVkXlAogvVmY0etWVpm7ATvXGzTxjk=;
 h=From:Date:Subject:To:From;
 b=GL1Ooh/NKCI4TKIR4NKVS7PGRk48FrnZTcVyFq2CKko7/Kt73CPqfq3ahbMRwXK3p
 6wSEtPv0GvWF7yLCJpzitbo0EkqM8WA4ypHRDkHHVUKaEJrzTm3hH5+SK803NZXp+T
 K+A8c5eE6iIzb3LyHS65iaUn5rAO7aWJVfJ7UVdY=
Received: by mail-oi1-f179.google.com with SMTP id w66so20835033oia.4
 for <cocci@systeme.lip6.fr>; Fri, 01 Mar 2019 14:41:06 -0800 (PST)
X-Gm-Message-State: AHQUAuaIYYIcBwSWE9XyzSQ/rYe6FMVoZ7ZRpz58sMBpGE6sUUXvMbXX
 GgPfcPraQ8EZdwHtTVuWU1Y1qT+/VHjlbdmru/0=
X-Google-Smtp-Source: AHgI3IZsImrvbDekPqKAOBat59eGyyrYOf1vh6Hy+nn433Fk8Mj8KmSFF9+5O2RkGxRW0J7E+5dVKUZItcr45diM9uI=
X-Received: by 2002:aca:4790:: with SMTP id u138mr4560995oia.135.1551480065902; 
 Fri, 01 Mar 2019 14:41:05 -0800 (PST)
MIME-Version: 1.0
From: Timur Tabi <timur@kernel.org>
Date: Fri, 1 Mar 2019 16:40:29 -0600
X-Gmail-Original-Message-ID: <CAOZdJXVJw4VSq5YzCaQGjsEA2L3EdByRvNpSF3TvPm1FqNsQPw@mail.gmail.com>
Message-ID: <CAOZdJXVJw4VSq5YzCaQGjsEA2L3EdByRvNpSF3TvPm1FqNsQPw@mail.gmail.com>
To: cocci <cocci@systeme.lip6.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 01 Mar 2019 23:41:11 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 01 Mar 2019 23:41:08 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] ERROR-RECOV: found sync '}' at line
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

Cocci seems to have problems with { } blocks inside #if statements.
For example, the following code:

void func1(U32 Notifier)
{
    if (x == 0)
    {
        x = 1;
    }
#ifndef MACRO
    else if (x == 1)
    {
        x = 2;
    }
#endif
    else
    {
        return;
    }

    DBG_PRINTF((DBG_MODULE_PERFCTL, DBG_LEVEL_INFO, "hello\n"));
}

Gives me this error:

ERROR-RECOV: found sync '}' at line 19
parsing pass2: try again
ERROR-RECOV: found sync '}' at line 19
parsing pass2: try again

In this case, my nv_printf.cocci is still able to process the
DBG_PRINTF and convert it to NV_PRINTF, so technically it still works.

However, I have much more complex source files (which I cannot share)
that choke spatch.  I typically get multiple "found sync }" messages
along with stuff like:

PB MAYBE: dangerous typedef inference, maybe not a typedef: NvU8
TYPEDEF CONFLICT:NvU8
FLOW: cant jump to done: because we can't find this label

In this last case, the label "done" does exist, but it's called only
from within macros.
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
