Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33DCAC3DA4A
	for <cocci@archiver.kernel.org>; Mon,  5 Aug 2024 11:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:content-transfer-encoding:subject:reply-to:sender:
   list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=/tyVwK047SxHVjw4GApHA6nTNTKF+8V+MWF7aOPn2Q4=;
  b=Or87k0jB08qjWXhPGtBM3p9ayeo2nd7L86NnXsIkjGioyViAV8loJHby
   XHe35HV/R8VsJv1UjJfBdtOG0QqnsHSKYQwDHh0YscBaA/p0GR5Fhnccn
   fT6NErRt1Te4bkWR8CMkToYrsue9RycO8yNKadhoLhu7QNygVfrmUCOf1
   g=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@chromium.org
X-IronPort-AV: E=Sophos;i="6.09,264,1716242400"; 
   d="scan'208";a="178139063"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Aug 2024 13:54:07 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4B284E0141; Mon,  5 Aug 2024 13:54:07 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 5727AE0035
	for <cocci@sympa.inria.fr>; Mon,  5 Aug 2024 13:10:24 +0200 (CEST)
IronPort-SDR: 66b0b320_SFdq+D0d1L1o1gZ1xwClwguse/0yeK3OYrL+HeVI6l/FLld
 8fBsFWAIVl/TpgsH4biLnMkLbzJkft5ZHY8lGLQ==
X-IPAS-Result: =?us-ascii?q?A0EcAABpsrBmgCzQVdFaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYJDfVozBFMDhFOIHV+GUIIiA4ETmyiBVoFAPg8BAwEMAT0HBAEBA?=
 =?us-ascii?q?wSCC4IuRgKJSgIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECB?=
 =?us-ascii?q?AYBAhABATsHDhIphXUNgmcBEIESgSYBAQEBAQEBAQEBAQEBAQEBAQEXAg1+A?=
 =?us-ascii?q?QEBAxIRHQEBNwEPCwsNAgImAgIhEgEFARwGARIigl+CMAMxAxGga4EFQos7g?=
 =?us-ascii?q?TKBAYIMAQEG2yQiV4FjCQkBCoEGLgGISQGBaoN4ATuDQXonG4INgRU1gj0HM?=
 =?us-ascii?q?T6CVgsCAhiBNw8Vg0aCaYtwgyODE4IfhQqDVnwmkBUmCR0DBwcODR5JDwUcA?=
 =?us-ascii?q?1khAhEBVRMXCwkFZIhnCoMjKYFLJoQYgTWDeoFrAQsBYIdyYoEOgT6BXwFJg?=
 =?us-ascii?q?ndKg2eBf0ICP4JjVx1AAwtiCz01FBtMpD+DFYICKgEieWIvEQUGxg+EH4Rvh?=
 =?us-ascii?q?yWVPzOEBZM3kwKYcCKCNIo7aodRCpMWAgoHBhEjgUQ6SYETMxoIKAhsBoIwC?=
 =?us-ascii?q?UYDGQ+OIYN6hRTCUEE1DS4CBwEKAQEDCYtyMoFLAQE?=
IronPort-PHdr: A9a23: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
 UdkLjDBRq9Uybx6ejIz4DI=
IronPort-Data: A9a23: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
 U7Keg==
IronPort-HdrOrdr: A9a23:ZXOFhqtz+KtXuP1qjlEGE7pv7skDtNV00zEX/kB9WHVpmwKj5r
 yTdZMgpGHJYVcqKQ4dcLW7UpVoLkmsjKKdjbNhW4tKGTOW31dAT7sSiLcKoQeQYBEWn9Q1vc
 wBAstD4Z/LfDxHZK7BgTVQeOxQuuVvnprY+Ns2DE0AcShaL49l5wd9TiCBEkN3QwFCQb40Do
 CV6MYChxfIQwVuUi14PBQ4tiT4yOEjXaiJEHw7OyI=
X-Talos-CUID: 9a23:HyR4DGNUq2YsTO5DZDhOqnJPRJkcamzixX32Omu6LmNjcejA
X-Talos-MUID: =?us-ascii?q?9a23=3ANeCXRw+Gmeir7bFThIZHvRCQf4R5uP+xOGkvq7U?=
 =?us-ascii?q?5q8WqGhQqN2y3tzviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.09,264,1716242400"; 
   d="scan'208";a="178134581"
