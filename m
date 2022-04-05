Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC4E8C433EF
	for <cocci@archiver.kernel.org>; Tue,  5 Apr 2022 12:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=JBTQpzbP72ROzzwlT8NhQDrUfP1RBqzG2+BjUn/g6Do=;
  b=II96zjlJOvurGjQKjSYldLjcUpJSk3+ByFvyYnIBbzTRfEPjD+Q7Na2X
   XXNLdcRsf4cNfge41WT71LwHWjID5jFnahOrxDIKMEqA6ZXxxV5eKO0Vr
   szoiXZJmRrHJl6/Wk7B/3fdJkvEsXr4QLJOVFwRpmPP4koPsqm2EjH+Bw
   0=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@ti.com
X-IronPort-AV: E=Sophos;i="5.90,236,1643670000"; 
   d="scan'208";a="30152525"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Apr 2022 14:57:29 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 80A68E0073; Tue,  5 Apr 2022 14:57:29 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id EF646E002D
	for <cocci@sympa.inria.fr>; Tue,  5 Apr 2022 14:34:23 +0200 (CEST)
IronPort-SDR: MtQADbQ6IlyYzdHy8n0BaP1GY9cIq+ARNCahfEHghJuMHn9+WYKe5okN/1wbND3RrovVCKQEny
 eL4BwTr7FrWFuUwrbFvzU4+nhbDQGcs3h1uJMeF+hSOsGq0yKkLi9vWR0x+nSH6gze1WU/CaI1
 Ev2Eff9t8U625G3UhT8R7M6Yu88omQKxEeUrHwUkU4NfRlCXhsulZl3bWsbcvArBcF09WRJGln
 pLhMffO54mYlPPVTXca3HG1LkMmd5a+ImeE89Y2mMTWfYT0zgRhMPeeXQYP6I+U+PzKBZkymyb
 birzU5UiYr+37bmpq338pDGW
X-IPAS-Result: =?us-ascii?q?A0CRAACANkximPgXL8ZaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?VqCKH5WAQEBKQQLRI1ahW2CKJFGjR4LAQMBCwEBNwwEAQGBTgGDOAKEXgIdB?=
 =?us-ascii?q?wEENBMBAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAETAQEBAQEBAQEHD?=
 =?us-ascii?q?QkHBgwFDhAFPGRogU+BdAs0DYI1KQGDZAECAzoGAQE3AQ8LGB4QVwYOgwkBg?=
 =?us-ascii?q?xYPriKBM4EBgggBAQaBU0GDc4FcAwaBPI1UeiccgUlEhAg3PoJjA4demhJgV?=
 =?us-ascii?q?wKBNJNdkAaeIINTixWUTk0RlkKRfi2WMY0YlHOEWQICAgIEBQIWgXiBfjMaC?=
 =?us-ascii?q?BsVgyROAQIBAg0BAgIDAQIBAgkBAQKOHQwNCYNQgT6JPiMBAQExAgE1AgYLA?=
 =?us-ascii?q?QEDCY4mAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:gWOoXa8Y7VHDSmJSL+hyDrUD+XiTJUtcMsCJ2f8bNWPcYEJGY0x3n
 GIaWm+HbPnbYTf9ct4ia4qzoENX6seGxtEwTFE4/C5EQiMRo6IpJ/zJdxaqZ3v6wu7rFR88s
 Z1GMrEsCOhuExcwcz/0auCJQUFUjP3OHvylYAL9EngZqTVMEU/Nsjo+3b9h6mJUqYLhWVnV5
 Yuv+5S31GKNglaYDEpEs8pvlzs05JweiBtA1rDpTa0jUPf2zhH5PbpHTU2DByOQrrp8QoZWc
 93+IISRpQs1yfuC5uSNyd4XemVSKlLb0JPnZnB+A8BOiTAazsA+PzpS2Pc0MS9qZzu1c99Z7
 tVIi5XsSFYSH4LolMY+UQsbAQEmBPgTkFPHCSDXXc27y0DCbSO1n64oAVEqe5EZvO1wBAmi9
 9RBeWBLMk/F3bnwmu7rIgVvrpxLwM3DOoY3pnAmxjbcZRojacubGvmVvIcJtNs2rp1yM9TsY
 +cIVQpQVD3JZkxfK1s1J6tryY9EgVGkImMD+Dp5v5Ef6G/Yxw1Zy6noKNOTe9qQRMwTkFzwj
 mbP4G39BjkINdmV0zPD83S2h+aJkzmTZW4JPLm18uAy2QHIgGEDFFsKVB2wpvzRZlOCt8x3D
 UwRxCNyrPkJ1WOPQvveXQ/7sl7ch0tJMzZPKNES5AaIw6vSxg+WAGkYUzJMAOAbWN8KqS8Cj
 QTQxoy3bdB7mPjEFyzCp+78QSaaZHBNRVLucxPoWufsDzPLiYU3gxSnoj1LT/Pt14ad9d0dP
 1m3QMUWg7gXk5ZSi/798EDbxS6t4JPOS2bZBzk7vEr7s2uVh6b/PeREDGQ3C94bce51qXHd5
 RA5dzC2trxmMH10vHXlrB8xNL+o/e2ZFzbXnERiGZIsnxz0pSLyJdkBvWkgeh83WirhRdMPS
 BOI0e+2zMMMVEZGkYcuC25MI5l0lvKI+SrND6C8giVyjmhZL17Zp3EGib+4w239mVNkkKckJ
 Y2GdMuqEW1yNEiU5Gfeegvp6pdynnpW7TqKHfjTlk37uZLDOiL9YepbYTOmM7FhhIvZ8V692
 4sOaKOilU4FOMWgOXa/zGLmBQ1QRZTNLcqo+5U/my/qClcOJVzN/NeKmOl7JtM8w/oO/goKl
 1nkMnJlJJPErSWvAW23hrpLM9sDhL5z8iA2OzICJ1Gt1yRxaIqj9vlNa5pxdr4irbQxwflxR
 vgDWsOBHvUSE26eomxNNcHw/N54aRCmpQOSJC75MjIxSJhtGl7S8dj+cwqzqSQDV3LltcY3r
 7C6+BncRJ4PG1ZrAMrMNqCzzhW6un1EwLB+WE7BI99yfkTw8dUzcXWo1q9ve8xVcEfN3DqX0
 QqSECw0n+iVrt9n6sTNiICFs5ytT7l0EH1cEjSJ9r2xLyTbojeuzIIcAuaFeTfRCDH99Km4P
 LQHy/z4LqVewA0MvppgVapqi6k54oK39bNdyw1lGlTNbkiqV+o6eyDejZEXu/0f3KJdtCu3R
 lmLpotQN4KPNZ63C1UWPgckMrmO2K1GgDXU9vhpckz26DUureiDXEFMZ0DQ02pQPKczLIJjy
 uAk4ZZE5wu6gxssE9CHkiEJrj7VdyRQC/0q5sMAHYvmqgs30VUeM5bSPSn7vcOUYNJWP0h2f
 zKZicIuXViHKpYurpbyKZTM4QaZrZADvA4SlQNZYVmZhpzZh7k82xg5HfHbiOhK5k0v7g6xE
 jED245JyWGm4zYuj89GN4xpMx8UHwWXoyQd1HNQ/FA0jCCUuqjlMGx7MuGIlKzcH6SwYRADl
 IylJK3ZvfoGsS0/MubemaKolhA7ceFMyw==
