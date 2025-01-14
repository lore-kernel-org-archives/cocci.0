Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E8B9C02188
	for <cocci@archiver.kernel.org>; Fri, 17 Jan 2025 09:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=nt2Jn/KWMgmWCwgCI6AbOgRjlEfOQCPo8QfhrxmdZ28=;
  b=oW3i/k6RownlwOoJOHAHhyPs0WDx84fAeeieyJGFyJQ0jyPCVdoO7Nki
   jyWP5GaRfpKXVy/hbu1T6OOJCBsMBwguL66Hdi0wajKmyLXIm+u2Dou0D
   I+Aq5F6rQ6uLCaV3o+vf8Wu0CIwW2vWkpARO72qZHaFvuoAWH1oadBG8c
   w=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@redhat.com
X-IronPort-AV: E=Sophos;i="6.13,211,1732575600"; 
   d="scan'208,217";a="203646318"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Jan 2025 10:48:57 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7ABEFE0D3F; Fri, 17 Jan 2025 10:48:56 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id E49F8E0077
	for <cocci@sympa.inria.fr>; Tue, 14 Jan 2025 19:30:27 +0100 (CET)
IronPort-SDR: 6786ad43_pBIzyD1ze/EVpI6xKlxiK8yntbIpwTnwz7laqNGxZZ0Mhlw
 Q1yBvNRWsLS5BK/jQkOHspa5KCLunfyzCczsscQ==
