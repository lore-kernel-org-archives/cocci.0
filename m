Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5958CDD1AF
	for <cocci@archiver.kernel.org>; Fri, 27 Sep 2024 13:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=dRPMAOu3qUuovmFS2nYUoyjO/QFux0rRso6G1a/3/VM=;
  b=nI8g7ZcjpX556V0ilYkJ+sUNmYdJdFumnjOZKnXj9ssK8kiLcxnPlMAg
   Mo7dRxTVq1h6BfmVKTXwhPLMhyZbRgpvDikc/v5aWJ6tyIg0oZJzGzFh1
   HHYRLxf47sfOd4tvcqdL402PtxVs/LtOsAtzPSOXDHTuLPfsM70QGFPGB
   8=;
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
X-IronPort-AV: E=Sophos;i="6.11,158,1725314400"; 
   d="scan'208";a="185535124"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Sep 2024 15:26:18 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9AEF3E0CD0; Fri, 27 Sep 2024 15:26:18 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id C6121E0035
	for <cocci@sympa.inria.fr>; Fri, 27 Sep 2024 15:26:13 +0200 (CEST)
IronPort-SDR: 66f6b275_Uc4nwpVxU1m+DWpRgkFZtHTrvLDE7u+E73FehRh4G8AhO1n
 HPTXwXbyGCz1A6v/ZerLzEOnthhyptv9E3u7Oyg==
