Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6960C7619A
	for <cocci@archiver.kernel.org>; Wed, 12 Apr 2023 09:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=EjhzYpJr/xITVvQmXT0En0vXJLwf3CpC4oMMEc9w3Tw=;
  b=VhR1sEVq/a2/YbQBGJGgcCLV+Yn5lAcnb0HnqW3Lbhp2TUIfHdR5z+KG
   J0kd8lNN1ZxLoHxK3Aj0wstKeMkGSVBu/+zZ6YnIyznRAQJQHGuIpOoZ+
   D3B5vKbtm49xDiiirZ4T8hah4AUL0lnH5KCDMhvV/JowradB+tr8sZ7nX
   0=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="5.98,338,1673910000"; 
   d="scan'208";a="102595666"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Apr 2023 11:15:44 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 72076E7312; Wed, 12 Apr 2023 11:15:45 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 31F19E016E
	for <cocci@sympa.inria.fr>; Wed, 12 Apr 2023 11:15:43 +0200 (CEST)
IronPort-SDR: 643676bd_99gMFSU1iSAkZC3tWbveXqw5JNAYNkphTgVDgBQ3vQKRJXQ
 lZGu8Sw7GwzTa2PAQLY21pJ3PQGIjtoqBASgkFw==
X-IPAS-Result: =?us-ascii?q?A0EgAAD9dDZkhw4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYItgUsvBAtGhFOIHokShDCHLoc+iGqBVoFAPg8BAwENQQECBAEBA?=
 =?us-ascii?q?wSEfwKFPQIdBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAUBA?=
 =?us-ascii?q?hABAQEaCRcHDhAFIoVoDYI3KQERZIEIAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QESAkc+AQICASMEGQEBESYBBAsLDgwCJgICVwYBDAgBAYJ6gigBAw4jB6wQf?=
 =?us-ascii?q?zOBAYIIAQEGnAsfLCJUgV4JgRQtAY0JgzZ6Jw+BVUSBPIJTMD6IH4JnjnKLU?=
 =?us-ascii?q?QqBNHaBIA6BPYEEAgkCEWuBEAhmgXlAAg1kCw5xgUljTIF7BAIURSUEDgMZK?=
 =?us-ascii?q?x1AAgELOzo/NQYDCx8GWGsCCSMREwUDCxUqRwQIOAYbNBECCA8SDwYmRA5CN?=
 =?us-ascii?q?zMTBlwBKQsOEQNPgUcEL158CgYBJiTGA6AvNAeCK4FWgVkMnw0GEy+DagGTH?=
 =?us-ascii?q?g4GkiWXcyCnf4FjOoFcMxokgzZPAxkPjiAZHoNuj0g/ND0CBwsBAQMJhUYBA?=
 =?us-ascii?q?YV9AQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:5WrnyKlfjVBD25DDiQYTpbcQf/DpDfL43DAbv31ZSRFFG/FwWf
 re+cjzpiWE6wr5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQyVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK6foSizPZLz9P+qjkzImVpaP502pnSx1sZppt9gFjF2+gYzBLrUV9ZKbQD/
 Cnl7F6TtebCA4qhk/XPBM4Y9Q=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,338,1673910000"; 
   d="scan'208";a="102595631"
X-MGA-submission: =?us-ascii?q?MDGIZFG6R+8PcP6NOKtBnk3qFSGhJs3RuPLL3M?=
 =?us-ascii?q?4owFk1oRKQ8K11PMEmG0Q7e4HS4bP5lB5rLf3D/AKENwYSet3QnTIL3R?=
 =?us-ascii?q?eik1ryUeoZL27lC+YPC1+0a0zoCG1ZCuOy6FUA6n7C+U22sLw3o+3b6+?=
 =?us-ascii?q?VdGl4p4Yp22mScY5fT4FBRmA=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 11:15:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681290942; i=markus.elfring@web.de;
	bh=EjhzYpJr/xITVvQmXT0En0vXJLwf3CpC4oMMEc9w3Tw=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=saM1YoS0PMECBeRnFTvZuMVY6Hpmbm4m/3PkyK/3pSTKVf3XHlTpue833btz+8s0W
	 ia+10Sgd//MXP8AwnoZUAnSW5mgn656WWppH67xr7Vn+wdpA3iS5JpvqMwE2Tzgo8A
	 VQSEqFmVMIibxvocWnIxxBfmfkn37hSpytSKr9QVIJQHdpwnnbr4mn1pAWENqwxYzz
	 +eYK49pBywbDfXYPzc2Ryv1+iaXxDAzZrAlD0bAI7mKzJrpFpJk3/O3QKvfoFM+qaK
	 meTQJUcNiBjLA9eLQliwOkH6vDBDjMOjkjGS6CqC97jRWNcjILccS0sxqgxFuLfCj1
	 lvhPf50zh+Hnw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MaHWj-1ppyYa41VF-00WCz6; Wed, 12
 Apr 2023 11:15:41 +0200
