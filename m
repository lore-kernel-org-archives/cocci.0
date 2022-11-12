Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C06C433FE
	for <cocci@archiver.kernel.org>; Sat, 12 Nov 2022 10:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=8ggpRRaMjQLjJvbMTKRjTdcUjHOzAwZCGuPT2XmPHpY=;
  b=YM2JCqIb3+hkzAoiZBYJRDXgmNZg7R/x0jY0xWNill47S/6hk3gSr/Fh
   g8RAiOMthoHC0pEB4SQOsVOYcxrpQBNQNjvj+tWoG6wkUvk25bUZj3IKx
   ZLTMYd0fh8L0D7SMFzNUCebZEyhvNw47YTlk73Xrs7wynYYkT+fchx3fs
   A=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.96,159,1665439200"; 
   d="scan'208";a="77854665"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Nov 2022 11:38:28 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 21385E0236; Sat, 12 Nov 2022 11:38:28 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 9010BE0092
	for <cocci@sympa.inria.fr>; Sat, 12 Nov 2022 11:38:26 +0100 (CET)
IronPort-SDR: 636f77a2_cTPoddbQCtMnAFyaT034kHwdxyUYVtGHkZCDjUGZhSiUFJ0
 l/qkeKR1VqvXfYrG2q1F9t7Zh5q0Qcpke6G0PkA==
X-IPAS-Result: =?us-ascii?q?A0GKBwCtdm9jhwMP49RagQmBT4ItgQIDUy4EC0WET5BsM?=
 =?us-ascii?q?YQpjlCKN4F+DwEDAQ05CAECBAEBAwSCC4JzAoR8Ah0HAQQyBw4BAgQBAQEBA?=
 =?us-ascii?q?wIDAQEBAQEBAwEBBQEBAQIBAQIEBAEBAhABAQEZCRcHDhAFIoVoDYI1In2BC?=
 =?us-ascii?q?AEBAQEBAQEBAQEBAQEBAQEBAQEWAg06GDs9AQICASMdAQERJgEECwsaAiYCA?=
 =?us-ascii?q?lcTCAEBgnkBgm0BAw0jBwyrLIEygQGCCAEBBoJhmSUfLCJTgV4DBoEULJEQJ?=
 =?us-ascii?q?xCBVUSBPIJTMD6CYgWBXU2DCoJnjnWIaiYEDgMZKx1AAgELOzINShsxJw4JH?=
 =?us-ascii?q?xwKBBcNBQYSAyBsBQo3DygvZyscGweBDCooFQMEBAMCBhMDIgINKTEUBCkSD?=
 =?us-ascii?q?SsnbwkCAyJlBQMDBCgsAwkhHwcWESQ8B1Y6AQQDAhAgOAYDCQMCJFRzAi4RF?=
 =?us-ascii?q?QUDCxUlCAVKBAg5BQZTEgIKEQMSDwYmRQ5IPjkWBidCATEODhQDXoFpBDVmm?=
 =?us-ascii?q?j+CHFoiEywJmC+sQzQHgh+BTIFNDIl0lHIGEy6Wbg4GkhSXNI1DmjWBaQwng?=
 =?us-ascii?q?VwzGiSDNk8DGQ+OOYNZM4osQDQ7AgcBCgEBAwmFRwEBhSsBAQ?=
IronPort-PHdr: A9a23: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
 UM6T/ZrpEy61PaCwHxrXUgWwgs=
IronPort-Data: A9a23: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
 RoiFrEc8/R/LlyFhQre2xBjvdpa+w==
IronPort-HdrOrdr: A9a23:s6wr+qtSkOMe50XMYpZuZEOg7skDotV00zEX/kB9WHVpmwKj5q
 eTdYcgpHzJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniFhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfDxHZK3BgDVQfexQpeWvzIDto/vCxHFwSgxQZ7hn9BoRMHfnLqQ7fmh77YFSLu
 vm2iOrnUvbRZydA/7QOkU4
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,159,1665439200"; 
   d="scan'208";a="77854661"
X-MGA-submission: =?us-ascii?q?MDEoS5eK4Er1tHzzFpLsHiBOQIAWr7ztMrHWWP?=
 =?us-ascii?q?b3ThpTTNxohLEHndKdVrBO30ijVsnga8pi6SKo2hO/B2yeywBix0BAN7?=
 =?us-ascii?q?XRwokwhVFk7TmLFn1knRBP+eBYjSPxsbUZqZgJgCAWH8DRBqZXac8LY/?=
 =?us-ascii?q?aZX7tkaaUXAuFw6i+6o0Jx4w=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2022 11:38:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1668249504; bh=8ggpRRaMjQLjJvbMTKRjTdcUjHOzAwZCGuPT2XmPHpY=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:Cc:In-Reply-To;
	b=UZ86BblE8WN/Mhoj2rGi7wwStVWjZEc/7SIJynRrDdzs8r/lBDTPtkyq8QFbBhfvU
	 lScpqiE+BODTFVjd+GdOU/u1d+MUZ1NF5pRPCC+z3kyoaOpbU3plRWp7q02VAPW1f0
	 BE8mxaZI9jfr79kY67VdiZlL/5iZUw+GLYk1JX6p8JWErEj6UoKOjuMpGBsboEsYng
	 5czfocGkQFg82rfOEQgfxLW5IRqrVugHyn8S4XzNvW2evIZYBjy8ATa+MF12KORf/d
	 uFdlfZ87I+Y7dsPkLLxCAEK6rATtSfpqB2De3ep9Mrhyzuf+Wn7aeumJOnBnqdIyUq
	 h6ECtb7Cwi6rw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MQPdl-1ogF8L2km9-00MKMB; Sat, 12
 Nov 2022 11:38:24 +0100
