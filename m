Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D34FC02194
	for <cocci@archiver.kernel.org>; Thu,  6 Feb 2025 10:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:from:to:cc:date:in-reply-to:references:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=TQfyj2tOBQvFyfKHnWWJqFbAbPlj9/CEBR1K9CxGJfE=;
  b=IaVDY/8UkhJJYLeYm7OQE1L5eHkxwRcbdDH7B1lNSxijCA0oUDp+TMh+
   h8YM4tWJuzWKQ/PTKGCYglxXtPSy+DI9CPljUJ2Mhn62LnIfnBmQIMA3F
   SrRsn09TXOXVJgTo/pULfrOc2uoE0TAa5tk/qI1FSZlX8TaemzxeuQv6o
   g=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@sipsolutions.net
X-IronPort-AV: E=Sophos;i="6.13,264,1732575600"; 
   d="scan'208";a="206888949"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Feb 2025 11:13:06 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0641CE0D1D; Thu,  6 Feb 2025 11:13:06 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 2E14FE0260
	for <cocci@sympa.inria.fr>; Thu,  6 Feb 2025 11:13:02 +0100 (CET)
IronPort-SDR: 67a48b2d_8erEQR6qVd4d/A+ChqgK6LKXEemqtBj0htmCC1lf/fLp73x
 5M46UycF3DB94WllbyorLOI4ER6nIkZWmjFDMqg==