IronPort-HdrOrdr: A9a23:ARU62ql4hWWeZMxOeh92pgvW3t/pDfIf3DAbv31ZSRFFG/Fxl6
 iV7ZYmPDvP+U4ssRAb6Km90cy7K080mqQV3WB8B9eftUzdyRCVxeJZnO3fKl/baknDH4dmvM
 8KHsQQZuEYT2IK6voSizPIdurIruP3k5xAyd2utUuEFGpRGtxd0zs=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,236,1643670000"; 
   d="scan'208";a="30147109"
X-MGA-submission: =?us-ascii?q?MDGdjSmy7Ryl/8H5Vg5T9l1rA246mH3eyln4qC?=
 =?us-ascii?q?qokpzDoHp89uobT0elJj/jlGn6MkTi8bbsZLepyVkAf+UiLnOoywn5YI?=
 =?us-ascii?q?PIuSP3jcQASOQ95NsZ/Jn8w1pypgo/v5L42QKoj/VLJwY+8IHQzUmVOw?=
 =?us-ascii?q?py31FSi4BLkE/buR5XJahQbA=3D=3D?=
Received: from lelv0143.ext.ti.com ([198.47.23.248])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 14:34:22 +0200
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 235CYH0u099060;
	Tue, 5 Apr 2022 07:34:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1649162057;
	bh=JBTQpzbP72ROzzwlT8NhQDrUfP1RBqzG2+BjUn/g6Do=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=KwgVbuVcWyxfIZ+4pGRHsr8xUf+IpgKaPnSsiVFSF2Rncegc7Lxe8dL78ITJoErA7
	 yIKAbFPV/RUnVYDDL9qqphedyyE22iICSA/rvG3UgKx6eh8bBk8mHWA7KliU/KYXph
	 HnjANKc6RS1fbzaZQM3uhDqrA8vvjxUBRKy3cT2Y=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 235CYHx1105259
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 5 Apr 2022 07:34:17 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 5
 Apr 2022 07:34:17 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 5 Apr 2022 07:34:17 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
	by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 235CYHbc106836;
	Tue, 5 Apr 2022 07:34:17 -0500
Date: Tue, 5 Apr 2022 07:34:17 -0500
From: Nishanth Menon <nm@ti.com>
To: Julia Lawall <julia.lawall@inria.fr>
CC: Nicolas Palix <nicolas.palix@imag.fr>, <linux-kernel@vger.kernel.org>,
        <cocci@inria.fr>, Kirill Smelkov <kirr@nexedi.com>
Message-ID: <20220405123417.n6mdou64qidgsfo5@doing>
References: <20220404215926.14811-1-nm@ti.com>
 <alpine.DEB.2.22.394.2204050816560.2185@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2204050816560.2185@hadrien>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH] coccinelle: api/stream_open: Introduce
 metavariables for checks
Reply-To: Nishanth Menon <nm@ti.com>
X-Loop: cocci@inria.fr
X-Sequence: 355
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-04/20220405123417.n6mdou64qidgsfo5%40doing>

On 08:17-20220405, Julia Lawall wrote:
> 
> 
> On Mon, 4 Apr 2022, Nishanth Menon wrote:
> 
> > Coccinelle spatch version 1.1.1 reports the following:
> > warning: line 134: should no_llseek be a metavariable?
> > warning: line 141: should noop_llseek be a metavariable?
> > warning: line 223: should nonseekable_open be a metavariable?
> > warning: line 290: should nonseekable_open be a metavariable?
> > warning: line 338: should nonseekable_open be a metavariable?
> >
> > So, introduce the metavariable similar to other check instances.
> 
> This changes the semantic from matching the specific thing to anything.
> So are you sure that it is what is wanted?  If it should always be the
> specific thing, then you can get rid of the warning using eg symbol
> no_llseek.

Aaah thank you. Will post a v2 with s/identifier/symbol. I still need to
grok the nuance between the two in [1]. Thanks for clarifying.

[...]

[1] https://coccinelle.gitlabpages.inria.fr/website/docs/main_grammar.html
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
