Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90215EA853D
	for <cocci@archiver.kernel.org>; Sun,  8 Mar 2026 18:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=NCU0aeR89nb/2zN89GgzVDrEAhsjD4DwlbYbLlnlbdU=;
  b=o7dg6ILYWZYZNDkhO5zTQkAGP29Ua2DbzvTG5PScVMFboazIQSGfOv9N
   8Dovtv73IqgBf0sHdRfFSxTTzI1B1rVUOeSOQ7jDHfvR8Jv1V6LM2wB36
   z0P9NV00O7ev/2UxR1LK8mX4OXiBEiux0ZbVwHqOdDylcVwu1OlzRgFWo
   I=;
X-CSE-ConnectionGUID: lxofGBUoThKAjgwRdWKpFQ==
X-CSE-MsgGUID: +vooInBSRn6E4swy0SEaww==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
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
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.23,109,1770591600"; 
   d="scan'208";a="266755310"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Mar 2026 19:30:24 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 2C95D81649; Sun,  8 Mar 2026 19:30:24 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id EDD6B81236
	for <cocci@sympa.inria.fr>; Sun,  8 Mar 2026 19:30:21 +0100 (CET)
X-CSE-ConnectionGUID: PIBbmlWlSBSCjkHueAPQzA==
X-CSE-MsgGUID: zFn1toEfQOOJRfs2j+MsEA==
IronPort-SDR: 69adc03d_c8TkPifs1jozJLXdR74c7MXeQt8R0D7f5X0iNTP1nLgcyit
 4XGur7TprpW1OkBulcQhg69TG/00ppMKz5Us8fw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GAAgADv61pgA4P49RagQmBUIJBaB9eNAQLSYRYj1OCJ?=
 =?us-ascii?q?IQ7jxGIeYNSAg8BAwENSgQBAgQBAQMDAYIMgnQCjSECHgcBBDMGDgECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAQE7Bw4KMYZPDYJiAYEkg?=
 =?us-ascii?q?SYBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQINO?=
 =?us-ascii?q?kQBAQECASMdAQERJwQLCxoCGA4CAlYGARICAQGCfgGCIgEGEAEDDycHDQarV?=
 =?us-ascii?q?YEyE26CDAEBBoFGAgwCAkAB2EsfLCJZgWcDBoEfLoVvgmUBhi+EPycPgVVEg?=
 =?us-ascii?q?TyCUjE+gmEBAgGBXoNbgmmCJoEOjF2GTlJ4HANZLAFVExcLBwWBI0MDKi8tI?=
 =?us-ascii?q?w88BS0dgSMhHRcUH1gbBwUSISqBaXiCAQ+GaHkDLl4aDiICOlxKPgoBWgWCJ?=
 =?us-ascii?q?QIBC209NwkLGwQ9jnI+gxVXAsh6NAeCOIFngWQMii6VPwYTL5dSDpMLmQYii?=
 =?us-ascii?q?22Beps4gX4kgVwzGiRPgmdPAxkPji0WHIN1gQuDVcQ6RTICCTECBwEKAQEDC?=
 =?us-ascii?q?YVGAQGMVoFLAQE?=
IronPort-PHdr: A9a23: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
 EZetw==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:bFjjoapccf8t5o3wTPJW2CsaV5r1eYIsimQD101hICG9Afbo8v
 xG+85rrCMc6QxhPk3I/OrqBEDuexzhHPJOkO0s1PKZLW7bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QEZSWY+eRMbEVt7eY3CCFM5IH3MSN9ryuiNzT1nF3UGhRGttdBktCazpyCSdNNXF77HcCZe
 GhDkErnVCdRUg=
X-Talos-CUID: 9a23:SyyV2W3T3+mWUiPjtZ2s17xfIuEPeHjZ83PrCXSTC2VJVbC8cWaC0fYx
X-Talos-MUID: =?us-ascii?q?9a23=3AwpPabQ6UrcVj0whrc/iGiukgxox6zaL3FEcgn6w?=
 =?us-ascii?q?hnOu+OzcqOXS4lxmeF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,109,1770591600"; 
   d="scan'208";a="140726049"
