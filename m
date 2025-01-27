Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7006C02194
	for <cocci@archiver.kernel.org>; Tue, 28 Jan 2025 09:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=xxg0hezMY3QdFEn/THOKSF706/cacT76YdsKJ2GXFz8=;
  b=ifkBFUZ5FWh9ieHOcaRbAZGfMpVmK3I+/Kv2S+8CSvsgc+NPU/DHlO5o
   5nHApFELtYfsnqoXQ9AHVC+uJviemKZdyylvdF5WJ3HpMIG3qJYGeCdaF
   EoTfxXzWFvMIEM5YPVOjuPa5vMesohR0lJvjuEXvOf7gLTvJfIrBIQHYA
   0=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@google.com
X-IronPort-AV: E=Sophos;i="6.13,240,1732575600"; 
   d="scan'208";a="205325477"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jan 2025 10:13:24 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A74BCE0D9D; Tue, 28 Jan 2025 10:13:10 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id E30B8E0035
	for <cocci@sympa.inria.fr>; Mon, 27 Jan 2025 12:46:51 +0100 (CET)
IronPort-SDR: 6797722b_IOiRbfTMs/2EJkRJcnByETyx08iYUSZDmagCj/4nPwMUcWy
 BZucDqBYKmJRl3j3MK9tMXWaZDzly0gd/70nfnA==
X-IPAS-Result: =?us-ascii?q?A0EGAAAccZdnfDWnVdFaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBPwYBAQELAYJDfVk0BAtIhFaIHYcygiEDnhiBJQNWDwEDAQ05CwQBA?=
 =?us-ascii?q?QMEhQACinUCHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGA?=
 =?us-ascii?q?QIQAQEiGQcOEimFew2CYgGBJIEmAQEBAQEBAQEBAQEBAQEBAQEBFwINOkMBA?=
 =?us-ascii?q?QEBAgESER0BATcBDwsLCQQCAiYCAiESAQUBHAYTIoJgAYJBIwMRqSqBBUKKR?=
 =?us-ascii?q?HqBMoEBggwBAQbcH4FkCRSBBi4BhX6CTwGBbIRDgzl6JxuCDYEVNYEGgW8+a?=
 =?us-ascii?q?YFhFwKFO4JpgjNLgSmDQKAwJgkdAwcHDg0eSQ8FHANZLAFVExcLBwWBKUgBA?=
 =?us-ascii?q?gFvIiOBJgU1QTqCDWlJNwINAjWCHnyCK4IhgjuCGIItR4QKhV6CFIFlAwMWE?=
 =?us-ascii?q?gGBc4E0eR6BTR1AAwtiCz03FBtMnSYBPIRKMRMBK2BtUh6xOZURhCWEb4N1g?=
 =?us-ascii?q?zSVSDOqU5h8jgSVRoVSESOBRDqBXDMaCBsVbAaCMAlGAxkPjiGDeoUTwjNFM?=
 =?us-ascii?q?jwCBwsBAQMJkB2BSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 bMbilZhO1yr50E=
IronPort-HdrOrdr: A9a23:ymFrTanaVBMOMD+pnpeHJ1sT3iTpDfI33DAbv31ZSRFFG/Fw5P
 re/8jztCWftN9/Yh0dcLy7WZVoIkmyyXcW2+Qs1N6ZNWGMhILCFuFfBOXZsl/d8mHFmNJg6Q
 ==
X-Talos-CUID: 9a23:Jkqm02/lZa0DWY5U+m6Vv1MGQOQ4aHH08GvdKXb7JiV5crixbnbFrQ==
X-Talos-MUID: 9a23:9kTRiAgj0fso154GvxyCRMMpaupjzpWlLmM2v8sd6seZHhJ2G2mYtWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,238,1732575600"; 
   d="scan'208";a="107440679"
X-MGA-submission: =?us-ascii?q?MDEn/I6KLJYYSJwjfDm7j5HUg5P5tygqZx7HUv?=
 =?us-ascii?q?8BaMOZ95zt9IqipfTHquOugPasHgVRRvescZhA5Z2Rzpcb9PQdv4h6lj?=
 =?us-ascii?q?UYgjAeLdwtOByvYXNUi9Yhe2O/OioyPFvQf6IEXoN5+vX9M0C7XkbwkK?=
 =?us-ascii?q?sf+fYup07gseVDtYCbwutRfw=3D=3D?=
