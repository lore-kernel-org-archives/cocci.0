Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E174C19F32
	for <cocci@archiver.kernel.org>; Wed,  5 Mar 2025 09:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=h7MF2pukzcCQNx/zWpZiCS3hgViBAj+HXBu+xCaW0ac=;
  b=gJQ5wRVmSLd/aIK8smQbm3fuhB5Y8DFwjCFW3ehHZgOsRLSFbYX5rVhH
   xCInnvzLCovqzWc7W1paMI0MesEU9osz0P4Bxe2zZtFUXW9jPvDtsiask
   lXF4IEQ5hn6RniOe4K8oET1QbyrGq2EtQb3ic8Ngpm/tsBSJ+2SQt5rb1
   s=;
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
X-IronPort-AV: E=Sophos;i="6.14,222,1736809200"; 
   d="scan'208";a="211270122"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Mar 2025 10:21:03 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2B24AE0D23; Wed,  5 Mar 2025 10:21:02 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id A9B63E0260
	for <cocci@sympa.inria.fr>; Wed,  5 Mar 2025 10:21:01 +0100 (CET)
IronPort-SDR: 67c8177c_tRxR1v3p409gdpCdBJPOUe3jt5vSAdB+UfRY7spghHcnuGY
 uqPV6QzPYf84OmK0y87bFiRI0OvnrDP0nQ/6ffg==
X-IPAS-Result: =?us-ascii?q?A0EmMQCIFshngQsR49RaHgEBCxIMQIFIC4JEfVozBAtIh?=
 =?us-ascii?q?FaPT4F0MIQ7jw6IdYMsKA8BAwENNA0BAgQBAQMEhQACixYCHgcBBDMGDgECB?=
 =?us-ascii?q?AEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQE7Bw4JATGFew2CYgGBJ?=
 =?us-ascii?q?IEmAQEBAQEBAQEBAQEBHQINBzNEAQEBAgEjHQEBESYBDwsaAiYCAksLBgEUA?=
 =?us-ascii?q?QGCfgGCLwEDDiMHDa84gTKBAYIMAQEG2lwfLCJXgWUDBoEaLoVsgmMBhVtLg?=
 =?us-ascii?q?0J6Jw+BVUSBPAuCeD6CYQQBgV2DW4JpgjODPYEDZ4FsilUcLYIlileOXFJ7H?=
 =?us-ascii?q?ANZLAFVExcLBwWBKRAzAyAKNBQdAhQNHwYQBGoFNEE6ggtpSToCDQI1gh4kW?=
 =?us-ascii?q?IIragQFgSSCN4Q9hEKCP1GCQoIRcW8DAxYPAYMfdxyDTHc7hHIdQAIBC209N?=
 =?us-ascii?q?wYDCxsGPaFtO4V8mQkBr1M0B4I4gWaBYwyKKZU1BhMvg3CTVg4Gkn2GIpJcI?=
 =?us-ascii?q?o1jlSqGBDWBSCSBXDMaJIM2TwMZD44hg3ozN8drQjUCOgIHAQoBAQMJAYFVg?=
 =?us-ascii?q?3ABAYpUgUsBAQ?=
IronPort-PHdr: A9a23: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
 xZamdsQwqwMO4e910EwMzFH
IronPort-Data: A9a23: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
 abZiIyErIyGpZbNLPtd
IronPort-HdrOrdr: A9a23:NHd42qNxroLEZcBcThWjsMiBIKoaSvp037Dk7TESdfUnSL39qy
 nIpoVi6faUskdpZJhEo7u90ca7Lk80maQFhrX5eI3SOjUO21HHEGgB1+ffKlTbckWSygce79
 YET0EUMr3N5DZB/KXHyTWZV/A93dKA7KekvuvGyWxxJDsaFp2Ioz0ZNu6BeHcGPzWu6KBJbq
 Z1bad8zQadRQ==
X-Talos-CUID: 9a23:ANEhC2Ng+Hsxve5DfG588EBOF8oecHDE0TSMAVToE0htR+jA
X-Talos-MUID: 9a23:JwXt6wnW93Husj6DjfefdnpwE+o12/SSA3ozlJABnNirZAJVZmmk2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,222,1736809200"; 
   d="scan'208";a="110701143"