X-MGA-submission: =?us-ascii?q?MDH1rJUQuH/+dI3rc/4eGJcZM/RYxfjst1eAo8?=
 =?us-ascii?q?ZLqXdNdNvd6rDRNyhclvR3qUN6cehCdNaufRtEbp0egQ0eTiVfeW1tf8?=
 =?us-ascii?q?0dd5luxIjSFCIDtl2/bI4wELrW0DkQFdeF2+SP1lGgvAWx1cASAAJlaz?=
 =?us-ascii?q?nk9Bl3WcBm9pwT8uvKxj4r7g=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2026 19:30:21 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MgzaT-1vQpDF1rif-00orGQ; Sun, 08
 Mar 2026 19:30:20 +0100
Message-ID: <8f94a463-e9ff-4b67-80e9-728e0a44779f@web.de>
Date: Sun, 8 Mar 2026 19:30:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <349a12a9-f70d-4c8f-a730-9f8ec90b593f@web.de>
 <f25025ab-4500-4315-b41c-53cd5775c69f@web.de>
 <20a815aa-5fa9-4b34-ab81-d6985ed193c0@web.de>
 <bc3eaab-b09e-4e67-054-b522d723c6a@inria.fr>
 <576f0704-7ceb-4e0d-ae1d-1beb1eb1efc3@web.de>
 <92db939d-8643-3bd5-ab3b-29605d36d29a@inria.fr>
 <0a740db5-eaae-43c9-9b73-d9317a1a92c6@web.de>
 <be59dbcf-c9b-745d-e15c-e8fcefaf40e2@inria.fr>
 <cd1bbe8e-ef35-408f-8754-173678bf3204@web.de>
 <f715289c-54d3-2c0-43fd-e6669973c5e1@inria.fr>
 <8ceb30ad-1143-4086-afeb-45b639c87e49@web.de>
 <1265ed1c-65e4-318e-8186-618346a4802d@inria.fr>
 <f12f438e-a89f-462a-b166-d6af025cdc28@web.de>
 <aa67fc7a-62b7-b6fd-d860-fd73623e6b77@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <aa67fc7a-62b7-b6fd-d860-fd73623e6b77@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:muv++nf5PT5yN+SKp9IQe0hvKQsiZCvNVUO02LYRdrLnPVdWX91
 9gK4wvgDU3lDwpEgQBQYO7jeGGuIWM9ywzV1zue+R3qIysWJHzImpV3YwcgXDwQdvA80xjV
 CmlWwASbrERlLXkU9WvJKXSIT4x561IUQKn49oRfRgg+2H0E4Y5Ng684esk2Mmrmx3EUv5Q
 /CwTo3L/7OxYYB+GpcUQQ==
