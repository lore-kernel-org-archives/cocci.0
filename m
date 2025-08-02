Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE80C87FC9
	for <cocci@archiver.kernel.org>; Sat,  2 Aug 2025 18:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=71wbkwQdkjn5y7S/4EgALZTo9C7YLe8X/WjHeWR7VXk=;
  b=XWAB13mbxef1FMOLt5B8ilEtP717wMh+uK/66aR7yJFcj0Me0CZGeUqL
   ip0zW26/uiaINY/GE5oHiYc8DC+uVFuOoH665Vq8yW+IHGUU2aspOMHHX
   9+5RTbW7e5K6YxT0bkUTkQcIiT37Fja37VSNaBErLhAz0BAL1FATcEBA9
   M=;
X-CSE-ConnectionGUID: hrNuiXZcQrSBcfQV3y8heA==
X-CSE-MsgGUID: L/bLWqCPTdiYkNSl2Xi6rQ==
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
X-IronPort-AV: E=Sophos;i="6.17,258,1747692000"; 
   d="scan'208";a="233969352"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Aug 2025 20:12:03 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4668AE0BE9; Sat,  2 Aug 2025 20:12:03 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 5B967E0171
	for <cocci@sympa.inria.fr>; Sat,  2 Aug 2025 20:12:02 +0200 (CEST)
X-CSE-ConnectionGUID: wlc3VhnkSduj35uqvFKPrg==
X-CSE-MsgGUID: ceMP6S3sQ7aRmk0XOpa/HQ==
IronPort-SDR: 688e54f1_MsBHphIJhYKFa9+6B+JUSifT2I8OpnmuVRlLMCpvcb5RF3t
 Rro5v7TnTPYjENfj0VrouRllfNbnKol8LGwlJTQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GVBAAIVI5ogAQP49RODB0BAQEBCQESAQUFAUCBU4JEg?=
 =?us-ascii?q?QBaMwQLSQiEETyPUIIkhDuYCoFpgWkCDwEDAQ1KBAECBAEBAwMBggyCcAICA?=
 =?us-ascii?q?owaAh4HAQQ0EwECBAEBAQEDAgMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQA?=
 =?us-ascii?q?QE7Bw4KMYV7DYJiAYEkgSYBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQJHQwEBAQECAQwRBh0BAREmAQQLCQIYAgImAgJWBgEUA?=
 =?us-ascii?q?QGCfgGCIQEGEAEDDiQHDQaTeptMeoEygQGCDAEBBoFGBQ1B2EUfLCJZgWQDB?=
 =?us-ascii?q?oEbLoVtgmQBhieDQnonD4FVRIE8glIxPoJhAQOBHAEDPoNbgmmCJkRSg2M2g?=
 =?us-ascii?q?jOKG4hwUngcA1ksAVUTFwsHBYEgQwMqNDEjSwUtHYEnfYMNgQ6EJytPgiJ1g?=
 =?us-ascii?q?XlBGT+DUx4GbQ8GgRUaHi0CAgIFAkNFgWAZBhpAAgELbT03CQsbBj2TVIQJW?=
 =?us-ascii?q?VRxbJZdmwmUYzQHgjiBZ4FkDIoulT4GEy+XUg4GkwWZBiKNZps5gX8jgVwzG?=
 =?us-ascii?q?iSDNk8DGQ+OIYQzgQu8I0E1AgkxAgcBCgEBAwmFRgEBi1uBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:S0d3q6qBfXI3xUIhtnYqm2QaV5r0eYIsimQD101hICG9vPbo7P
 xG/c5rryMc7Qx6ZJhOo6HlBEDtewK4yXcx2/hyAV7AZmnbUQmTXedfBOLZqlWKJ8S9zJ8/6U
 4KSdkGNDSfNykDse/KpCe9V/ktyMSa66yz7N2uqEtFfEVFb+VP4W5CZTpz0XcbeOCFP/cE/V
 aniPavbgDARUgq
X-Talos-CUID: =?us-ascii?q?9a23=3AnD3yEmnKB4Obp9ElgjG7cEGFh3TXOWLZxyzuI0m?=
 =?us-ascii?q?7Mmp0SubIVEaO1oBcicU7zg=3D=3D?=
