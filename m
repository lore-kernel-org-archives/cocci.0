Return-Path: <SRS0=pQEi=HB=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B52E0C433DB
	for <cocci@archiver.kernel.org>; Sat, 30 Jan 2021 03:54:18 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0469C64E05
	for <cocci@archiver.kernel.org>; Sat, 30 Jan 2021 03:54:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0469C64E05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 10U3rt56004535;
	Sat, 30 Jan 2021 04:53:55 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 2003E74B6;
	Sat, 30 Jan 2021 04:53:55 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 85E43389B
 for <cocci@systeme.lip6.fr>; Sat, 30 Jan 2021 04:53:53 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:532])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 10U3rpBu005252
 for <cocci@systeme.lip6.fr>; Sat, 30 Jan 2021 04:53:51 +0100 (CET)
Received: by mail-ed1-x532.google.com with SMTP id d22so12869716edy.1
 for <cocci@systeme.lip6.fr>; Fri, 29 Jan 2021 19:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=HNjSZwNQ8JDwBMbb5HAFLGG51tpfUMPetya9PVtDBi4=;
 b=pF6xmgGwHN7xe+C/g3KaVjdx1x9hkjyKmkqprtLHj8B67LfvgA2TG9Dd3fB6Cflo5c
 v6G6H4msjFI+fmnJaL/zaf+St3b58DGDn10F1urkNonaLKmSIyKwr9cTpqAOFryZKxFH
 jkN4XULWZcuirV45lvs0ULhTFdYnOkPE4zN/87Zo0XO7ghiF3Sevn9tyN4h7q2gZpfwN
 b8785jaBrwppTPL0nXyohdtr/VvyPvm+9AJa/jJiyRWe0Q1Xv+BGs3CAYtLEyt/xSYme
 RMwkYUzs1WB3RCykY/EN8vKSHVbCCr4Spqe7v2tW0+mXQZULB8xGf/UdKcdEenuCiiOc
 mu/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=HNjSZwNQ8JDwBMbb5HAFLGG51tpfUMPetya9PVtDBi4=;
 b=MmC28Cr6Z4am/lPt5niFYNj18MuPGseAdY//sKpHcUkOMkaU2CslsbAYxU1GblZ73Z
 Nfm3VdnhWB5Rr9cvlAP5mJD8OAemTFnBxOkAxxMTKcmEZJkzTfopOX5A15dY+8ZcSR0b
 mXmVXc7uZ81NXi6C4c2kB4lhQejd0ey5JjiGEe/rcUOSErh9UJvuV9eVFEdQ/oWAfVYP
 bdrkYtzCku34qnNtBs9MkTRhIL2tgHIwcrY2W0+tDY7sQnTsPVFzeCLd80K5PKAckFs6
 u4m9qE/2eIOqXkhI31hp4DmZZyN4tJnaqIdlZQH7TTkQDnUiIvSQfA5kXgBqzMrK/ddl
 Gvyw==
X-Gm-Message-State: AOAM532qHZpFR0NhDDIGdZVMqHoF6N2HeEtIhuPrw9jMpxjnim9NZLn/
 3ofYBaMHVOanWHg0Pl6irDDWMHfxQ0u97T5vNC+p/seP+EU=
X-Google-Smtp-Source: ABdhPJwnDm061qxOuI//ShShsIpnIegzEdH2BYp3eleHwkMDVPhi8XnW2Ty/aJfdxr0Rix2n2PT/3/pDt6yUssOldQ4=
X-Received: by 2002:a05:6402:151:: with SMTP id
 s17mr8179035edu.107.1611978831245; 
 Fri, 29 Jan 2021 19:53:51 -0800 (PST)
MIME-Version: 1.0
References: <20210127152325.5692b2e6eb7b8ed82d91262b@schemamania.org>
In-Reply-To: <20210127152325.5692b2e6eb7b8ed82d91262b@schemamania.org>
From: Mansour Moufid <mansourmoufid@gmail.com>
Date: Fri, 29 Jan 2021 22:53:40 -0500
Message-ID: <CALogXGV1sf3z9rS8eL4-jJdXoeJdThXb=CTvCvaUVNrk31d3=g@mail.gmail.com>
To: cocci@systeme.lip6.fr
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 30 Jan 2021 04:53:56 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sat, 30 Jan 2021 04:53:51 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Subject: Re: [Cocci] qualified function rule
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

On Wed, Jan 27, 2021 at 3:23 PM James K. Lowden
<jklowden@schemamania.org> wrote:
>
> I don't understand how, if it's possible, to qualify a function in a
> rule.  I want the class of all functions having a parameter of a
> particular type.
>
> The code I'm working with has hundreds of unnecessary casts.  Many
> functions take a void* parameter, but are nonetheless called by casting
> the parameter.  For example, the parameters to memcpy(3) often
> have casts applied.
>
> I imagine writing a rule like
>
> @@
> type T, D;
> identifier F(void*);
> identifier D * data;
> @@
>
> - F((T*)data)
> + F(data)
>
> but that doesn't work, and I haven't found anything that does.

Try:

    @@
    void *x;
    @@
    - (void *)(x)
    + x

or, to catch them all,

    @@
    type t;
    t *x;
    @@
    - (t *)(x)
    + x

but this only works on function arguments when Coccinelle knows about
the function prototype from a header file (see the options
--include-headers and -I).
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