X-IPAS-Result: =?us-ascii?q?A0FQAAC6sfZmhwQP49RaHQEBAQEJARIBBQUBQIE7CAELA?=
 =?us-ascii?q?YJDYiFUMwQLSIRWiB2HMIF1MIQ7hzqHVIh2gVaBQD4PAQMBDUEBAgQBAQMEg?=
 =?us-ascii?q?gyCdAKKBwIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBA?=
 =?us-ascii?q?hABAQE6Bw47hXUNgmMBEIEUgSYBAQEBAQEBAQEBAQEBAQEBAQEXAkdEAQEBA?=
 =?us-ascii?q?gEjHQEBEScECwsaAiYCAksLBgEUAQGCfYIwAQMOIwewRoEygQGCDAEBBtpaH?=
 =?us-ascii?q?ywiV4FjCYEaLgGISgGFVkuEPCcPgVVEgTyDAz6EQ4NbgmmNIIFtgwCCEIleJ?=
 =?us-ascii?q?YhfXRORLFJ7HANZIRMBVRMXCwkFiTgKgxyBbiaEFgiBKxODX4FnCWCHZ2KBD?=
 =?us-ascii?q?YE+gVkBRoJzSoNPgXgFOEmCUWtOPAINAjeCKCRqglyBJwQFg1J2HUACAQttP?=
 =?us-ascii?q?TUJCxsGPa4/gkFhyQ40B4I3gWSBYwyfUgYTL5c+DgaSc4YgklYiqHs1gTI6g?=
 =?us-ascii?q?VwzGiSDNk8DGQ+OIRmEFL1mQTU7AgcBCgEBAwkBgVWDcAEBhkGBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:NccVEa94UrCGkRNGhy8oDrUDvnqTJUtcMsCJ2f8bNWPcYEJGY0x3m
 zEdUD3VaKmKajf1ft91OY62/UID65/SmNdqGgJr/ytEQiMRo6IpJ/zJdxaqZ3v6wu7rFR88s
 Z1GMrEsCOhuExcwcz/0auCJQUFUjP3OHPymYAL9EngZbRd+Tys8gg5Ulec8g4p56fC0GArlV
 ena+qUzA3f7nWctWo4ow/jb8k837a6t4GpwUmEWPJingneOzxH5M7pEfcldH1OgKqFIE+izQ
 fr0zb3R1gs1KD9wYj8Nuu+TnnwiGtY+DyDW4pZlc/TKbix5m8AH+v1T2Mzwxqtgo27hc9hZk
 L2hvHErIOsjFvWkdO81C3G0H8ziVEHvFXCuzXWX6KSuI0P6n3TE88hxEl0zZYwh9slmIn5T2
 tUAdiozYUXW7w626OrTpuhEg8M+MI/0MYlZtnwIITPxV698B8qZHOOTuJkEtNszrpgm8fL2Q
 sMDaid0KjnEbQdOPFg/F5802uul7pX6W2wH9QPE+fJni4TV5C52376zNMP+QYWTFN5IoGzIu
 2aXonusV3n2M/TElWrdqSLz7gPVpgv/UZ0bELmQ5P9vikeagG0VEhwfE1WhydGyjUW1WvpEO
 kkM82wvq7Iz/QqlVLHAswaQpXmZolgDVtAWH+BSBByxJrT80zuGGHQBFj94ZPM3l9ArahUyi
 EW3kIa8bdBwi4G9RXWY/7aSiDq9PykJMGMPDRPoqyNauLEPR6ls1HryosZfLUKjsjHiMR3dq
 w1mQQA7gKgPy9EG3eO38DgrYg5ARLCZE2bZBS2OAApJCz+Vgqb7POREDnCFtp59wH6xFAXpg
 ZT9s5H2ABoyJZ+MjjeRZ+4GAauk4f2IWBWF3gQwRMZ8q2Xxoy7zFWy13N2YDBg4WirjUWC5C
 HI/RSsMtMYNVJdXRfQsONnoUazGM4C6To2+B5g4keaikrAqKF/fp3ExDaJh92Hqlk832boyU
 ap3gu78ZUv2/Z9PlWLsL89EieFD7nlnmQv7G8qnpzz5iuD2TCDOFt843K6mNb1RAFWs+1mOr
 L6y9qKil31ibQEJSnOIrt9IcwFQchDWx/ne8qRqSwJKGSI+cElJNhMb6epJl1VNzvoLxNTbt
 GqwQFFZw1fZjHjKY1fCIHN6Zb+lGd41oXsnNGZ+dRylyloyU7aJta0/TpoQeaV41epByfUvc
 eIJVf/dCdtySxPG2Q8nU7/DkKJYei+GuyeyLgu+QT1mf5dfVw3DodDlWQ309RgxNCm8tOpgg
 rj5yA/reIcPHTpjKMPsbNOu0FKDknwPk81iX0bzA4dyeWe91KNIOiDOnvsMDMVUEir6xxyez
 BSzLSYDgPvk+qsZ0YDuq/ifjoGLF+BeIBJrL1PD5+zrCRiAr3uR/4BQdc2pIxbfbTrQ04e/b
 7x3y/rcDqU2rGxSudAhL4cxnLMM3Pqxlbp01Q8+IW7qaW6sAbZeInWr+8lDm6lO571BszuNR
 UO91YhGCIqNJf/aPgYdFCg9YsSH8MMkqD3YwPA2AUf9vQtc3r6MV2dMNBit1g1ZCpZIM70e/
 ORwg/5OtjSDiScrPO2W0QFS1WCHdUIbX4sd65o1PY7MiygQ8G9kX6DyMCHNzau0W41+CXVye
 j6wr4jetotY3XvHIiYSF2CS/O9zhqYumRFtzX1ZFWuoh+jqu/4T9z9S+AQRUQ564Ehm0eVyG
 24zLGxzB/yE0AlJjfh5fVKHOl9+FjiG3Hfu2n01lGH9ZGu5ZFzndWESF76EwxEEzjh6YDNew
 oC99E/kdjTbJOfKwSo4XB9emczJFNBe2FXLp5G6Ip6jAZI/XDvCh52ub0ourz/MI5s4pG/Dl
 NlQ0NdAU4/JHg9OnPRjEKif76oadz6cLm8bQf1BwrIALVuBRB6MgwqxO2KDUeITAcfV8H2IK
 d1kfeNOcBWc6BygjB4mAYw0Hrslu8JxufQjfOvwKH8koomviGNjkKjt+xjUgE4pRNRTkvgBF
 L7BSgLaLEuugSp7pmyciuhFJWuyXvccbiLewu2e0bsEBrADgs5WYGAw1bq45UuUFA5d+zOVo
 wLxSKvExMNyyYlXvtXNE4cSIy6WON/MROCz3wTriOt3bPTLKtXrmz4Oj1vaYzRtIroaXupom
 YS3sNLY2F3PuJA0WTv7n6atOrZo58LoesZqKePycWdnmBWdVP/W4xcs/36yLbpLmoh/4uilX
 w6JV9uiR+UKWttyxGxnVAYGKkwzU5/IV6bHoT+xi9+uCRJHiAzOE46BxE/TNGpecncFBo36B
 grKoM2R39F/rrlXJRo6FvpjUo5ZIljiZPMcTOfPlwKkV0umvlDTnYHZt0sQ2WmeQD3MWsP3+
 onMSRXCZQy/8vOAhs1Qt4tp+AYbFjBhiO03ZVgQ4MNylyv8NmMdMOABKt8TP/m4SMApOE3QP
 1khrVfOCBkRmRxBdgjgpsvuVEGTC4Ti/zs/yiMBpyuph+WeXetsw4eNMg9/7n0wdjaLICSPN
 4QF4nOpVvSu6sgBeAvQj8BXRc94y/mcyn9gFYURVSDtK052PIjmH0CN0OaAueIr3i0NeIj2y
 bAJeF15
