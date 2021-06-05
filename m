Return-Path: <SRS0=Fsbo=LB=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B6BC48BC2
	for <cocci@archiver.kernel.org>; Mon,  7 Jun 2021 05:32:05 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 880A061209
	for <cocci@archiver.kernel.org>; Mon,  7 Jun 2021 05:32:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 880A061209
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 1575VxC8010036;
	Mon, 7 Jun 2021 07:32:00 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 4750E7666;
	Mon,  7 Jun 2021 07:31:59 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 9B9FA402A
 for <cocci@systeme.lip6.fr>; Mon,  7 Jun 2021 07:31:57 +0200 (CEST)
Received: from mail.zx2c4.com (mail.zx2c4.com [104.131.123.232])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 1575VtRH028555
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 7 Jun 2021 07:31:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105; 
 t=1622889155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=QXb1T5k0YpRFM7zHiF8CtrzsG3dw0+gr+1j55KqllaY=;
 b=d3NR+D8MRSr6dIPwM9yRk0k2Tgh24tmBt0saFdPaB8DlDLntetze+lqjthL7txWha5nMlT
 aYdHia4op4Lx7Zad1Q+J21yXIv+IDLZrzujsMJrMleCCt3b0awflWbRBXxKrmfsVQdw685
 hAeGvpmLmKX4Y6BBb63enMCoFdd3cxo=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 4cedffe2
 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO) for <cocci@systeme.lip6.fr>;
 Sat, 5 Jun 2021 10:32:34 +0000 (UTC)
Received: by mail-yb1-f169.google.com with SMTP id g38so17307259ybi.12
 for <cocci@systeme.lip6.fr>; Sat, 05 Jun 2021 03:32:34 -0700 (PDT)
X-Gm-Message-State: AOAM532zTQ+aoSZJIDX4iJjgrg1TC5TMMzXpwgwpkavPWFEOLUDXphey
 6ZOlQrdcTP0LHAJhy9jZFpqWRK88TpDQnhNVffs=
X-Google-Smtp-Source: ABdhPJwix1aUX2R8e091DQ3CiVngzhr2iC2k6csnVsbwSt384bJqitxGmpUErqLEFNorLjJpHRHOOJ/VfbsfE/7i1aE=
X-Received: by 2002:a25:389:: with SMTP id 131mr11309894ybd.306.1622889154381; 
 Sat, 05 Jun 2021 03:32:34 -0700 (PDT)
MIME-Version: 1.0
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Sat, 5 Jun 2021 12:32:23 +0200
X-Gmail-Original-Message-ID: <CAHmME9rRQmSLkU6ELNiC=pr-D7CGjdyw27_oXdBp+hMdn8WQ5Q@mail.gmail.com>
Message-ID: <CAHmME9rRQmSLkU6ELNiC=pr-D7CGjdyw27_oXdBp+hMdn8WQ5Q@mail.gmail.com>
To: cocci@systeme.lip6.fr
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 07 Jun 2021 07:32:00 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 07 Jun 2021 07:31:57 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] struct type renaming in the absence of certain function
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

Hi,

I'm trying to write a spatch rule that has some inversion logic for a
given struct member, but I'm struggling to express this in SmPL. I'm
also a bit of a coccinelle novice, however. Specifically, I'm trying
to express:

For all structs, for each member `M` of type `struct rwlock`, if there
are calls to `rwlock_wlock(&M)` and `rwlock_wunlock(&M)`, but there
are no calls to `rwlock_rlock(&M)` or `rwlock_runlock(&M)`, then
change `M`'s type from `struct rwlock` to `struct lock` and change
calls to `rwlock_wlock(&M)` and `rwlock_wunlock(&M)` to
`lock_lock(&M)` and `lock_unlock(&M)`, respectively.

In other words, "if I'm not using the reader part of an rwlock, make
it into a normal boring lock."

I realize that tracking whether, in a call to f(&something->M),
something is actually of the type in which rwlock was replaced is kind
of hard (I think?). But I'd be willing to compromise on just assuming
that something->M is always correct, because M always has
unique-enough names. Or maybe that compromise isn't needed due to some
sort of amazing coccinelle type inference, but anyway, I'm willing to
compromise.

The trickiest part seems to be, however, only doing this in the case
where there aren't calls to `rwlock_rlock(&M)` and
`rwlock_runlock(&M)`. I tried using a virtual rule and a depends
clause, but those dependencies don't seem to work over a given
instance of an identifier.

I could probably hack my way toward that with a ridiculous sed
expression, or do it procedurally after parsing the AST. But it seems
like this would be a good case for where Coccinelle makes things
easier, so I thought I'd commit to getting it done with spatch. Any
pointers would be appreciated.

Thanks,
Jason
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
