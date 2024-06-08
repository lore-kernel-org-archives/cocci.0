Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 039D2C25B76
	for <cocci@archiver.kernel.org>; Sat,  8 Jun 2024 06:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=oQIHcN3t0mGos6nkIkeUNHAGyPzrGqA67aW9fAkcaHo=;
  b=HdkP6pJQLymJ1/8go+wraIewEBHwcNhUo1zsS+T4NvY2Q9sAmgKEDseE
   XDDxbODu/6xZy87303SH4xgq5BVtMaMAlm/x5QReFot9+0Olnrbp0y02Q
   sCd5nG/DkLQwg2pF8OF3E1C3qtoPOqXsAwmbYvHIeIzD8JUDGz3q3QpB3
   Q=;
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
X-IronPort-AV: E=Sophos;i="6.08,222,1712613600"; 
   d="scan'208";a="169639851"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Jun 2024 08:53:03 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B802BE0133; Sat,  8 Jun 2024 08:53:02 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id DE5FDE0035
	for <cocci@sympa.inria.fr>; Sat,  8 Jun 2024 08:52:57 +0200 (CEST)
IronPort-SDR: 6663ffc9_bmhiMzYsqRZz2r3meWZNGy/BY4fWfiy+Bcu+cOK5XYTWZqU
 g1TxwXwlstvGz+GNumHy793/H5JVRO+Cvv7HPpQ==
X-IPAS-Result: =?us-ascii?q?A0HwCgDe/mNmhwwR49RaHQEBAQEJARIBBQUBQIFPAoJCf?=
 =?us-ascii?q?AZUMwQLSAglhCmPSIF1MIQ7jwmIcYMWPg8BAwENOwYBAgQBAQMBA4FJQoJ0A?=
 =?us-ascii?q?muHewIeBwEENQUNAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBAhABA?=
 =?us-ascii?q?QEjFwcOECeFdA2CZwEQdxd0MAIBAQEBAQEBAQEBAQEBAQEBAQEXAg06QgEBA?=
 =?us-ascii?q?QIBIx0BAREmAQQLCxoCJgICVgYBFAEBgnwBgi8BAw4jBw0Gr0uBMoEBggwBA?=
 =?us-ascii?q?QbaWR8sIleBYwMGgRouAYgwAYV8g0Z6Jw+BVUSBPAuCeD6CYQSBXoNbgmmUD?=
 =?us-ascii?q?oVQgSiKdCYLimdUfRwDWSETAVUTFws+HQIWAxsUBDAPCQsmKgY5AhIMBgYGW?=
 =?us-ascii?q?TQJBCMDCAQDQgMgcREDBBoECwd2gXGBNAQTRAOBN4lxDIMvKYFLKYQYCENsF?=
 =?us-ascii?q?YNugWsMYYgOY4EQgT6BZgFPgwtTgUsdQAIBC209NQkLGwY9qECFHlRxbMRLg?=
 =?us-ascii?q?Qg0B4I2gWCBYgyKIZUnBhMvlzoOBpJrHphHII1WmxSBfSKBXDMaJIM2TwMZD?=
 =?us-ascii?q?44hGYNhM8pKQTUCATgCBwEKAQEDCYVGAQGDWoFIAQE?=
