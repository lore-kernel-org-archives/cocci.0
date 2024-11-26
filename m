Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A85EDD65552
	for <cocci@archiver.kernel.org>; Tue, 26 Nov 2024 19:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Nl41yQuNhLDumIJ1Ga2QI5Gbwss7NQREmXng8iZduLs=;
  b=Wz+Rlm8H9q0vafjic8SaOiaVxgUSi+v9BuC0qZwusrykwGOEvtDkrIdt
   su4TTBFpD2kV95R//7KEdcrMfbn01X57VKBT3r2zHj9GEE8aXJ3KuFxP2
   X82hteZuepmEbUVXzmWhdcu7LBiMM3L/UpCyMKlNj2n/SMwuq89QpNYS8
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.12,186,1728943200"; 
   d="scan'208";a="195950739"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Nov 2024 20:55:20 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0ECC6E0D1C; Tue, 26 Nov 2024 20:55:20 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 4D61CE00B6
	for <cocci@sympa.inria.fr>; Tue, 26 Nov 2024 20:55:19 +0100 (CET)
IronPort-SDR: 674627a7_UgmJsTDXfOYIl1nmi4vDQvTpNABT6Ls+V6u1F0uR8UFBBxU
 qprVC6NYcAW2UzYYgIvSSy1HoAv6P+ZhcQIsopQ==
