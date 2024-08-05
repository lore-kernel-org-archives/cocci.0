Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E1B9C3DA7F
	for <cocci@archiver.kernel.org>; Mon,  5 Aug 2024 11:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=UnyfvG/zuuHEws6jhkB4XpTJWrkdhwPFoIfuRhEN6j0=;
  b=OdZmJQ/DCauROyAPOT5wIf/tmPidoFEZFSWCUxCOjRW2vQsusJt40BKl
   udZ/zcL0nhQPblfuEG4Y2dhVX1347Y/AQSF9IBU5wIZaHj51z1BgorvBa
   KgBOb6m2JFAbTRLH/3FWsnLSSJwD/pW+8uQdwNMvAbr34/PDP2nKO/DxX
   o=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.09,264,1716242400"; 
   d="scan'208";a="178135915"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Aug 2024 13:27:46 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id BAA19E013D; Mon,  5 Aug 2024 13:27:45 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 23559E0035
	for <cocci@sympa.inria.fr>; Mon,  5 Aug 2024 13:27:43 +0200 (CEST)
IronPort-SDR: 66b0b72e_bIULfcFF+qacPEecVz454WmeCqg4FA693Wk3HxTYsYCIhkh
 TuptqW8x1QGA2oGmPe8rBohRsoMOKRCcGE0m2WQ==
X-IPAS-Result: =?us-ascii?q?A0EhAABAtrBmhwwR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYJDYiFUMwQLSIRWiB2HL4IlhDuHOodRikuBQD4PAQMBDUEBAgQBA?=
 =?us-ascii?q?QMEgguCdAKJSgIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECB?=
 =?us-ascii?q?AYBAhABAQE6Bw47hXUNgmcBEIESgSYBAQEBAQEBAQEBAQEBAQEBAQEXAkdEA?=
 =?us-ascii?q?QEBAgEjHQEBESYBBAsLGgImAgJWBgEUAQGCfIIwAQMOIwetc4EygQGCDAEBB?=
 =?us-ascii?q?tpZHywiV4FjCYEaLgGISQGFYgGDfHonD4FVRIEVJwuCRzE+iB6CaZImin98J?=
 =?us-ascii?q?k2PblJ7HANZIRMBVRMXCwkFiUsKgyMpgUsmhBgIgS0Vg2WBawxhh3JigQ6BP?=
 =?us-ascii?q?oFfAUmCd0qDZ4F/QgI/gmNXHUACAQttPTUJCxsGPaoTgj/FWzQHgjaBYoFjD?=
 =?us-ascii?q?J9PBhMvlzwOBpJumHAiqHSBZzqBXDMaJIM2TwMZD44hGYQUxzlBNTsCBwEKA?=
 =?us-ascii?q?QEDCYVGAQGGXIFLAQE?=
IronPort-PHdr: A9a23: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
 t3Iib61NzpItd7Zr5N0Og==
IronPort-Data: A9a23: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
 ITteV15fQ==
IronPort-HdrOrdr: A9a23:5siX3q6KhffzkY4SVgPXwBzXdLJyesId70hD6qm+c202TiXqrb
 HLoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhWotKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkaNDSaNzhHZKjBkWqFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkjuRRjz7LqVsLjM2fqbR+a
 DsnPauLFebE0gqUg==
X-Talos-CUID: 9a23:de9thmObFltYg+5DZS1s+xY7N8sZa3jc1E33LUyBAHQ2R+jA
X-Talos-MUID: 9a23:8xfA9Qj0mdnsr2pisNOllMMpMf5a/5qEVho0g7I8msTfPipKARCwk2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.09,264,1716242400"; 
   d="scan'208";a="93592142"
X-MGA-submission: =?us-ascii?q?MDFWh5D1GVjEVHTUYRCcDnelNtxfScYBB+TPsE?=
 =?us-ascii?q?Vci9jIU9ZnB6smUmdsUYV1c/hNRFEL+e0m2AkF52m+A5YNRYLYKkxUe3?=
 =?us-ascii?q?PykLitWT7d/l3aBv3+zPiCn3DMoqGYziZ6H00e8/lnvS2LPb9ThMJthB?=
 =?us-ascii?q?oFqmqXaAEySajWMhpLWC9GVw=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 13:27:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1722857260; x=1723462060; i=markus.elfring@web.de;
	bh=UnyfvG/zuuHEws6jhkB4XpTJWrkdhwPFoIfuRhEN6j0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=NiWRfn1SZaK1OxX0EQCBopGXJI46Jc4ca33phmfdxr4IFTicoWfEleYMxVpSQ9mI
	 AVsKmk9sVs0JKaG60Y4uU1B0HHBlcaBFiBho9rUUtV8nxTVJk5Yv6NL52OT7nuhdW
	 iFp74uLV5Fysh7VTUMLwY8TKVkwLaeEg6/koG9WExfwhhj5x8Ww2dwAsREUg5juQd
	 BgZpoqqj/JcU8FPjXsohkOUX4YUv7pXwXVR7ygsjMf8H4g6MdDHEjpkgex3b31sjA
	 vLesw0Xl4XK8VB+yW5znatJwd0Tfw80Z0obGh6kLepuuw3mJXbMqCZBCXP/1Dv6rE
	 G4cRvU3Vgoo20/5eHQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MzkOR-1sF7fh2NAP-00zVjn; Mon, 05
 Aug 2024 13:27:40 +0200
