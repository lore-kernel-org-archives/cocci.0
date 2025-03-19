Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A38AC35FFA
	for <cocci@archiver.kernel.org>; Wed, 19 Mar 2025 09:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=DnheqgRDwYeIM0LGTw1qpz6P+AnP3VaqBW5y7tPy8mU=;
  b=YINfvKdm76Y9oks4qweBBWzDcPHRtEROquIU+rZL/tBoi8tP9DzeJyvM
   UlRCpgNPk6H8b55kvCEMqtoShL+2fSZvNXy749lgWTDvKT4duqnz2joXK
   6LgImHcS3mNdAiYReavLgo4HlSxPz49hYYrEAJU3HdwHHG5jklmgwmzUx
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.14,259,1736809200"; 
   d="scan'208";a="213657008"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Mar 2025 10:43:29 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6614EE0D1F; Wed, 19 Mar 2025 10:43:29 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id BCC5DE007A
	for <cocci@sympa.inria.fr>; Wed, 19 Mar 2025 10:43:28 +0100 (CET)
IronPort-SDR: 67da91c0_uL9CRNYrhPBN06Y4ygVc6JzZjJTa6P3N3mJW0jM9l6pV8vQ
 A5HTo/Usm0fcUNzjIykIYbuffJIBUsTMiFXx9vw==
X-IPAS-Result: =?us-ascii?q?A0EGDAAAkdpngAMP49RaHgEBCxIMQIQXgVczBAtIhFaPU?=
 =?us-ascii?q?IF0MIQ7hzuHU4h1g1QPAQMBDUEBAgQBAQMEhQACiyACHgcBBDQTAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBARABAQUBAQECAQECBAYBAhABATsHDgoxhXsNgmIBgSSBJgEBA?=
 =?us-ascii?q?QEBAQEBAQEBAR0CR0QBAQECASMdAQERJwQLCxoCJgICVgYBFAEBgn6CMAEDD?=
 =?us-ascii?q?iMHrh+BMoEBggwBAQbaXB8sIleBZQmBGi6FbYJjAYVrATuEPCcPgVVEgTwLg?=
 =?us-ascii?q?ng+hEODW4JpgjOEQWeZeJBHUnscA1ksAVUTFwsHBYEpQwMqNDEjgSIFNAo1O?=
 =?us-ascii?q?CmBY2lJOgINAjWCGyRYgihqBAWBJII2hD6EQIVQghGBXQMDIgGDH3ccg0t2P?=
 =?us-ascii?q?4RhLVCCFh1AAgELbT03CQsbBj2jbIRCF5ZesyU0B4I4gWaBYwyfXgYTL4NwA?=
 =?us-ascii?q?ZNVDgaSfZh+IqkRgX4jgVwzGiSDNk8DGQ+OIYQttQVCNTwCBwEKAQEDCYVGA?=
 =?us-ascii?q?QGKVIFLAQE?=
