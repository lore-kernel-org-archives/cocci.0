Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEF37CCFA1A
	for <cocci@archiver.kernel.org>; Wed, 12 Nov 2025 13:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=wwjbzODtZ/FCv3dpzDz42ZyJn9ISYeUI/1GjGv1kjog=;
  b=CcTvFLsQBW+RgaXvyxqf0OaepJDzq3FW3EeIUkcZxokdmhE6k8JHEorA
   z3Eilnx5Sh8eRsnVCQaBN+/58Vm6T68Va1VMWbEbTD3GnN0oFHkq7IlrO
   wuwBdvnkeUkwJT4SiwxKZYih1s16lgD+lNpBib9Gir/PfyKu0u94ho2tt
   g=;
X-CSE-ConnectionGUID: e1d/S9IIRMacPEGEqAc7oQ==
X-CSE-MsgGUID: lW985if4Thyl0qM1isLtqQ==
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
X-IronPort-AV: E=Sophos;i="6.19,299,1754949600"; 
   d="scan'208";a="248768843"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Nov 2025 14:15:25 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 20DDDE0B0D; Wed, 12 Nov 2025 14:15:25 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id E3225E0171
	for <cocci@sympa.inria.fr>; Wed, 12 Nov 2025 14:15:23 +0100 (CET)
X-CSE-ConnectionGUID: l//JSAkDQrWf0iyd4TA6aA==
X-CSE-MsgGUID: 5Gt/eNQcQR2ss6B9CENp+w==
IronPort-SDR: 6914886b_B1zoVFqGO74Ib+qBrUM819Ebzcr7gs62HN5BvdA4pTuN1C4
 1aey9WUSdGVgY79zeFmZFYfZ4Dki0n1/hQoHSew==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EHBgBNhxRpe07ASNlaHgEBCxIMQIFFC4JAZSNYMwQLS?=
 =?us-ascii?q?YRVj1OCJIQ7hzyHVYpOgX0CDwEDAQ1OAQIEAQEDBIR3CQKMWwIeBwEEMgcOA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABASIgDjuGTw2CY?=
 =?us-ascii?q?gGBJIEmAQEBAQEBAQEBAQEBHQJHRAEBAQIBIx0BAREmAQQLCxoCJgICVgYVA?=
 =?us-ascii?q?QGCfoIjAQYQAQMPJwevYIEygQGCDAEBBtpfHywiWYFkCYEcLoVugmUBiWx6J?=
 =?us-ascii?q?w+BVUSBPAuCRzE+hEODW4JpgiaBDpB6BohSUngcA1ksAVUTFwsHBYEgQwOBC?=
 =?us-ascii?q?yMPPAUtHYEkIh8YEWA9F0CDSRwGaA8GgRIZSQICAgUCQDqBaAYcBhwSAgMBA?=
 =?us-ascii?q?gI6Vw2BdwICBIIcfoIKD4lOcgIBC209NwkLGwY9lQiGc8Y9NAeCOIFngWQMn?=
 =?us-ascii?q?2wGEAMvg3EBk2AOBpMFmQapQYFvBi2BXDMaJIM2TwMZD44hhDO/fkI1PAIHC?=
 =?us-ascii?q?wEBAwmFRgEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 GmlUVbOwhkRkdiJndsQLTgjssqi6jQyB+rE
IronPort-HdrOrdr: A9a23:6bb6DaEY1LmMcX1hpLqEPMeALOsnbusQ8zAXPo5KOH5om7+j5q
 STdZMgpGfJYVcqKQgdcLW7U5VoLkmyyXcY2/h3AV7mZniBhILKFu9fBOnZrwEIcheWnoNgPO
 VbAs1D4bbLbWSS4/yKgzWQL/Zl5sWb+6a1gurkw25qVhwCUdAc0+40MGem+lYdfng8OXPVLu
 vn2iLNygDLRUgq
X-Talos-CUID: 9a23:g5UPeGG/D2F11CqqqmJjswk2IekmXkTH83mIIl60VVpAFrS8HAo=
X-Talos-MUID: 9a23:MicSawWXbvBb/GTq/GLDmHZvEv5j2p70E1tTu8Qtlu+cdjMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,299,1754949600"; 
   d="scan'208";a="130611426"