X-IPAS-Result: =?us-ascii?q?A0H+AQBniqRnhRAmd6hagQmEF4FWNAcISIRWiHyId6ASD?=
 =?us-ascii?q?wEDAQ1BAQIEAQEDAQOFAAKLAiAGAQQ0EwECBAEBAQEDAgMBAQEBAQEQAQEFA?=
 =?us-ascii?q?QEBAgEBAgQGAQIQAQEBAUBJhXsNgmIBM4IWLAhjAR8BAQEDIwQZAQE3AQ8LG?=
 =?us-ascii?q?AICJgICVgaDFYJlA7AlfzOBAYIMAQEGgmnZN4FlCYEaLoVsgmMBgWyDfgGEd?=
 =?us-ascii?q?0KCDYQ/PoEFAYcYgmmCM4Fvg0CGTIMfiG+QHAlJexwDWSwBVRMXCwcFgSlIA?=
 =?us-ascii?q?4ERI4EjBTUKNzqCDWlJOgINAjWCHnyCK4IggjqEQ4RNhVuCEoFiAwMWEAGDI?=
 =?us-ascii?q?Xocg20dQAMLbT03FBufRIcfMMcOhCWBY5hih06BS4MFpgKYfKNuhUCBfiOBX?=
 =?us-ascii?q?DMaCCYKgyJPAxkPjjgCiDnDWkUyPAIHCwEBAwmFRAGKbIFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:vwfO16C8rHackhVW/9Dnw5YqxClBgxIJ4kV8jS/XYbTApDkggjAEx
 2FOCDvSOv2DNmKneosjad+/pk8H7JfRn4cxOVdlrnsFo1Bi+ZOUX4zBRqvTF3rPdZObFBoPA
 +E2MISowBUcFyeEzvuVGuG96yM6j8lkf5KkYMbcICd9WAR4fykojBNnioYRj5Vh6TSDK1rlV
 eja/YuGYzdJ5xYuajhJs/jb9ksz1BjPkGpwUmIWNagjUGD2zCF94KI3fcmZM3b+S49IKe+2L
 86rIGaRows1Vz90Yj+Uuu6Tnn8iGtY+DiDS4pZiYJVOtzAZzsAEPgnXA9JHAatfo23hc9mcU
 7yhv7ToIesiFvWkdOjwz3C0usyxVEFL0OavHJSxjSCc52nfVHmw3fppNxk3Y6MByOQrA2VQ3
 uNNfVjhbjjb7w636Km6UvJrgtk/Lc7tJ8UZt20IITPxVKh2B8maEuORtZkBgl/chegWdRraT
 8geaTNpahnbSwZOIkwQDI8ineCunT/5fiEwRFe9//JpsziDnVcouFTrGMWNet24GIZYonijv
 T/N5FulB0giC/XKnFJp9Vr12LGTw0sXQrk6ELSn//puqE+Sw2YJAVsXU0G6qL+3kCaWUNVUI
 E084TsrtaF09UqxT9C7UQfQnZKflgVHHcFRC/Y97ByRy63S+ECfC3RsoiN9hMIOkNYRR2A02
 Viyx9K3KyVdsuGXTWy26eLBxd+tAhQ9IWgHbC4CaAIK5dj/vY0+5i4jqP4zSsZZafWlQ1nNL
 yC2kcQou1kEpeImv5hXEHjc2HS3p4DSSQoo+gTQWHnj6A5lDGJEW2BKwQWEhRqjBN/HJrVkg
 JTis5PDhAzpJcvc/BFhuM1XQNmUCw+taVUwe2JHEZg77CiK8HW+Z41W6zwWDB42aZZbKWeyP
 BSJ51s5CHpv0J2CPfQfj2WZW59C8EQcPY2/DquLBjazSsMoJFDWonEGibC4hjy9yxl8+U3AB
 XtrWZ/yUypEYUiW5Dq7W/Ub3KVjwSY6xGXeDZn0pylLIpLODEN5vYwtaQPUBshnt/nsiFuOr
 L5i2z6ikE43vBvWOXKPqdZ7wJFjBSRTOK0aXOQMKL/efFU3Rjp9YxITqJt4E7FYc21uvr+g1
 hmAtoVwkTITXFWWdlXYWWMpc771Q5d0oFQyOCFmbx7i2GEubczrpO0Tfoc+N+tvvuFy7+9Gf
 99cceW5A9NLVmvm/RYZZsLDt4BMTkmgqj+PGCuHWwIBWaBcaTbHwOK5QTu3xhIyVnK2keAcv
 4yf0hjqRMtfZgZ6U+fTRvGd73Kwmnk/iutCdVnCeMkKdGro7oJsDjH7i8FvAsATKCfswimR+
 BaWDCw5+8jMgd4R2/vYiZ+Uq7yGF7NFIXNbOG3A/JC0HyX+1Uiy879qCeqnU2jUazLpxf+Ee
 +5Q8cDZDNQGu1R766xHDLdhyPMF1evF/rN14FxtIyTWUg6NFLhlH3ih2PtPvI1rwptym1O/e
 mCLy+lgFYS5AuHXO39PG1N9dcWG7+8epRfK5/dsIEna2j5+zIDabWpsZSuzmA5vB5orFrg6w
 NURmt8csC2+rRsIDuyorA5p80a0E3hRdJl/6787BtfwhxsJ22NyR8XWKhXL7aGlb/RONUgXI
 QGoupfSuoQExmf/dyscKHuc+8tcmpUEhz5SxnAgOVmiu4TIl9037jJr4BU1SQVelBFY2LgiI
 WRbDVV/f/ic2zI1gMRofnuNHjtZD0az4X3ByFoulUzYQXK3V2fLEnYPBOaV8G0d8ENeZjJ+/
 oCH+F36UD3vQt797hEyVWFhtfbna957rS/Gp+yKAOWHGMMcTQf+o6rze1cNlQTrMfkxiGLDu
 +Nu2uR6Mo//FCwIppwEG5uo7qsRRD+ENV59b6lYpo1RJl7leRa2xTSqAGKycJkUJ/X1rGmJO
 /Y3LcdLDxmDxCKCqw4APpE1Iph2oeUI4eQTcba6NE8EtLqi9gBSiqzyzRSnpmEXQIRJq/0fe
 6fxbDOJF1KCiUREw1HtqNZ2AUvmQN0mSjCl4sWL3rQoLa8TiMBtbkA47ZWstVq3LgZM3kyZr
 SHDVYDs3s1gzoVnxY/zGf8SHAmEE8v5Drma1AXut9hlTMjuNP3WvFg/sWjXPAVxPJoQVe9ol
 L+LjsXF4UPdsJsyUEHbg5OkFZhW1f6tXeFSDN37HENakQSGRsXoxRkJoEK8FrBkj/Jf4ZOBa
 zajSc7ta+MQZchR9EdVZwdaDRwZLab9NYXkhCGlqsWzGgov6hPGIPyn5E3WQzliLAFQAKLHC
 yjwp/qKzfJbpt4VBBY7WtdXM6UhK1rnAaYbZ9n9sAeDNVaRg3SAh6DDkCQx4jSaG1iGF8fHu
 aj+fCbcTyjrmq/0z4B+ibdQ7y0nVCM3xaF6e08G4Nd5hgyrFGNMf6xXLZwCDYoSiSDoko3xY
 DbWdmY5FCHhRnJ+fA7h5Mj4FBKqbgDU1gwV+hRyl69VV8u3OG9EKKBg7jxn52pqezzl16ehJ
 M12FrjYIE2q2p8wLQoMzqXTvAul7qqyKrE0FYTViM3qGBEaHKkL03p6WgxASUQr1unTwV7TK
 zFdqX9sGSmGpI2YLSqkU2VUAAoeuC7zzjIudmGJzcq3V0B3CgFf4KWXBtwfGYHvoCjHyHDii
 J83q6awD7iq50Eu