UI-OutboundReport: notjunk:1;M01:P0:bmkHT99SPYo=;ErTvxV22KQjRsV9drdJvf2pxc1x
 8Cr+2DcxUsE1ArgOYOsYhkT3gfBZA+d3B7LsZ9wXi2KVOYugnB49YJCMxCL2gWMLRlTfrCfO9
 ry/w5T6/+Qn+gP9xV4gtvo0kYXO58DD37QWkVqrBpgRLccHk7VpW9Unmw//12ix+sxgHse2ZZ
 JWtMROa38ZH8j7YBp7NUJS52cJG1ELktwyzK/+LysyIy+OiZKWUrXU3oEi1xCd6+QC6Ur7yEY
 OTMuuhXfK8DYSOWpLJX5sgiTYNQmHVVskWYQsnDP09WgTlryf8OmCWK5luxhW0eRUsTeIY7bf
 V6JSFsHqIqkSnWQuFGUwnX3C0N6SIhz1tUH/SUqk3H0oAtOzP3doSal6xwH0iEpcnypYEzRCc
 6I++WLJAuTeoEP1YGGi5gmoQQPnvoCZW4LD792gSIWIjCZ7ntBS+Bwiw9JLOiHJ74h4qtLLk1
 USO31sMVZWbGuZvC9mwH0xPoRv++tmCziu1mjrOsRnv325L10aey/yo5KN8d8IX850K0JlUkn
 ELf4JNg5oFH/PpsOUFTsONqFc/GKHIsFKmyf/NnL7xRV1c2ScNOrybjqhu/xLfd1e4IXqPMdL
 4Q+b+H5WF3N4DM85yU1+D1zIc7Rsoema+0Ca7bCT3KVF/GK3kNXMfZQrNR1Vf7MGy1OzDRC9U
 44pgjGgBYe69sl7lgMGSEDpNFKirAaeROk3acttXzcwI7tYVZSrI3j/ED9stLL0u7bqHp8AF2
 PiagexL2byyN/Vsd+Bqb2CnVqB3d8WRQpgiXA1PdyvpALIdMFsb2UcKpwtiaGq6AkmZy1l67+
 tzMSPyLHKL19YChKcr5Ly8Ll0TTRyQRTfsLLr6BVu0XgsBZYmYo+OoCq0nZ/d00B131DQ0k3g
 bRDj5ax5ajyUG/+i9KQUelvoOZlBUKwPvmWHlOv9JAIDlg99GHLIXkyaIuxAUWUyuko5t6DBN
 ozyeSKmh+k1haZGcpKvwmwpQQvagaGwqAEWFGmDiD6X03fCKFhESPMvAx9GFLyko+Klyby7i1
 dCVlULPz+T9ZZoMBwiZtpZ/V3RvhT/rsu44ASd4Eh1V1PMlmS5gA4tM+Br6GHPgnlTC/Wi5wU
 oj0O8uUrpo37Tw+PEkCfzS8+1C3CpFTAp6C38s6Dc2YQouCyNNe+9WeZQ8UzyP4oLxb5tKpM2
 K5aiyOcWsAH3TxTqZozfHgOUKjivRlMYAtYp3m1SR0I1xXWbsA1t6jS8RLa8WSQVWuAIwEFNL
 B9GU+IOYmI0Mc3sri3YXfdcqqWcnsDvW+HiMV1UQASGyBAlRMoUDrWKP2Tf2m9QAusbJT+yB1
 JE8REPlyiJghrwX+VPuq44pGPQC7axbUR8mNiLo8v2becfwsoi2i/I047EOMUX30NwSMF0hH3
 YPoDqknDNsB2JbqotD07VA+aK9pfxzwlFabHacwfALxM7yFMniTkOeJyVHafn98/HWNtx4bdy
 j3TnCGKbtpvuCrg/teNwuoPkkO/Mxed9EvrFRmG0FBSJMa4BuzjF7LgWsfQv+4wxm5gyAGfnV
 tKs5B+7vRdp3rfuSggMm/dUGgpXPJi1Cm+Q5cGgfmeoOUB7MlWfpFrYrHP3szXFXEf5p14rKv
 5u91ZAFB81PpmVvSfo7a/DYU7K47lMOW2dkvyjKjxb8q7xFSNy33ROBokaWdjMGGTh02lZVzK
 huK5l9e7iCvD8YwFhXqYpmXfC0y51p9AI+wqaClgXu4iVISBk2fdwApWFdWBB6o5RB0fINjsc
 AsE39JJprXJL6xUDc6HUJkektF9QJDEF00YX8OoxFs09eaR/0Uoe7nsLjlswrT3/P1qMdUY81
 4Y0Z3GsGvGaBobhtiCXx/HPkeLgkS6bjBy57XBkDzqPQUt5FWWQKA7yyNDZWEO03E+PLedH7E
 z7Yitx/Y8wDaapQatU+kN0/1KXMw24dqmScAlr2yo8eLmetIoiIn88SFn8iWVuojtTh6o/cjk
 +YrwrcF6teqaDCr3GQv5Arjpx+JJTuq++DRKb3fbCb5dTf8iVUyd0EE13IJzfbaPybOEpJehT
 evcNRmNOLiHo0JvPrI8G+/5M0WxJQyGJ14rgSSkoZop9vhrJpSQsltvull9Cml95k9vlYo6aT
 8SBPdQUBm7WMqZ+R/2NH2J6ushB33QBvU1Zl7L3GAOkgbRwG3nlOkgdJiINhp36hhiNVflw4S
 K/SeA1qJCZ0iv5CkN/aSom0U5DDVII1lxsS7dxifyOcYbTe4IlPy5pCmijnN6wDH2OK5jKY6I
 tB6llZ0Q2cqzIVajEK0w/j+5QeIecjgIMxiV5NKxvr/I1H4OsvZmjzz5AaPbVQohvImtapx6m
 rfofg42Dmqc1b9lS7UXqrfru1BAfRsvMur1r2r2Hf70ZbES9THFJtWDW9bKqS3R/wXJcAxYb0
 pISlckYH2VhWQ+6wMwUuD0FtqxDDrccrEwU9TNtXhQ31dcCTrYSPvNdqJy13dnKahHyj0l/xN
 do/oWZttXk6kGDRB9MmYW4MNlWwY/nkBZ6wTVBa+97qiDsFJftEbdUKQFDb836xXUNo0iVrbr
 T1yP0R/AZfKfcwqeJGn+GUySHpXKLuhEg2E+1I1gpeUXqSVy0dWTazASkoz5Ey98viBPZArFl
 KQ7WkfnR2CywCdU58Bzbn78tQlDn+YGZz1SOckj0M+0c+pRmy887FqJfaQ6koU+9w/Y1aWMxY
 QiS5UNolLwTwJNeM7t0I1TXFGnPTCPbM+oVOj42RypGjVgVuu5RPjXNNvxHO74JTfMH9vD+Ez
 vFY+8p6gWq389fcc7QW3hoKtsQgKzlwRzASFRPLasRIwZEi8X2NPii0RIbmjds+rHsewsrXPF
 TQuPMxA+L9L6+E5hiVb6Hn4LjHj/MGxNcfnAJqVfm0gfExUhWz8o+vl+UUEKb8GgAlEzObd0Y
 EzkBOsqacZBAUIegETCpmv4zyrFbouVXNaQQ9obtQc7OIHoRd3daglBvxy4Ry/VDh/OQKGqai
 /yujKBNX/y4H2apQONljxZA0SfIhL3lUTMYxN/jUsfNQEbO7FcpKpzvc3p6WgKcxT6ZkJKZwY
 EoKECTOkUJvdUV56cP+MkyM5MRWd7sq5Nj1WI0JuRSslx9jmQJ78R8+L0nCXk7e7Rio9kJGuB
 aNI/97UE+pRvEJBLMn4BTno3EL4lXuSKBtJRis+mvwg5tvbU53JmopQzURTY8NSV0TxVasvzf
 3K8rke5entNF1FcJ3AeDs40dfNFQfisxXPR8FY3smTg6fcE8JnfMAOnhA+GFBBp68+vnYqpMP
 lB80zoE//I/xzxh8seBfRo7jn9KBfcBK2NV69Q4W5l3Ti32im1+4VjRmg4h8PMOuCw5LvYtSD
 TmjBPuacZXduXm/kL9/Y29I2fNIoBh4PA3lF16IX7843rqLOhS4pHRA9HhjOxPRQowRpSJ6+m
 +8jkQYUxsmsBcIMjNR4/3ZPjbrCYOJxmxCnNKEDEJqr9LBHc++r7lpvUfoZc3nI5UtIamuxKK
 11l0nVLmcZ092DCqHEdi8Jbt7XO4YDQge34+BO3ZTzDRtUYB9NTiRkSvS0yyQfy5TAPhQeKyS
 QZhvdw+7vRKLPp+pDm0s4eOw6jrBlDCSiARvuKR3zqtmwMzz9HjHxWc2gQyv0TErBOm8ebcXu
 vIFsZr64WG+iSTOcKH9VkjFvIp0TsQbmoMHi31YvhtCbye1LMXxrYhh5urr4G6mQeU7N61/4a
 DQTHiLstzcWaiR2W7WX1h3cbvS6PlAftxOfXfqGg9/zN4VwuuQF6WCxqoJrpE80kSg6GJtGj3
 N/VilqCRdexDOmYDBNCgsB3GTirNzQPiEiI9Oe2YvYXeFIQGhufNeUuNGRLFenPcq+TKP95Zd
 dVC+/3RhIkLM0WToG2GiXgYD9mhfOj3+lyrCqSOvXbAmbbA/tRG5s3za02x0ZEDSdVQr+HNhw
 cioojVndZyf9UB48hhyGSraMXzxNMYGh6o2EFLVdTtiMhpJygXZh5gWLb6XvZmDsa0WupDggT
 r7qGuz1gD2/wF7REkYPKdjvsz88IFpHXC728pCMTKg8GJKYE+tsBMcHQWuViqv3CHLYLFy8+N
 kNYLnW4qkc/wzWJdty5auKHRp9JqLfBH3H1LDP354Uz1fmPT9UdrDlJAbaiwiTbEWYhYZ25re
 sgtr5lsWu/wiYOz7hapxgTMGgLdeR0QS27r6Z+YZMFS3ZhBcptV5HKaC7leupbwV2YBrbOekk
 Cl3NPiWx2oNPdjqrywTYCE2Ab8gRGEzYSXJcvZR75SyV27ZVxQHKcjmbRK3hjFjrDM4FRfpPm
 YPVaWDuq+UG5UnievbF0q4Je1CRIdDRsFcjf0mTGvNSw0y18ybeShlVIBtTIlb2UmWiQjsCUV
 dIaX+OGGMiVs1MpTZgklkZf7CFcGkljcA0MZqjQSdBVS+c06rcLApKSoRBAi/VCaJyBlLa68Z
 FrJiUJOz00xg0i5BEJnsXKh34L2b3ZggKtZ8O7E3tGfLZ95rC7hDObFPgso4+CtyKbk7xNykR
 PUXpd6N8ijuUFV4EHmrty8cmPdqJgLjOc6+mwr7l98HkIMH5M35hB8vxI7/nBydqzpHgq23FZ
 kih8c4TlVhLpIpat7iD1w82kxHHwsOmfwVScpovNVzoeggnBUygmgrebnebbCznITpmccEHNf
 wPF2rYQIDzK4JqbkCcj5g4Z3K5fSWkOVLpG8z0sk1ltA/ODrTNv8lwclzy5km4CRSfEDaUZhY
 Ae05565sOr9VNoZyh3yFCJh+DhWLqs3dQwL5DyEDNJLG+1bUmafBhGRr+c4Xx+tDaPphSqZKM
 +/IP1/TxAJu3ySko0axzkE0v/R27tcEg8xZwTbPT3697Te+eFdbfRGahqbKlsArezIIcl1z2y
 axTiMax/IVyfE82rv6LFHyN+Lss1XDiPLffUYzCtwKx557BtLYpy9YImeEYaHpAo1MXLKv1Nc
 dYBKNNzwUfsgQweHspoofw/J3H0Shjy8oVXken82l2lyMuJ2E5P/+2l9Nx+mV2sWQxAXblKnl
 F50K5uaWxEKE2Kzptf7jLRIwuP2/aq3gm5hnTMqkxw1C8vSCmJdPlTOacZ+ojdMZoCJ5IN9lB
 HMZeoHS8vwVgMQ+Hf/YYAuUWmIUrn5VxTN6D+dw3j0cJQ2yoGLp0BZfZbFqmZpZn1/7g4oyFh
 gdgXpkR+tpp6K1Mu6+nmul9XxvCgNsc7WG2gSWRlYCo8WPw5XVdL4LNG1/F5XJaFJoUb5d13t
 CkvTUCfCt1Uhnavthc24/5DeGrBYFnoKr85sKzxOam0cMLffrgA==