X-IPAS-Result: =?us-ascii?q?A0FEAABnrIZng3yBCqpaHQEBAQEJARIBBQUBggEGAQsBg?=
 =?us-ascii?q?kOCCgQLSIRWgSOOKoIhA4tzi0+GVoF+DwEDAQsBAUQEAQEDBIUAAop0Ah4HA?=
 =?us-ascii?q?QQyBw4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBAQE5Bw47h?=
 =?us-ascii?q?XsNgmIBgSSBJgEBAQEBAQEBAQEBAQEBAQEBARcCDX0BAQEBAgESEQQZAQE3A?=
 =?us-ascii?q?QQLCwsNKgICIRIBBQEcBhMigl+CQiMDpioBboEFQopDAQEBeH8zgQGCDAEBB?=
 =?us-ascii?q?twfgWQJFIE0AYhNAYFcAg6HfHonG4FJRIFKgnU+gVKGTIJpgjdLgSiCWWeGV?=
 =?us-ascii?q?IMhiHyLXSYmAwcHDg0eSQ4BIQMmMywBVRMXCwcFgSlIAQIBgRMlgScFNUE5A?=
 =?us-ascii?q?YIMaUk3Ag0CNYIefIIrgiGCO4IYgi9HhA6FYoIUgWUDAxYQAYFzgTVuHUADC?=
 =?us-ascii?q?2ILPTcUG0ycITyDcXwTAUIJglqlCqEDhCWhYDOqU5h8qQMCCgcGESOBSwMwg?=
 =?us-ascii?q?VxNIxU7MQaCME8DGQ+OIRmDYb5XJTU8AgcBCgEBAwmPYoFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:7cwKkqzgzvGM4JBTx8J6t+dzzSrEfRIJ4+MujC+fZmUNrF6WrkVSn
 zcZXW7SM/uCNGfyL4h+a9zkoUoOvZOExtNlSlQ6rlhgHilAwSbnLYTAfx2oZ0t+DeWaERk5t
 51GAjXkBJppJpMJjk71atANlVEliefSAOCU5NfsYkhZXRVjRDoqlSVtkus4hp8AqdWiCmthg
 /uryyHkEAHjgmQc3l48sfrZ9Us25aiq41v0g3RnDRx1lA+G/5UqJMlHTU2BByOQapVZGOe8W
 9HCwNmRlo8O10pF5nuNy94XQ2VSKlLgFVDmZkl+B8BOtiN/Shkaic7XAhazhXB/0F1ll/gpo
 DlEWAfZpQ0BZsUgk8xFO/VU/r0X0QSrN9YrLFDm2fF/wXEqfFOwxMVXA1sPNrEp2blcK30X1
 NtFARc0O0Xra+KemNpXS8FxnYE4KdXzeY8SvnB+wCvISK98HdbGQqDH7tZDwHE7gcUm8fT2P
 pVBL2M3Kk2aMlsWYAt/5JEWxI9EglH2aCdZtluJvoIt7mTTxRA327/oWDbQUoXSG54JwRrD+
 Qoq+Uz1BiwCFMLHzQHZ83GM3r/DnDPWYa8rQejQGvlC2wDKlzNDWXX6T2CTqv6ygU+WQMNaM
 0VS+yw0rKF0+lbDczXmdwCj5WWBogZZV9dUEvM38hDIk/CIpQOYA2UPRyVdLtchsafaWADGy
 HfVmOPQCiZWu4Gkai223KvNjBTvEA8seDpqiTA/cSMJ5NzqoYcWhx3JT8p+HKPdsjETMW6uq
 9xthHdj74j/nfI2O7OHEUcrag9AS7DUVUsu4xnPG26o6gJnaZS0ItXytR7e7PNNJ4+CUh+Ku
 31sdymiAAImXcvleM+lGbRl8FSVCxCtbWe0bblHQsBJythV0yT/Fb28GRknTKuTDu4KeCXyf
 GjYsh5L6ZlYMROCNPAsPd3gUJx7lvG+TrwJs8w4iPIRO/CdkyfYpUlTibK4hAgBbWB1y/tva
 f93j+71Vi1KYUiY8NZGb7xAiO50lnFWKZL7QJH+wh+uyqbWYnmPVbdNOV6DdOEy5euFpg69z
 jqsH5Ti9vmra8WnOnO/2ddLczgidCFnbbio8JY/XrDYfWJb9JQJUKa5LUUJINU9x/w9eyah1
 i3VZ3K0P3Kl3CeYd1rWOig+AF4tNL4mxU8G0eUXFQ7A8xAejUyHt8/zrrNuJeB3pt9wh+V5V
 ecEcMimC/FCAGaPsTcEYJW36MQoeB23jEjcd2CocRouTa5GHgbpw97Dehew1S8sCiHsi9Ayj
 Yf93SzmQL0CZT9YMuDoVNyVwWmM4EctwNBJYxOQI/14Wlndz4xxGimg0t41O54tLDvA9Bu71
 iGXIwYqmtPKkr8M7eiT1LylrpioIcR6DEF1D2nW1pfoFCj4r06I455Mb/aMRh/ZDFjLwaSFY
 f4P6ePRK9gFoQp6iJV9GLNV0q4O3dvjiLtExABCHn+QTVCUJp5/A3uBh+9ji7Zsw+JHhA6IR
 U6/wNlWFrGXMsfDElRKBg4EbPyG5M4EiAvp8vU5D0Xr1hBZpIPdfx1pACCNryhBIJ9eEoAvm
 74hsfFLzT2PsEMhN9Legx1E82iJEGc7bJwmkZMnG67utBsgzwBTQJ7bCxKu2qq1Vfd3DhAIL
 AOX1Y34vJYN4mrZcnE2K2rB4voFu7QKpyJx7QEjI3anp4P7o8EZjTxrzCQPbwVKzx94/fp5F
 Up1OmZUe6if3Tdaq/JSfmKrGg1xIQGSoBWpwHBQl1/mX1GkU1LcIVZlKcOPxV0TzGZATAd9/
 LrD8XvUC2f2XcDu3xkdXVxuhOzjQOdQqCzDupGDNOaUE6YqZQHKhveVWlMJjB/8EOUNi1bhp
 9gy2MpVdov6Kj83j4ggLouRiIQrVxGPIVJdTcFb/K8mGX/WfBew02OsL3+dV9xsJfvY112RE
 O1re9xyUiqh2Ba0rjw0AbAGJ5l2lqUL4PsAYrbaGn4UgYCArzZGsIPiyQamvTUFG+5RqMcaL
 p/dUxmgEWbK3HtdpDLrnfl+Y2G9ZYEJWR340OWL6942LpMkstx3UEQMw7Cx7mS0Mgxmwkquh
 zn9RZTqls5s9Yc9uLHXMPRnJx61ItbNRui34FiNk9BRX+jub+bKlS0o82fCASoHHIE/edpNk
 Za1jOXWx2LA5bY/bHDYkcKOFo5P/sSDY9BUOcPWclhcvy+wd8/s7zBe+WricZ1tu/Fe7/mBW
 AGXRpaRd9kUetEF31xTSXFUPCg8ApTNTJXLhH2CvcXXLyMCwCr7LN+D3l34X1FxLyMnFcX3N
 V7phqyI+NtdkrVpODYFIPNXW7lDP17pXPodRe3b7DW3IDGhvQKfh+HEixEl1DDsD0uEGubc5
 bbuZED3VDa2iZHy4OBpia5AlTxJMy8lmsg1RFwXxPBugTPjDGImE/UUAa9bNr5qyB7NxLPKT
 xCTSlA9CBfNfyVOKjT9x9XBYj2xJMIzPvXBGzh42H/MNgmXAtqMDoI0o20kqz1zdyD4xe6qF
 cAG9zeidlKty5VuXqAI6ub9ne5jwejAy2kV/Vzm1fb/GAsaHa5AwUkJ8NChjsAbO5qleIT3y
 WkJqaRsXVr+UkvtCYNsdnpUBhwDrXa2lWluaCaKzd3WoJndx+pFoBE61ycfzZVbBPnm5pZXL
 Z80e4dJy3qb1nwape0ivNdBbWpcF6eQBsbjREP8bVR6okxzg1jL++sYkCYPRd1k8wlae78Ye
 v9A/FBmbHm4xIttNHF6BOnHF1+dkp7BMt0RsDPCmA==
