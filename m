Return-Path: <SRS0=Ntgp=IM=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_20,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25B4C433DB
	for <cocci@archiver.kernel.org>; Sun, 14 Mar 2021 00:55:26 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D587C64E98
	for <cocci@archiver.kernel.org>; Sun, 14 Mar 2021 00:55:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D587C64E98
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xteddy.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 12E0tKov009173;
	Sun, 14 Mar 2021 01:55:20 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id EB971571B;
	Sun, 14 Mar 2021 01:55:19 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 34C4D3BA2
 for <cocci@systeme.lip6.fr>; Sun, 14 Mar 2021 01:55:18 +0100 (CET)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:234])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 12E0tHvM003120
 for <cocci@systeme.lip6.fr>; Sun, 14 Mar 2021 01:55:17 +0100 (CET)
Received: by mail-oi1-x234.google.com with SMTP id x135so26455672oia.9
 for <cocci@systeme.lip6.fr>; Sat, 13 Mar 2021 16:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xteddy-org.20150623.gappssmtp.com; s=20150623;
 h=mime-version:from:date:message-id:subject:to;
 bh=iEwHQS6bAStbCFsHcf66X8J/CKosMnTXz0l66GFaR68=;
 b=F4OOtevrx3qGaw6WjVDzSUH89dbXASMf79sw/wmWdc/3SRD9l4VYQfhGUr7Z41ykEH
 ANIA40O9caqUd825cz6dqRujJk+o2j3+fREhBPVX6iJjIIrOHoCu/UxtgO3wSxejODRC
 n3vjk9LZX8nyGMSIkkyqwJu6Jn6nnnzHI1LQpI2MtTrbX6N0jCQIiBoqaNxwhZo2jDRi
 bQ2tn1F7FAKKdbaW8gjszewUB8MluRFdatsb1Mg60Hn12557EBxZMm5x068vzz5+1Wk2
 jGyxNQSKqB3sXk4FZhQgqo8FnNMOZlsjSjS5CyYwDmuAp8wSSiAXmSFTq3CTpBQz0yj6
 UQ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=iEwHQS6bAStbCFsHcf66X8J/CKosMnTXz0l66GFaR68=;
 b=aE8W6CjUiYUnLGXbl5lyyvhSRlVEL1yMegCdfBLENqjN0fNSdimJszoLYR8sDbxtA9
 YYbMDOvV6nhfBHIInfm4B7YwydODCGPhhrVV7zcVaoY13sYt5tqNalxB74gGGQfQfV38
 7RhxAJ8jeNBFV5KxFEAG9k4zDdrE24586ENnhzjUHDaO/h4n1pZCtq3xY20Tbi0X1Wl4
 Llch1w2COGl94yIkGWQx70ob2S9bKGueP9HLBqDhVLrlQ1w1mjQfhIZBrAzJpKp2vop4
 GuUSwgaued9tAqAeP6csxMtwGAkoB+O65RJXrvBYFNJgbWfzjbeRHcPJkoqlhcTgeQW+
 Jw8Q==
X-Gm-Message-State: AOAM530nAJycBb97+v68zg7diibmRgnzCfH83Tsl+wcRSfy/zLgAMy1s
 zGaC6fla3HjdRw75dgUK73zgkN0PTYIIPvN82olk7AWMI5JvfA==
X-Google-Smtp-Source: ABdhPJxNeCPbSTHFAkFfSxOzqEn6+MtgQFdTdRaz8XemPsGNpcRXPUPJuuoaiHfU7CB4hcrZAAQqX9uSm9fuI5XyOl4=
X-Received: by 2002:aca:4c48:: with SMTP id z69mr6255624oia.61.1615683316722; 
 Sat, 13 Mar 2021 16:55:16 -0800 (PST)
MIME-Version: 1.0
From: Thomas Adam <thomas@xteddy.org>
Date: Sun, 14 Mar 2021 00:55:06 +0000
Message-ID: <CAOhcEPbTH-oTTn1OUkgoYf2GaBKaCYjwpWuhrdNRkNQ0uZ_r4A@mail.gmail.com>
To: Coccinelle <cocci@systeme.lip6.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 14 Mar 2021 01:55:21 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 14 Mar 2021 01:55:17 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Subject: [Cocci] Replacing a struct member with a function call
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

I'm wanting to replace a struct member with a function call across the
code base I'm working on.

For example, I currently have the following struct definition (simplified):

struct monitor {
    struct {
        int width;
        int height
    } virtual;
};

Across my code base, I typically have the following:

struct monitor *m;
int f = m->virtual.width;

I have a need to remove `m->virtual.width` with a function call, hence
the example above after the modified code would look something like:

struct monitor *m;
int f = get_monitor_width();

I've tried the following smPL code without any success.  Could someone
point me in the right direction?  TIA!

@@
type M;
@@
- m->virtual.width;
+ get_monitor_width();

-- Thomas
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