Message-ID: <5c80a86f-4ba4-ba5b-204a-4a6d914e57a3@web.de>
Date: Wed, 12 Apr 2023 11:15:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-GB
To: Dan Carpenter <error27@gmail.com>, Julia Lawall <julia.lawall@inria.fr>,
 kernel-janitors@vger.kernel.org
Cc: cocci@inria.fr
References: <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <alpine.DEB.2.22.394.2304092044020.3028@hadrien>
 <95caa4c1-2455-2733-ef4b-3ab07783c725@web.de>
 <alpine.DEB.2.22.394.2304100824510.3387@hadrien>
 <2de88997-0732-d0dd-5178-f9d42b5a3be5@web.de>
 <alpine.DEB.2.22.394.2304100959310.3387@hadrien>
 <31b51efc-afbe-ec34-255e-9df60983ec3d@web.de>
 <alpine.DEB.2.22.394.2304101415040.2875@hadrien>
 <5defca25-d893-f61a-ec24-aa99ba39d8a7@web.de>
 <4d2383c7-b923-31a2-2c26-7b34b3b13c7@inria.fr>
 <11c630fb-8c17-425c-82fb-becdb90cfbe2@kili.mountain>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <11c630fb-8c17-425c-82fb-becdb90cfbe2@kili.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:yjhiUHVa176eUBZCH/FpFC4Zgzp6/2nphb6zUzY70fr/AFgrWGD
 9aNa3nDqDMWxBgl8PIdlVKZaHj0qhdRaQcKXD5LCExGdCXa3j9ssUZ30dEGysb3kKmrneL9
 3IeqU7CFcNopNNsNssTkSBNxVhkIRkOczZkj8m0mLoCfMumatOSZWBpbE9XLkaiir59xEKf
 Ilznel6apwP2L7cPxdi4Q==
UI-OutboundReport: notjunk:1;M01:P0:MFEodP3/Cjc=;WOs6Yn08XlJCQfCiM8ASb741+M4
 uf+Tu4ktDrIG+bF5AJB57N7hm3Grj8iT+GXWUkurnX7lNpzzp92TxUISS7lZ/8LGJXSt3klAL
 /ka5X991WlzCJXutLCTbvF0TlhjVwSfKRl2TPRZhBNIl9hI5j8R+M9mEhVh+r0gBAAtv/xqTz
 aaNWYI4OHNBOFYqcVMtcJxH2psOzkwYMzmo2oX9y3WaiPWzsz2uO+D8woN3sGTm/9x9XsM1+P
 6nyOhCk+8zowJ1746ffLOI2DKU+uHj4s4Ic/oQEHa8OIqBOs6e/LHIUQsQ3yOwaZTi1NYrEnU
 dlE6wh0SofytMOTT3ZRVQWsrijBiPvz9HmTqQqxB7YPNU2Qyr+1Y5kxwyihTbcBhPgAq8aTNR
 8l/d3oo/ITB/cyxI1pPaW8HVKP0I/zyW5zFb65nwrdaRdgv3txA13xX6BllRiFfUjTSWRJ7k7
 7e5Z/rmfdq4j7BjRNDIc8tKF7o58FmpFCU7wF6iajfr6RoF3N67Q9PqC3GDESrQXSG71/WOUz
 TG5H6ks1oUaBKqFtrmI8cZZRJHLIulS6Pj68gQqLpBlrUZIzDWAYjeKnn8k5oa1cv5RUPa9qt
 lb2V8V24B7g4L0ZALsRtDbHvzIEXHvNeagMYVfo7n+5Cn3pm6sJ3rYhm4Axtfi1Y/IB/cUqQV
 SIdaz3ZPY1Prvjco2R0fUBkHLCDEAD8//CKCpcEnfqHbiAsVdtYOZ/hl73wAF1WRSrDmC+Nlt
 fYVpqP40msophooMNW3+mkeGoWl4NHNwObVKgs8OBSi3i0mI6xYaplxGmPjr5ieB5WD4cNsO5
 X+IuYF1c9INaTsIinfFbaRc51VxXTkBdlEoq5Uaz3Mrfqi/Sq+Brs5WziNfiE/Mz81oEIU2C8
 vk1PsI6ig8Z0Dr9e7ssM1B/1wqRkiiNhq28dQUdwZ8Kx2jX/luCivbPop
Subject: Re: [cocci] Reconsidering pointer dereferences before null pointer
 checks (with SmPL)
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1038
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/5c80a86f-4ba4-ba5b-204a-4a6d914e57a3%40web.de>

> So &a->b is just fine in the linux kernel.

I find it occasionally nicer and safe to use such an expression only after
special condition checks.
How do you think about to move any misplaced code parts to other places?

Regards,
Markus