X-IPAS-Result: =?us-ascii?q?A0FoAAC9JkZneAMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UEFAQELAYJDfQZUMwQLSIRWkUEwhDuPEYh1gVaBfg8BAwENPQQBAgQBAQMDA?=
 =?us-ascii?q?YIMgnQCilwCHgcBBDIHDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGA?=
 =?us-ascii?q?QIQAUMOCjGFew2CYgGBJIEmAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQECR0QBAQECASMdAQERJwQLCxoCJgICVgYBFAEBgn0Bg?=
 =?us-ascii?q?i8BAw4jBw0GsRiBMoEBggwBAQaBWEHYQh8sIleBZAMGgRouAYVpgmIBhiSEP?=
 =?us-ascii?q?CcPgVVEgTwLgng+gmEBA4Feg1uCaYJEeUGDQxIlh3MlaIN+g0aGC4EwgQ+CE?=
 =?us-ascii?q?Ik/UnscA1kyAVUTFwsHBYEpISwDgXlOf4E2gVEBQoJOSoMugV4FN0eCSmlLN?=
 =?us-ascii?q?wINAjaCJCRZgk2BJQQFg2mBC4NehFuGKB1AAgELbT03CQsbBj2hJkeDQWhZA?=
 =?us-ascii?q?oFDxwQ0B4I4gWWBYwyKJ44thwUGEy+EBE2Scg4GknqYeyKCNIsqlVoOhUCBb?=
 =?us-ascii?q?gUugVwzGiSDNk8DGQ+OIQwWhAuBC8ZSQjUCCTACBwEKAQEDCYVGAQGLVoFLA?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23:Orx6bB05fHcHWjqFsmDOnw4yDhhOgF0UFjAc5pdvsb9SaKPrp82kY
 BeGo6kyxwaTAc2bs6sC17GO9fi4GCQp2tWojjMrSN92a1c9k8IYnggtUoauKHbQC7rUVRE8B
 9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUhrwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9I
 Ri4sAndrMYbjIltJqos1BfErWZDd+BKyW91P16ekBjx6tuq8JJ/7yhcvu8q+tJdX6n9Y6k3Q
 rtUASg8PWwy+MPlqwTIQxGV5nsbXGUWkx5IDBbA4RrnQJr/sTb0u/Rk1iWCMsL4Ub47WTK57
 6d2UxDokzsINyQ48G7MlMN9ir9QrQ+7qBx+x47UZ5yVNOZ7c6jAc94WWXZNU8BMXCFaHIiyc
 5UAAPYAPeZAronyuV0OrQelBQKxAO/j0yJEimPq0aE/1ekqDAPI0xE6H98Ws3raotr6O6kPX
 +6rwqnGzTfMYO9Z1zrm9IjIawosre2QUb5uc8fcz1QkGQPfjlWXrIzoJzSb2f4Xs2iY8upgT
 v+khWEjqwF/uDivx8EsiobUjY8SzV7L7z95wIUoJd2jUkJ1btqkEJVKtyGbMYt2TdgvQm92t
 ykh0LEJpIC0cTEMxZ86yBHRd+aJfJKU4hL/SumROzF4iWprdr+7gxu//0mtx/HzW8S00FhHq
 iRIn8XNu30M1RHe6smKR+Vy80mvxzuC1wLe5+FGLEwpmqfXN4Itz6Itm5Qct0nIAyH4mELzj
 KCMd0Uk/PCl6+XhYrX8p5+TLZV4ig/kMqkoh8exAvw4PxAQU2SG5+iwzqPv8VP7TblQk/E7k
 rPVvZ7CKckfqaO1GQFY3ps55xu7EjuqytAVkHkBIVlYZh+Hi5XpO0rSIP/mF/exnlWskTZ1y
 P3eIrHsBIjGIGLZn7f7Z7l97lZRyAotwtBb4JJZErQBIPXuWk/trtDZAAE2PBeuz+n6Ftpxz
 oIeWWSRDa+FKK7er0KE6vw1L+WSeoMYuizxJ+Ul6vL0g3I1gVodcrOo3ZsTZnC4BPNmI0CBb
 HTrmNgBC2QKvhclTODwh1OCVTBTZ2yzX6I66TE2E4ynApnYSYy3nbOOwj+3HptNaW9eEFCDD
 W/od5mYW/cLcC+eP9dtkiYYWri5V48hyRauuRfmxLpgMuXb5iwYuIn41Nl14u3TjQs9+SZ1D
 8SbyWGNTnt7knkGRz8sj+hDphlPw1yAmZJlmP1eXYhB7vhKFB0nLp/a5+ZgDNn+UQXEONyOT
 QDiCt6hCjowZtM32d4HJUhnSPu4iRWW+iOwAKIO35GPCoY19K2Ui134PcVg0DDr0Kc7jl8pa
 tRCPyuqi/gspEDoG4fVnhDBxO6RfqMG0XuIrT/bpYLvlERRUQoqFL7AQWhafEzd69Lw+kLFS
 baqT7UhKApIj8CYeeNRctO8q1JASb/4PcjGJXqrkjKVDAyL26jKQY7kYWQb0w3CBUJCnw1At
 W2eO10GDzy663nbECQoEFvuZ0329uwrjXqhTVIviSyOYVdg0bWd5RMfw/CRGLsIxrxRniAnp
 n1vGUqlmdLbD93Vvw16YKBVes8w+n9C0n/F8RNwNNqsIsiOn3Y4dAJ69wPr3hRzUMBblNQy6
 Wktx0x0IL6Z11VIc3WZ24rxM/vZMDu6+hfncKPQ1lzEtbTesq4S9PQ1rUnitwC1BwIj9Xtgy
 dxcz3qb4N3DEgMTVZv7Vkt/+QJ9ovnWZSw05oWc0nMJU+H8lzbY2M8yQsYhxAyhedh3L66OU
 gP/UoUbC8WoNO02ig2xdBtXdOtW9aMyI4anb67cgfTtZrw/2mv7yz8UheI1mliB/Cd9VOPSi
 pMMwvXCmxCCSy+5llCq9Mb+hYFDYzgWWGu50yntQoBLNcgQNc4GD3mjJ8qvy5BwnZnoDjR9/
 USgGkhA9cunYxuUYHTi0AcW2Uld8hnF0WOoiid5lT0ktP/V+SXUwPn5MjcDNHRKQmZKklrmZ
 4S5xYN/PgDgf00ikx2r4lz/zq5QqfFkLmXddkxPejD/M2BoVqbYWqOqW8dU89totCxWVL75e
 lWGUvvnpBBc1Sr/HmxYzTR9djewu5y/kQYowG6aKX9yqjLed6QSjV/67cbfWOUX8z4IXih+h
 hHIC1L6M9Th8diPlpjFu/yzTCr7D8cVK3O0i9rd8nDz7HYiGRClmvGvhtDrdGpymTT20dVnT
 2SArRrxZJXqy7XvNOtmekdyA1qvo8F+G4x4js4xnMRKgCJc3M/KuyNa1zygVLcTkbjzZ3cMW
 zMRltvc4Qy/nVZmMmrM3YXyEHOU3spmYdC+JGIQwCM0qc5QW8L2pPRJmzV4pl2goEffe/94y
 304wOEt9WVcruUHogsrwQ2CD7pUEUQSbkmO31yYqsuzqqlafjPlVLGq11dl2/2lAquDpA50R
 3vzPJsvV3wVjI03IBfH13v97Zvhcd/bYIcItxGapBzHivBcNJM7kvdZzToiI2/2umcpjvIql
 RE7l4/vp5CJci8+mcDxSg4dLDD+YNkfvy3gnboL1NjDxJihR91oSDAMQYeuUv+iVj4f/f21M
 gGTDHgspHCBBrPFEUmA5U0go3+qcdjjPiOSI2QFiN9lWR+WKQpAjQpSUDhyl8w8ER22gcf6e
 lp95XZI71j0811HzecNVVG3WzXaoxq0LzwvQ5+FNFwP5wdOvgHeNsnW+Ot3G2swEoSJiguLJ
 yTbYg1JCTtMQUmYHxX5ObLo49Dc8u+eD+74Lv3UYLzIp/YMH/GPjYmi1Idr5VPufo2GI2ViA
 vsn20FCQWExGsLXnC8KQjAWkCSFZtCSpRO18Cl65s6l9/GjVAXq7IqJQ7xcVLcnswixmruGP
 vWMiTxRLDFFytUTyHWOxLVelF8ehidydiW8RLQNsSmeKcCY0qRTDhMdd2ZyLJ4Stvh6hFMSf
 5eGzIims9wwxuQ4AFpES1H7z8SgZMhQZnq4KEuCHkGAcrKPOTzMxcjzJ6K6U7xZyutO5HjS8
 X6WFVHuOjObmnznTReqZKtphTuYIQcYlYWzaBdrBkD8QdigZhDxY7oVxXUmhKY5gH/HLztWK
 T9nb0ZEtaGd9wtdhehjXXNM5DxpIKPX/kTRp/mdIZEQv/xxBy1ynO8P+3U2xYxe6yRcTeB0k
 i/fxjaLi06rmK+Dx2g/OPKvgjNMmZ7Nokhof6nUpMEosZns4x8Hq2mdWU1img==
