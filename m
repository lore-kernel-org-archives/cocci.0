Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF267C0219B
	for <cocci@archiver.kernel.org>; Tue, 11 Feb 2025 10:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=bUhCDdj9SwZ14BiysXs4gcPiCZncC0dEGlPxjy5MWhc=;
  b=OcK7A8vuesBbBb9QOEi6K3nIsYCQ+EHN6Yu3HltBloUSrVnHAIKl1TB2
   vfiKx0rP93AWmv/Urn9fVGC72J6hjExStl4g5t70zuY/zGEYvtfJVPXH3
   eR7IaLf3MxGbeJrl+5YWToyZISsxVwB0qtp2R3aCqielyds9gdF5gRPV1
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.13,277,1732575600"; 
   d="scan'208";a="207672923"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Feb 2025 11:33:28 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 17155E0D1F; Tue, 11 Feb 2025 11:33:28 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 9D392E0260
	for <cocci@sympa.inria.fr>; Tue, 11 Feb 2025 11:33:22 +0100 (CET)
IronPort-SDR: 67ab2772_HQXsCnwqSIWw1R1jJITK31feXXvLa1uj8xA2/2i3st00sel
 sXzkU8uKFa1+4I3FjpPqTDekvtwsppl5UwQTzag==
X-IPAS-Result: =?us-ascii?q?A0EBEACNJqtngAwR49RaHQEBAQEJARIBBQUBQIFTgkRid?=
 =?us-ascii?q?TMEC0iEVo9PgXQwhDuHO4dTiHWDVA8BAwENQQECBAEBAwSCDIJ0AosGAh4HA?=
 =?us-ascii?q?QRHAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABATsHDgoxhXsNg?=
 =?us-ascii?q?mIBgSSBJgEBAQEBAQEBAQEBAR0CR0QBAQECASMdAQERJgEECwsaAiYCAlYGA?=
 =?us-ascii?q?RQBAYJ+gjABAw4jB7B7gTKBAYIMAQEG2lwfLCJXgWUJgRouhWyCYwGGJoQ8J?=
 =?us-ascii?q?w+BVUSBPAuCeD6IHoJpgjOER2eaU4lAUnscA1ksAVUTFwsHBYEpSAMqNjEjg?=
 =?us-ascii?q?SMFNEE6gg1pSToCDQI1gh4kWIIragQFgS2COYRDhEuFWoISgWMDAxYSAYIxc?=
 =?us-ascii?q?Hgcg1eBER1AAgELbT03CQsbBj2fSKxyoTs0B4I4gWaBYwyfXAYTL4NwAZNSD?=
 =?us-ascii?q?gaSeyyYUCKpDIIhgVwzGiSDNk8DGQ+OIQwWhAvFIkI1PAIHCwEBAwmFRgEBi?=
 =?us-ascii?q?xKBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:KkybragG5JUr/QO3+8Y8rwI2qnBQX9523DAbv31ZSRFFG/FwyP
 rCoB1L73XJYWgqM03IwerwQJVoMkmsjqKdgLNhdotKOTOLhILGFvAH0WKP+Vzd8mjFh5dgPM
 RbAuJD4b/LfD9HZK/BiWHWferIguP3lpxA7t2urEuFODsaDp2ImD0JaDpzfHcXeCB2Qb4CUL
 aM7MtOoDStPVwRc8SAH3EAG8TTutHRk5riQBgeQzoq8hOHgz+E4KPzV0Hw5GZTbxp/hZMZtU
 TVmQ3w4auu99m91x/nzmfWq7hGhdf7zdNHJcqUzuwYMC/lhAqEbJloH5eCoDc2iuey70tCqq
 iAnz4Qe+BIr1/BdGC8phXgnyP61iw11nPkwViExVP+vM3QXlsBeoR8rLMcViGcx1srvdl63q
 4O9XmerYBrARTJmzm4z8TUVittilG/rRMZ4K8uZj1kIMsjgY1q3M4iFXBuYdI99eXBmcQa+d
 xVfYLhDTBtABSnhj7izy9SKZeXLw4O91+9MzU/U4quondrdTlCvjQlLMBzpAZ9yLstD5ZD/O
 jKKaJuifVHSdIXd7t0AKMbTdKwEXGle2O7DIu+GyWSKEg8AQO7l7fnpLEuoO26cp0By5U/3J
 zHTVNDrGY3P0bjE9eH0pFH+g3EBDzVZ0Wk9uhOo5xi/rHsTrviNiOODFgojsu7uv0aRsnWQe
 y6Np5aC+LqaWHuBYFK1QvjXIQ6EwhWbOQF/tIgH16eqMPCLYPn8uTdbfbIPbLoVS0pX2vua0
 FzKQQb5P8wnHxDdkWI8CQ5AUmdBHAX1agAYZTy7qwU1JUHMJFKv0wclUm5j/v7WgF/jg==