X-Talos-MUID: 9a23:OBCS9wlB1dlT9rrGkOmPdnppOeJQvZ/1E3lSmK8DuJG0EjR5fBek2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.17,258,1747692000"; 
   d="scan'208";a="233969350"
X-MGA-submission: =?us-ascii?q?MDHU8YT6gsni3p7qH0XyWk2W41AIHKjzPwGQWl?=
 =?us-ascii?q?Fd7EaZBvGp+klT/Cc5WweMS9S7pqR8BoluT1M6fAqLMlaOD0lmrjyD7g?=
 =?us-ascii?q?NHFe6IHCFUsOVR1WE9ososfp8N+eNe5KJ9FwQOiaVU9WgPUhZsiIAtjT?=
 =?us-ascii?q?oIDU0ySS4qQgdG8nvV9wJFoQ=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2025 20:12:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1754158320; x=1754763120; i=markus.elfring@web.de;
	bh=71wbkwQdkjn5y7S/4EgALZTo9C7YLe8X/WjHeWR7VXk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=l58CAgRTGn2eHJsAtJzOYXZGNvnwwoJ01sE+4xsm33OSJKR7F7aF/kHnEAtWsyxC
	 hUmSObbNfa5zm057rkeDOZKpdHIop/WRvd2cJKBsiXSISndS5wafP8jCFc5YWOQq1
	 y4toqFFjNrDfK+ksAYvCKeStErHdx3CNshwCJutK4Fr4jGuoiJSmVwtm/gsozE+7D
	 AjX8Gqpm7EQC2EtDKe51gftsDXGXUN80wszzG08MMoF9T0NVRG7D2PQovrvmPlfZG
	 Q1/Fxl1FIT/Ahom2SqktUozkG59OhYyXrHkHJOlez08t92ZOiC6psXTvVzdYJJfZK
	 CESELRkw2KyWizspGg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.1]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MyNwm-1uRpBr2trw-011KxM; Sat, 02
 Aug 2025 20:11:59 +0200
Message-ID: <a86ce687-61a5-4e52-92fa-6a0d53db9360@web.de>
Date: Sat, 2 Aug 2025 20:11:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Erick Karanja <karanja99erick@gmail.com>
References: <6daf83a9-abbf-45f7-b82e-c6207364fd8b@web.de>
 <3cdb1e5b-72bf-475a-a83b-c469e0225c84@web.de>
 <23a375dc-e768-f2b2-1036-909be61596d4@inria.fr>
 <70a43c52-f898-4fa3-a4b3-16c54bd4f9cb@web.de>
 <c1d74aa4-44db-4618-ba59-e9b6dab28c0e@web.de>
 <alpine.DEB.2.22.394.2508021326250.3428@hadrien>
 <7560a81f-ba29-4b16-b8ed-95cb4d72f3f4@web.de>
 <alpine.DEB.2.22.394.2508021353080.3428@hadrien>
 <e0519749-0043-4cb0-a12d-6a34e2076f58@web.de>
 <alpine.DEB.2.22.394.2508021409080.3428@hadrien>
 <c5042d2d-43df-4276-9611-da4f30763940@web.de>
 <alpine.DEB.2.22.394.2508021502250.3428@hadrien>
 <6239d52e-3213-4083-8d97-9b1f59d2d5b4@web.de>
 <alpine.DEB.2.22.394.2508021745180.3428@hadrien>
 <2130ab11-8ec0-4e57-9a73-5e1ac9e41f7f@web.de>
 <alpine.DEB.2.22.394.2508021803360.3428@hadrien>
 <51664351-746c-4d7a-ae45-2a610ba45176@web.de>
 <alpine.DEB.2.22.394.2508021822490.3428@hadrien>
 <5e8e1f8a-6832-49af-bca5-41d2a13b1322@web.de>
 <alpine.DEB.2.22.394.2508021935250.3428@hadrien>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2508021935250.3428@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pkCtqbBgyBnBTtdHCQX6mnCNYy/WRjxzEAdOl5WSYmdbRuaP97J
 psOd5H1CFxSuvfFG9yoXIltg9nAmGIGeIDZubNW2jc5NowUPkQgnQzTlXIllOzYmk6X1oqm
 cVdM3R59dq0lrxrV8OvzskgDWOEcf2eu0RdODBhqcYYxkAu7OHCi7ElY3u2MIOzRoO5HtUR
 dAEUkpR70N97dxRhitn3w==