IronPort-PHdr: A9a23:oafSShxLUiKsdd3XCzI+wFBlVkEcU1XcAAcZ59Idhq5Udez7ptK+Z
 h2Zvq03xwaRDM3y0LFttan/i+PaZSQ4+5GPsXQPItRndiQuroEopTEmG9OPEkbhLfTnPGQQF
 cVGU0J5rTngaRAGUMnxaEfPrXKs8DUcBgvwNRZvJuTyB4Xek9m72/q99pHNZwhEnjSwba9sI
 Bm5sAndqs0bipZ+J6gszRfEvnRHd+NKyG1yIl6dgwjy7dqq8p559CRQtfMh98peXqj/Yq81U
 79WAik4Pm4s/MHkugXNQgWJ5nsHT2UZiQFIDBTf7BH7RZj+rC33vfdg1SaAPM32Sbc0WSm+7
 6puVRTlhjsLOyI//WrKkcF7kr5Vrwy9qBx+247UYZ+aNPxifqPGYNgWQXNNUttNWyBdB4+xa
 ZYEAegcMuZCt4TzpFUAohSwCgexGu3i1DFIiH/00qIm3OosCh3G3BU6Et4SrHjYstf4OaEPW
 u611qnIyjDDYutR1zjn8ojIcQ0hoeqRVrx/dcrRx1MvFwLDjlWftIfoODSb2f4Xs2iY8upgT
 vijhWEjqwF/uDivx8EsiobSi4Mb1F/L7j91z5srKtChTkNwfNGrHodKuS6AK4t2Xt0tQ3tuu
 CsiyLALu4O3cTQWxZg62hLSaPyKfYeK7x7+W+icPSp1iGxkdb+jmhq//1Wsx/PzWMWpzlpEo
 ShIn9rDuH4CyRDe6M6KQeZz8Eem3DaAzQHT6udcLE8vkqrbLIIhwroxlpoVq0jMAij2mEDwg
 aSLdUsk4vCl5/r6brn4vJOQKZF4hwPkPqgzmMGzG/k0PhYWU2Wf9umwzrPu8VDjTLhJgPA6i
 K3UvZDcKM8GuKO5BxJV0p0/6xmhFTeozdUYnHgZI19dZB6KiZXiNUvUL/DiF/i/hkyhkDd1y
 PDCOb3sGpDNLn/ekLf9Z7p85VBTxxEpwd9C+Z1YErABIPTtVU/trNHUEAI1PxKuz+r5Ftlw1
 JkSVX+ND6ODLa/er0eE5uc1LOmNYI8Vtiz9K/8g5/P2inE2g0Udfaq03ZsMcny2EfBmI0uDY
 XrthNcBHnwHvwQgQ+PxklGNTCBca260X60n/j47Ep6pDZ/fRoCxh7yMxDm3EoVMZm9aElCMD
 Wvod4KcVvgQbyKdPtNukj0fWLi6S44h0AmuuxXgx7pmKOrU4CwYuoj52Nh7/e3fjQsy+iBsD
 8SBz2GNSHl5nmcSSD44xq9/pUh9x0yC0Kh5hvxXDsZT6OlTXgc7M57c1e16BMroVgLPZNfaA
 GqhF/e7BTA4BvY43NYKZw4pGcimjxmF2yO1CrsRv72NHp09tKzGiTy5LMF2wHfu1a87jlBgT
 NEcG3ehg/ta/hLQGpWBvkGXjaeseuxI+SfX93qYi0eKsltZVgFYTqjPG3wSMBiF5e/l71/PG
 uf9QY8sNRFMnIvbcvMigrzBiFxHQK2mI9HCeyernGz2Ax+Ux7SKZY6semMH3SybBlJX2xsL8
 yOgMg4zTjykv3qYFCZnQHfmeUDx6q9TrH2hT0k75x6HZQtt2un94QYb0MSVUOhbxbcYoGEko
 jRwEky62ofzAsCDuhEnUaFSe9I7739Y2GifuwEudoe4IfVEgVgTOx9yo1uo1xhzDdBYltM2q
 Xox0AdoAaefzU8HaD6Sm5z9UlHOAk/1+h3nK6vf21WElc2T5r9K8vMz7VPqoACuEEMmtXRhy
 dhclXWGtN3MC0IJXJT9X1xSlVAyrqzGYiQ7+4Lf1GF9eaiyvDjY3ts1Bewjgh++dtZbOamAG
 Uf8CcofT8SpLeUrnRCuYHdmdKh3/bQ3ItjgWv+Iwq+tM85/kTjggWkGqIFx30SQ9jZtH/bS1
 sVNyPWZ0w2bEjbk2Q346Iatw98CPG5URzDsrEqsTJRcbaBzY4sRXGKnIsntg857m4aoQXlTs
 liqG1IB3satPxuUdV30mwNKhiF16TSqnzW1yztsnnQntK2aiWbryv7haQFBF2pFXmhkgn/zL
 ILyg91QDy3KJ0A50QCo40r33f0Rga1lLHTIB2pMcTL3KW5KTaa68LaPKZ0qittgoWBcV+KyZ
 kqfQ7j2rk4B0i/tKGBZwSgyazCgvpiRcwVSsGuGNz4zqXPYfZs13hLD/JnGQvUX2DMaRS5+g
 D2RB16mPtDv88/G35vEt+m/USqmWPgxOWHOxJmDqTD9yGlkGxy5kNisl9ehHQVy3SLg1tZsX
 DnFt16mO9Otjf7ld7s4OBAyTFbno9J3AIR/jpc9iPRykTABi5OZ8GBG2Wb/PNNH2L7vOX8ER
 DoF2dnQs0Du3ExuKG7MxpqsDCzHhJE7OJ/jPSVPgHFYjYgCEqqf4b1akDEgp1O5qViUev1hh
 nIHzvBo7ncGguYPsQ5rzyOHA7lUE1MLWE6k3xmO8d26q71aIWi1dr3lnm93h9O8F/evpg9GW
 XD2UogvF2l8448sVTCEmG228YzidNTKOJg2vweXjgyGouxbMpM3mdIViCAhNW+37hhHg6Yry
 Bdp25+9po2OLW5gqbm4DhBvPTrwf8oP+zvpgPUWjoOM0ouoBJkkBiQTUc6iU6ezCDxL/6eCV
 U7GAHgmp3ycA7aaAQKP9BIssSfUC57yf3jFIX4E0ZN9SRPbKEEXiVIRWygm2443ERq1zdbtN
 lh07HYd6zua4lNFmOdvKgW6WGDCogylLCg5Qt6TIVJfvARF+luQOteU8+ZwWXhR+JH46geKL
 wn5L0xBX2QOR1DBDEvoOaO2o4DJ9eTBQOG5KrPYaLGK44SyTt+uwpSimstj9jeIbICUO2V6S
 uc80QxFVGx4HMLQn3MOTTYWnmTDdZzTohD04SBxos2llZajEAvy+YuCDadTOtRz6li3h6mEL
 euZmCd+L35RyJoNwXbCzLVX0kQVjmlicDykELJIsiCoLuqYgqhMExsScD9+LuNN6L8gmBZAM
 4jXh5K917J1iOI0F0YQVVHlnZLMB4RCKGW8OVXbQUeTYe7ff3uRmZ6xOPz6EOcD6Ycc/we9s
 juaDUL5azGKlj2zEguqLfkJliaQehpXpIC6dB9pT2nlVtPvLBOhY7oVxXU7x6M5gnTSOCsSK
 z95Jglop6eT8Dger/FxAW1H4VJ6IOPClyvTvIy6Yt4G9OBmBCh5jbcQ+HMh175c9z1JXtRwn
 zbO6MFjqReqn6Pcr1gvGAoLoTFNioWRuExkMqiM7ZhMV0HP+xcV5HmRARAHzzOAIsLiseZcx
 4qX/EocAChP+ZTY8JlFbyA1AMeALWZnLhfjXjLZXlNtcA==