X-Talos-CUID: =?us-ascii?q?9a23=3AnoK36GjQ6887aBWnFQt9xBgWezJuQHjezDDxIBC?=
 =?us-ascii?q?ENyUxZZ6NeW62qZpCnJ87?=
X-Talos-MUID: 9a23:f2IL7wSwg0F9jxJVRXTj2yldDvtp7Z6IJ1Eul7kvvtXYaCF/bmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,277,1732575600"; 
   d="scan'208";a="207672899"
X-MGA-submission: =?us-ascii?q?MDG1SDpre5Yk39rq6bznSynA2DFbVwTrBa1GnU?=
 =?us-ascii?q?6pVC+UmAIjztSYmlN1zYRl09N5fKnpFx/yhrP1ZO42uISn6WbL2EgP45?=
 =?us-ascii?q?+dfb3qQgzJTw8oB/fR8S4Kj6saKMehT2/nvZcj7QWwfiIBtFILbBjS6S?=
 =?us-ascii?q?FgfIgtLw+wNHc/fPB9TS1AXQ=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 11:33:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1739270001; x=1739874801; i=markus.elfring@web.de;
	bh=bUhCDdj9SwZ14BiysXs4gcPiCZncC0dEGlPxjy5MWhc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=a5FgSv7E4nq84lkgkm7hnXBLtpxgUIdjY7Otm+4YYdNa6NyqrzZF7ZLdTAvtr/wy
	 xshPFHXY6fcOvYLweZPDy9AWJc5Y8ppiGgKKmU4OPmK7Ta9tNivREIshLgCQt2+X+
	 21Da7Mf9QR9/AwvCNl0yv454sYJ46Y6EcPW7Ro2yOTIjINaN6EEFQVvlvK8TDpv2S
	 mW0sngxtwTr5ri71z9iUEtQqrF04WoeQmtGsK3UIPF08DsqnR297krHmEiAR8nIcC
	 D5Mi9D2fgpvmqaP+C3OyPDhnoVYusJzMOljDlmpzOeIEvUBxjIPW92XWtFsubTHc4
	 giAK5pgUDzSo3lFfvA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.9]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M7Nmo-1tl7Ur1LWG-00EMII; Tue, 11
 Feb 2025 11:33:21 +0100
Message-ID: <e01dde43-9c07-4914-ba39-224b4eccdeb0@web.de>
Date: Tue, 11 Feb 2025 11:33:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Victor Gambier <victor.gambier@inria.fr>, cocci@inria.fr
References: <381b5a9cb89cc068ca13546f69636291874010b3.camel@sipsolutions.net>
 <e9273f8b-7e6d-4441-8681-3f9044c23257@inria.fr>
Content-Language: en-GB
Cc: Johannes Berg <johannes@sipsolutions.net>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <e9273f8b-7e6d-4441-8681-3f9044c23257@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:T/Ic/nen9mrDLN7tiTSggc99aGLqPUMc5IGgGFATP2gTYFTaEO4
 9glOQO55ANdcz8NR+r/8MViBONUpGfHc64sRPA6u3P3S8PCJaj62wVSz8H/xiXJRt8zSTY+
 YAqCj54iMbY1VEdYeNulbU2/jPeiHfMq8RBCFvzYWYj9AM7O77CSVX3qIGUYnkbm+p5JBRk
 D2stksZN1qPKuu69DopkA==