Message-ID: <1282431d-b379-0ddf-5dbd-a50cb5d1605d@web.de>
Date: Sat, 12 Nov 2022 11:38:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr
References: <CA+EOSBm7wxOoXmhbAP7YhTDXJxNQJJ6QRU8Rb47QV_XmvyyaGg@mail.gmail.com>
 <516d8b97-907f-5a7b-41af-ff162ffe7316@web.de>
 <b73dc7c1-d5ad-dd23-f559-7b73939ed710@web.de>
Cc: Elia Pinto <gitter.spiros@gmail.com>
In-Reply-To: <b73dc7c1-d5ad-dd23-f559-7b73939ed710@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ko5mX2CF0lQi22sm7vpU428AiCybsLGbKfKB47gukZPm+78cimZ
 vFk+sukGS04uz9y54L0VvJJi0IY2XydpdixDM9xiy/GodqpLX+fv2nEpOGb2YLci0OlilCB
 /4mBFGF6lymG+X/Py8gqg0KWrSjJWaOnI/AhgPZgxXdLNLOemuSLbsz/c/tW9jS+oGa8aOD
 IiuoFm8svjCVFPe3BLYKg==
UI-OutboundReport: notjunk:1;M01:P0:GJL0bUNAoCE=;yfVjGvXF4JJyT4gv568cBvy3NKy
 7CKdfUKy20EvQP1zbiHVb/VqhrciYJy9DUOvDH1KcE0dabhCLHPYqPSP8pFKgc7JuLEHR8krY
 6uCX8zZ4B+iKV0cCvYFsMCefB42J183vvw7lBdTiSlyRFgW55/OeHVvKTymNSxN149WOIFTV0
 xrzoUE1dwVWiXbzoxbPJJaf6kPQ5a8PKkaJeKXDnOM5z0ZXtBXpwUtt3TNi28wamO8l1UhKzJ
 ts+Q/dSiXJxMbCi8Jr8eaFVqQ/+AH5w7cP/wnOeG/8RAdOetfX+N/gB3oAtbTc04CWpEGgFnP
 3yjlz9zPI5zVUWSxCpAPQkUDmtudM+kziNViNXw/XmMsuBHYhWafEYYqdsbwIN3eLAi0TGP7j
 Zg/jpDkiE3T/QLfLikm+e2XRJCKfbSvc66JHh80cDu+oNKZJU3IcFrHe6N/1Z/1o/NFqIOGJB
 zPRWvbg9btRBncrcTzBXpG6GqDL89yCVtUK/ZLa+6kyqnoW/GpVL0Oo4h9uOM+YlndTinrLbB
 WeR+0N15YC+gbcEMCvbd6awahVXDknBFY9911t688fg5+DVEMNVGn1ohoAbSLip8KUcrTnHr/
 X5Rfy3eC5jyM0mjz6QGIx/ehK5uuiacIfufwjZRWiTsrfmxqf6Ey/vqFfHHTlezby5Qhh7gsF
 3GwKW55pS9ph1TP7yuzPbZuTIA4SJ79GDGQS3M0H6MEETHRFyOa4BEAVRaPTNzSuzOSClfhrq
 QZk/Gf4dkkzfzkNPXYYSh3wDrnsJMyXvCG1LkfZUcSE1xTHaY6zB4vaP9ltkS1NTpyNFLIoQg
 JnGZJ0bBe/NC5j6S0Bo4TrLiSenKhcLHfOagfIe1cDV4qqwvwuqInQv4L4upV6O8QgwalWXCX
 acHelJzy5QH+6Dwjlps3c70NLrEj6rsykPDuxFx6joVBfhL43lZV5v7TCMasJwPhTQeb50oHI
 Sedk9g==
Subject: Re: [cocci] Fixing the adjustment of variable declarations
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 736
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-11/1282431d-b379-0ddf-5dbd-a50cb5d1605d%40web.de>


> Would you like to clarify a related bug report for the software combinat=
ion =E2=80=9CCoccinelle 1.1.1=E2=80=9D?

Can another variant make sense for a transformation specification
if you would like to increase the change precision?

@moving2 disable decl_init@
type t;
identifier x, y;
@@
=C2=A0t
-x,
=C2=A0* y;
+t
=C2=A0x =3D 'x';


Markus_Elfring@Sonne:/home/altes_Heim2/elfring/Projekte/Coccinelle/Probe> =
spatch --parse-cocci move_a_variable_declaration2-20221112.cocci
=E2=80=A6
minus: parse error:
=C2=A0 File "move_a_variable_declaration2-20221112.cocci", line 7, column =
1, charpos =3D 64
=C2=A0 around =3D '*',
=C2=A0 whole content =3D=C2=A0 * y;


How will the handling of declarators evolve further?
https://en.cppreference.com/w/c/language/declarations

Regards,
Markus