IronPort-PHdr: A9a23:9jcugh8aRvYRCP9uWU22ngc9DxPPW53KNwIYoqAql6hJOvz6uci5Z
 gqHvb400AOYDM3y0LFttan/i+PaZSQ4+5GPsXQPItRndiQuroEopTEmG9OPEkbhLfTnPGQQF
 cVGU0J5rTngaRAGUMnxaEfPrXKs8DUcBgvwNRZvJuTyB4Xek9m72/q99pDdfQlEniaxba99I
 Bmrogjcuc0bjI9/Iast1xXFpWdFdOtRyW50P1yfmAry6Nmt95B56SRQvPwh989EUarkeqkzU
 KJVAjc7PW0r/cPnrRbMQxeB6XsaSWUWjwFHAxPZ4xHgX5f+qTX1u+xg0ySHJ8L2TLQ0WTO/7
 6d3TRLjlSkKOyIl/GzRl8d9l7xQrg6/qBNjwo7UeICVO+R4fqPBZtMRWG5NUt9MWyBdHo+wa
 o0CBPcDM+lFtYnwv1gAoxWxCgaiGe3h1DFIiH/00qIm3OosCh3G3BU6Et4SrHjYstf4OaEPW
 u611qnIyjDDYutR1zjn8ojIcQ0hoeqRVrx/dcrRx1MvFwLDjlWftIfoODSb2f4Xs2iY8upgT
 vijhWEjqwF/uDivx8EsiobSi4Mb1F/L7j91z5srKtChTkNwfNGrHodKuS6AK4t2Xt0tQ3tuu
 Csiy7ALp4K2cDQOxZk5xRPTdvOJfoqL7x7+VuucIip0iXJ5dLywmxq88Uiux+PhWsWp0VtEo
 CRLnNfCuH0PyRHe6M6KQeZ+8Ee5wTuDyR3f5v9eLUwqi6bWKYQtzqMwm5YJv0nPBiv7lUrsg
 KKYa0ko4Oyl5ur9brn7p5KRMZJ/hx/6MqQzgcy/Hfo3MhITUWia+OWzyqXu8VH/Tb5XlPM5i
 LPZv4rfJckDpq62HQtV0oE75ha6CDemzcgYkWMJLV1bYx2LlZXmNE/WLPD5C/ewnUisnS91y
 /zbILHtGIvBImbBnbv7YLpw61RQxQQrwdBa/Z1UC7UBIPzpWk/2sdzVFhg3PBauw+bkFdV9z
 ZkSV22LAq+XKqPSsFmI5u00LuiCeoAaoyzxJOU76PL2i382gkcSfbO10psPdHC4AvNmLl2Eb
 Xb0mNcODX8KvhYiTOztkFCNTTlTaGquUKI9/Tw7E4KnDYLbRo+3mrCB3SG7HodXZm9cEFyMH
 23oJM24XKIrbCucau9siD0CWvD1TIso2zmnuRf0z7chIueCvmUTspno1fB04ffSnFc8729aF
 cOYhkSEVWJphSslQzEs3aZw6RhYw02AzLM+rvhWD91V6NtWXw18OZOKnL8yMMz7Rg+UJoTBc
 12hWNjzRGhpFrrZovcLakd5QJC5iwzbmjGtG/kTnqCKA5o99uTd2WLwLoBz0SWOz7Ev2n8hR
 MYHLmi6nuhn7QGGIofTkFiC0Yuue74d2iHl62qJi2aD7wlDSAAlaazeRjgEY1fO69Hw50fMV
 birXJEuKAhc0oivLqVQa9vmpUpLTrHvNYeWeHq/zkG3AxvA3baQdMzqdmEaiT3aE1QBmhsP8
 GyuMA8jGmG+rmiYADEG+UvHRUTq/KE+rXq6ShRx1ASWdwh60KLz/BcJhPuaQvdV37QeuS5np
 S8mVFC6l8nbDdaNvW8DNO1VfM897VFb1GnYqx01P5quKLpnj0IfdAI/tl3n1hF+AIFN2cYwq
 3ZiwA13IKOemFRPElHQlbX5IL7KMS/f+B61aqjZ8k7T2pCa9+ZH6fg1rUnioBD8DlAroD1s1
 9hY1WfZ542fVlNIF8irDQBuql4h9NS4KmEn6ojZ1GNhK/yxuz7GgJcyAfc9jw2nZ5FZOb+FE
 wn7F4sbAdKvIaokgQvMDFpMMeZM+aozJ87jeeGB3fvhGe96ny+9y0lD7pp81E2k6Cd2DOLFl
 cVgobnQzk6cWjHwgU30+OX+g4NZfnc/GmSlyC7rLJFcbOt+cMxYbAXma93yzdJ4iZn3Xnde/
 1P2HFIK1viifh+KZkD81wldvagOiUSugjDwjzl9kjVy67GawDSL2OP6MhwOJm9MQmBmy1bqO
 4m9yd4ADgCkaA0glR3t4kifpeATga1lLHTIB2pMcTL3KW5KTaa68LaPK8JC85IntyxLXf/0O
 wnADOSn/F1DjmW4V2JFjCg2bTSrpon0k3kYwCqGIXB/oWCYMcB8yBHD5cDNEPtY3z4IXi592
 nHcAlmxOcXs/M3Bzc6Z9LrkCCT4C9sIIkyJhcuauSC25HNnG0i6lvG3wZj8FBQilDT8z59sX
 DnJqxD1Zs/q0b67OKRpZBoNZhe05sxkF4V5ioZ1iosX3C1Qo5yP/mcc10r3P89a363Wc3cHA
 zIGiY2wgkCtyAh4I3SFypisHFCU2Mh8fJ+XZm0M2yQyx99HAuGY4fYX+Ek96kr9pgXXb/9nm
 z4bwvZ7838WjdYCvw81xzmcCLQfTgFIeDbhnBOS45Wivb1aMSyxJKOo2hM0zrXDRPmS5xtRU
 3HjdtI+ED9su49hZUnU3iS749Phf8TMK80evFuYnl/J3e1SNY50hvQNnzVuI267onAvjeI26
 H4mlZjouY+aNyBn+7+/CRMeKTD/Ic8esji/iKFDgoOdxIqyGpYnQzwNUMKuRvWtdVBa/f21M
 gGTDHg3sXycA6KZRAaZ5B4gpHXKW4aiM3XdTJUA5fNlQhTVZElWgQRPGS4/goZ8DQeygsrob
 EZ+4DkVoF/+sBpFjOxyZVH5VS/EqQGkZy1RKtDXJQdK7gxE+0beMNCPpuN1ESZC+5S9rQuLY
 mWFbgVMBGsNVwSKHVfmdrWp4NDB9aCfCI/cZ7PWZq6SrOVFS/qS7Zeoz5cg4DuGcMmCfzFjA
 /A9xktfTCV5FsDeyFBtA2QckyPAadLepQ/poHQt6Jrlr7KyBUS0tu7tQ/NIPN5i+g67m/KGP
 u+U32NiLCpAk4gL3TnOwaQe21gbj2dvcSOsGPIOr32oLuqYl6lJAhoccy42OtFP6vd2+wBXO
 tPAzP7x2KR5iPEdFFpPE1Ds0JLMB4RCMySmOVXLCVzefqyBPiHOytrrbLmUTLpNkKNLuhf2t
 TvRQCqBdnyT0jLuUR6oK+RFiiqWaQdftI+KeRFoEWH/TdjiZ3VT0fdyiiAqh6I5jDXGODxEW
 dCZW1xApPuc4HEA6h2QM3NM5DxpILvd8xs=
