Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6731CC021AA
	for <cocci@archiver.kernel.org>; Fri, 21 Feb 2025 10:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=GDmCe53Y2cxCxTc2pZ7YEzEK4/9czcfUq1+QZdAFsTk=;
  b=c2SOGbp49f/MvQZKBvtXHRUeaFzl2wpuq/jgUdUVHVkChn5Z65vOSIvl
   4Ctg3pmH6UmpqKZVAc2Sy3VrImoPYML9PQy12lUciZFsios8qJK98Fou2
   mL4pf+17bUrchup0zDMN+htsg7Zn96prrrHpZTZl2nip81eNPb3NGIHrT
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
X-IronPort-AV: E=Sophos;i="6.13,304,1732575600"; 
   d="scan'208";a="209359698"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Feb 2025 11:11:18 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D3852E0261; Fri, 21 Feb 2025 11:11:17 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id BB9A0E0260
	for <cocci@sympa.inria.fr>; Fri, 21 Feb 2025 11:11:11 +0100 (CET)
IronPort-SDR: 67b8513f_tS8p6D2CKPMdlDNmU2fl6C3G0J9mGIbE9qAbgMvHVgOxF+a
 fkFOMkR0XeeJSKNI/Qfody+BbYVptJ1ft7VaXyw==
X-IPAS-Result: =?us-ascii?q?A0EnBwDBULhnfk7ASNlagQmBU4JEfVozBAtIhFaPT4F0L?=
 =?us-ascii?q?YQ+jw6IdYFWgX4PAQMBDT0EAQIEAQEDBIUAixECHgcBBDIHDgECBAEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQE7Bw4SKYV7DYJbgSyBJgEBAQEBA?=
 =?us-ascii?q?QEBAQEBAR0CDTpGJx0BAREmATQCJgJzAQGCfgGCLwEDMQcNrymBMoEBggwBA?=
 =?us-ascii?q?QaCaddzHywiV4FlAwaBGi6FbIJJGgEFbYh2eicPgVVEgTyCUoM5FwQYghODD?=
 =?us-ascii?q?oJpgjOEICVnhyWFBoQ5hE6EXleCf4kEgU0cA1ksAVUTFwsHBYFxA4EPMoEUe?=
 =?us-ascii?q?oJFaUk6Ag0CNYIefIIragQFg2OEQ4RHhVKCEYIIiAGBLYJoHUACAQttPTcJC?=
 =?us-ascii?q?xsGPZ9wbD2FBTwrCYFIYAyTN5EpoTs0B4I4gWYFgV4MiQWBJJU1BhMvl0QOB?=
 =?us-ascii?q?pJ9mH2OBZVVhVaBbgwngVwzGiSDNk8DGQ+SToRgwhlCNQIBATgCBwsBAQMJh?=
 =?us-ascii?q?UYBAYpmgUsBAQ?=