Received: from mail-lf1-f53.google.com ([209.85.167.53])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 12:46:51 +0100
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5401ab97206so4484477e87.3
        for <cocci@inria.fr>; Mon, 27 Jan 2025 03:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737978410; x=1738583210; darn=inria.fr;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xxg0hezMY3QdFEn/THOKSF706/cacT76YdsKJ2GXFz8=;
        b=IikDQdoaNZTu/a0qJqaRGOWE8/jYssz847LBlocOaVIePHcM6toNifVCkvC2gkWGye
         iDPtMFUcndMi8MVipT5OulSYd1rhJVL0aySEVYCDCuN9cyIajsJxwXq+3vUYJJHZgZ2q
         pqwYNzjFS8O5+Pom8XNy+5jOLfoe70tAV+TEiMfHSYOaCBGKEDMtf79GY4Wbj+w/+9se
         XHHahfz7VV3EOx1gdZRv+bosGvw7PXreDFbonhwFeKEsgCFD7TcaqhBAif+n0aTnwM0z
         i6ei7w2B8DPNIHz13mY6f/r2EUtvtE61H4IbCi8R1gegPX9KKmuHm3hMbeBakkcG2M8T
         v9iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737978410; x=1738583210;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xxg0hezMY3QdFEn/THOKSF706/cacT76YdsKJ2GXFz8=;
        b=GFPZ4dn5WlU3hNDdD7O+GlnAdYt7B1VewklTUF20/KtVLqSFOQjqOhhXpwllQyH9Vs
         FUvRmlBDC/S3B1wPI8TZgO4g+m+dcLvgb0//AEyUHjFZjPZp5VGZJBie4h66UI6Z/PD+
         bIL9RUua7Rrx/uLJp/uCdHBg8IE1zY7WGACNDaMVHmU2U/5RIDvZd22EYXCQyNdP+kdQ
         TKdXPIfyBddq2H6UxFspL5+Z7bh8uoLA/JQ37ej3F3bhNRt6o5XskyUeFoBYYBcmonfE
         qCRmatFqaWlm7whDy7eCy1obGGSVQccFQK4ZoL+3eXO56NKH/+40nvbZUo6Z56RSk3+H
         rK2g==
X-Gm-Message-State: AOJu0YzotiMH9RVZ54gUUZzO2wJtzFmLPflUCl6vYaCLodxvAhP2YETT
	UowJoU92DEz3RTlUrPABURjrZvCFdRhnlX9SDBuiPQAr+bn41gxv96NXJqn5kAKUsBMUIdhpN1v
	UwLHDwpvjTr5ZHMj5mGZ05ffrNjTqCLqIDb58obg94RH/yC6l0i9p
X-Gm-Gg: ASbGncvRlP6AwW9HzYNdpzrwYt9W9wKTG+T70Kfk3Gf0NSyriehoXS8J8pN7gmQteV4
	FBgw9AK+2+kd8q/EWrjROULsF/WVyDxQ/LiqL8ipl0JtsIGwTMAn7qM7GuCLtl8BrmWlKHxDFLm
	jmqcizlWRLQnRVqNa+
X-Google-Smtp-Source: AGHT+IEj6y3jTbyGzuJabx6KrE7RfHOIwqzC7w6UehhWm7/Jpqn6BxsARtli+/rNsnd03bFI53BYY8P+QqHa6fCK59g=
X-Received: by 2002:a05:6512:128d:b0:542:238d:d714 with SMTP id
 2adb3069b0e04-5439c2855e3mr15545539e87.32.1737978410061; Mon, 27 Jan 2025
 03:46:50 -0800 (PST)
MIME-Version: 1.0
References: <CANiDSCvLCaMdJVSMahNgg1UQMh3naoTrWGh=9+4p8pePWyLStg@mail.gmail.com>
 <1176708922.5283093.1737643285348.JavaMail.zimbra@inria.fr>
 <CANiDSCsj1r34A5ytx5u_XrJwysyX3n7oOVPO7xGOPvUgHrnHSA@mail.gmail.com> <e8572652-54bc-475d-a25e-241fdb83b9c1@inria.fr>