X-MGA-submission: =?us-ascii?q?MDHTCc48mSH6Rb31j4kBrGTlV68kG7tyhm3tgs?=
 =?us-ascii?q?KkZtSCLViRMuGawKqBP/SGqS55WpPeUN8MkbvLzIN/j3V3qgNKu/+ClF?=
 =?us-ascii?q?THRUAdUi2zD6UBaTyv8exwvyd3OU9kR4RaY29Df6AE7aC2oCNUQzS/+c?=
 =?us-ascii?q?xKA2HPIL7rWTkeqgvOgEcLhQ=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 14:15:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1762953322; x=1763558122; i=markus.elfring@web.de;
	bh=wwjbzODtZ/FCv3dpzDz42ZyJn9ISYeUI/1GjGv1kjog=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hgghc4ilnTNkVsyFMxGrldGhNqMeQZEWaZyDCQgLur2Dir2eOksslnHm9fH6Z3UB
	 Hm/vEfqrdzP95oQZxDBNIK7g4LMHHBc093WGRGEnO6ZjvOvqCDzxXXymseQpDkgq/
	 RZgbgjNkhhQHsJ762JIIsK8I7Jcc45Cu4PXaX0CkPzXvnf9IXpFuyNtgSnxyvnbqU
	 s7RHNxYIpZRDKqO52gODPr2FZOP6lXDmw/hU51L2NWAwi96PK3+TgW4RKVn1Hz3hr
	 Sw8+OOv+CIQy2uZzxVQ7V0rDEaJ+x2kKb83q1AqUfocr6Gp0hOE80qSa4bCUQgPS1
	 Me7/eVOrvx8NlVsNSw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.246]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MmQYd-1w1LGV0V8r-00dRNb; Wed, 12
 Nov 2025 14:15:22 +0100
Message-ID: <66406059-1020-4762-81f4-c197cdc94ceb@web.de>
Date: Wed, 12 Nov 2025 14:15:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <ca1862a2-8a84-49b8-bbfd-fca9f15c6787@web.de>
 <c5aa7f4a-4efc-5384-3295-823dea0ea10@inria.fr>
 <92736910-a93f-4a91-9356-f6f6c1aebd8b@web.de>
 <3177bcc9-773-393d-edf4-8fb67a59115@inria.fr>
 <2c82cd3e-6190-4f6e-ab86-5eb047349f04@web.de>
 <9ccbf656-3d48-afbf-3e7b-2ad2157240db@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <9ccbf656-3d48-afbf-3e7b-2ad2157240db@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:r3GWhSbgG2lzz/5mzp+0rQQR10yChpPA4l5ua1LeweRNNMJ9L9o
 7g0CPXTfAKKkaRIrUSDRjir8k6z/mLbNl/fKuTjw7oQMZKeViHmCUTS9/yWp2+OD81z9Bvw
 zp/0rJANb+vMwn/YWEEcf4jVlDdYkOoL/Agugle/k/Ycdb1H5gq54niu4797HMxAfomq/Md
 ds7Y04DJgh14dOAV466wg==