IronPort-HdrOrdr: A9a23:nQ1TF65v+tetcmPlbgPXwEfXdLJyesId70hD6qm+c20rTiX4rb
 HcoB1/73TJYVkqKQkdcLy7SdC9qDbnhPhICOoqTNOftWvdyRGVxehZhOOJrAEIWReOkdK1vp
 0QDpSWZueAcWRSvILV5E2WH9483MKK6smT9Jzj5kYoYwUvRa8I1WdE48Wgc3GehjMpOXP0Lu
 v/2iLrzADMRV0nKuC6AnUOV/Lf4/nlvtbPTzBDJzNP0mWzpALtzL7/HxKRxApbdxxkhY4Y10
 KAsyGR3NTTjxk9oSWsp1M6O/9t6aXcIxJ4da/87/QoFg==
X-Talos-CUID: 9a23:HCjesWPus+kfXu5DBC5XzUEOI8sZQ16C513Mem6fVE9OcejA
X-Talos-MUID: 9a23:79Bn6AlbMtfwNDKfRoS7dnpuMPpww7r2DHtRkJYm45mINDxdAhqk2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,315,1728943200"; 
   d="scan'208,217";a="106347437"
X-MGA-submission: =?us-ascii?q?MDFFKXD2IuJi+TXjTXtSPFCXLzBZvhuAvVKdOG?=
 =?us-ascii?q?Wrb2p0C2oxmTyVX5aasgibeqTAq08C6JVn57tlaD7VRwGJdq1zK0/Rsh?=
 =?us-ascii?q?NoPnoQ7HgdoqvxTxzolYqm6CmJiC3162chvm6DWuGkJm+XLr/vDXbyST?=
 =?us-ascii?q?jHUAeMifng6Iaygiur5xIPYQ=3D=3D?=
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 19:30:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736879425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nt2Jn/KWMgmWCwgCI6AbOgRjlEfOQCPo8QfhrxmdZ28=;
	b=LYctsJqFCrnYvobl6XndYbFy2SZ8VZ28CrEPENXPL8l8lbh9tOGwewxwWmQDmf/fWav+9w
	yuEHN57hrkHIeghLqKpnN2LaWin+0pRD9go/jHGWTWVPNP8jbAcVChhmRPUuk1x4xEurYg
	iyYlG4EkorDvgatwtc14vDt6YjrQCXA=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-zkCj6kYuM9GVNqAM4ocQPA-1; Tue, 14 Jan 2025 13:30:23 -0500