UI-OutboundReport: notjunk:1;M01:P0:fSvm6aESJlk=;Gb8Mcoqz97XdqODx6akSMc1Lwf7
 Bi0eQd8IyS2U7PboY4oIqJ5g6eImz/FQU0LEsl1gJYCZLczl2MT5eoaCk7vMzQ15BrOZCHLxT
 Bpgm4zDGxpV2vTsdrUa8iRC5so0pq95+fUdhqOl/ODUtUj9rElmU+HC2q68NRyIQegDMWpsvi
 cO3Hp48YFAwrGPiMWx0Ncd/uxOXERuN1SXbB4N4l3GSFmXzAlnokiLD9812OMxoJHPaTYG2Aq
 M142WpNOqxR3GnzvRzl+VpBWnOgwrhBetGAHq9HD7gu0ZX2NoDh/kCTkunR5ShVfHL+sgI1Lx
 CVDJWaPCEnhVcRSad7w1jMBWfMoZwCYWxCoQiNM/VDaMNBVKDfYWGrBn9RbGDYbGIG6K7h1q9
 ZO6XpNsXvSwWMidC3kwJyHUgH3csx6L1Hgss9Q1ppqWT4KzigkwIl26fsOMNfnfLH4D6nxYwS
 RCi0GQzZtuOhpuJ3/P7P7csM9bz0saCWmaIwklHdbmqOgVFOpebExafC2wD/Avdj3LqR0N8ZR
 do2utI5t7Q35vvxF5PdTIEsWJlf2dWalKiMba8XmX9/GOo1Zi+7ua4L/1msrB5dRqJ/SIPPWp
 2OYkXg4AxoX2JjWhSHg3xjl9C6USbhFvXepzqUPtx9eY5Rjjv5yNoq13hmOBZ4AoIP5swoqN0
 Vw48PjOK3vmaIdz1sTKf3iFmpeGtiaXWq978fAobYJqm+g8LRlSCZqBc5bJcDnEIPvC115MLR
 21ZGYiAri4Wzkq/fDzVFThFnY/i2YZ/PUMF1f5E+1+X1RRDp88yVmtdfDEsvQihztBLTweuK5
 DU1lDloZ8wyDfD5SjL8uVzEuKOH4nzH3myZ71uosA///oBzOOtg7pncdrvBrOQtnxBboNy3Eq
 4rUZPSBdum+L8HMH82Nvs/5VF4exY0xfD8DG1U9H9l4R8gC67Ek9ImpQ5xFekQnyU5Esqi/9a
 MIhXrVANPJJc7j/wGVqEI7gqGfG8b/7HGIJkP8owUEh+gh0yOkKmL3t3iy+YeHSWvCLMGfwEr
 9CKhW0wro62e71D0T7d+/W5BYBbK3gJ0Ho7HnFTUlItnF+cn5GOJH5UX3W++LarEkrYDF69B5
 Hhmlfmth5BOFoBtVUOJCTz3bSzTSTBRalw4wIxtxjCbAy+Th+rbHh65kTCK+4Za1SyKnf7yYF
 2EYT9nO1j06dPvTIIv+dwXSvzpJnR7AbmWIc5klHe8wo5NM/7yNZlJS3vmxJE3Ju10zOVrGxr
 QZo2aQM4ytc/t0KmDZCqfp+pwHSeBlCAlxwE236JZyAqgwIQbSJsvy0giCA5PxhdudZaTgC52
 wZYpsALfIpjOAB1xiZizAZg53VBC4s0gnVekllg0DmA+/OpOf629nF9DsxRr3bLvkY8LECONh
 Oj7rtBfE9uwkK2VRAX5WIdB7bhn/Gh9otTWhuT+09kPYaroD+9Fbo6U2AtlCTXtYtxe5Ix1Rr
 2rdriGyT4YtTj4fz5eKSoAN3FGiE=
Subject: Re: [cocci] Comparing software run time characteristics
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2407
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/e01dde43-9c07-4914-ba39-224b4eccdeb0%40web.de>

> That is not enough to narrow it down, I'll see if I can figure out something else.
* Which test criteria did you try out so far?

* Will development interests grow anyhow for more precise analyses
  of questionable software behaviour?


Regards,
Markus