IronPort-PHdr: A9a23:GnID5RRxm4+SsNdTl5Rc5SraQtpsojOUAWYlg6HPa5pwe6iut67vI
 FbYra00ygOSB8ODs7ka2rWK+4nbGkU+or+580o+OKRWUBEEjchE1ycBO+WiTXPBEfjxciYhF
 95DXlI2t1uyMExSBdqsLwaK+i764jEdAAjwOhRoLerpBIHSk9631+ev8JHPfglEnjWwbL1sI
 BmssQndqsYajIpmJ6szxRbCv2dFdflRyW50Kl2fmArx6N238JB/7Spbpugv99RHUaX0fqQ4S
 aJXATE7OG0r58PlqAfOQxKX6nQTTmsZnBxIAxPY7B7hRZf+rjH6tutm1yaEO8D9UK05Vi6j7
 6dvTx/olTsHOjsk+2zZlsB8kKRWqw+nqhdiwYDbfZuVOeJ9cK3TctwVS3RPU9hRWSJcHoyyY
 JACD/YDMOtCs4Xxu0UCoBm4CAKxBO3v0DhIhnru0KM9yeshCwLG3BE7H9kTv3rUqNv1NL0TU
 eCzw6nD0DLOYfRM1jfn64jIbwshreuDU7J0f8rR00gvFwXKjliLp43qISia2v4QvGeF9udtU
 /+khGE7pQ9ruDev2tsshZfThoIT0l3I6Th1zJorKdO3SkN1b8KpHZRTuiyENYZ7QN8vTW91t
 Cs+17EKpZq2cScOxZko2RLSZeCLfoeU7h/iWuudPzR1iXR4c7yxgBay9FKvyuz6VsSs01ZFs
 DBFkt/SuXAJzRDT7dKHSvR780y82jiPzxje5v9ZLU02j6bWKYAtzqQtmpcXr0jPBC37lUbug
 KKSeUgo4Oal5/n9brjiqJKQLYB5hwfjOakwnsy/HP84MhQQUGiB5Oq81bzi8lPhTblWiPA9j
 7PXv4rAJcsBo660Gw9V3Zgn6xa4Fzqm1dMYnWQbLF5fdhOIkZPmN0vTL//mFfu/glKsnyl3x
 /3eILHtH5fAImLBnbv/Z7px9kpRxBQpwd1d5J9YErQBL+jyWk/1utzYFBg5MwmszujgEtp9z
 IAeWX+UAqODP63StVGI5vguI+mKa48Yozj8JOY+6PL0kHA2h0cRfa+y0pQPcnC3AuxmI1mFY
 XrrmtoNDH8GvhAiQ+zylF2CTTlTam6uUKI7+j40FIOmAJzYRoGthbyBxD20EodXZmBAEFCME
 G3ne5+KW/cWO2quJZpqlTcPVJCgTZUg3FegrlzU0b1ie8/d4C4FrtrO0NZv5uvc3UUX/CZ3E
 t/b/mWDVWBykUsXSjVw0K0p8h818UuKzaUt268QLtdU/f4cCm/SVLbZxu1+UZXpXx7ZO82OQ
 xCgS8mnBjc4SpQwxcUPagBzAYbqlQjNigytBbJdjLmXHNos6KuJ+nHrJNtmjVvC2rMgiVYOX
 cZFc2Gr1eZk7waGP4fSiA2CkrqyM6EV3SrD7mCGmE+HpkJFS0hdVavfXHYQTlTbp5L16xCKV
 KegXJIgNAYJ0sueMu1KZ9nu2E1BX+vmMc/CbniZnmCtGVCXy7nKYIeCl3w1+iLbBQBElgkS+
 SzDLg0iHmK7pGmYCjVyFFXpakeq8O9kqXr9QFVmhweNJ1Zs0ba44Ht3zbSVVu8T07QYuSwgt
 yQ8HVCz2MjTAsaBoAwpdbtVYNc06lNKnWzDsAk1MpulJqFkzlkQFmY/92bnzRZqEcNtlcYwr
 XUl5BV/I+SU3RIJdj+V24zxJqyCMnP7r1ikb6/b3E2b0c7DoP5Qrqti7Qyy5kf2RhlHkT0vy
 dRe3nqC64+fCQMTVci0SUMr711goLqcZCAh5oTS3HkqMK+uszaE1ch6YYltghumYdpbN7uJU
 QHoFMhPTe2nMu83gB6EahwePeZd3LE5NYWqerHVvczjdPYlhz+ggWldtcpY21iP6jE6Z+rGx
 ZcDzNmH0wHBWzq23zLD+ojn3ItDYz8VBG+2zyPpUZVQaqNFdoEOEW6yIsezy72SnrbVUmVDv
 B6mDlICgoqyfAaKKkb61ktW3FgWpnqunW25ySZ1mncntPjX0CvLyuXkPB0JXwwDDExrl1TxO
 s6Zi94AXU6nRxcknl2p6A72yrNaq6J2M2TICR0RIG6pdSc7A/H26erKatUH8J4ytCRLTOmwB
 DLSAqXwpRcXyWKrHmdTwiw6ayD/v5z4mxJgj2fOZH13rXffZYRx3UKFvYOaGqQXh2tcAnYo2
 ly1ThCmMtKk/MuZjcLGu+G6DSe6U4FLNDPsxsWGvTe64mtjBVu+meqyk5vpC1tfs2ez2t90W
 CHPtBu5bJPs0vHwFOt9fVRzQnL45dB7HI5WjYY6wp0dkyt/5N3d7T8cnGH/PM8Ok4f3dnkQX
 ngmx9DP4Q7q8FJuJDSFysiqMxfVitskbN68bGQM3ys75M0fE6aY4otPmi5tq0a5pwbcMrBt2
 y0Qwvw05DsGkvkE7UAzmz6FDOlYTiw6dWT80g6F5NekoOBLaXazJPKugVFmk4npBeOHpRxAH
 mn0cNEuEGd5vMB4LU6JwHP08J7tYtWWct8Z8BGZ9nWIx+EHLZUsir8AgjdhMm+7onAvjeI2x
 RU82JanoM2MMG9w+KH/WxdeOmSzbMQWn1Olxa8Mm8GLw8WkBZ5mAC1NBZLuQavuGzUX/eLuM
 wLEeNElglGcH7eXXQqW6UM86mnKD4juLXacYn8Q0dRlQhCZYk1ZmgEdGjsgzNY/EUixycrtf
 V0chHhZ70PkqhZK1uNjNgXuGmbZqgCybz4oSZ+ZZBNI5wBG7k3RPISQ9OV2Vy1f+5SgqkSKJ
 An5L0xQCnoVX0WfG135Fryp+MWG7OWSQOazbrPPbbiIte1CRqKIyJaoge4Et36HMsSCOGUnD
 uVugBMcGy8jXZ2IwXNQG39y9WqFdcOQqRai9zciq8m+9K6uQwfz/c6VDLAUN9xz+hewiKPFN
 uiKhS8/JywLs/FEjXLO1rUb20Yfzi90cDz4W5EJry3QV+T9nqFNDhgUQzx+Po1E4uhvu2sFc
 d6ekd7z2rNi27QtDExZUFX6hsyzTckNPn37K17NQkqGfufjR3WD04T8ZqWyTqdVheNfukiru
 DqVJETkOyyKizjjUx3H2QBkiSaGIFpBtYv7fhs/UQALqfr5Zxf9PNIl1VXeLpUri3mMOWNOa
 FBB
