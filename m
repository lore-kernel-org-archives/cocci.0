Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEC82C433EF
	for <cocci@archiver.kernel.org>; Thu, 12 May 2022 16:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=M4UDlKRebsbsd9fHAw24fkcv1MtmUWX3qlEufb0SRbI=;
  b=rVss00sTNJUwHM2pewCwzeGN0YtivU3assfJogzrogoy8lhppF65K8Jj
   GDgwJuMZOGYtb47/rCf7YKuWq889OVNc1G14labtxkMTkHJnGHUTSkxDT
   CAEHHfpIYsPhfTVEzM8fh9CbYe4U54njmpuIdXfLg/8hl+YuvVasTX7Ne
   I=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.91,220,1647298800"; 
   d="scan'208";a="36014081"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 May 2022 18:48:58 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8EA73E0269; Thu, 12 May 2022 18:48:58 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id A178DE0048
	for <cocci@sympa.inria.fr>; Thu, 12 May 2022 18:48:52 +0200 (CEST)
IronPort-SDR: +WlxF4aBqVZL6zvQIyHtjJMLnHWxcC+th30qiUgchARndvu0HP+iGRO9qvDyjgXK9DEhJzjSqW
 p5myewja6sw32+YwUfyVNO3xgEdZKEszEKrBGVwZ4zbozl5EaY1iFaaFLkBwkdJNRxOQLHn+8G
 YhM5Eh8Isf47BN6BIFBt511MCF17Az83eFxnGIXk20z1Jy5JSpVIYOKH+C5QTuI3aZQIYl1Siu
 ow4dDETybRvseyKzf1WQ0FveRMgYrtLYPXFZx5WOywql00jHthAYvmVbVkZpBSXgUdC8Kb4kz8
 k58+8Z+CPP1AH6LbJT9Ygg3/
X-IPAS-Result: =?us-ascii?q?A0AnBQAAOn1ih07ASNlagQmBUYIigVMtBAtDhE6RDosnh?=
 =?us-ascii?q?xuKI4F7CwEDAQ0/AQIEAQGFAgKFPgIdBwEENgQNAQIEAQEBAQMCAwEBAQEBA?=
 =?us-ascii?q?QMBAQUBAQECAQECBAQBEwEBAQwNCQUICgcOEAU2Bl4GZASBSwSBdAs0DYI1K?=
 =?us-ascii?q?QGDZAECAgEjHQEBESYBBAsLGgImAgJXBg0IAQGCeYJjAQMNKKwTgTGBAYIIA?=
 =?us-ascii?q?QEGhEofLCJSgVwJgRAtjWV6JxCBVUSBPIMDPogagmWVXCgEDwMdOIEGEoEhc?=
 =?us-ascii?q?QEKBgMDBwoFMgYCDBgUBAIVEVMeAhMFBwocDhQcJBkMDwMSAxEBBwILEggVL?=
 =?us-ascii?q?AgDAgMIAwIDIwsCAxgJBwoDHQgKHBIQFAIEEx8LCAMaHy0JAgQOA0MICwoDE?=
 =?us-ascii?q?QQDExgLFggQBAYDCS8NKAsDFA8BBgMGAgUFAQMgAxQDBRsMBwMhBwsmDQ0EH?=
 =?us-ascii?q?AcdAwMFJgMCAhsHAgIDAgYXBgICcgooDQgECAQcHiYTBQIHMQUELwIeBAUGE?=
 =?us-ascii?q?QkCFgIGBAUCBAQWAgISCAIIJxsHFhkdGQEFNycGCwkjHAokDQYFBhYDJzIGI?=
 =?us-ascii?q?gEbAlKWDKcGnlg0B4ITgTuBQwyeJQYTLYNjAZJmDgaRdZZlpySBewSBdzMaJ?=
 =?us-ascii?q?E+CaE4BAgECDQECAgMBAgECCQEBAo42hAyKLT80OwIGCwEBAwmFRwEBh0UBA?=
 =?us-ascii?q?Q?=