IronPort-Data: A9a23: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
 VQIeF0=
IronPort-HdrOrdr: A9a23:5kQ72qwIoj8RCndYVC8JKrPwPb1zdoMgy1knxilNoH1uE/Bw8v
 rE9sjzuiWE6wr5J0tQ++xoVJPsfZq+z/BICOsqXYtKNTOO0FdAR7sM0WKN+VHd8iTFh4tg6Z
 s=
X-Talos-CUID: 9a23:HBR+hGD3tGLiyI36EyQkzWUmRPB8TnPcyVCTAFKeGVtlYoTAHA==
X-Talos-MUID: 9a23:pXuW4QTXI9RzkPQSRXS03TpAEe1zwZ2EIxxcipsM59KCajB/bmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,259,1736809200"; 
   d="scan'208";a="112004543"
X-MGA-submission: =?us-ascii?q?MDGH2Ab+MOExGsBxNNRlOLooF/RhyJGBoDg07R?=
 =?us-ascii?q?Nav0wWNGBI+Q30rK4peYMeioA5MRXvzq53oDfy6PIq4wF87rz4DRthoX?=
 =?us-ascii?q?tJJC8afkGHhm0aLjbqXBreTfeIvlY5qD4zOrj+sx7GTN78SobzQ05G9I?=
 =?us-ascii?q?fJFjF0buoACb0JDTySeWizXA=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 10:43:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1742377406; x=1742982206; i=markus.elfring@web.de;
	bh=DnheqgRDwYeIM0LGTw1qpz6P+AnP3VaqBW5y7tPy8mU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=riebz/HxkMXIE5ZHq2XFNUksVWLRLw5FmBW7RVdaMBqGN64bFvZXN1PZNzvSTusU
	 Nhh6KUaTdUlNmfDmEHfDved0/PX2GOXGrgKvd16JPwyR17B4hNakrBIMVWCfl6Bzm
	 VMhYY6DJg4he6BESDC4y/wJSQVOwGypdK9PpLuHwIzl5LfeNjF82Dv/FarKXmo0NZ
	 YrzvGJJdYKYAbKc8s040mTNmGgWPRen1F5JWsX06Q9X5p2hLm9oNo4TkBJMRPe7ZH
	 Ordt+6f4JRpJcSrniB4v3Oq5cls/FqtUp89E6Qt9NqEmpVjoIKZWbPf7voV1+wOqh
	 65Z9AjgH31TgbzFFSA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.16]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N7gXO-1t7q9s3FJq-017uLI; Wed, 19
 Mar 2025 10:43:26 +0100
Message-ID: <d13d49ed-5861-44a9-8d08-953e79d2415e@web.de>
Date: Wed, 19 Mar 2025 10:43:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Olaf Hering <olaf@aepfle.de>, cocci@inria.fr
References: <20250319083051.2862-1-olaf@aepfle.de>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250319083051.2862-1-olaf@aepfle.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xpxLKNYbptBkr+cDy3xX4okCaFQqRhK2VwW691VW6Ehx/prAnKT
 ExxgzQyvWCSJlXdj2gH6OGlrFfPVJwjNhdQJogaokPFSE48HnVbG3/p3jCOULJgMuIANzzz
 L/u+xzrLsx8GuWXBO/uarAhM1GbIClkWxlHcLC/R75hLt2J+1rxkrGx+tPOO59ju2lYvrrB
 WuXw0dz0dJMYL40CrYhxw==
