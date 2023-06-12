Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEE8BC88CB4
	for <cocci@archiver.kernel.org>; Mon, 12 Jun 2023 14:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=+okEL26aCtJNHquSWnTxOQH+sMpus8fE+I5Yy+s2Ohw=;
  b=Wl0FMkaX2ghMRuiJkDgc3hSCYLx/imViY7i/v4OiXFWGqXzQHfFkFEI6
   SwNjBydOOZ7BbRnLNPbAqtK+XK6/eVUVB9Q9mFBQLK5I0asEvQcDVosKd
   OcuZ9UQblXmNxkA3kq3NGWUob+03xW49pyV06MeBM8a9Nsvx0Moh9a26W
   4=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
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
X-IronPort-AV: E=Sophos;i="6.00,236,1681164000"; 
   d="scan'208";a="112462159"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Jun 2023 16:01:14 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 58E56E0CCC; Mon, 12 Jun 2023 16:01:13 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 4DE33E00BA
	for <cocci@sympa.inria.fr>; Mon, 12 Jun 2023 16:01:09 +0200 (CEST)
IronPort-SDR: 64872524_u+P0EZYCyZUq+5cQV9Nij9RZTHnDgyaoPiZWBiG8freqMQX
 /nMsAi+c880qJK5xlOYLbtoaZj5BgfULfNDe+ow==
X-IPAS-Result: =?us-ascii?q?A0EyAAADJIdkhw4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYIueFMwBAtHhFKIHYk0hDSHMIdFhGiEBIFWgUA+DwEDAQ1BAQIEA?=
 =?us-ascii?q?QEDBIFMgzMChXUCHQcBBDAJDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBA?=
 =?us-ascii?q?gQFAQIQAQEBIxcHDhAnhWgNgjcpARFkgQgBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBARICRz8BAgIBIwQZAQERJgEECwsaAiYCAlcGAQwIAQGCeoIoAQMOIweuX?=
 =?us-ascii?q?n8zgQGCCAEBBpwOHywiVYFfCYEVLQGNLoM3eicPgVVEgTyDBD6ERINbgmeOJ?=
 =?us-ascii?q?Y9hgShvgR6BIn8CCQIRZ4EICF6BcUACDVMLC2OBHFI9gUYCAhEpExQFTXsdA?=
 =?us-ascii?q?wcEAoEFEC8HBDIJFQkGCRgYFycGUQctJAkTFUIEg1gKgQ0/FQ4RglstNkMbL?=
 =?us-ascii?q?iUEDgMZKx1AAgELcD01BgMLHwYmAR4CKYFXMFhwCiQkomgHpH6iCjUHgjCBW?=
 =?us-ascii?q?4FdDJ8cBhMvg26TJg4Gki0uhzmQLyCoF4FjOoFcMxokgzZPAxkPjiAZhA6PS?=
 =?us-ascii?q?D80OwIHAQoBAQMJhUYBAYV+AQE?=
IronPort-PHdr: A9a23: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
 V0EzOGgRWz8HpL20QpuZwsj9Lk=
IronPort-Data: A9a23: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
 R/yN5Ew0tWMLklVeNsu
IronPort-HdrOrdr: A9a23:bbGqb6DHwcSXMcTlHel455DYdb4zR+YMi2TDGXoBKiC9Afbo8/
 xG+85rrSMc6QxhIU3I/OrqBEDuexzhHPJOkO4s1PKZLW/bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QEZSWY+eAaGSS4/yb3CCFM5IH3MSN9ryuiNzT1nF3UGhRGtxdBktCazpyCSdNNXJ77HcCZe
 ChDkErnVCdRUg=
X-Talos-CUID: 9a23:zPdWqWwWWZncqmxrKrRWBgUrHP8Mb0Pc00zeOl+qEkgyErvLZHKPrfY=
X-Talos-MUID: 9a23:fRPdbQSIETdiZNySRXTCmiEzKsxZxJ+iI0ATj48NvdXDBydJbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.00,236,1681164000"; 
   d="scan'208";a="58499077"
X-MGA-submission: =?us-ascii?q?MDH6prJN+BCOcfn0JrihbAnsIPvs0cK2K7wV3P?=
 =?us-ascii?q?qn7sMhKwmaf0n6O/3uuRoxCoOl9/9hF2eK64XXu9GFvcJIBMicRw+huW?=
 =?us-ascii?q?oTspyX6DSGde+9W5MgLIky6DXSmyuGVciXPrqJPgXizBiutOEf7nhZsw?=
 =?us-ascii?q?uVHGqBPG6OPgdHlzl40LDhdQ=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 16:01:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1686578460; x=1687183260; i=markus.elfring@web.de;
 bh=3H9vPymDYsf8Jm/nGBr9ehLJ3rvWNhPcHqI8HEMcTr4=;
 h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:In-Reply-To;
 b=Ei2DpfsxNrQU3cS/r3uPxhSRMdPSZRYgOrf/rgBroG8OOW0MZ6teSfKPbU+YTquhpKTaW2h
 m3Nbf/rKgD/DfUIzCZAu0IDJuEU9VL4pPQu6BhJ2MV9BF2Uony1Aqio8amPosrkLImQNg6LKN
 UjmHqsIeuoADQMuT2GEt/GHTSDB2/DcE9Jk7FlpGcLfIhvSJFw/dRxgsmQVw0eTvtZRd0NdkY
 jrCyfT28F6gfxd6CO06c4SpfHdcZMgcq5WC1x0Kfdi4t/r8bxfp7dMkkSfpiTOoEnXSn5dz0i
 +CEcYOM7UYvAB2oXH43DAQ0M4HBpB5lSPQNIvfPn0frsn01WlY/w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MnX5F-1ph2GP3hw5-00j6hd; Mon, 12
 Jun 2023 16:01:00 +0200