IronPort-Data: A9a23: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
 FU=
IronPort-HdrOrdr: A9a23:Z8xWlq4ZGzc5ScIHmgPXwBDXdLJyesId70hD6qm+c202TiXqrb
 HMoB19726TtN9xYgBGpTnkAsK9qBznmqKdjbNhWItKPzOJhILLFu1fBOLZqlWMJ8SUzJ846U
 4PSchDIeHRSX5nkM39/A60KNo4xsKbmZrY/ts2g00NcelwAZsQljuR5zzranGfz2R9b6YEKA
 ==
X-Talos-CUID: 9a23:HujKqWA843QOyPH6EwV8qkAVPvB/SEPAnF7MGBCzLEttWqLAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3Au6Wr7Q7+5QMeA7LukE1tM+Vtxoxk4IeXDk8ona4?=
 =?us-ascii?q?Cuum9bD15HweE1T24F9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,304,1732575600"; 
   d="scan'208";a="209359680"
X-MGA-submission: =?us-ascii?q?MDFB6D4oW/IFR6luhsaxQcD78KDzRE4LGHm2Tn?=
 =?us-ascii?q?6ncY571YJ8MMznFuyt9ozB/EVd5oSCoKY7SiGOq4uYMS81Z2nsMvPB4q?=
 =?us-ascii?q?14YnIsrTjdE6ZZ4cf013M+ZO9KvbI1cGH+O3QZf9qJbAYurbNJftnXVx?=
 =?us-ascii?q?U1ZgRAtal9yH9pCUNf4OHmfA=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 11:11:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1740132670; x=1740737470; i=markus.elfring@web.de;
	bh=GDmCe53Y2cxCxTc2pZ7YEzEK4/9czcfUq1+QZdAFsTk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XhHkyLIjGTT7Il28wEPj+RRjv0JrC5f33PfZH262kEuNEMIz4hmlGpvw2W9HWFZF
	 /ndcPonxwDeZLXaEtwO04OIm1K8K2QFrCBEDx6ktho1ceQQpl8F6rv4uwJZgoplGS
	 zmu2pX+7XKGAFuXBqAEJeNXx3vtVVDCDzW9xWKcNeyQS07xQARbAe4wdkQSFlNQ46
	 UIpGlVl6cQBLRwmgwJIit5W6q5cyuly3w6A6T+dMekAcRPkRlZlPpvyY0FUbpaGj1
	 iXmBPUIqEd/m6sb+SyRvmnwL6jLlqDwq+dUsxxZ2YVyoeR1XE9Wy9wY6HL5KhRs9e
	 YzL+US2TPV1qDyMzhw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.4]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mc1ZN-1tC66r0bKZ-00bIp4; Fri, 21
 Feb 2025 11:11:10 +0100
Message-ID: <1fab8d2f-20e5-4e92-afb3-53167fecab54@web.de>
Date: Fri, 21 Feb 2025 11:11:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:9LNEizQ2clxvfWWQdpZe1VFLV2jQrBCIvewuRxWmh8LctzB6RW3
 tQXBeNI/JAXr/5mX40qGXqU4JaMsM8ctXSNU12i3u87Mc3pM1LWRdPHwDjnpBLg/9GS2LtL
 O/x4j9kPphMGi7I4VlbspWlw9NF/HyLoCITfRdqo1WKmNrDQ9vU2xxThB25RvzcZOxEYJJ1
 nC2VEakr7sJy7dnzZgKRQ==