X-MC-Unique: zkCj6kYuM9GVNqAM4ocQPA-1
X-Mimecast-MFC-AGG-ID: zkCj6kYuM9GVNqAM4ocQPA
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-e3fea893dc5so155973276.1
        for <cocci@inria.fr>; Tue, 14 Jan 2025 10:30:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736879423; x=1737484223;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nt2Jn/KWMgmWCwgCI6AbOgRjlEfOQCPo8QfhrxmdZ28=;
        b=JAty0QiaQuHHT4/Ss5QtLEN2C1WPiCJ3yg26CeNv6M9ipDVFSpdwuw5oIoBcd3be5A
         ZlXSKuEuLml1gbQsaVwzB1QKlEFSLQC0DnTPLOzGjsgXQ8NMoU1Lgvz9FBwLyWnZlKW6
         ctE0spTzMnYAeaDj+OjtOgyZFBN7/AoWLYKJ9IpXsxQH/7IoDyNPUaNy3gL+t7Djd5vA
         LEX5hDajPCDLFejB54SSh9ve3w/oAegvQ4OWOU+lCcUZGEZYxwFa1idflqp8Xab9JCsR
         5ePiuYl24C7fv2a82QinnZrTRjAS2YCft6DPLOOS9rDBQ9RKLmByKCs8raaaI+CHOCoK
         MYAQ==
X-Gm-Message-State: AOJu0YxLNVo+3WrzurxFBgH9XQw5mVPHr2EfmZsaxl7un4E63Q/WB2pS
	r6WI91SYYpUMHgu+6Ysx+Bv7PKRY0Bk7xWaV9gNH7vK3fAc+28w2ycGJZ1DDo9PSa4gVfdPiIBC
	lBT97kTr7xzpGMYOC+NccF7S7g+KQM9PzQ+Oo7RRXClEzjwMTV9jZwKnwWPM7NWFkxfiEtVLNfo
	ku72CsV98WPfYpZxc3Ux/NXpklAH14
X-Gm-Gg: ASbGncsvgZNMsoIakmjFPzfXTaH+gsmWneoXt32p9oMmAuGv4WLiN+XtEHgn3oCqWcj
	X4NoBDmD4vRRFny/R0e+5jdauxAnDXSNTHFOI
X-Received: by 2002:a25:a4aa:0:b0:e48:a3d7:89db with SMTP id 3f1490d57ef6-e578a18913amr17351276.13.1736879422779;
        Tue, 14 Jan 2025 10:30:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2ZsLPmUs18cHxQPB417zgkTf+xliJQ+wRliUzE8p4pHkTLJfe7rrpcfgUKv4f/3bD7/34J5Oq/ilcOG9jpN8=
X-Received: by 2002:a25:a4aa:0:b0:e48:a3d7:89db with SMTP id
 3f1490d57ef6-e578a18913amr17303276.13.1736879422425; Tue, 14 Jan 2025
 10:30:22 -0800 (PST)
MIME-Version: 1.0
References: <CAN9Xe3T2LjcD9Xr8vAGQWu5MUvVjr-eEaMhB-JauL5DW0aA9QQ@mail.gmail.com>
 <dcaf63e4-78bf-3111-8494-6380e6118fd8@inria.fr>
In-Reply-To: <dcaf63e4-78bf-3111-8494-6380e6118fd8@inria.fr>
From: Anusha Srivatsa <asrivats@redhat.com>
Date: Tue, 14 Jan 2025 12:28:51 -0500
X-Gm-Features: AbW1kvakgW5W2QcXTwXZZOFhI5BiibxGdLw--kMnuL3CT6RQHXfkoCNcTGBNkMM
Message-ID: <CAN9Xe3TBb2GYNeqL1f1_GTPT2W5J78gniK0ZTZJyLwJL=KydoQ@mail.gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr, Maxime Ripard <mripard@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8dU0iGF7taNOugOjnYPusb23aqHxSTn7ABuX-2UiQG8_1736879423
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000fdea8e062baec071"
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] Ellipses usage in line addition
Reply-To: Anusha Srivatsa <asrivats@redhat.com>
X-Loop: cocci@inria.fr
X-Sequence: 2211
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/CAN9Xe3TBb2GYNeqL1f1_GTPT2W5J78gniK0ZTZJyLwJL%3DKydoQ%40mail.gmail.com>

--000000000000fdea8e062baec071
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Julai, Thanks for the response. More info inline.

On Tue, Jan 14, 2025 at 12:50=E2=80=AFPM Julia Lawall <julia.lawall@inria.f=
r> wrote:

>
>
> On Tue, 14 Jan 2025, Anusha Srivatsa wrote:
>
> > Hi all,
> > Wanted to know if ellipses usage is not allowed in the lines that we
> want to add in the code. To be more precise,I want to replace
> mipi_dsi_generic_write_seq() usage with mipi_dsi_generic_write_seq_multi(=
) .
> > the coccinelle semantic patch that I am using is:
> > //rule_1 ->s/mipi_dsi_generic_write_seq/mipi_dsi_generic_write_seq_mult=
i
> > @@
> > identifier dsi_var,dsi_device;
> > @@
> > struct mipi_dsi_device *dsi_var =3D dsi_device;
> > +struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D dsi_var };
> > ...
> > -mipi_dsi_dcs_write_seq(dsi_var,...);
> > +mipi_dsi_dcs_write_seq_multi(&dsi_ctx,...);
> >
> > this throws:
> > init_defs_builtins: /usr/lib64/coccinelle/standard.h
> > lexical error: invalid in a + context: ...
> >   File "mipi.cocci", line 9, column 39, charpos =3D 298
> >   around =3D '...',
> >   whole content =3D +mipi_dsi_dcs_write_seq_multi(&dsi_ctx,...);
> >
> > Just commenting out the function replacing the snippet (i.e having only
> dsi_ctx being populated) works just fine. But the intended change is ofc
> the proper usage of the _multi API.
> >
> > Would be nice to know what is going wrong with this approach.
>
> Add a metavariable declaration like:
>
> expression list es;
>
> And then your change can be:
>
> -mipi_dsi_dcs_write_seq(dsi_var,es);
> +mipi_dsi_dcs_write_seq_multi(&dsi_ctx,es);
>
> This doesnt find any match ....skips through all files.

Another approach is to write:
>
> -mipi_dsi_dcs_write_seq(dsi_var,
> +mipi_dsi_dcs_write_seq_multi(&dsi_ctx,
>    ...);
>
>
This again throws the error : init_defs_builtins:
/usr/lib64/coccinelle/standard.h
lexical error: invalid in a + context: ...
  File "mipi_julia.cocci", line 8, column 39, charpos =3D 220
  around =3D '...',
  whole content =3D +mipi_dsi_dcs_write_seq_multi(&dsi_ctx,...);


Another issue is that you may have many calls to mipi_dsi_dcs_write_seq,
> or taht some code paths might not contain such a call.  You probably just
> want to make such a change whereever it occurs.  So you can write:
>
> Correct. Somehow the below approach : <...P...> ends up matching all
mipi_dsi_device *dsi_var declaration and adds a mipi_dsi_multi_ctx
declaration regardless of mipi_dsi_dcs_write_seq() being used ...

For the lexical error, should spatch be run with  some headers that I am
notexplicitly adding? I wonder if I am running with wrong options instead
of the semantic patch needing a tweak.

>
> @@
> identifier dsi_var,dsi_device;
> @@
> struct mipi_dsi_device *dsi_var =3D dsi_device;
> +struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D dsi_var };
> <...
> -mipi_dsi_dcs_write_seq(dsi_var,...);
> +mipi_dsi_dcs_write_seq_multi(&dsi_ctx,...);
> ...>
>
> The <... P ...> notation is like ... but it makes the change whereever th=
e
> pattern P occurs.
>
> Yes. spatch however disregarding the pattern ....not sure why

Regards,
Anusha

> julia

--000000000000fdea8e062baec071
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Julai, Thanks for the response. More info inline.<br>=
</div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr"=
 class=3D"gmail_attr">On Tue, Jan 14, 2025 at 12:50=E2=80=AFPM Julia Lawall=
 &lt;<a href=3D"mailto:julia.lawall@inria.fr">julia.lawall@inria.fr</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