IronPort-HdrOrdr: A9a23:pryr0a2nDsZVUtTWweuhKwqjBGwkLtp133Aq2lEZdPUnSL39qy
 nIpoVj6faUskd2ZJhEo7u90ca7Lk80maQFgrX5eI3SOzUO21HHEGgB1+ffKlTbckWSygce79
 YET0EUMr3N5DZB/KTHyTWZV/A93dKA7KekvuvGyWxxJDsaEZ2Ioz0ZNu6BeHcGPDWu6KBJb6
 Z1bad8zQadRQ==
X-Talos-CUID: 9a23:ijH0MmGc4AbCwxKJqmJXyVEKBsV9c0TR42bzPFKXIH43UoOaHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3ArJUEtg8c4oJO72UU+DNdWJqQf+Vv7KLwDFkmqsw?=
 =?us-ascii?q?f6tKZCwYgJjPM0SviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,158,1725314400"; 
   d="scan'208";a="97599408"
X-MGA-submission: =?us-ascii?q?MDGOtx0tSOVLYpzNI89TJIOctjoDIKAw3RYiQQ?=
 =?us-ascii?q?/ASoa2m1qu9KW1e4aDmduj4O0NmLQ1PaEOxy2G8iKD/3Rb0kupYt73R9?=
 =?us-ascii?q?rmunhh9UL/rXTLlzYGRi0Ej4GglRux8bgsvOU1L6FncTx6ms98Sly7Lf?=
 =?us-ascii?q?886KeETSeE0uJdgYK6/OccRw=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2024 15:26:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727443571; x=1728048371; i=markus.elfring@web.de;
	bh=dRPMAOu3qUuovmFS2nYUoyjO/QFux0rRso6G1a/3/VM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=DgcYHu+hC8SNGQs6GkSukHwflJX8asZ2IOaQreEBz76AdzI7Hxyh05NOK780jSN9
	 Ma1abaN0jiC59re4WliY2Ppy56jMlzDJH0G0OlVTCdXH0sH9m5foPeVqSsLelgRvH
	 fktVUwW7RZQwCPu2ohUiKmB0jFAH1a9CJmgHc1gaWsKnHTPeBE2qijfrGtDqcTVCi
	 Ei2lizJDXSqDC9jZ0j/5vA8J36nQTKjCsDOJJW3Hz1XJZ+NKnM7guOupTaznoBtVn
	 sfYVV+rFoS3vfZZFZHdda/uKcWVj1ZeLHgAUdYfYM5tuZsF8e6cdM9Gg49pOTleKt
	 3N+tZl+yqdkT58PRyA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MHmlu-1sfHGf31Py-00DGhR; Fri, 27
 Sep 2024 15:26:11 +0200
Message-ID: <30e00877-0cb1-4d53-a074-8140b372969a@web.de>
Date: Fri, 27 Sep 2024 15:26:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <12bd8d0a-d066-4fd7-a7ee-99209f18a613@web.de>
 <ca8a6747-ca52-5a1e-b0ba-df9bb18ac010@inria.fr>
 <4ec353d5-9771-4db3-83ed-7571b35eadce@web.de>
 <f2835a9f-425-211e-2d91-e6ff92903dd2@inria.fr>
 <3771e8f1-e6a6-47fe-a348-3ab248d765a6@web.de>
 <feffd7ea-f095-4562-9a82-3a1ec72ba5ae@web.de>