UI-OutboundReport: notjunk:1;M01:P0:DU4gnxnkiRo=;sXvtjMmjVszrThb0iCyBmFJUlQJ
 f06t+T3zG3C30VHEzr4Xc+B1PMcFH3/brZUB96xwqq5zMF9HZ7MaV0BBlPK3ijIWDs5Dl0pAM
 Zml5EXwiAm58uWb5Q1NKGJIBKnw4kTsu5TkoXzbZr8gOi98HV4wN3XFdR7z/TeDGBlUVlw6L9
 S8CIy/gOfGvXjS7lwuNcxKoE2b60zI08bu7JOwMQeJVneShdOBi08P2/XavFmOsUfGwkswR8S
 EqPKGNF9QEFSfBd4EoGbKkGzD9LTvKOoZbxJpH2rSrRYhg/W/bEcJDq1uBVSPQ1/Egk9E5Fw5
 CsZkNkn44F1fiBu48BptEaJcvIXgsf22t1FvHNc0VB7vvUUtau1CL7PjvtOYmwx9oRp2C1+7f
 kTFw1P9uoHItjhnTI/t5T7J4t2PXedLlqKNESrPZfnlP6glUmGBbEUjxv502ZXUFvgSpjn/T2
 8s3BnyHMs6q6vOf5b8znJ43xbvxsR/8+hYqYRX9KQQhn4rIkSSnelZHit1Ih6g5IGpv15a/c0
 EN5fXVKzo0B4T7j82LpKJMXv9keTba78b3jvgUpm0Y55HCEz2ItxWW7ByZHn9tGbpn9+tZin7
 m71uES0s0GhYMRdUaaVr+3iJliUjPW48E+eNSs3xErytatz4Hh//zcEkksBvucKP9bpO59d93
 Pf8POMr2Wi6VxQj9IqLBV4+634lOJxab5JPvlHm7S9TdBW/fvJS2qaabhxOJXkmLs/OEwG8hj
 w3P4EqYzOo3sACbBQEsxPxpkr5K9yOjNxK0k+34oi7ibmF3ejJKboOPTGFJM/nF2Ek07QTfEw
 V1SkXdXfyIi96TK3fdCzn0cNqiWoPpgo0MymBpBUg671NZjK5PEZ3oolxNUuZJYOwJzMlFcwY
 oAVBPEvhqBoYPkUSfwWVoDP6t8kS0tD3UskKsupIdbN+odcon3wzdFQ4AfWm2FHZO9nzPAGGQ
 TrbVmAJ7QhcCtbR9nFbNk4XvC4V0b4PS1q10wJCfWr41W72cSN4YpQbDWnpLl5ptGMYrtJBKM
 nXgj74Vv4DG7AobpCqPjQJYxRlAEuM3xrQydl+fvHl6Um+uquGBQzp7dZd2rqLPNgC1crJXE1
 viulVomotiDKkXMjQHWewVxNbPNXmGwEAAtyQRHZR7lni9tVsf75yaQ+gIyz7kWzduC6qfhQj
 Lnux/aCp+4mbK9SIpgWoNrxy0gwpdr6byC/q4yGUAzuryXj8RIkrO84QU3tkkLfWulRVxwDnq
 1qegcpgt8lG1msOXhNC4PeWd95EDa5NrSUQ0ClHgN6UC2ab1pTfWAK3enF+xfqWRJkslA4+BW
 Ib3DzToyp0gxu1p/JqOOeo5yyGu2Yv4PL1Z5SU7u0xowCQ3lTD5nwP8xQszgxeYC1FTyWAIvo
 mqZ+cbsxD5T6sM58ySjX+c+WQ4jiJPDWTdfJKzCHxpOMHhBqUCg1ejN/L0eWyc/6aX84DyT7f
 vxsAHTLjU2bMfWc5jH4R0iEOVQfs=
Subject: [cocci] More benefits from higher level structures for coccicheck
 scripts?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2426
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/1fab8d2f-20e5-4e92-afb3-53167fecab54%40web.de>

Hello,

Various source code was assigned to functions (or function-like macros).
Common functionality is stored at selected places.
Thus there is a desire to increase the corresponding usage.

Some scripts were constructed also according to the means of the semantic
patch language.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/dev-tools/coccinelle.rst?h=v6.14-rc3#n71

It can be seen that some of these SmPL scripts share also program structures.

* Operation modes need to be determined.

* Special source code items should be detected somehow.

* Data output should be provided.



Would you be looking for the support of higher level structures for
coccicheck scripts?

Is there a need for placeholders (or variables) which could be filled from
other advanced information sources so that selected data processing
will eventually not be mapped to separate SmPL script files to achieve more
desirable transformations?

Regards,
Markus