IronPort-Data: A9a23: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
 ajZiF2omH2GdHM=
IronPort-HdrOrdr: A9a23:zO3Sk6n7xSDE4lya+GrteoUgZVPpDfL43DAbv31ZSRFFG/FwWf
 re/sjzpiWE7Ar5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQyVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK6PoSizPZLz9P+qjlzImVpaP502pnSx1sZppt9gFjF2+gYzBLrUV9ZKbQD/
 Cnl7F6TtebCA4qhk/XPBM4Y9Q=
X-Talos-CUID: 9a23:CO/9m2FHB39mJHkEqmJErHw6GMwqW0b+jynIPRWpJWVJSq28HAo=
X-Talos-MUID: 9a23:4m2bfwZT84NJ7+BTs2LMrQ9hZflT35vwA19VsL5b4dONHHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.08,222,1712613600"; 
   d="scan'208";a="169639848"
X-MGA-submission: =?us-ascii?q?MDHNyDpeoy5qwqDLroOAITF43BVy4wO/MCd5wh?=
 =?us-ascii?q?s3k5iWcujBfNbZYE70RC2r9+jl9a3ua3XX1LA2pHl5kdlCVkQUVhyqO/?=
 =?us-ascii?q?j7wq3AZY7ghM+gnFWAb4hA6usggDsuv+rsWtsRybAbI/1DY2MO9fh7Wj?=
 =?us-ascii?q?iPNpfht+IOreXrp+RZcrK5cQ=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2024 08:52:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1717829576; x=1718434376; i=markus.elfring@web.de;
	bh=oQIHcN3t0mGos6nkIkeUNHAGyPzrGqA67aW9fAkcaHo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=VaeowVvQ4DeKPp2b2Ghs1Aqt80Cxcfxat3mgzFQcSeg74a7N9/aDJmG7jbAB2bEa
	 SsAV4TbQbUx3i4t7ZmgHf50D5hp2ayoW52QNueuEtKsrp7TsJDUAwIRERyI/m16bk
	 Abv/YaGXVbnYUBsNlPmZyqxfXDviYzroj7YmA8aZyRbL9CQB3MPhyQ38S3p8kwhhI
	 HhHIEzRxn6jOyjK1gH9Zo0+WcZyfb7flopJQtOLBvAHwY0PoKtW8jqAIAVVkiAO1v
	 QGS/PtkCPVWdE70yA8hazEKg2V6I08pDGVOjqFME4tb1Dxqq5yixd+YoGAwkp5iFG
	 WNmOqDQp6iDnX0YMyg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N6sBp-1sVEiF20nn-00ww3z; Sat, 08
 Jun 2024 08:52:56 +0200