Content-Language: en-GB
In-Reply-To: <feffd7ea-f095-4562-9a82-3a1ec72ba5ae@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7+OTcxlhR0BigRJMj56T5Q0pPMHr4LY1zNsUqDG6ZNFdjNWpsLI
 sOyu8Mck+EWJR+yf72pXBpJpBAuzRxTz7Xt6ZAs2eZYaKyatC7XC6Spjwyffz3aGuJ0tnV4
 nFv00MthL8M8KfSgoce+ftISev5FULDK90PD2PNWJGlcPCzbeDuX6yzItqC846tnUuHTEYT
 rMuwWCqJMTSjWX6/NOyPQ==
UI-OutboundReport: notjunk:1;M01:P0:Glbhhq0gpAA=;K2rGDfLwzocnTzLPdUdVt7mL7Kf
 Gu1AXmoA2rplTnokrwanozGZpmIGJtimi2plHeuGtVdm3j6f/aRr6uSo7F/wGZVC89Af3Iozt
 HfLyiFrvyeSDNwgkDlDsnc1REpRn3/dogsr63s9HIY2qC7b4ckEYzWCwcxa4RJAbgwX32AQhW
 5Q1zuWCa4N6DlZlnsaiNaSRoJ6LQnZcLTjtxtea4XDg4ppwAPJIXnF8kG2mH3clqH6a4xe+8b
 xAgh5Cdtmbeg3ijFG16rJwgPnhJlAnxjAk1nzPA0DP8WjRPklSLejKhGsPS0WY95uh/DE8H+J
 A8c4v9NsxSh8D6nmqA2YCktrZ0IajjESilSzIriP8wMjwHb0HKWf+0rRj1kMW8kwvu+ek0ky6
 8Bqz/KN4HnY0CtzUiMN5Z9xV3uOL6G3lc1ij85mFEd6xidaTFza9VUlBvgg3si0bqhWKWctP2
 ZfvYend7sXEmSVdNltNcV2aS9Fdx8/0q1TFOsFWNdADLIETohKVKB4n1LOPYGZevQw/boMz8z
 NKWdg9Qf6W2dheFCJjwmtTBD6v9oteR539CH3oJPK3Lx6wGI911377/OHgp+kCpBS6g51JW2f
 LcUNZGPwJnaz0W9nH55oKUp+mhxEzQLWU+kDHyoXtXW33hV3RdFHGRizXffmRm4bovAZLCbes
 RR0uySCOGKvCuq1iaqo5nd1rG25jVveCgGBiBfH8JGBjsaR/rknNaBKxbK6CVMjkvyB4NB1+H
 c/OM13Inn1fjBlALbjWfAh5qBFp2cj8i/zJyrnduj4wu4M+bdkY6pkxIaA18NgjirID5tY2fi
 b8AQYUlmNEoaty3jKpt0gQNw==
Subject: Re: [cocci] Searching compound statements without
 =?UTF-8?Q?=E2=80=9Cif=E2=80=9D?= filter (by SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1895
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-09/30e00877-0cb1-4d53-a074-8140b372969a%40web.de>

> Would you like to compare such a questionable test result with
> other helpful data?
>
> Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> time spatch=
 -timeout 45 -j4 --chunksize 1 --no-loops -dir . =E2=80=A6/Projekte/Coccin=
elle/janitor/show_kfree_candidates_for_reduction2.cocci > =E2=80=A6/Projek=
te/Bau/Linux/scripts/Coccinelle/show_kfree_candidates_for_reduction2-no_lo=
ops-20240927.diff 2> =E2=80=A6/Projekte/Bau/Linux/scripts/Coccinelle/show_=
kfree_candidates_for_reduction2-no_loops-errors-20240927.txt
=E2=80=A6
> Markus_Elfring@Sonne:/home/altes_Heim2/elfring/Projekte/Linux/next-analy=
ses> lsdiff =E2=80=A6/Projekte/Bau/Linux/scripts/Coccinelle/show_kfree_can=
didates_for_reduction2-no_loops-20240927.diff | wc -l
> 325
>
>
> Will such information trigger any further software development considera=
tions?

Probably, yes.   ;-)

Can an isomorphism be disabled so that the combination of a kfree() call
and return statement will actually be presented instead of the case
where the kfree() call is only performed once just before the closing curl=
y bracket
in found function implementations?


By the way:
Are you still looking for opportunities to benefit more from the applicati=
on of
scope-based resource management?

Regards,
Markus
