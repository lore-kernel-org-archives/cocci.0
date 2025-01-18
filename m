Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27BB3C02185
	for <cocci@archiver.kernel.org>; Sat, 18 Jan 2025 10:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=V24zjCfEk92Q3Cj+uCYD6TfhHjSQrCtg47NncHvU0/E=;
  b=X2gzfftMY+y24FZP2CSZhAi+SCLEOwJ9VtsDAVYzrxsFilSE2V/82nl+
   Ta5gellsVtDP3rKrL0mSQfJrTT824bvzFxFtpdkq4Nf5KQp+zt4NYGjcz
   rMiXiotXVURE66C41VHF4ucxQe1CKNzWv/2aRIVfO54hB2sdi3j2BtQBs
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.13,214,1732575600"; 
   d="scan'208";a="203798393"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Jan 2025 11:09:28 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D99F7E007A; Sat, 18 Jan 2025 11:09:27 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 8283FE0077
	for <cocci@sympa.inria.fr>; Sat, 18 Jan 2025 11:09:25 +0100 (CET)
IronPort-SDR: 678b7dd5_sU2a3GjmmytUZdLXJ65tDYFJqkqK3qRDVz8ELRM0ecgw1XY
 9FIJy+VpKf7EN33bXUnUpv5c+v7H7ypZ8V8Ux2Q==
X-IPAS-Result: =?us-ascii?q?A0ECEQCCfYtngAQP49RaHgEBCxIMQIFIC4JEYnUzBAtIh?=
 =?us-ascii?q?FaPToF0hGuHO4dWiHaDVA8BAwENQQECBAEBAwSFAAKKdAIeBwEEMwYOAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABATsHDgoxhXsNgmIBgSSBJ?=
 =?us-ascii?q?gEBAQEBAQEBAQEBAR0CR0QCAQMjHQEBESYBDwsODAImAgJWBgEUAQGCfYIwA?=
 =?us-ascii?q?QMxB7RegTKBAYIMAQEG2lsfLCJXgWQJgRouhWuCYwGGJoQ8Jw+BVUSBPIMDP?=
 =?us-ascii?q?oRDg1uCaYI2hExnn1NSexwDWSwBVRMXCwcFgSlIAy02MSSBJgU1QTqCDGlJN?=
 =?us-ascii?q?wINAjWCHiRYgitrBAWBLYI9hEWEUYVighSBZQMDFhABgyd+HzAdQAIBC209N?=
 =?us-ascii?q?wkLGwY9nRrOAzQHgjiBZoFjDJ9cBhMvg3GTUw4GknuYfCKpC4F9JIFcMxokg?=
 =?us-ascii?q?zZPAxkPjiGELb1dQjU8AgcBCgEBAwmFRgEBilOBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 FU=
IronPort-HdrOrdr: A9a23:mQqGT6wbruf5m8s3u84xKrPw+L1zdoMgy1knxilNoNJuA6ilfr
 OV7ZEmPHjP+U4ssRAb6Km90cy7Kk80mqQb3WB8B8bEYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 pdmupFeb/N5DNB7foSjjPIcOoI/PnC1ry0juHDyHpXQRhtcLwI1XYFNu/WKCxLrBItP+tDKH
 Nw3Ls8m9IqFE58UviG
X-Talos-CUID: 9a23:1Cg8TW3Bf2ssGaHO7jyzIrxfM5kUQD7XylbsfU7jLT0zZ6KRaXLPwfYx
X-Talos-MUID: =?us-ascii?q?9a23=3AVgm1cQ89FNF3div/qCPGBLWQf5lZ8oCAL2Zdra4?=
 =?us-ascii?q?HhfWqCDwpFRfHsiviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,214,1732575600"; 
   d="scan'208";a="203798387"
X-MGA-submission: =?us-ascii?q?MDHzSRrJtZFT8GYxOiXZY4xodBBerj/8fZlStc?=
 =?us-ascii?q?xoz+AsB7FLSppwHaz7ibfj3PLEIj1IOJBq+eEBX4+jQ4qlWgfHOTRqhE?=
 =?us-ascii?q?JUFhnpG5e9suAZdmPD8m5tWmv4TMYQXWLIbqNAoNmoOYug3uuO/QCj7s?=
 =?us-ascii?q?3p3C1oFYn9E9gw2qSpdajdhg=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2025 11:09:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1737194962; x=1737799762; i=markus.elfring@web.de;
	bh=V24zjCfEk92Q3Cj+uCYD6TfhHjSQrCtg47NncHvU0/E=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=XKW24F1W59J+H6LVNXYJApHFp540Sp81UyJUeFU945Qx01COSLAjrr6vZ4FmYUNc
	 lr2IpPCVNP73sbG9HKHpoGJa7tvfFj2gFgjIdJScxN/GOtylHnWpiVaj5TrwnQ2cs
	 UqFG5CpF5u5ygBAXkrX0mrCosa/OI24YYLTT9t3WEGJzCzos+YfERDzpX0UYIz/zP
	 8H1XCzvsEr/aqDZ097PqgXjI3L1YFj20OZ0AFPkHr9tqkIGY7Fn6Ub49jQZVmcMVj
	 Vfcgomw06JCyNu0O5klnvUJD3xoqyVZuHJHzfj40I2j5n32NKeKgCdqqx3BR9CUM7
	 XTQDxa8b9yRC5Dm7dw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.37]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MdwJO-1t0Zxk0STG-00fHql; Sat, 18
 Jan 2025 11:09:22 +0100