UI-OutboundReport: notjunk:1;M01:P0:lrL54t0j948=;hTX7+d7TqiOKgxRHmWAIz0XFQPd
 D6oWqQjnGaSV60nbhAdsGWsnfxv4SfJPVGD24K3yhC0n1C2nBDMyKAWQZNgZ4qj0/K45+hKv6
 C8with+7c0ufj7aT1sO+U+Ajea+KKq2uf92yRaYJo3W35G+bd46Ds3PQJbyQjK3CY/YYbI8j2
 JH1jspGVfPvB1C42wV3N0nCwdW1wbFCJVpoyb/hbWdL+PoWAnmJu1qt57YF3+nLCiLuqUhKL4
 wG1FwD/WOWQqt7hi9/aM72olB/jP9gyjsaxxl1b3HS5ELw53TOX20E/Lh+baoGqf518V50jEU
 CUrmw4haz+TTuOTSWcE6rd23JEdho+7GCfhz/znWgl2Fkn0MEh1BUTrkwGJFiX6cyr01vatEV
 FUi21XeBu5T4OmbfXEQ+j5LQtOJaHOCjic8i19sFepo2kHcC4Nn/QnTiB9ySlwdli5WzEAhOM
 peKThtsGU7rNW7FNXcxj5w8DvWlxKV64WOyQg1bnl8sNkYxm9qgjp/pZ2x8A2NCZA1XwCSrEG
 muB+Y2kZyZt5idQ/TOjE/cpP/qHLkLIOonImHiM+mp7auaW3HuSWA0aHH3I2+3KkwHxL0OKoE
 Mkx/J/VQRsJJzLlvfZrtdjVJzjCdQjiJ7DUKRUVEkhwcq5M7zj5g3baqMo55Hsf9VNh5v3J3G
 SVDVeNGfzkFKSytF4lVMyIAKi7y+M2vE7tGPomsIf1Q9c4wzXg7Xj7E6hRyxpzFXKrzVbO0E6
 AsAD62fanuSKqe99LoI701ByfyMN1owr2Sp/IYH4zF9s/rNA3eIK+tTmbmAfLjEVj92NJVUg5
 nxgeoArhRt1XjDPO3lUMmfP+ybJ+fyjfJxgU05z08Gb7bNcfQ3f+HDc0HFbO2fmglkXO1fwZj
 UYRgI7HFaN1hUI10oNWRnsRoE5bSRpXNEeboCCWPyqeRWo7wlPwalj4J1prRQLgptzFJaiaai
 op+KofObpwZuPqG3NxtCEmIRcHfeSjxt+qmLpkc4hwDud4TGX3qTA68vd+Sdzy4qK/nITuIj3
 Q5RetDt4gMlvQjUnLYiDDHg8YEqyst3W9Osq1Okj/F1BpnF9jzoNbHO7W1pF1BVwSlGhaiO3c
 U88C5+vSzgyskPepUyiftoS3wnUIGpEMOU8o24QBu5NhbaSQ/FlSWLw6grZrTN+V0iODI9Ph2
 oxTj7QZnDESi3b5SrcMRMxZxFhSO29/pzJLkGron89DrsWLrTCoDN1ul+Sm+Enyj25+ub6bUt
 aU4oT1ll7Msox1rBPfp1D0Nz5U/H7W0XrF5pj0RnP2vzLDycRDqMzX689/iGNB8q2bKF4vXQS
 Q4aQ6cIlHgBAp6LR6lTeNLLOMNUBE9vhW1DND2ThDG7GvUDvxb59GtqoBCYIaa+6CKKbn+5K7
 Tg/H3BB1Lm0YaAphBDsJSrkp/sudsbM2rFUmImryDwwg2KWnLyJEATXPe672gzuLDzV1ZwODd
 RpP3HP/WDix0tt7GE6GzUM79C0wUbMS6dkBLD1GOj9YsGW/t3SxO/V+s+eE96mQG1fWw5TQBi
 Fe+nUWK/069MoF/MldUwYK1sMm8gZp55U3T5ky5xtp36rJat6sCMeZCJcXtVuiTRqFeB4IbSF
 E3ZSDh1QM7LcKrDsymZ7+z1VF6pdpxfTCGpOLuxlwE20KnpfOhe+HZCHtAr8NOcKRLGQZ57ZY
 2tm3Y9BDhkjrx/JqhL10XeY8APjMXt/63mWCaZ+NLgrpRPg+QMrmvZQTnmfGJ9TuD5EXWIPfW
 1zlJ6dOk/A1FR/Sl+29jnqTBXlekqwtNOla8vCSRBYyu2CxTwr0lG89Tf9utepLPlfMjzinWH
 gn6gdXuXen91YLRdDXSvtg8UYebCzNdPEPThngCc3TZyp07C+4qoPBamdkfRw7GEBvYnEJp4r
 V12l00IcBoH9pBmbq4lle0gwffJj6mKrF8Y8SPYK8NzxoO9ZP9S//kaIGYdy47WGOwSVTL0Mh
 Jnq3zTjMleXI/hr0iFSc0Pufr6KN1R+lE1ga6qO4/+6at1iEbe843HX0GiJr364c8faPNWhUW
 tGE7qpa5WOomTwvyB7nJtp1WsONDoeFh1Nc3vv8HshHYm0i7lrHfJ4Yv2mXMb0oS6q0d4A1cq
 wTGeBeR5CQaS5k8AkE/v5LGgzkV1sYKO2NNpdlteSsouMyJdgEenYpTNhnPPmGAzOP4HXB4iR
 jJnt0QBhVE1VSyTPjFnUN3xl+v/+rClBytgGSffurAj7bkDv6FpNvFdlEQDtXMsAGkIdW5ZKr
 mz3Iyf+PBBVlNuDsZXbWqjBFc8A6aAlknGqsjGthV6EZljLaI9sDidh2l3ndc1gAmVSBMQmKY
 rk0ytZb+r0nVu3SccJ8L1e4goBy3P0cChHW/j1HCOq5SiesZAs3qtkt706E51LhR0bsJESGND
 DSXgy3cyW0kuIB1Tg4quiCYCxls+QIgqK7PBISHdpjFOca+KIzCnIDPXexKzOG70Q/71l+dew
 ZCPNCJ5ItRCgeMclCMegcURT2O4uZbkPIPRno/SSlahkPohl9QlePNDG2pvDn1/GVGg/bbDKO
 qPZFVSPA0MRA92NPndo0Q0nqLSkNuYdqhE0LV+zeBXm5yFBbncEQ4UkRb8mq/TM+m4hyhAS+H
 2YLQgrHek8ixBW84zDuOip/7ODaVM5lg3y2ip6bBCWE+xKnDblg8bJkSUCue3A+ej70mB0oyP
 eCSwHZYRdPkhvx1mnqT2BYaOYaaNC105p7yN2+OVZ702oEbqc/yu5UL2x6EVc/YW5pJWgYUB2
 4Pp+e+9JIckuS6r8AGNKEEdLoeVsBotknxWd79Pcm50sFlwwEN9eAM9uBE62BT2gei0PpHhKK
 4ftqNv00A1doeSeWRRja3cz4VtLY17L5tDUO3X4PTQBpuJPlY+WvjRIn+reZwfCYd3Z1AZ2g/
 NuHvIC9JaffAvegiY9bejl3UaLAM/xngoeLmnUXSHViOzO5EwTI4yBDIbgbAwsGvq4F7oY4FB
 kHpQFNzRtm+Lb22U8yFjEZeif8cksPD+KJIvB2xB2TA0blfmQq9hTPQQmI+/enMnQdbUlLErI
 3eWd7qNwV+xdkTazw7CgR0r4Blp7K3ywE3cO+yYXAV12Rd35SlURaNMI7g8sKflyeG6lLIPhH
 sdkKOXrak8+rsxLqszK1Eq/VpxkquHXC16rO1xakS3FrqkXb39pXTQ6fP2OeuzTepRYmYK2nk
 H0h44Noe5EV41ejBdcGm0nNGXIYxbtC38V0Ai9HXTDts/AP137Wyo9ig5XHi8x0ctuxxXqJDf
 aOMUQGCIrDcKubk9DMn9Zk/KRnJEnbgWWIBQF33FQMTEEATPFeIGup7OTfkr4Fm0HDiCeMvOo
 OMCvMs8oiwjSxrCflcP6RB9hxZFEqw7Bz0dYPw/Hhx68z6cLLTp63Q9NCq4oDvofCvhJWLNsW
 ug90DewuVWkDJ9lj1xV5JkfVOxIKnMF242S51O9hK+dT3n8+HIzKcZElJ+zOc5PHlMsptcgSI
 KAjZFOD+GBV51oWUE10vpcfs2T9i+cBvZlR+C2v8/PanLA/0tW52BwXY1OLkxKnwxydyztgF4
 nObIe8d3OPOs76uPka47cxuR1BqP04VFEx8gtLieCe8ToNY1++qtslZLoVJblCa+h9eUEagaN
 0Ajj9n6PHgs06a2DWtiWfmosxDJ65prJybf