<br>
On Tue, 14 Jan 2025, Anusha Srivatsa wrote:<br>
<br>
&gt; Hi all,<br>
&gt; Wanted to know if ellipses usage is not allowed in the lines that we w=
ant to add in the code. To be more precise,I want to replace mipi_dsi_gener=
ic_write_seq() usage with mipi_dsi_generic_write_seq_multi() .<br>
&gt; the coccinelle semantic patch that I am using is:<br>
&gt; //rule_1 -&gt;s/mipi_dsi_generic_write_seq/mipi_dsi_generic_write_seq_=
multi<br>
&gt; @@<br>
&gt; identifier dsi_var,dsi_device;<br>
&gt; @@<br>
&gt; struct mipi_dsi_device *dsi_var =3D dsi_device;<br>
&gt; +struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D dsi_var };<br>
&gt; ...<br>
&gt; -mipi_dsi_dcs_write_seq(dsi_var,...);<br>
&gt; +mipi_dsi_dcs_write_seq_multi(&amp;dsi_ctx,...);<br>
&gt;<br>
&gt; this throws:<br>
&gt; init_defs_builtins: /usr/lib64/coccinelle/standard.h<br>
&gt; lexical error: invalid in a + context: ...<br>
&gt; =C2=A0 File &quot;mipi.cocci&quot;, line 9, column 39, charpos =3D 298=
<br>
&gt; =C2=A0 around =3D &#39;...&#39;,<br>
&gt; =C2=A0 whole content =3D +mipi_dsi_dcs_write_seq_multi(&amp;dsi_ctx,..=
.);<br>
&gt;<br>
&gt; Just commenting out the function replacing the snippet (i.e having onl=
y dsi_ctx being populated) works just fine. But the intended change is ofc =
the proper usage of the _multi API.<br>
&gt;<br>
&gt; Would be nice to know what is going wrong with this approach.<br>
<br>
Add a metavariable declaration like:<br>
<br>
expression list es;<br>
<br>
And then your change can be:<br>
<br>
-mipi_dsi_dcs_write_seq(dsi_var,es);<br>
+mipi_dsi_dcs_write_seq_multi(&amp;dsi_ctx,es);<br>
<br></blockquote><div>This doesnt find any match ....skips through all file=
s. <br></div><div><br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">
Another approach is to write:<br>
<br>
-mipi_dsi_dcs_write_seq(dsi_var,<br>
+mipi_dsi_dcs_write_seq_multi(&amp;dsi_ctx,<br>
=C2=A0 =C2=A0...);<br>
<br></blockquote><div><br></div><div>This again throws the error : init_def=
s_builtins: /usr/lib64/coccinelle/standard.h<br>lexical error: invalid in a=
 + context: ...<br>=C2=A0 File &quot;mipi_julia.cocci&quot;, line 8, column=
 39, charpos =3D 220<br>=C2=A0 around =3D &#39;...&#39;,<br>=C2=A0 whole co=
ntent =3D +mipi_dsi_dcs_write_seq_multi(&amp;dsi_ctx,...);</div><div><br></=
div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Another issue is that you may have many calls to mipi_dsi_dcs_write_seq,<br=
>
or taht some code paths might not contain such a call.=C2=A0 You probably j=
ust<br>
want to make such a change whereever it occurs.=C2=A0 So you can write:<br>
<br></blockquote><div>Correct. Somehow the below approach : &lt;...P...&gt;=
 ends up matching all mipi_dsi_device *dsi_var declaration and adds a mipi_=
dsi_multi_ctx declaration regardless of mipi_dsi_dcs_write_seq() being used=
 ... <br></div><div><br></div><div>For the lexical error, should spatch be =
run with=C2=A0 some headers that I am notexplicitly adding? I wonder if I a=
m running with wrong options instead of the semantic patch needing a tweak.=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
@@<br>
identifier dsi_var,dsi_device;<br>
@@<br>
struct mipi_dsi_device *dsi_var =3D dsi_device;<br>
+struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D dsi_var };<br>
&lt;...<br>
-mipi_dsi_dcs_write_seq(dsi_var,...);<br>
+mipi_dsi_dcs_write_seq_multi(&amp;dsi_ctx,...);<br>
...&gt;<br>
<br>
The &lt;... P ...&gt; notation is like ... but it makes the change whereeve=
r the<br>
pattern P occurs.<br>
<br></blockquote><div>Yes. spatch however disregarding the pattern ....not =
sure why</div><div><br></div><div>Regards,</div><div>Anusha <br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
julia</blockquote></div></div>

--000000000000fdea8e062baec071--