Message-ID: <63657b4b-b516-4993-8836-0b757f968401@web.de>
Date: Sat, 8 Jun 2024 08:52:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: kernel-janitors@vger.kernel.org
References: <7eb9626c-da7b-414d-bf50-da1eed27be31@web.de>
 <alpine.DEB.2.22.394.2405261847380.16852@hadrien>
 <9d79a2de-10fa-479c-b720-1c4a2f51782d@web.de>
 <4bad748-afee-713a-a2d7-30b6e5c1cb28@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <4bad748-afee-713a-a2d7-30b6e5c1cb28@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ciHrHpRuRZdVO+RhDqKLoRKld7/wpDTU2cSQ2v2zr2FYd0MSYPO
 X3Hq8ja7VA/vEasW/3nevigCA11gPnhBGZZdT2bCCmgVthXXZe9bQZysQ8udXT0fb+tFx/u
 FeMynjG8sYKHj3nAHzmDZgD1mVq80cDBJOF12WhbBRN2vFoVm4iTRCRKNE6xQTgfGbaCQma
 7Zbzs7eWZ+2MOOdIGC5fA==
UI-OutboundReport: notjunk:1;M01:P0:3vd+JJxa6t4=;UbMDIer3No2WVxeavpHF4mQbNrv
 8hV/K65L39f9JoM/4f2NaPCEnV+TZtVk/ArKmFQNBctxhtqHKgA5/NepbmeR+L8w9+++5Hzk8
 cT7jDb16GwaZhFhig3J6u0TH9T8n8vifQA49mHQkgIcaSvBVKogPt+9q/4EfUXbluqr99FEt6
 uwNHiGqZTQ6aEXDUEOJlRNrI+bQ3MNGY8mBgRByrLZPVqfFU78XN2uVeNep4f/pcho0HarHnl
 R7lhQa8sdjUULd3T0dYUwQMpPfKsFtjc4gm0sc6hckNGvwpcW9dW1z9myAjqmr+fp1Ii0sewj
 Uxi4SPVYtOsEBdoJ7ah4bJcg0A79o971mnvq8cZrMtAvGMPJRUc9Q8Pjwil9siR/4EDk0pZEn
 /EgQt+bvlAqnebCx+5iSNTTf9pLMq0W+EBmgnIzxx9A+lVdu3+NliHsnFj0W2gvO3UkjgICXN
 iPVPUOShhbzwaCRe+r2ZyQ9SzzeWRs0kLEneDBsgtcSrf4L/IgcoBM+yIsLlGMKAH1ampzlRY
 2Mk4Bw/VWxGn4oLcwbuzzZQRgOJUMKL3K9dVUJRGPFBQrHVpgVu1FiTKzMeCPLBdJDjajkkw7
 UmQ6z6OGG2/zYhG7nQ7L1RJdr8JzXBK/I1DF+pKrTG6+MEolfUDApzmscz54apgMj9wrundJI
 SOqSU058CLly+CfkJQRgxjfEJr/TeJhyhBe+xw+vmliDsW47OlLPs/8EiBCk4qTfGrl0PMTto
 Mxu+Syu81vUhQISBsFtaqEryOFSscaezzoJC6W90iDqCR++4BTwZ+Ph2yqWiwNP5V6Yz7xL1+
 dXtwVt3yTNyOVDx2ELtUu2OACsgbWyJ4wg/TxT6oDQU1Q=
Subject: Re: [cocci] Determination of lock guard data (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1782
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-06/63657b4b-b516-4993-8836-0b757f968401%40web.de>

> What exactly is the problem?

Another development concern (for example):
I would like to benefit a bit more from information which is provided as p=
arameters
for macro calls.
https://elixir.bootlin.com/linux/v6.10-rc2/source/include/linux/cleanup.h#=
L179

Thus I hope that something can be achieved by =E2=80=9Cadvanced=E2=80=9D s=
ource code analyses
also with help of the semantic patch language.
May I expect that some data should be presented according to the following
tiny SmPL script?

@display@
@@
*DEFINE_LOCK_GUARD_1(...)


Test result:
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses/include/linux>=
 spatch --include-headers =E2=80=A6/Projekte/Coccinelle/janitor/show_lock_=
guard_definitions.cocci spinlock.h
=E2=80=A6

No data are displayed by the software combination =E2=80=9CCoccinelle 1.2-=
00008-g75525032=E2=80=9D
(because of the specified SmPL asterisk) according to the selected macro c=
all.

See also another known information source for further development consider=
ations:
https://elixir.bootlin.com/linux/v6.10-rc2/source/include/linux/spinlock.h=
#L537


Regards,
Markus