Subject: Re: [cocci] Searching for lock calls without unlocking (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2945
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-08/a86ce687-61a5-4e52-92fa-6a0d53db9360%40web.de>



Am 02.08.25 um 19:38 schrieb Julia Lawall:
>=20
>=20
> On Sat, 2 Aug 2025, Markus Elfring wrote:
>=20
>>>>>>>      The one in the if is matching with the call closest to it,
>>>>>>
>>>>>> I interpret this hit as a false positive.
>>>>>> (The first lock call in the if branch is not the relevant companion=
 call
>>>>>> from the function implementation.)
>>>>>>
>>>>>>
>>>>>>>                                                                 no=
t the
>>>>>>> call at the beginning of the function.
>>>>>>
>>>>>> This is an essential requirement for the discussed source code sear=
ch pattern,
>>>>>> isn't it?
>>>>>
>>>>> No.
>>>>
>>>> I hope still that a better common understanding can be achieved.
>>>>
>>>>
>>>>>      I don't understand why you think that.
>>>>
>>>> The source code search pattern tries to find a pair of lock calls.
>>>> Is the passed expression determined for the metavariable =E2=80=9Cy=
=E2=80=9D after the second
>>>> lock call was found at the beginning of the function implementation?
>>>
>>> I don't understand this at all.
>>
>> Does this feedback indicate another communication problem?
>>
>>
>>>                                  Coccinelle doesn't care about the
>>> beginning of the function, unless you start the pattern with a functio=
n
>>> header or a ...
>>
>> Where does the statement =E2=80=9Caction_lock(&blockage1);=E2=80=9D app=
ear in the implementation
>> of the function =E2=80=9Cmy_action_test=E2=80=9D?
>=20
> It is at the beginning of the function.

Thanks for another bit of positive feedback.


>                                          But that the fact that x matche=
s
> &blockage1 n one place doesn't mean that it can't match something else
> when checking for a match at another place in the code.

This technical aspect can be usable for further source code search approac=
hes.


>                                                          If you hava a
> function like
>=20
> int f() {
>   a(1);
>   a(2);
>   a(3);
> }
>=20
> and your semantic patch is:
>=20
> @@
> expression x;
> @@
>=20
> * a(x);
>=20
> Then all calls to a will be marked, because the pattern can march in thr=
ee
> different places, with three different bindings of x.

It seems that this software behaviour (according to the functionality =E2=
=80=9Csemantic match=E2=80=9D)
was not officially documented so far.
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/3aa9a6ab3b035e31292be=
31399b99a8857480aef/docs/manual/cocci_syntax.tex#L1214-1225

Would it be cleaner to use the SmPL construct =E2=80=9C<+... =E2=80=A6 ...=
+>=E2=80=9D accordingly?


>> Would it be possible to determine that special control flow from an if =
branch
>> would be inappropriate according to the mentioned SmPL code?
>=20
> If you don't want a match to go over an if,

There are further constraints to consider.


>                                             you have to add the if to th=
e
> pattern to specify that.

I do not like this suggestion.

It should be possible in a simpler way to point source code places out
which start with a selected function call combination.

Regards,
Markus