IronPort-PHdr: A9a23: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
 jTfpJhirgP++gFg4iVqWlxCp2QS7L8=
IronPort-Data: A9a23:G9V3z6pJ2enfwpeTUsX1zNeERjdeBmJJYxIvgKrLsJaIsI4StFCzt
 garIBmDaK6DYGT9LtgnPIqypB9QuJ/UnN5rGQU4/CxgF3sW9uPIVI+TRqvSF3PLf5ebFCqLz
 O1HN4KedJhsJpP4jk3wWlQ0hSAkjclkfpKlVKicfHoZqTZMEE/Nszo68wICqtMu0IHR7z+l4
 4uo+ZWCYQX9gVaYD0pNg069gEM31BjNkGhA1rAOTagjUIj2yhH5pLpGTU2AByOQrrt8RoZWd
 M6fpF2NxV41yj92Yj+TfhkXRWVRKlLaFVDmZnO7wMFOiDAazsA5+v5T2Pbx9S67hh3R9+2dx
 umhurSoSQcNNILe394mWgFZUHFCBItj/OLIdC3XXcy7lyUqclPpxOhySl47N8sU946bA0kUr
 KNed2pLN0HZwb3mqF64YrEEasALCcDxP54E/FxkwyvYC/kOXp3JBanHjTNd9G5r15oeQ6+CD
 yYfQRVOTEjZT0VlA2Y4IYA8xt+BuGXCMDIN/Tp5ooJuvjSNlVUvuFT3C/LefdeBRO1Oj0OAr
 yTH+X74C1cULrSiJSGt93WxmqnQkCm9VI96+KCEGuBCmF2T4mY8GlosblKjoLrptneYftYCJ
 BlBksYxlpQa+EuuR9j7ehS3pn+YoxIRM+Zt//0GBBKll/OOslfCboQQZm8dOYV+3CMjbWZyj
 je0c8XV6StHnJD9dJ5w3rKTsC/0JiUfa2MPDcPlcefny4m9yG3QpkiXJjqGLEJTpoOvcd0X6
 27QxBXSf51J0aY2O1yTpDgreQ6EqJnTVRIS7Q7KRG+j5Q4RTNf7OtbyuAOLtqoedtvxory9U
 J4sxJn2AAcmUsDlqcBxaLlWdF1Uz6vZYWOH2zaD4bF7q231oxZPgry8EBkneRs3a59aEdMYS
 Bad4EtQ4oNeJn2nced+bOqM5zcCncDd+SDefqmMNLJmO8AvHCfepX0GTRPOgwjFzRZ9+Ylia
 M/zWZv9Vh4yVPU3pBLoHL11+eFwmUgDKZb7Hs2TI+KPiubFOxZ4iN4tbDOzUwzOxPna/1+Jo
 40PZ6NnCXx3CYXDX8UeyqZLRXhiEJTxLcmeRxV/erHRLwx4NnsmDvONk7otd5Y7zbtYnKHE8
 yjlCENfzVP+g1zBKBmLMywyNumwAMwn9X9rbzYxOVuI2mQ4Zdj95qkod6wxIest+ttlwKMmV
 PICYciBXq9CR22fqTQQZJXwtqJ4cxGviV7cNiapemZtYJNqAQDEo4e2cgzq/SgILyy2qcpn/
 +z+jFyGG8JbSl07XsjMaf+pw1eghlQnmbp/DxnSP91eWETw64w0eSb/uf8AJZ1eIxv0wDbHh
 R2dBg0VpLWWroI4rIvJiKSDo9v7GudyBBMDTWzc8KrwKiTQuGaumNcSXOGNdDHbdWX15KT7O
 bQLla6haqVfkQYYqZd4HpZq0bk6uYnlqYha+QI4Tn/FWFKmV+F7KX6c0MgT7aBAmu1DtQ2tV
 h7d89VWI+zQasbiDUJXOwcvKOiOjKlGlj7X5PUzAUP7+C4uoOvZCxoPZUHUhXwPNqZxPaMk3
 fwl5pwc5Tu/vRx2YNyIuSZZqjaXJXsaXqR77ZwXDecHUObwJo2uvHAdNsP33H1LQ9BLL1VsP
 TKewqbP71iZKowubFJrfUUhH8IE7XjNhPyO5EAPLRKFl7IpQ9cpiQZJ/21foht9l316PiEaB
 oSvH1J4L+OC8l+EQSSFs3+EQ2l8OfFSxqA9J5blWoEUo4lEm1Eh9FEABNs=
