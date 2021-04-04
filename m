Return-Path: <SRS0=NM3K=JB=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5E1C433ED
	for <cocci@archiver.kernel.org>; Sun,  4 Apr 2021 17:48:22 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99911611C0
	for <cocci@archiver.kernel.org>; Sun,  4 Apr 2021 17:48:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99911611C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 134HmHnS013985;
	Sun, 4 Apr 2021 19:48:18 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D009477D0;
	Sun,  4 Apr 2021 19:48:17 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id BBCBD74DE
 for <cocci@systeme.lip6.fr>; Sun,  4 Apr 2021 19:48:15 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:52e])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 134HmFif014433
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 4 Apr 2021 19:48:15 +0200 (CEST)
Received: by mail-ed1-x52e.google.com with SMTP id m3so597383edv.5
 for <cocci@systeme.lip6.fr>; Sun, 04 Apr 2021 10:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hnW1CgFVJ6/2436rmyaGXeIQBSZmi52jnXOi+a+WJ3I=;
 b=skES67ZmCp+b4VbidKgP0FLgd6hEDbT7KanovsQeFAQGX+TJrqXtWsk0vMvSeOFl9M
 YgHbuToHh2kJHnSqBSBfIFM4mdlUAPiujXPa9aqpXFqy36s/LrzdO4NgvdC3At04jJGW
 NilBEiBgv2uMcj8sASQe2kopDwa5grYCX/lcXsLZ63hIpdae9OzcGO1GukQJOT6FZxsf
 vVMsvkFx0bThwQbhGzHFPc+S4xPm/G3/FYQLZXjONBnZbKG5e5ZTd5RBWWqNfekWraQw
 Fov+Lv9iyktnbeRsB3clBNu7ewFLrQeXXlDAjU18rzdqB8Mt7tm8n0Hn5gsDgV6a77xj
 svgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hnW1CgFVJ6/2436rmyaGXeIQBSZmi52jnXOi+a+WJ3I=;
 b=mlIIBdFrB5xNNqm6q5UdM/OUnC6Chn5iGk20h6wDccFqc+TbRvzN0KxGrE2pxGzVDI
 qsD7QT2BPodyACdDNowobQyDFdqW+N65dtLBVC60RBXjjdco8bv7R3nl7qcyz4NIRnGe
 G5/A3R42TqrYfMQC6MTHOdPV0lJWmX+M2qJhS+Y0JwvLPm7E8Iz2ZpjOdurYnBR0lPQL
 OUc2/rQYmUzbO5Or4BI4Cn3nB872RuQcMixiERaZxfbpojqjxT8WAzaUCpDc/zOlO3cG
 6IZo26/ALKbr/CjSxc3hk21KayMrEWan5RcyJpb1cUcsR1f7bLkakZlH89kVYK52VCzz
 VlRA==
X-Gm-Message-State: AOAM533sF5gX/A6zNO5/RZ50i0ney0mJnCvSiZQYmQGtqb6meIHa5mJL
 HydeFwk+5ystJQybYGCKR3/lSSVmJZpLoq0LT6h5hhVGrJuIrg==
X-Google-Smtp-Source: ABdhPJwFrmazluJmARHlVYT89C+C7/FltkPfUIEoMBNZ8MuoDCDNR4DffpV1TFNLgrAVRxRB/PMmTYwZmASTj/o3+ZE=
X-Received: by 2002:a50:e607:: with SMTP id y7mr27555012edm.18.1617558494981; 
 Sun, 04 Apr 2021 10:48:14 -0700 (PDT)
MIME-Version: 1.0
References: <acfc6d2f0a7ea90f451de6d1185a0383@walle.cc>
In-Reply-To: <acfc6d2f0a7ea90f451de6d1185a0383@walle.cc>
From: Mansour Moufid <mansourmoufid@gmail.com>
Date: Sun, 4 Apr 2021 13:48:04 -0400
Message-ID: <CALogXGVkTv8eDpNxDnh38qPk0jwMHNpE0HShb4tmGZS3CSF-gQ@mail.gmail.com>
To: Michael Walle <michael@walle.cc>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 04 Apr 2021 19:48:18 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 04 Apr 2021 19:48:15 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] changing of_get_mac_address() to pass a buffer
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

On Thu, Apr 1, 2021 at 4:13 AM Michael Walle <michael@walle.cc> wrote:
>
> Hi,
>
> so first I need to say I've never used coccinelle before,
> so please bear with me ;)
>
> To make of_get_mac_address() work with DSA ports (and a nvmem
> provider) I'd need to change the semantics of of_get_mac_address().
> Right now it returns a pointer to "const char *", I'd need to change
> that so a buffer will be passed as a parameter in which the MAC
> address gets stored.
>
> (1) Usually the call is something like:
>
>    const char *mac;
>    mac = of_get_mac_address(np);
>    if (!IS_ERR(mac))
>      ether_addr_copy(ndev->dev_addr, mac);
>
> This would need to be changed to:
>
>    of_get_mac_address(np, ndev->dev_addr);

Here is one possible approach, doing the API change first then
handling the conditionals. It seems to work.

@a@
identifier x;
expression y, z;
@@
-   x = of_get_mac_address(y);
+   x = of_get_mac_address(y, z);
    <...
-   ether_addr_copy(z, x);
    ...>

@@
identifier a.x;
@@
-   if (<+... x ...+>) {}

@@
identifier a.x;
@@
    if (<+... x ...+>) {
        ...
    }
-   else {}

@@
identifier a.x;
expression e;
@@
-   if (<+... x ...+>@e)
-       {}
-   else
+   if (!(e))
        {...}

@@
expression x, y, z;
@@
-   x = of_get_mac_address(y, z);
+   of_get_mac_address(y, z);
    ... when != x
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