In-Reply-To: <e8572652-54bc-475d-a25e-241fdb83b9c1@inria.fr>
From: Ricardo Ribalda <ribalda@google.com>
Date: Mon, 27 Jan 2025 12:46:36 +0100
X-Gm-Features: AWEUYZlXJbAo-VvSZbefUXDROncUeguoTRYPjbUb7TvPrE2GhYJAxsoDcrJzKUg
Message-ID: <CANiDSCtHhG4Cm2OXovD=B-NgrD=U9JewpJQhNpzve2EZEuz1vg@mail.gmail.com>
To: Victor Gambier <victor.gambier@inria.fr>
Cc: cocci@inria.fr
Content-Type: text/plain; charset="UTF-8"
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] linux-next: virtual rule report not supported
Reply-To: Ricardo Ribalda <ribalda@google.com>
X-Loop: cocci@inria.fr
X-Sequence: 2269
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/CANiDSCtHhG4Cm2OXovD%3DB-NgrD%3DU9JewpJQhNpzve2EZEuz1vg%40mail.gmail.com>

Hi Victor



On Mon, 27 Jan 2025 at 12:43, Victor Gambier <victor.gambier@inria.fr> wrote:
>
> Hi Ricardo,
>
> Thanks for all the info, especially the patch. Unfortunately I still
> can't reproduce the error.
>
> One thing that stands out to me: Coccinelle 1.3.0 shouldn't be
> compatible with OCaml 5.2.0 - are you sure you managed to compile 1.3.0
> with 5.2.0? If so, could you explain your process?

I have just used the Debian packaged binaries.
https://tracker.debian.org/pkg/coccinelle

You can try them with something like
podman run --rm -it debian:unstable


>
> Either way, could you give me an exact commit for both Coccinelle and
> the kernel? If I manage to reproduce it, I'll merge your patch.

For the kernel I am using from
git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

commit 5ffa57f6eecefababb8cbe327222ef171943b183 (HEAD)
Author: Stephen Rothwell <sfr@canb.auug.org.au>
Date:   Fri Jan 24 15:50:21 2025 +1100

    Add linux-next specific files for 20250124

    Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>


Regards!


>
> Victor
>
> On 24/01/2025 13:43, Ricardo Ribalda wrote:
> > Hi Victor
> >
> > I can easily repro with:
> >
> > ```
> > spatch -D report --no-show-diff --very-quiet --cocci-file
> > scripts/coccinelle/misc/secs_to_jiffies.cocci --dir .
> > ```
> >
> > tested with
> > spatch version 1.1.1 compiled with OCaml version 4.14.1
> > Flags passed to the configure script: --prefix=/usr --sysconfdir=/etc
> > --libdir=/usr/lib --enable-ocaml --enable-python --with-python=python3
> > --enable-opt
> > OCaml scripting support: yes
> > Python scripting support: yes
> > Syntax of regular expressions: Str
> >
> > and
> > patch version 1.3 compiled with OCaml version 5.2.0
> > Flags passed to the configure script: --prefix=/usr --sysconfdir=/etc
> > --libdir=/usr/lib --enable-ocaml --enable-python --with-python=python3
> > --enable-opt
> > OCaml scripting support: yes
> > Python scripting support: yes
> > Syntax of regular expressions: Str
> >
> > This patch "fixes" it for me:
> >
> > diff --git a/scripts/coccinelle/misc/secs_to_jiffies.cocci
> > b/scripts/coccinelle/misc/secs_to_jiffies.cocci
> > index 8bbb2884ea5d..2d85dca16418 100644
> > --- a/scripts/coccinelle/misc/secs_to_jiffies.cocci
> > +++ b/scripts/coccinelle/misc/secs_to_jiffies.cocci
> > @@ -10,6 +10,7 @@
> >   //
> >
> >   virtual patch
> > +virtual report
> >
> >   @depends on patch@ constant C; @@
> >
> > @@ -20,3 +21,8 @@ virtual patch
> >
> >   - msecs_to_jiffies(C * MSEC_PER_SEC)
> >   + secs_to_jiffies(C)
> > +
> > +// Dummy rule for report mode that would otherwise be empty and make spatch
> > +// fail ("No rules apply.")
> > +@script:python depends on report@
> > +@@
> >
> > On Thu, 23 Jan 2025 at 15:41, Victor Gambier <victor.gambier@inria.fr> wrote:
> >>> Deleting scripts/coccinelle/misc/secs_to_jiffies.cocci "works"
> >> That script was added to the linux kernel in December. Which version of Coccinelle are you using?
> >>
> >> On my end, with Linux 21266b8d and Coccinelle d4309c2, the following command executes without error:
> >>
> >> .../linux $ make coccicheck M="drivers/media" MODE=report
> >>
> >> Victor
> >
> >



-- 
Ricardo Ribalda