UI-OutboundReport: notjunk:1;M01:P0:gGJkPHk8H7g=;bW6F+Ad6y7xh2tyn/bw5CbInMG8
 Cdc6hoP0mQLXwvXOeCx2ulsbFHACL3gql447VQB6ZqMaAvRaxpmSrlv4DH4i/C5v/Qi64TaeF
 4+cLlEKKEumix45rNxMcj5zfvxTUW+84tc4JzRT9sXzZPFX+nJ+usPSEQ40dkxKPlvIYmEerz
 8lofiN7+nEHoVEJ9CHYsMbjHNPxcrhMIMVYOQsvsoUmNOom0x0Khbx8Bam7TZyWquohIQ1Knp
 IFqHalL3G7N2tAQf4rAAx4O/a2oUjIiFeE7GNh4sfxD2t2+wISHG0UTNWVGeh77A8mgrSl1eQ
 5hEMDEwghpJMbI+sp7ACHBgwG/UKFZAlwU0hrO+ycl3mvgwRkH11U5FPbgIic8s8U/xWEdsXp
 u/T8tErrDWWJNxurqibFJmoGZI0LJJCA9bkmn4iWpazoSccZrPI0htxCpZf3fy8CcXcmehf/8
 hHMOBu+48n/WFQwyGKm/vKqpiRPC3YSx8spOHwRW+Ni1IjTnxpfw3U2MwdWezZaAbKh28F3LS
 Rd3kofKUmYYLckZoSqsADo/S+0QlUCJ+DfB6laN65NOpCExorrkgyuVAqDOmnuCdth6QVLct8
 ZA+3ww1k5WSSzqGosaKzCIaE6KbVUzW5SQqbCjxAdV7R+9e3oPXlhMZcpAoAyOI0J2FWg1Qki
 FSqYfHuRHEsShvnX6GeHtERjbdBpoNOXaWvAFZr0qJbLSUWFcBhql4PQlcqdbpOgEhht5Zr6m
 ijBXKRfWdVzBN1SY+alWTebCHfO3ONzNOwpj0BqlhLIciOOMB7lNkh2ncFFOhvJjRxjVMv9oL
 DM6CdQ+sUoZX0l+vWvljAJzakdH+uasbHntRCIXZp+jZkLZouwbYOLjvg3yUqXluVTlsUMyok
 6MH+UqCaZ/xbUSgZ+nCJwVO+e/sgogBIJwccv0Ujs+qUxxTZRJIm5q7NvWyXvB0efKcw4dUPt
 MWsl0l5SjNtqGp9IBuMduuVw8YLyXeczElw7AHrbVIa5t5seSTEf2wbKnacUJ1wQyLjPkovPK
 fZd/S4FRcS6d1om69yYSNHVyZSWgv8jU3U80R8ZVwE3XT1kje2GoDmpD7dbxoZFIV1pBe7M5e
 fdHQ4LuQ/OmA6maeoOhyrxCdX32PjUpZIWIxHf3SOgCMQ9j1wBQBC5xFdS1ldO7gSl9VdwSO6
 LQKCPcBffA4VwOBRFpfjtRe2aRxgSZPhKgwLcMeVnoE1ZCJ2sHkWDweqVdDKU5jnbhQ/q0MPT
 iP/to37YsgYDu/jjMWVmTP5LCkhue6LGiaTUE0i7YXeNxjWXnNU1YKgQw/+2dER9O5kgma5DD
 LUroq3mLZe+/aEA5vHhqFpXc2x5ABir+PXimwVQ5JVcIZ14P2kg0108R4JqIm889QeARtBe5U
 LDEqy4LGss/Cq5qnDJcHZNUZO0df4IEyLvOffQY+zIfXouENJaP+z0R+6BcGeDGdY1jxhKPlD
 EHU3BVFCV6nDaAAU59MqPUl0r78OwBq7vXJ3I6aBWm8Hdxf0e
Subject: Re: [cocci] [PATCH v3] replace pcre with pcre2
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2642
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/d13d49ed-5861-44a9-8d08-953e79d2415e%40web.de>

>                 =E2=80=A6 While other regular expession libraries for OC=
aml

Would you like to avoid another typo here?


> exists, they are not as feature complete as pcre2 is.
How relevant is such information for a better change description?

Regards,
Markus
