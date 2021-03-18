Return-Path: <SRS0=PEvY=IQ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2525C433E0
	for <cocci@archiver.kernel.org>; Thu, 18 Mar 2021 18:26:34 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B164B64E22
	for <cocci@archiver.kernel.org>; Thu, 18 Mar 2021 18:26:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B164B64E22
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xteddy.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 12IIQUuu015724;
	Thu, 18 Mar 2021 19:26:30 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id C938C77CD;
	Thu, 18 Mar 2021 19:26:30 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 66A8F5DC3
 for <cocci@systeme.lip6.fr>; Thu, 18 Mar 2021 19:26:29 +0100 (CET)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:235])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 12IIQSle009782
 for <cocci@systeme.lip6.fr>; Thu, 18 Mar 2021 19:26:28 +0100 (CET)
Received: by mail-oi1-x235.google.com with SMTP id i81so479426oif.6
 for <cocci@systeme.lip6.fr>; Thu, 18 Mar 2021 11:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xteddy-org.20150623.gappssmtp.com; s=20150623;
 h=mime-version:from:date:message-id:subject:to;
 bh=x2qxa8JuYHrajaauySVPr74EAf7kMKbaJIyNiv0DkJg=;
 b=fGEri5zb6kBOr608xj/7abKqwcDYidxPY2TiUtzCvZFHDwe9ZYPC7aMiNDP/ZvO5U+
 pWdKYfqZKqCiOr82rjGiZ0BE7ZAg02z21uVL2VFH5/nFilf+JWn5xGuCRRuOR6MMtvX8
 J6qsD4FNUTYaSI6j+HCEqypYc71X8jBfwXi/v8b2DCvHNQAaZ91n5a2aFx0cXYbHquUI
 fceT77q0MOuUyX86+kBfQbzsyePmDe3Q4GBqq0Wwbqx0jIDw4kGKDfGHDQoZvc63897/
 mv4HpmLtrk/zxSNdI4A+jYj10kKsBABNaVsjvW5H2jOQZUpG0wc6pcmub0yv0vNDe1W0
 JhPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=x2qxa8JuYHrajaauySVPr74EAf7kMKbaJIyNiv0DkJg=;
 b=hErhqEKKzR3/o8lklYFVgi4e4qwMmpUKMVEy45gcHYgMmxo1AQhBVoE08k6VLK5UnK
 Y712B3fIvPW+qHnPHb0yUz+SX9/nmxoofG5z1TOhaJUCzhRonNlvb7YDAqPNzX/dMohd
 ygL5V+D3XPKy8h2aKXGHG/N+6f1Y9q6DomMjJmalwFrBplCuxLH482qOAeogYvsjLUzI
 Qr4aA1CduP5JEHXuWwvG3ZoiRAsHRBUzmxDoPCXR6lBfDLpmMRe/hA2MlBCMDow154+1
 PxkK7KOi3iYSPjQ9dzKDhw4n9znfl0nGPTin2lXlqjOpvIfgz+FoWZPj7HC0vPwoLJYF
 qEwA==
X-Gm-Message-State: AOAM533fVfipXQZkt7cHPQGpsVwOqzz0frs1x0SR8Y2hqdo9DUUjmU2x
 AhYcNh6M8Lb0UwlQZ2+zs6nIM8sXZYdjclu0NdQdmRpVXubWr+8h
X-Google-Smtp-Source: ABdhPJzGKoavK0IdzE7UX4ACos3xQM6QmML5k1PYgy5r1SqPpnWW8Y9MguWBgRml4CZ+rGRQdnnteLjRBCuD5E5kusg=
X-Received: by 2002:aca:f13:: with SMTP id 19mr4024522oip.56.1616091988075;
 Thu, 18 Mar 2021 11:26:28 -0700 (PDT)
MIME-Version: 1.0
From: Thomas Adam <thomas@xteddy.org>
Date: Thu, 18 Mar 2021 18:26:13 +0000
Message-ID: <CAOhcEPYTkAqYM4q4p6q=nvF3eS6QX_-ajRykn08YfnOK9+VHUg@mail.gmail.com>
To: Coccinelle <cocci@systeme.lip6.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 18 Mar 2021 19:26:31 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 18 Mar 2021 19:26:29 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Subject: [Cocci] Removing the last return statement from a void function
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

Hello all,

I've another Coccinelle question I'm hoping you can help me with.  The
codebase I'm working on is old, and has some interesting styles which
by themselves probably don't cause any problems, but newer C compilers
are now starting to flag them.

In particular, there seems to be a pattern in this code base of using
explicit `return;` statements at the end of void functions.  Here's an
example:

static void broadcast_mini_icon(FvwmWindow *fw)
{
    if (!FMiniIconsSupported)
    {
        return;
    }
    if (fw->mini_pixmap_file && fw->mini_icon)
    {
        BroadcastFvwmPicture( M_MINI_ICON, FW_W(fw),
            FW_W_FRAME(fw), (unsigned long)fw,
            fw->mini_icon, fw->mini_pixmap_file);
    }
    return;
}

Here you can see the last return statement is not necessary.

I'm trying to make coccinelle recognise this and remove such cases.
Here's what I've tried:

@@
identifier f;
@@

void f(...) {
  <...
- return;
...>

}

... which sort of works, but proceeds to remove *all* `return;`
statements from void functions, rather than the last occurance in the
function.

Am I on the right track with this approach, or do I need to do
something more creative?

Thanks once more for your help.

Thomas
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