IronPort-Data: A9a23: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
 YT4eIycfHyGdA==
IronPort-HdrOrdr: A9a23:mnvEwaMFZ6Ssw8BcTh+jsMiBIKoaSvp037BZ7TEVdfUzSL3gqy
 nOpoV86faQsl0ssR4b9uxoVJPwJU80sKQFhrX5Xo3NYOCFggeVxehZhOOO/9SjIVydygc378
 ddmsZFeb7NJGRbyeDn/QK/D9Es+9Wf9ru07N2utUuFATsKV0l6hT0Jcjpz/3cGPzWvjvcCfq
 ah2g==
X-Talos-CUID: 9a23:AP2EQG9adNW9K01MkJuVv0ASF/w1LUCG9kf3Pl2ZKkVkc+3OaWbFrQ==
X-Talos-MUID: 9a23:eeT5xQjfGOvaIVpdUzrZn8MpBv5M/bnyVEM2iZxW4cOkbglcIzKPk2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,186,1728943200"; 
   d="scan'208";a="195950736"
X-MGA-submission: =?us-ascii?q?MDF98gklkfw9K45hh6Rq1rUfgu2x3SfHM+pLOU?=
 =?us-ascii?q?3Hu8HQMrjvmYb/aiVr8Derme5/49j49flShnQ1z+7jiYvcHIzRjEtyTF?=
 =?us-ascii?q?FzcKxJGge6J6mtAkWEsR0u3rHkKngtFEoOWy0yyaz1OxFRSunfUGUB/6?=
 =?us-ascii?q?k7ly0NwZrd8qoQKSNl8NYPmA=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 20:55:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1732650918; x=1733255718; i=markus.elfring@web.de;
	bh=Nl41yQuNhLDumIJ1Ga2QI5Gbwss7NQREmXng8iZduLs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Kut2WcUyo3MtD97A71/LxWr+j6nZ3PzDqExCNDQATDSIRCLGJImf4LIwZDAmfOXV
	 gFVvsw0H055mnvJ3MI4mnVzW89UlPREEwJDB6JGtHmJtcA7E8pj1dPt4nNSESQn3r
	 CNPF9HAqNMKjKYL/aNQrwjyixEQdCvXA0q/B+WhvrOJbLP0nHn+ynE7412KcGc5dk
	 TlV4gcTmzViHylu4jCj88uB8SBrCJEzbbzycymX9qw1h73Tl1t093pm5w9GfzT0tj
	 Z8DddRzOpKQ+8j/BOXTu9tARnPgd685sEXZ59V/qA5Va9LgClxSE3GKADy0Xl6JnO
	 S8Xjszkzol6qnz4deg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MDv9M-1tNgcD2cq4-00Cv7o; Tue, 26
 Nov 2024 20:55:17 +0100
Message-ID: <dc50f13d-6b93-4a3c-9976-87078e5b050f@web.de>
Date: Tue, 26 Nov 2024 20:55:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zack Rusin <zack.rusin@broadcom.com>, cocci@inria.fr
References: <CABQX2QM+cBpVhcBYRae+W4n5a6bVJ=sC+zu9GGj0veiqvU2_4w@mail.gmail.com>
 <81d0c6e4-0d7e-4f40-99e5-d4229613348d@web.de>
 <CABQX2QPEz7ukgtt3GS-t_UYcGJTuetkhWS=nf=7r9sz+wCDopA@mail.gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CABQX2QPEz7ukgtt3GS-t_UYcGJTuetkhWS=nf=7r9sz+wCDopA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5gnESUfIrr9sdj2xunPvWP2uI5i4ngJXhJA6EtXkSbuLMRregg9
 kXecQNBmIHYwPJNIROaxiDujZIEaEHyU7gQOhqVQ5uRrzdm1UO0fCycBsQgtxX/4dTSHVLc
 hdIT4AwoaWG1MvWKkCXfGJxoNj4u+vpHOLpgBz99Yu/8tvCAHIIWE7yldwgBoeO9htkzv6p
 dXrcrB/zD6S+ebGqrkARQ==