IronPort-HdrOrdr: A9a23:v2KWeam2VYQxJCpSqk89f8sf5qvpDfII3DAbv31ZSRFFG/FwWf
 re+cjzpiWE6wr5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQyVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK6foSizPZLz9P+qjkzEnlv4bjJ2wGd3AQV0iM1XYCNu6jeHcGOTWvjvcCfq
 ah2g==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.91,220,1647298800"; 
   d="scan'208";a="13928614"
X-MGA-submission: =?us-ascii?q?MDFo9diSgTh/xAZZ7dJgHwTxBRwWV73yf7Avxw?=
 =?us-ascii?q?1MWvI8Xo1C9mEwTgZRoiC53J6Mpt84KIa5g061Ag+L3sYS3vjMVT3Tjj?=
 =?us-ascii?q?FojlMUxbysHfK39RsqO7l//F8aFtcaTs1BAcVt1B+OdpZRQvTCcszQf3?=
 =?us-ascii?q?E+DCYVJQz4OURB+oq9/KbuKw=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 18:48:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1652374130;
	bh=M4UDlKRebsbsd9fHAw24fkcv1MtmUWX3qlEufb0SRbI=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=IbK/RtcqbtrRW1+MtlAhCWcoOH4vXaFwxFDy+WcA1BrlIAUGy5kKML7jtdq4IJ8oP
	 frfGanuQAmeuSKEj4xEteZwACKnuNZqAJFn+n9LFookVBfDLjd65G4bo3F6EJHejzk
	 pZ8z3X9E7l3Gcb2QUioK+sQqhW0kE5qnGiZuud3o=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.65.223]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MlsKH-1oFy5Z1PkZ-00ix2P; Thu, 12
 May 2022 18:48:50 +0200