Subject: Re: [cocci] Reconsidering source code search challenges for nested
 compound statements
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3341
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/CfjzLZbUCOjTBnA8HCUjSg>

>>>> @display2@
>>>> declaration d;
>>>> statement list sl;
>>>> @@
>>>>  {
>>>>  d
>>>> *sl
>>>>  }
>>>>
>>>>
>>>> Another questionable test result:
>>>> Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> /usr/bin/sp=
atch test-item_assignments.c ../janitor/show_compound_statements2.cocci
>>>
>>> And I should know what test-item_assignments.c is?
>>
>> Reminder:
>> This can be possible.
>> https://lore.kernel.org/cocci/f25025ab-4500-4315-b41c-53cd5775c69f@web.=
de/
>> https://sympa.inria.fr/sympa/arc/cocci/2026-03/msg00014.html
>>
>>
>> void my_test(void)
>> {
>>  int item;
>>
>>  if (1)
>>  {
>>     item =3D 1;
>>  }
>>
>>  item =3D 2;
>> }
>=20
> A statement list metavariable only matches the code starting right after=
 a
> {.  It can't start in random places.

Interesting =E2=80=A6


>                                       Nothing is going to chenge here.

Will it matter then to mention for a better software documentation
if declarations would be skipped (or not)?
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/233b5ceb1d5a701fb270e=
bdf0a9bd6be0a6ce53b/docs/manual/cocci_syntax.tex#L348-350

Regards,
Markus