UI-OutboundReport: notjunk:1;M01:P0:rJMKhkHtjr4=;nI5iswR8oEpLKfkA+Xsh3c6KTYO
 CST8y93j/N5Gx4Fd2N0xzLoDV8ZZOIdIchX0ixKvSH2yH6/Y1BzvErMEHL+3Kx4OcD2D0cNax
 aJ/9h/0P8BHCGtTSTekv0VqxcsA65BAIYs9/NqV4syStHI+0Xxc/rvqjbtMyCJ8d3Xo/qDLSI
 85Gdrns3UGvWZKDbLzFahqM+XD/GpkmEA2rLydGoaSC7Q8kBUBOUBbdO2KbdyGUn3AwdtePyi
 lT41vltpE/n0Qb4V9eBxz8wDF50FNpJIQa3z9RDpfWRDBkrj9fE1sYDee8P2r+NhzC7E6XRCV
 RGGkB9WWZdWUW+hcn/M9K0reIU8YAZpYKKx/WDXGHHEoSCRdc0b+aIZsCCEeA2OsfNGrdUcB3
 U3IR7Zk2RWEznr7RXtxMd0F13q9uu5OA9CvGTFHmVBwFOYSFyn9YeWpnNnPFFq4oNOaZuuh+/
 qqeqUx4Ie+mMfUn0hE4S6clH8kCNYex3KSRSoGNgFle9oshoo9i2xSY1NHb7aKE8mmdw1E/O4
 I2tVWLQyKSFpAWiOjdTjs388nyPpfhY9hhpY+BCnpuhLk2C0IBupfpDgxzOYMCuhi6IxR8rjI
 HxazIAL6mZ3j9uRjrfgYpLbbWJFXR7nEjDqZ8HRROGPsqsshsh8yRSYn8xM0LZnxCmMznffZu
 +96UhV0+o8iaszL6nm5HCHOfgt3eDiPz6fitzLu1E41njX0rfMUEfME7m3tWualbSpG5fZ6fk
 ks8Va3KakGmonCkWwJ8WuA/rWzv46DbdHkh2N/5RlXrzjdqIosM9FPqvKM3Y8/en0fDozy93D
 x1MEJA7WhS66ZwhGzCDhS3cU4puL3adpfaeSfrvCouJnmJrGFZsGDaQ+hoggxks9cz6IlshG8
 mhDtSHYIFlRYBPHNDulRzow+n7XJwda1mk6eEOg+Ib0DrqSjSFFDHiPzn2+0U3dbXtEE0wcK5
 s+M1wigg7JS7zPfVQDljJ6uoRDuhDzHoiZA8cRd6xaptLAr0wLfgwZRluyPyLKGWoSSS1HRA+
 h5Iz7ADcfREQRtgy9h8cB64EbeTHEjp4PrmoPNyEEEFqBJWOlg4iHfGNS+imPL9c07kqKYCC8
 SFJPgwHaU=
Subject: Re: [cocci] Replacing type names
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2133
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/dc50f13d-6b93-4a3c-9976-87078e5b050f%40web.de>

> I think in general I'm just wondering whether it's currently possible
> and your thoughts on doing this. In general it would seem like if we
> could get "fresh" modifier on type and function that would solve the
> problem, i.e.:

Did you notice a known key word in the available software documentation?
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/04f71e76b0857ca12ec72=
07b26368df78d2b57d4/docs/manual/cocci_syntax.tex#L200


> @replace_types@
> type t;
> fresh type renamed =3D script:python(t) { camel_to_snake(t) };
> position p : script:python(t) { needs_rename(t) };
> @@
>
> -t@p
> +renamed

There are further design possibilities to consider also for
supported scripting interfaces.

1. Searching for update candidates
2. Selection of new values
3. Update applications


=E2=80=A6
> but I'm not sure if this is a task that Coccinelle was meant for in
> the first place.

Source code transformations are supported to some degree.


>                     =E2=80=A6, I was thinking of also doing the camel ca=
se to
> snake case conversion with Coccinelle to keep the transformation
> pipeline within a single tool,

Higher level functionality is provided.


>                                but it seems like just a regex
> replacement over the text using python/perl might be an easier
> project.
The usage of regular expressions triggers risks for the safe
identification of some source code places.
The identifier generation algorithm can probably be also
improved considerably.

Regards,
Markus