X-MGA-submission: =?us-ascii?q?MDHXfkIgvz3oCiDnZsWsbAEFRb0oAn9oBcHUw2?=
 =?us-ascii?q?irlF9FEeR7vRjD4G1K1PPwVT5A1pD9WTwXCxe4Jp5mfwOopn5b2lJTpv?=
 =?us-ascii?q?RpYTMGYBEYC3WzWiRYH21Z6BLsWJHgXmmQRkzD/5qjBbMgs+AUjmm7//?=
 =?us-ascii?q?52ZbGtOQAJcPDzUZvj3y0LFw=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 10:21:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741166452; x=1741771252; i=markus.elfring@web.de;
	bh=h7MF2pukzcCQNx/zWpZiCS3hgViBAj+HXBu+xCaW0ac=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=cMUx7bA1rSuadObqsP5/9GPP77G0F95Jptm825dUCW0m387ivjweN2joWqlMXaI+
	 IcBA7fuTgGI0FF01eQqUH8fECJ9YtmF2yf9wWYvc24jJeXCH2KbsuBO4jpZK3FtVh
	 NmyDRIc/+dORmuANznZSyZK8yX78IqwUgid3oSoNWoOzDUxpn68i2Ifd53uRZQkXp
	 3X/nLV15MA00SxregkO7FtgxdOD8g1sHWgGzGnax07K/UJxrEXMnNNSFA2G9WtdCa
	 2kpTtojfihhjt5kYreeSuJsvLBlvL2ziOR91h4uTsDhNq/ojzAIo0oqVyeGGrm0Tq
	 2gwmSMJmm38DLSiFMw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.10]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M5QqN-1tr7qL1mQ1-000RCH; Wed, 05
 Mar 2025 10:20:52 +0100
Message-ID: <a6243882-e289-4a08-9119-3c73933d6458@web.de>
Date: Wed, 5 Mar 2025 10:20:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Dan Carpenter <dan.carpenter@linaro.org>,
 kernel-janitors@vger.kernel.org, freedreno@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Archit Taneja <architt@codeaurora.org>, Daniel Vetter <daniel@ffwll.ch>,
 David Airlie <airlied@gmail.com>, Jeykumar Sankaran <jsanka@codeaurora.org>,
 Jordan Crouse <jordan@cosmicpenguin.net>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
 Simona Vetter <simona@ffwll.ch>, Vinod Koul <vkoul@kernel.org>,
 cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <13566308-9a80-e4aa-f64e-978c02b1406d@web.de>
 <54c30a69-71cf-4582-9086-50eb0d39f273@web.de>
 <k7un3bjavyt4ogscgc7jn7thfobegaguqqiy7gtypmq6vq7zox@l4bsevbsjrud>
 <29b32b0d-312d-4848-9e26-9e5e76e527a7@stanley.mountain>
 <e665514b-5a62-4afb-b267-7c320e4872af@web.de>
 <4c489b64-4c25-43e3-90d3-37f2f335d665@stanley.mountain>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <4c489b64-4c25-43e3-90d3-37f2f335d665@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PPRCchf5c9fDV82ZnVt3zyworm0/jc6du/DkLT7OlMhlEOw06gL
 14PuC/lWkV/JePSRYwvu623J4IKThp5oaGF4ynFVpdhJXlVZxPSJjnmuEmhahu+d2ScWbqm
 o8a3oV/4fBh9DAyhBQ3CB5ZRuZZKROAleHVK2qANvWYGsHI0540nBiweJw10osUjOHUwX7V
 R0TgSdK86F/K8S5BWqmdw==