Message-ID: <fca44dcf-e632-fed6-aee9-03a5b0c6b1d9@web.de>
Date: Mon, 12 Jun 2023 16:01:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To: kernel-janitors@vger.kernel.org, s32@nxp.com, linux-gpio@vger.kernel.org,
 opensource.kernel@vivo.com, Chester Lin <clin@suse.com>,
 Linus Walleij <linus.walleij@linaro.org>, Lu Hongfei <luhongfei@vivo.com>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <20230606070201.14249-1-luhongfei@vivo.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20230606070201.14249-1-luhongfei@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aMsbMYYWpM/k+nckgyAy7/WTQkiPkoXQ68McLSfS/18/cKUQyv/
 EZqkJNTF6AXnDtO8+D++s8VJVOKG7OQNLBWDb/ywlG7FdYVYbcP4501o/Zz9tjrZo4aaZ6k
 qCNCQ0R2XJvivMKmGlOokvNc77uDWqAABUGS/bZdpcf9C9VDlGjr4YSfsXnSVFDgD1EaEyG
 JTnMQ2CfTdTFVzF8yjohg==
UI-OutboundReport: notjunk:1;M01:P0:4lyTzoABKJU=;AW6wcGf5lLQKH7jl7rTqi0T9COr
 x80XoA3Q1k/XdE/7MTR+lhg18h4gLHorN5O6DZTwVkKazy8CJ7s9GCOHWnY6p0HB0g0jjQCcj
 AqXgMP1OTaKCHNwDePDrPx5nVnaeC0FNM51ZbdZYRHq/+FMt7P1Fuf5wDmMSx97dG5MY4HQ/W
 Nct5SO5J3H0tjAS6yj483ZW/znp7Ab7g1SKHUo3bbrUE3/wbwIy7RTJUMqTdRPJx7wVCHDN9M
 ajeJ9r9+kehFVTdpbpi62/p3rBdT8UBwX7ZQcWLMHeGr3AJ6+QPkxPIptumvRvYhSkZ1QKCtR
 ZP0+zkwMRGFmS6kQlIPJd0dZQ1TpYR5jCnrnFHLR8IHTLPNSIU6xB0pF6558JjaZVmWL4hkoE
 1CvaRmIsKI0itwHeNm/wGPPzWYmKHZNkejlUL6D246P4gg57Eo+FKj1JRBJBLXZ3iMBkGQ1UV
 QgkWqXGDq+XbIRXPdIC1Y5zNhsPHN3FuCiUxgG6qQX+wuucv3hjYUWD7fzVYZp8TbdTXqOH+v
 w+Bp2yG4NAbH0Zi4G3ipug6Fjj1ZYeZqShA3JkERLtwXgF0sY4ipwgGDHvVLl2oeBV9ULXzTd
 GgyUlwtIOeTGb16yWQJRmTO0C7+BFXqr7de+YGb6jhMyckh82VqnVoGCagYNRmxNkG6qruKo0
 mcNHCI2tnsbF3mEUliThjGVYjduRa80jVne26FAZMmN1suaDyeQhEJ9pGYqaMBGhmA+fgeziS
 OHOTKZHN11VA4Epn+zRhigobcTdelyYK4QN9UVkXlkXgMeMZZ0KDSelqyz56574OwG2xnRQl/
 +bvOmjSCvYJuLo+QX6DutwpUFS7Btz6T+T5SlA0Ylrr3b8FaIF5qN8NlWWDmI47gjZJEN8Aov
 SOnY6idc793xBKvC4RrVH72BshfJKpXbqnD+IBiT/GJwdsH1sb02k0XVbeUfMsCZi89vSuYO4
 Hlk2mw==
Subject: Re: [cocci] [PATCH] pinctrl: nxp: Fix resource leaks in
 for_each_child_of_node() loops
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1177
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-06/fca44dcf-e632-fed6-aee9-03a5b0c6b1d9%40web.de>

> Ensure child node references are decremented properly in the error path.
=E2=80=A6
> +++ b/drivers/pinctrl/nxp/pinctrl-s32cc.c
> @@ -279,8 +279,10 @@ static int s32_dt_node_to_map(struct pinctrl_dev *p=
ctldev,
>  		ret =3D s32_dt_group_node_to_map(pctldev, np, map,
>  					       &reserved_maps, num_maps,
>  					       np_config->name);
> -		if (ret < 0)
> +		if (ret < 0) {
> +			of_node_put(np);
>  			break;
> +		}
>  	}
>
>  	if (ret)

May the same error predicate be applied at two places here?

Regards,
Markus