X-MGA-submission: =?us-ascii?q?MDEGyLChhszW/ymwykoPYhbL41syknCD3tTfBC?=
 =?us-ascii?q?MJ94WpqQqY0hiGcx7g8DIjnOii+IobEZG7ipX59G6O23gHPl46aqqG+0?=
 =?us-ascii?q?ZTi/OCKmL7nK5XDMn8R3RMcywIQ/u/1dQkMZ/gHaglKQK1AXFZB/gs3r?=
 =?us-ascii?q?fThhv0ofcVr2I1uhEmbNwLrg=3D=3D?=
Received: from mail-ed1-f44.google.com ([209.85.208.44])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 13:10:24 +0200
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5a20de39cfbso13224754a12.1
        for <cocci@inria.fr>; Mon, 05 Aug 2024 04:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722856222; x=1723461022; darn=inria.fr;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/tyVwK047SxHVjw4GApHA6nTNTKF+8V+MWF7aOPn2Q4=;
        b=CfwOIbwCffbayMOn+cLgMIK9LBMID4oBfosKikJ2BrMENe7WPsf+D1OlYA6OgoT5Pt
         EoFUi6fYhbxn3qu3wtDJczw37xNd0ob+va/JyOAX0lvQtmnSEdcpEkHyW18LBXKwKiv1
         W3EzhjN1z+0b9W4wL3JZdlrn+iYyY+hC2yuQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722856222; x=1723461022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/tyVwK047SxHVjw4GApHA6nTNTKF+8V+MWF7aOPn2Q4=;
        b=WF3SBd5O+iCIxu4Ic9EqVaNc2fEjhTBsLbTeqP0tPE+mbi65hOFdHfRwhgogfLsLxp
         jtjzb1GGbQIyybGH/7c/uJX/Ov+II+rMupCozoD6gVI5fV4YGOXMmBHXVBkjLS87NsSy
         0iir9FlkiodTyJMrrSfzsBJJuLxCcCno96pLPf3+AkiZoVNkNd9/XOqgwK6QybjL+D2J
         R93dUfOx7CVih5q/1YGfW7ThcoGxCuByZz8rbqL5bCrcE43E2pnHpVXsvOQeWGUMetnN
         13ytOYBkQRKoKjdIsBqC9JJasf6kTkPVE1LxzcFVgYWrameHt6vdkHM4HUldW3OCxhBW
         V16w==
X-Gm-Message-State: AOJu0YxvLJlXfA/k9rwjtElweePlDqRda2AvKbdXZKr8fZi4aX9ZM/Lv
	xjkrtvyIFYNjyPnGDZJRBey1xS9ZkU0FwzKRzRbh/Qt5jubcFQhSXoSHwS5jYdRcCJPrawx4qaH
	otg==
X-Google-Smtp-Source: AGHT+IFFcBvMCOyxrZYmL7eGH8K01Shsw5TOsT6met4oEDO3L8maThmqSUNwZxQWllFTMhpaba1WIw==
X-Received: by 2002:a05:6402:1a3c:b0:5a1:1740:33cc with SMTP id 4fb4d7f45d1cf-5b7f36f4cc8mr9115855a12.3.1722856222229;
        Mon, 05 Aug 2024 04:10:22 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b839705d44sm4772819a12.11.2024.08.05.04.10.21
        for <cocci@inria.fr>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 04:10:21 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5b391c8abd7so10222757a12.2
        for <cocci@inria.fr>; Mon, 05 Aug 2024 04:10:21 -0700 (PDT)
X-Received: by 2002:a17:907:1c1a:b0:a7a:bece:6222 with SMTP id
 a640c23a62f3a-a7dc4da4fffmr959485766b.10.1722856221218; Mon, 05 Aug 2024
 04:10:21 -0700 (PDT)
MIME-Version: 1.0
References: <CANiDSCvmboKBK=Z7uS9tnN_LcPA16rx0j_iWeEoQ=jO+pEgLiA@mail.gmail.com>
 <98a94966-14c6-45c4-99d8-471f65b292ea@web.de>