UI-OutboundReport: notjunk:1;M01:P0:E1Vpxyi3afk=;PcbhfQ93Qn2aqyf99/UIgXfhpzY
 va7jS5MDE3wDmNKuRgnT+VPr8pIMyJK1Zf0i3uHoQrz0oFhEYYLlkpgq3mTxBUBRdDSG2UQYw
 Y5yMQXNy9YTcyABlQXYLQkzoQjB5eeKAsNjvc+9bs3so7NGjpQUMae9Fwqo2y8lIdqUDgQ6WQ
 2XVQKlbHqAthkPoMdm4ZePUKB+F83L3T0RKDAPK8tMcIS8eUofqldYbTxOtKy7nR4SnJ6jEDu
 VHJJB+dn24PDHqf4x+zH3nH/sYN+PpsNdE5Iun5aZttb3AfXj7bJXNbUqNiWusA9NAay/8vpc
 Q7Qjhn1CZcSyxe1y8x3OGiFDLe/PUwejrlNnDnh4uR0yaJb0jOFaxYlKQQRn2NXnN4LT5kzEX
 DEjp8YGig/bSGW9kq+sk518TZzNQKf4PEH5nmiuUmN0+cAlA3HjX7XVC047IkVSvjGoNf2o5I
 KkUjPCosVedLslSwBYVIeRs/yWQ85Vzt03FOl0vNI6EJ2Wwf4pJfCHxLsC/eieUhAPK9OFY53
 96V367b5UpwKmbNBNLVl/Pka6RwJTbIqU+MDvo3vYFObOagpbp5hyBpt3uJW4oMZPFPLo0scL
 OvW1JckNp2hcNKeRj7mP1vqlERB6HgcS9S8fvMarf5Y5V3aFTM+RvPGocwG0GwSWGDatc/ibZ
 D26tfQOpA1bQCO7rPav/7Y+MIlH6YZZFi4zfT05/j5/04POKV8nOnKEE6rXVdGCKIKaFp/1Uo
 eZWunLsKNz8okw3J3Y2xQ9IvK7j20oWKpbYxCuAmBuyH5KRTcXsC/7EeJgXgLavtIG6wMoIJu
 efRGApzP6z4UDpr+GnM6NJXuI9XGlVjx6X5xPzwOEyr75a2CqvW9uagHT8TpAHL2knMJ+SH+e
 3HIgG7rjRMoumcuOWbMM6R347tCMWDmEGmeyLF49hYsbxYxWBVAaqwZ5Uf01/bhLP6jHfVgsI
 EquoPY01QAhPEHEaYbLlE0Ba6rbsiszTwndI6cIUgNSPgZwkiU3ZAvs4ZBdGm967KHAMo9LXb
 wXHpyxUgwrtaUwNUXuxRe9yEr7texzmX4K9pLx+KOUF75aqx0fdv2es9eG2aqlEfxdKijgW1x
 j9FDTigjLQRSiYWTS991ygF9YjRX4P171fqGUMpuXdQDz1jdb6pWybEhFoaNAAlV9jhk2enJd
 N+L1bimit/md6kizT6NkaC8IwgLefp8UFNeFRPV3rVDuFqYa5pkXowRDWglHdvavovgX8JzNn
 fxv920ejfANMYUHwBUGTH2XHzYBPjB1EAWX0iiEEe6fW3R7rl0IVtryfOcMp2ovXiO8ketReM
 B21M43RtouWc+JRSRH/aa1GlMprljYEFf5hBkSQklujdY6RBWp6ikR7CUqacXJneWkWrGsaj1
 8wxP3KfvC/WiAQnt/4F+IO33MSlbSJ+vTXHXLz0pqdfvVeLXkHgK4OTOPbysiqAHIWOITn7N1
 ttTVcYNzLus9IvtCzfHGL9pM76SetB10Bc4n72NMbN5/dt2bpdo6R5Y5BmFo9eT0w3YJa/3yh
 I8VA9uFarMiJgZ9/90gxPkzaTYwGnaJ8Mo9SwspK87vt+YTcR8PayIReN0xoMojDasD+84JX6
 Pj5s5MDWgV5EMZDpirQnPPpc9hMIASBdkEGrn72mHsYEhpDgTK1LUFpZGhPMxYbLc24e9V7RZ
 JanN++fzjRozdAUvSH5Jz6naInmxqH3btJbGsb8iTagFoxkJ7I03QbFqSlXzfJF6SAogxXJar
 /AdkjeCTRXPDvVOCj06ijd8tsVjWijkd0NvfHqNHTsehlLGrdhxjYLQOONQNqvNwzIWZgaUY+
 U9cIrqD1H16ym2wVxiKylVPvSGgfLS/UiS8viEYizFdB5FRd88w6p+fJZ0Np5H7MP2kWT00iN
 WAgImxpsMF2c4v67/FYaGSfhOF3Bz5BN5RgP72g3fRSfsUN4aez/cg58DnJ4oDRtwIeW/4CWZ
 jJW8bYSp1bZM6nFFxxbHfVXjb8Q7ZadP6HaX1Akf+IPPdDHfEqeokvFT1XEBMxaIBnJdlLd4M
 W7WjhZooPoyuBHHelTUH7g3PZ9slxF7zD2gkA/0+UHjbNyqz0FGGq/VhobDa5uPBzJCnbOV8N
 3y6APP+7mMQeWXZMyGs6cCbHvbyvUpeq0q6I14a6d+yIwdjLxkoWzl1++JWMuHGYAQXPzquX9
 fdV1Rz3bYKOX/sSUObaDcJvCyFn3PV61YjLKpm3acyPDi4ve1PcRyqh7cHEqyyx8BdO4cdj/V
 iPOAFKi4c6W/ldIIH7ntgZjGFzFxsGR8SYPCU8/qrlOOQM7ecUuHv+Se1F7QaMb6/wzFzu8XQ
 wWp1wTim0IxRtFmXOo9L4KGeWnmqIMuJueVMtrTrCoXFRJoCrb/7I9ABwPOf4nKLv2VwPnzD3
 wgJlRUYKhLhno4pMN/GF1sr8+mLNmLzyfr2UKpteEcQI+sDXNNHfVA8RZkZnk745WAJGQtX+a
 tx/E+olTF/1W39kUP3iiQHlMmgiFHmWT+WzElBrlgql9fyKyF/VFe/FqO7+WBf4VyCWfhqNoN
 g0vw8dr3MT0jzwHb44wFIC0pLxfAyc6PqysMRucyP9bySVehEK5NtsdFRWngvS+tZF8ALRR3j
 +LV/cVZvzbFPepH5yvQkOw3oOo8upi1pTMgHWDV3Iho5liFDg3S4+YK54jKbq+/Ezqco8g55i
 UVNAouTEXjovCuO7zVVyi5xV0jEPJxHvaQoguDLNDA2X+1nltPiyArqWxPl2jJ9i8rYesBbLL
 XafhO7GStE2afBDnceJg0RTJn4eDBnP2fcaEdELiiTrhe0WRuwxl7gQM6eOAAxZr5yJSFfkP3
 pkZILvDUfFtCra1Dxxxt8ZGItlgR2Qy187qrpDobeYbKP3al2exg6RLOe7ZvnkwCUAhUafHEq
 GGuSRrLNR6fcXE2JEPa+c1CvAHl8PvXdNTmdzb8k3/GWIFYGxPr8fxuqWefkqK0FzPma37s8C
 ofpDpq6ksGTG5WVfwHiR4PWb3r08k6VdOA4RJaiBVbYjz7mTUZ1PRM8uHy89kW4CaEkooF/89
 W7R+yXIfOc9HWcwCe9BFFSx0UPf4wNbjJhtOaS2MsA8TJR/z7y7le9bbHmIyjjPPTfptLzIFX
 QS4iGjg8GUnuDqg0bw/mpNKMRhDt9czwH8kYObrZbyQGM2atT7KLYHMXqcCnhcXC021NpQpYg
 xPLtfMU/1n/35tMjrOaTVdzDkJ5nHkbzL9J8T+keLNMeV5Bli8TDZLQb3GsSIOEinqhh5jcO2
 3Q87Gp93QdR50m2fyHeK6VDwDu8jmotqb9kbh2oSpZ9lb8l7nkLNQihpEGOpd0jihzuvv6n1I
 SAjyLKcEooTD/D+zfAb0U0UxoCmZqCBii6Xk5YZk/QySi9hXBKhedSxj6U1JPGPBwbbquPlnC
 Pn7tkNM+umTbNxIYfwWIQT1TWsOWULVkLqxPS+Babp8XYchtwxbieqpWnfoRHRR6KHBVonD9m
 wQA1j6ZViA+bcMG3U6gj+D2lbsiwVJqfJMHp8Kr60kg0o7qire74pCPZhpaeqbI+3AdwgobOQ
 rLFZd/IoAPOUuHSyH9ApfDJDoQHs6eVZs8hP1T3aclbJxj9TzSwfpd81ycxRx9iNESbdruy1q
 2prJfKgLfFc8OmkZor27siDajHfY8pw1n3xrdV0W9ohAV3vuYyrUCotPWgjOKmcB2rExk3vlH
 Q6FwhHtuH3G2hwQykyV1GIJIWPme2f9M6jAFUe2Ve1CIpocEGrawncIPoiDL09GlQBH+g4v2I
 ikQb+O0Lhy2u6r3gj4xbcHEv/d7J2qrUfjHu87nJN7L++Z9EoYw9fV1tp0YFZSCWWWBMWz4Eg
 P3CzIOKV+pAK124AJV/eAYN7QfVqW4OIztD4ltbjJtjcOi2UR3ZyOhJ3+IXbMOt5SxCaD75at
 0/+7SBpO1UmBoRsgGEJ4CxovvmiJdDNCn2iO+s6OxDAeoDJdhHmeqxrelN5JP4mMtpBmvA5gL
 zMSXpk2ILPxkVJeqfKwPktZdSW0nzRjlm0/IzOWbkQO8vIr0e0YYoRzSSVLKFyebKqJ9XBwT4
 q+9uYqinmcOrKhnNPze/+3J2ikcv2ejc+xcjvL57ftfUpDBrobXiDyLiqC5EkRLQY6gH9z+Gm
 Peyvhsmqu6I8PcBqczyTay+HJ1x39yE8VSQlAnByeO5YclqzwDSP+6MLBc8oGxpBZ43sboyYL
 4EYjmfAfZwRf1jDyHu0uVwZdm4sPC/H8hcHr5u4gYY95LBJ1EtIXVz/c+3nR4XQd92ZbNXn65
 71p3h7GTjj+FP3YHTB0pjwW3VeNY/xpH6ceN6voP8Gy6M5L1RHb2IOztACph8KB82/WjwhQma
 jIJT/hZ/REzTSdDOv9TJwRBods2VSGCflyh4X5eYg/Q49qcjKUzKbpUsoEZRXt7OSb9qD5RAX
 E4EcncEES03SPfp3y3DLqPU66P1rNYpptvniCGvfcZBGMeXxyi1maoZm0i/JY3OCRYmW3TxWL
 8V0NOmhkwcBGbW/mAY7lNax3EWs7JuMIQ227GfpX7G1KXYXP9jTIknRn0/h9xrxhozsYDc8KV
 lB2zhYLCV9D6YlmZgO5xBIeXJgFE+tBjeRzTaK6N3zHd0Rp4ziBXUmXF13lkuMJ1xMAHU5JDs
 e0h11f9mJ5TUvA3xQWW/XyCYFQ3XPZ9MhvjHkggU5RHeRN6A5bPYxO+8LQ46ODtSwcbSCx+gW
 9LRqrO8Gj6s1+8y9MbN55IZivHc+zSDJUjHwY40btDp90+QQxLgEOQKK3mKVrQUJAatvNiVXZ
 1gIs1lH04U+MLlLVaTBhVUMH/hoJ89dI6V/Ot2Kd6lmiaSwLNKjV0/epgNtGA0nXqeQorBv7L
 76gJkZjzPLW2MjEeoqaK93OEIyKP6tFIVIoOiMu5Ex36eilIJUntDMvkqMMkKXAGGsnNTaLBw
 cn9lAeNGBo1JQa3a0FL8oksRBEZfPT0SHd1BU5W8nYNzePoPjxqE+5n47iI8XQGznYsWJSpp7
 D/yd/pE2XPoNu0kSmJzkHtG7X3236/64fG87mxLKahHDRZVr8ErUdb6HInCdno+bRX811ApN+
 Vuc1KMZo59WB2wmr0P+wblrCpGC4cFgizJJ+6eexABKII+n7VuU/N4QPm4Xf5nhoYA9of6zd+
 nNgwtxHLRhruicPxA=
Subject: Re: [cocci] Checking SmPL support for two special expressions
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3168
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/66406059-1020-4762-81f4-c197cdc94ceb%40web.de>

>> How interesting is it that I can recognise casts also without extra typ=
e definitions?
>=20
> Not interesting.

Can development interests grow accordingly?


>                   Sometimes it can infer them.

Will the pattern recognition be improved anyhow for affected source code?

Regards,
Markus