Message-ID: <fc83d22c-cb5f-ef67-fb1c-43b63efec1e1@web.de>
Date: Thu, 12 May 2022 18:48:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-GB
To: Alessandro Carminati <alessandro.carminati@gmail.com>
Cc: cocci@inria.fr
References: <CAPp5cGQV6Lm7fwhUcVs6sqXrA00XYAem2ZopE1eFW_v2EExJQQ@mail.gmail.com>
 <alpine.DEB.2.22.394.2205091216530.2394@hadrien>
 <CAPp5cGRMAOanfvuhV1LAV9eZka8ZJHRPy6ncMwO=Q+C=GUA2gA@mail.gmail.com>
 <CAPp5cGS+ANKVuE+QThN=Byqm=BR0FotbCe7aQgjX77Ee65UDuQ@mail.gmail.com>
 <6a926cad-e15a-5c04-1fc9-34d20bd18618@web.de>
 <CAPp5cGQRKxk5RXn7a=7R3s4y=fsvi_O9aFUj6HudPSX+06-_2w@mail.gmail.com>
 <alpine.DEB.2.22.394.2205100957160.2667@hadrien>
 <CAPp5cGS+4snNh+8S3vFw01MMbUjYgpL2qm0tUPrZ1FUtK8bz9Q@mail.gmail.com>
 <alpine.DEB.2.22.394.2205101123120.2667@hadrien>
 <CAPp5cGQMuy3aM5cLYk4HH8Ny=uH_t2yhWasfmT2AS7M12YDiWA@mail.gmail.com>
 <alpine.DEB.2.22.394.2205101236050.2667@hadrien>
 <CAPp5cGQzYtDVjE-K_Vpt3cbqYW-cwNTLmt_KwdpMdds9L7rXug@mail.gmail.com>
 <a4e74094-c6de-d23f-4d42-3b68c73687ea@web.de>
 <CAPp5cGS1DTUwCi9jNpjY_cA+cbMML+J1YNhy6yqPZ0ju+q9Q-Q@mail.gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAPp5cGS1DTUwCi9jNpjY_cA+cbMML+J1YNhy6yqPZ0ju+q9Q-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:tuoxSy+cHsqAvsijzWVD/lNmKhn1ubr8vUVsYVuIshmB0Q7l7u/
 AjL4rj1VIQM14xVN1ICsufGfelisAag+nuDjgSvP0e3a3O0ogppefCxFRYQFxs/FaUGU8uI
 6PIkotzz3oR4RGyRkF1BD28k++bbGfFd+9fMsx48E3SbSYRFe19bMhOnL87sKqJlYOJVNw3
 UI3c3Opl7zVeLVRs2ef3A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QX9ZfB5St1I=:lb68JaarxgkmVkvIX1ocKf
 mctJ7Od9ODMrsEbcf0NwLyJDtdM7hETwZXeaUGSxPVmm/y6rPSDr0usxZSP0w6lcFLcFvGV+N
 KX4HaOgo/5lPbD6ABeVNUC4LV/WEtys4htIehL2uJyIR2coB9Uj+GHQ+5HIQgAO2UHWdlLyd+
 QEtcCmVuvicPIMwtiWok/0HXaNwyBmxzoHH78okHgWNspo5/FJHjBh34tBI4iUPmRoBKpBVk0
 E/Vb7N3amWaPMSs3p6bRPhYLY1Ejk/R6Gq5ssZiuuud+8qTMaE5WRkW4OGfZX5WHjQFeP4znO
 NXPXjoOTDF667sMHWpZ6auyrDzcKAqjiUvPEF8CSdgewXQ4T1X3K0wLMgE4QeDkDjntvFrPtb
 sdBNyQ5Kt66Z85c6d3DvtBu0zY9vVmqHI29/Hd0cfBGyv2cxb1dewsngKuO84z2v1rwSYer4J
 hyvku4p5Xjo8wULCqXBKlUeCtTKroxeFYMZzBihDgaVoHICJ5kHmvz80YdIxeXdiRWQ/lQRdT
 KlVsS5JGh57DXwN4ABzVdAiOD8VS9b6TGVgbSOIOSU5szPG2BAY1kOXNFayc35DJESPOf0r9x
 pMBNcXFFywxsZCESbaJVRZALicyx+k3z/Y7Ft+eTq5H5Khd++rLEm/Zi5Z3rl2yCW+egHi9B0
 nR/gCDjDk8bOZqR7STFWzMhYBOvxFWwab9tcHtu0YfwMCNifedhhA8O5DgI779BHSu8vq+aVh
 3y8F4Qk2+g6R4LpSrffM6HcP138EH0hTiWb/8rCmXwMHmxCFlTNqRnQXNHNAwrSEA3AEHI1Dx
 JzxOjkBB29iXZqKj5UJSD7DjOZVTmjfN57Xqcd5MLcimbOupIYMzDrPDQ12TgCOoPRjHEHZxt
 o/2kSwP89ZZr27+ZC4RRwvzRFbXovQRTZdiCYUk+XY09GP3ojAZUdS+78OSKXn2kc6HRdAyqP
 zEobOzHt5s1nHdN7TbPMSLlimZGzvmEtrFl+DSt0vRdYEmkJLo0p9POtI0rmCf51hmWBjF/01
 zpXxMHHzKDpEKLoidPEq4i7s5Jzf5a0PxFA8BZcxgcG+ygdAQVGVtStvDREAPnuWLT9BEbegL
 OXKLcSoE4VhZao=
Subject: Re: [cocci] List global variables with SmPL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 387
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-05/fc83d22c-cb5f-ef67-fb1c-43b63efec1e1%40web.de>


> Still, I do not want to monopolize it for my own purposes.


I find that you do not need to be so concerned here.



> So I put a halt to the discussion.


Would such an action hinder evolution for desirable improvements?

Regards,
Markus