In-Reply-To: <98a94966-14c6-45c4-99d8-471f65b292ea@web.de>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 5 Aug 2024 13:10:07 +0200
X-Gmail-Original-Message-ID: <CANiDSCuJHTsHsFLbMGC1S47myfReZX7JBfGZFVknj8y=4-QLCA@mail.gmail.com>
Message-ID: <CANiDSCuJHTsHsFLbMGC1S47myfReZX7JBfGZFVknj8y=4-QLCA@mail.gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>, Julia Lawall <Julia.Lawall@inria.fr>
Cc: cocci@inria.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] Cocci MUCH more slow after 6.11
Reply-To: Ricardo Ribalda <ribalda@chromium.org>
X-Loop: cocci@inria.fr
X-Sequence: 1834
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-08/CANiDSCuJHTsHsFLbMGC1S47myfReZX7JBfGZFVknj8y%3D4-QLCA%40mail.gmail.com>

Hi Julia and Markus

On Mon, 5 Aug 2024 at 12:02, Markus Elfring <Markus.Elfring@web.de> wrote:
>
> > Our CI went from 5:40
> =E2=80=A6
> > to 42:13
> >
> > https://gitlab.freedesktop.org/linux-media/media-staging/-/pipelines/12=
35432/test_report?job_name=3Dstatic-upstream
> =E2=80=A6
> > Is this something expected?
>
> I hope not.
>
>
> > Or shall I investigate at my side of the cable?
>
> * I suggest to offer further version information for involved software co=
mponents.

It seems to be related to the cocci version, and not the kernel version.

Debian updated it recently from 1.1.1 to 1.2.

These are my results for the same kernel code:


root@a361d9092793:/workdir# time make coccicheck M=3Ddrivers/media/
MODE=3Dreport V=3D1  > 1.1.1.txt

real    1m59.021s
user    53m53.038s
sys     2m17.171s
root@a361d9092793:/workdir# apt-get update
Get:1 http://deb.debian.org/debian trixie InRelease [169 kB]
Get:2 http://deb.debian.org/debian trixie-updates InRelease [49.6 kB]
Get:3 http://deb.debian.org/debian-security trixie-security InRelease [43.5=
 kB]
Get:4 http://deb.debian.org/debian trixie/main amd64
Packages.diff/Index [27.9 kB]
Ign:4 http://deb.debian.org/debian trixie/main amd64 Packages.diff/Index
Get:5 http://deb.debian.org/debian trixie/main amd64 Packages [9211 kB]
Fetched 9501 kB in 1s (9852 kB/s)
Reading package lists... Done
root@a361d9092793:/workdir# apt-get install coccinelle
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following packages will be upgraded:
  coccinelle
1 upgraded, 0 newly installed, 0 to remove and 71 not upgraded.
Need to get 6644 kB of archives.
After this operation, 3680 kB of additional disk space will be used.
Get:1 http://deb.debian.org/debian trixie/main amd64 coccinelle amd64
1.2.deb-1 [6644 kB]
Fetched 6644 kB in 0s (132 MB/s)
debconf: delaying package configuration, since apt-utils is not installed
(Reading database ... 21008 files and directories currently installed.)
Preparing to unpack .../coccinelle_1.2.deb-1_amd64.deb ...
Unpacking coccinelle (1.2.deb-1) over (1.1.1.deb-6+b1) ...
Setting up coccinelle (1.2.deb-1) ...
root@a361d9092793:/workdir# spatch --version
spatch version 1.2 compiled with OCaml version 4.14.1
Flags passed to the configure script: --prefix=3D/usr --sysconfdir=3D/etc
--libdir=3D/usr/lib --enable-ocaml --enable-python --with-python=3Dpython3
--enable-opt
OCaml scripting support: yes
Python scripting support: yes
Syntax of regular expressions: Str
root@a361d9092793:/workdir# time make coccicheck M=3Ddrivers/media/
MODE=3Dreport V=3D1  > 1.2.txt

real    15m0.552s
user    371m28.976s
sys     3m32.884s
root@a361d9092793:/workdir#


I can share the 1.1.1.txt and 1.2.txt files if needed.

>
> * How do you think about to extend configuration parameters for affected =
test runs
>   so that detailed comparisons of run time characteristics will become fe=
asible?
>
>
> See also:
> Selection of benchmarks
> 2018-04-24
> https://github.com/coccinelle/coccinelle/issues/133
>
> Regards,
> Markus



--=20
Ricardo Ribalda