Message-ID: <fdc397c4-8823-46c3-b471-382ebb483900@web.de>
Date: Mon, 5 Aug 2024 13:27:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ricardo Ribalda <ribalda@chromium.org>,
 Julia Lawall <Julia.Lawall@inria.fr>
Cc: cocci@inria.fr
References: <CANiDSCvmboKBK=Z7uS9tnN_LcPA16rx0j_iWeEoQ=jO+pEgLiA@mail.gmail.com>
 <98a94966-14c6-45c4-99d8-471f65b292ea@web.de>
 <CANiDSCuJHTsHsFLbMGC1S47myfReZX7JBfGZFVknj8y=4-QLCA@mail.gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CANiDSCuJHTsHsFLbMGC1S47myfReZX7JBfGZFVknj8y=4-QLCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:90FJkBwJJJ2MGzKuQxR6BhCxmeHQ1DyLjLC/XQXiw1I7NEdUbBf
 W2kgqBMLf9rTBTT237Aa9ajP5XJNFNZhlU1Pw+4H5y6Fvh6iyJtIvRGPd5CbmtiysSXisb8
 njv/8sVixDZ6nTvpE7DV8PHrohh0ILfJNKeRQoH+rts1zE3gW9WC4x/LngyskKSqParw8r5
 cFrDg8zXhlHhqyeRZA5gA==
UI-OutboundReport: notjunk:1;M01:P0:PMzOtkwPszk=;nIUk8i52INwzTpa8xwEsY8WqyS9
 tku4gr66VLC/KkVMz5BEBd3fwJs/Aq55fYTsFUVKfB8RCkq4kJQpZTZWWYCOlGZLAMdNnyeH7
 32BgG1Fnxucbd8jY21NY2MSTn9Qr2scMv141YQzI06ijmKS7x6ih3SL7yeWCR+r18WjYB78+p
 kVP2MIF9Ext7z5JicLXSxf0/aXSxqABgFULt2udKk9aoCIILRbOEoEI6c8QMMlp/1Q/eIJrL/
 HbEmv2uNR4g5C6MaE5RS7pbgpNldP13ELxesqOQdh5g4oHW1866yWkxtBHi09jPAFcniAxncg
 zGberKduH82IBU7mUAO+WGbIIJgnSnqd+iMRPn/7f0LKXLUGLlCD2ndcIC03PUBsYLhTmXMVQ
 KTQfqWSP0dptlQol/5lRUpTK69lm3q3g0xrqDroAviItmamyqnENPJAl9TF2pmTBPhNvp+nnp
 wiG5vKCPgbjlP8FIihQdTbrZVtsUwpYh/Y1honL35hxZ4595xCWMhIx2atCtEV5rnYgC+PwLY
 riBwgQ4Q3kJ/94HDnXjRaE0BZlez7WOlnrrQNUAyiNLHcDAiR+YaWw40Ry0jhDgM7d8cBHfJj
 oG+doNsU0g45Ld3+figfwqgSXXVFLxCqtjkm1ePnbLHPZXoWrFyKPks/eABm5jgT7w37X9l/o
 BAmt+2AGb9WwfvEWbKQzP/b2+3fV5OpAwJtDY5ePyyBVhdkzRxXsRcwlpK7+hbS2j80cxh2UD
 ZFp/Ayw6v2cvrdLS43yk2PTK3SsfWQTTnp4qUNvDcwfw77P8381xMVZRW0arj1vUDGg3+yS3v
 Shmx5GcPPL5Mmk/FQx4iF2DQ==
Subject: Re: [cocci] Cocci MUCH more slow after 6.11
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1833
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-08/fdc397c4-8823-46c3-b471-382ebb483900%40web.de>

> It seems to be related to the cocci version, and not the kernel version.
>
> Debian updated it recently from 1.1.1 to 1.2.

Thanks for such background information.


> These are my results for the same kernel code:
>
>
> root@a361d9092793:/workdir# time make coccicheck M=3Ddrivers/media/
> MODE=3Dreport V=3D1  > 1.1.1.txt
>
> real    1m59.021s
> user    53m53.038s
> sys     2m17.171s
=E2=80=A6
> root@a361d9092793:/workdir# time make coccicheck M=3Ddrivers/media/
> MODE=3Dreport V=3D1  > 1.2.txt
>
> real    15m0.552s
> user    371m28.976s
> sys     3m32.884s

Are there any possibilities to increase the measurement granularity for
affected SmPL scripts?
Would you like to compare software run time characteristics in more detail
(in parallel) also according to each SmPL script?

Regards,
Markus