UI-OutboundReport: notjunk:1;M01:P0:HnHMVUu0qf8=;HtW5MydlmAVPgeX+uSbHvOiYseX
 dM0hYYg+7B7fGA9abFJssSljkkmmEfoM3sCZ57ejyN7SkfRkB/eHpf5YwPwnybrimceAO3nol
 tyhUZepOSoQFqbR0W+vyRfnLUhiu/Bfla7goEUf1YSK/DxSRE8F03d56EH68VDTWRtN0AX09E
 l4sdclwQTcxe6pMuVRcS7I6dXcgLzZUqTaqD4WN3wZUlFUteqY3xGT6+iDobs9GFDpcMYW6iD
 aC7TOD8jjJXgViB212eXZgyV0q9LQcV4JB7lpQBeuCIyXdMRqdG7RTXLDr7l36nOn8vFveT8o
 4pF11vYIbpsCPh2/VCUo6JgduPAuB/ZJI50lFc34gTQvxD7SsjHlcPSzAKSWmUVYcnvhia+2d
 YaXhvf/7bTuF3pTNoOWFzKx8yXdJl2Kza6a3kdzA2YTa3iwz8ONBvrIFdLhk7BHlF2ouT04Ff
 OmxyMXmIyAbWbst3L9v5xZz4dhndC4p+ytsiiqAl47057acFB7GDxNKPeKXS2p0wThhNTtfWO
 IbRQpLRTby8ogQrtbzbGNScxofF0CfJsu5mWl84xMVn5jdEgTLd0iYtIt3Lag92yw/7IYR/vI
 w9SKBfGKiFhLdzdT6L7QYvbVRpMwm6Z08zdbov1TYWsA/pm87SG50mRoN5+gma+R8zxHrjFQX
 2uLxXKhOPsTbsSaDxNKrgY7p0w0txZVc8eeFchvb/1x4+1zOpm2iJ4JlZrxHpPZj3lu9yBvk3
 MmnqlL79molwdVDEzXKjotOq2tMGmcpdLbg4zsN1FSm71YNAzUS0ipSBZlcUuz1JhLH0m7wfw
 8nJnYjLY9QthG5v+pdbFCSGkn0tPY8+gDPZyj/o1iSB2812Bj6A/il38tFJqqQ0GRHZImDWJv
 hI9lNCLnosx4+ii36ET2MfDgeLR29z4hrQiK5cUDr58us3kmj1AmFJVSzd1VgzwHo9woONiSC
 n3RFz8L6e1GLU4fOL6y1TKWsI6ICKZgQDXMqsr/b+/OWgVZ+3FbJ3AtRZMsN5+iFqiIJPuufp
 jKFUCMJObBE/lYvqfcIJPviwZ84qFJT1coeF5jDRMUWOHnwaNnjCNet4W6U4GIOsXEmM8VRi7
 Y9l8ZVPemT88XSrKUw5hcgzAk5rYc5GD2Bf/0BxjAd0CqjMkOfD3CbkoJd3C887ueTYiA8vvD
 mZcVwKZJlWSuIqz5fY2MshrrzceyR0Io5cp31d1wWoA+7stG1dgX6wxREQ7Ezr/LZBPNXhryh
 9tNzBGUSeSQnDQb/cFw5FZ2daVXwh/9DhcuXMHh+30NnqzVCeEDwnRDclYpbYr/QLOFKlIFoi
 zOiBhA1Ad2vPtg246rgJPa519l8GD7+5moJmn66X5omhMmrkddJ8plri//4gp2uyKhKOZm/sT
 7PnBLvEdJdpiT6KMa/v/wqhb+QUlejdCRwtMxB6oH2H+tlxG5875+Rk5GZBpmfaK/GZIELIx1
 WaQEILRh7bwQuBTcx4u4kZSHVGfM=
Subject: Re: [cocci] [RFC] Clarification for =?UTF-8?Q?=E2=80=9Cundefined_?=
 =?UTF-8?Q?behaviour=E2=80=9D=3F?=
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2540
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/a6243882-e289-4a08-9119-3c73933d6458%40web.de>

>> Dereferences of null pointers are treated in special ways.
>
> This not a dereference.  It's just pointer math.
Do you prefer the wording =E2=80=9Cmember access through pointer=E2=80=9D =
occasionally?
https://en.cppreference.com/w/c/language/operator_member_access

How do you tend to describe (and detect) null pointer dereferences so far?
https://wiki.sei.cmu.edu/confluence/display/c/EXP34-C.+Do+not+dereference+=
null+pointers#EXP34C.Donotdereferencenullpointers-AutomatedDetection

Regards,
Markus