IronPort-HdrOrdr: A9a23:oeuja6sw2uHwzlEcuOErlROI7skDX9V00zEX/kB9WHVpmwKj9v
 xG+85rsSMc6QxhPU3I/OrqBEDuexPhHPJOjrX5eI3SPzUO21HYSr2Kj7GO/9SIIUSXnNK1l5
 0QEZSWY+edMbEVt6jHCUWDYrEd6ejC9Kism+/EwzNnRRJjY7oI1XYBNjqm
X-Talos-CUID: =?us-ascii?q?9a23=3Ap/Ole2nPGPlFmK9yWYQSn+N4+ZjXOVnE63WMPUC?=
 =?us-ascii?q?/Mj5oFpOMe13M+qd6uNU7zg=3D=3D?=
X-Talos-MUID: 9a23:E6Zr6wm9ON8Rs0A69Iundnp9bMdp0fntBXwzqo5bsNK7aSkpAwi02WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,264,1732575600"; 
   d="scan'208";a="206888931"
X-MGA-submission: =?us-ascii?q?MDHQ2ug1cV5c6Gp/O4wgprNvR7J0H4OiDGxNY4?=
 =?us-ascii?q?gVbZpEZWMNkNXH4uinYh1tRo1lNdaJ0EJW2bsXliJEgvaTBP1mE/HAwP?=
 =?us-ascii?q?FD4eed1ftPYDdUHOImsdMi070wRl3w3c3VMeAywKiy/8AsqUsMJuZpRz?=
 =?us-ascii?q?5cpfdYbuCcEiTOoKfkeKd7iQ=3D=3D?=
Received: from s3.sipsolutions.net (HELO sipsolutions.net) ([168.119.38.16])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 11:13:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=TQfyj2tOBQvFyfKHnWWJqFbAbPlj9/CEBR1K9CxGJfE=;
	t=1738836781; x=1740046381; b=GkLTxVLChisLdzlwJwGZYKeM1O93dR43qWBhgc4O/e2nLTx
	5n5yGJWV68fDjTyFENWGKaSdSPgzKUdOL4pv3GS/QBl6KaMVa5z9hz6MczVJBnEerVa2C1Chv4jDd
	oaIu90oaph13NmsGfNe2sp5NO0hxjQXhHJNjoqqr4DhxKjyZmch+XSSjSSPOXJdjDhLXzkpBZDwIo
	OZnLoPQwmoktBxql1W+a4h7GXR0zk+NsfULR7dahqE1aQHIVZjHcciNmouCFvqtYzvhmwT16pllCU
	TV5JK4js92nkfGvXdGTmKBk1tqwzCHPPoZAVyezU67PRrmOd64ZdajdUWlDIspoA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tfysW-00000004ypT-29Zs;
	Thu, 06 Feb 2025 11:13:00 +0100
Message-ID: <12d36f971e2f3d2141a27a00b9b4fc7f44ea1d17.camel@sipsolutions.net>
From: Johannes Berg <johannes@sipsolutions.net>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci <cocci@inria.fr>
Date: Thu, 06 Feb 2025 11:12:59 +0100
In-Reply-To: <9063a6e6c83f9169456bc009cc35426889cc46e1.camel@sipsolutions.net>
References: 
	<381b5a9cb89cc068ca13546f69636291874010b3.camel@sipsolutions.net>
		 <061f1b6b50d305671c02742382a3df0ff95f9c6b.camel@sipsolutions.net>
		 <ca7c1a14-522a-9c2c-4f85-2fda289b83e8@inria.fr>
	 <9063a6e6c83f9169456bc009cc35426889cc46e1.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
Subject: Re: [cocci] possible regressions in 1.1.1 -> 1.2
Reply-To: Johannes Berg <johannes@sipsolutions.net>
X-Loop: cocci@inria.fr
X-Sequence: 2357
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/12d36f971e2f3d2141a27a00b9b4fc7f44ea1d17.camel%40sipsolutions.net>

On Thu, 2025-02-06 at 11:07 +0100, Johannes Berg wrote:
> @@
> @@
> static inline int
> ieee80211_get_mbssid_beacon_len(...)
> {
> ...
> -if (rnr_elems) {...}
> ...
> }
>=20
> That seems ... simple enough?
>=20

Oh. I notice that the function actually contains *two* blocks that could
match "if (rnr_elems) {...}", one is nested in a loop.

The older version of spatch _also_ takes a very long time on this, just
not quite _as_ long (about 1 minute vs. 10)

They do seem to remove *both* instances, however, modifying the spatch
to be

@@
@@
static inline int
ieee80211_get_mbssid_beacon_len(...)
{
<+...
-if (rnr_elems) {...}
...+>
}


makes both versions process it pretty much instantaneously. :)

johannes