Message-ID: <7252d34c-8d6d-47ee-9dd7-b5a54fdb0f02@web.de>
Date: Sat, 18 Jan 2025 11:09:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Anusha Srivatsa <asrivats@redhat.com>, cocci@inria.fr
References: <CAN9Xe3T2LjcD9Xr8vAGQWu5MUvVjr-eEaMhB-JauL5DW0aA9QQ@mail.gmail.com>
Content-Language: en-GB
Cc: Maxime Ripard <mripard@redhat.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAN9Xe3T2LjcD9Xr8vAGQWu5MUvVjr-eEaMhB-JauL5DW0aA9QQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+D8W97v1e50T3BqrqHCHJQz1SOPHpqd2WxeNXQ0ovPGBKHIlnPs
 eIcteITCvnsd1YZ798FHhWj2n69LWkJ2jPJZC5YFBMHvZuwUIDfVU8xhlITdbvENUS2OEOX
 YHkFooRRH1eXKJ9QaB20NEe3LU6Tl3SMV0TBtsLGIzfWd8thSpBKKZ76zSbCYlQLwnicEt/
 +BOrXBRYSR6/BZgDkTLag==
UI-OutboundReport: notjunk:1;M01:P0:xe9Qidxuu6s=;c9YKp873VUaazHFeoQNcxYg3Izm
 nCMgKOn2xVM9NycMyDukODJCoLf6Po6ZIlDdi7H8zt+uwxQjtBRlHabnzMB/wGe/Wg1eNEDba
 t+oHRwAHvcYC6tn4TaoOEPnd404P/Lt0PG84lkPrK3HaT88Wfb2d6xX1ePbd37NJVGL0xWBko
 z7WcGYb3/aVWqfPSj1Xu+OiK+dpW4P/XBbb0x4wGGCyZNt47hGysPimq12XlZSkUDtSVTn/A2
 vV5NFyv6ihSwjsvkRFVsBqB3bJ2LlaGxxQqBqUajSYSmY/HL/VpFRoqmoo1cJd6Faf6kfjX9Y
 bMvlO3VnAkJA4ToPdJByQHlYqjBnRM7dbZVwSpc4gRU/wjixw942CeEGObjdrzAhPJOiJ9Ot7
 PaRf6kVYIL8p4Gi20FPvDWVZUfGru0GgzbFAhWbJc4dvFM8pyKx52lo7QVjts1EYqHLfNlUc6
 VSefxdjKGCKnjDhgzPOTer/J43lknbdDmwelvAb6SSXbuFOl+7+HY9m2D3hg9NT8z2/kDqE20
 yVUtUoEsHNbwCH9/GbDuRIbvfwTxxSEai62dUNf0AR6WWzUZ448uPiOjZRKInmdRc1HlB0mZH
 FDITCMd/7nd9HHxa0sSYBYoZnGEqNfMKS59r0W6o3xz8lB144CO47NpfkDG0KrWdP7n0EhKFG
 IPJ7jNWP/hSuL7Q3QMTpoPdjQxJbue5JVH3dRiBgPrAZyUsLly6hZJWNPM1NaLIEid2c+9BHK
 tsqblfw3saRzUGNg4Bb0TcrlssfxNuUiVYrNcO+Sk4qk09NAyXLHKaJQy940rdzYcothf08ZV
 KjZ3TRhOo+MvE6QSkemurIdFYYjXlzIU4/UYejBoPME+7oUIKX+ZZQj+C44K0WqznRfzAW7X4
 8i7J6RxxsjrG9YwmvZqucIC08QMAJsGoQLobv8tDms+nSQCFmXBFgO4DgyJVrWBfDWz0/p+Jx
 RyoF5XiNs0PSeRHFyw3/vnfhaIZIXC91VlkB/m7SPa4IXQRHOidOCvKPXMU0ek422J/SKXQZh
 jwQe0D2rqxia8AATl2vqZMO3boTnc5v+l0HRZFlrDqZoTTmubgDZiDUdGWapB2goLbywDqSAy
 BP2WOII6a6BXEQsXftLJb5n/QfwTdnEgIaDw6fP7J5vuFQT6g1G/JNqS+6vVD9vs4/ft0WKIZ
 4m4sMuJeIWuOJsGq0kPrs9x+1kW1r8h7jjEgivMXl0w==
Subject: Re: [cocci] Ellipses usage in line addition
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2216
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/7252d34c-8d6d-47ee-9dd7-b5a54fdb0f02%40web.de>

=E2=80=A6
> Would be nice to know what is going wrong with this approach.

Will you get further development ideas from another script variant
for the semantic patch language like the following?


@adjustment@
identifier var;
expression device;
@@
 struct mipi_dsi_device * var =3D device;
+struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D var };
 <+...
-mipi_dsi_dcs_write_seq(var
+mipi_dsi_dcs_write_seq_multi(&dsi_ctx
                        , ...);
 ...+>


Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> spatch =E2=80=
=A6/Projekte/Coccinelle/Probe/suggestion_for_Anusha_Srivatsa2.cocci -j4 -d=
ir drivers/gpu/drm/panel
=E2=80=A6


Regards,
Markus
