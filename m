Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C269C4725D
	for <cocci@archiver.kernel.org>; Mon, 22 Jan 2024 12:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=JlI6oJ4yUpkIyWemM/YYc6/lnR2MeUov9gvivfsE8fI=;
  b=gc1eaao1ifqJR6L2CLgv7RIHln+nj12QZkCIKZKFMON0R9jNXrU6y+Pr
   IRPKGI7l7F6cLT947YlBoHhaGwk3Iy3ZhjkVMEWyEKzFeRnyrPu8gj+Qd
   pYmVpLLf1330wiTywstDG/5fNKgi0p2p3b7er8yP6AuDZ5hFzZ8hAtLPo
   c=;
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
X-IronPort-AV: E=Sophos;i="6.05,211,1701126000"; 
   d="scan'208";a="147943966"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Jan 2024 13:15:51 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D1A9DE0CD7; Mon, 22 Jan 2024 13:15:52 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id D6CF7E0035
	for <cocci@sympa.inria.fr>; Mon, 22 Jan 2024 13:15:50 +0100 (CET)
IronPort-SDR: 65ae5c72_GCQpFKnbKSI4WVSl33ylU9H73bAfJJXVTZ11F/eDQr+Ph5e
 xgqS477e8JrctHgzcBFLEG/xhFnrHHlndQ2oF/A==
X-IPAS-Result: =?us-ascii?q?A0FpBQAJW65l/wMP49RaHgEBCxIMQIQIB3hTMgQLSIRTj?=
 =?us-ascii?q?0GBdTCEO4c2h06Ea4QEgWqBLD4PAQMBDUEBAgQBAQMEgguCdAKHRgIeBwEEN?=
 =?us-ascii?q?BMBAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECgQYIC4UvPQ2CXAEQg?=
 =?us-ascii?q?QyBHgEBAQEBAQEBAQEBAQEBAQEBARcCR0IBBAEjHQEBESYBBAsLDgwCERUCA?=
 =?us-ascii?q?lYGARQBAYJ8gisBAw4jB7RsgTKBAYIKAQEGr1kfLCJWgWEJgRouiBwBhWeDQ?=
 =?us-ascii?q?XonD4FVRIE8gwM+g3xHP4McgmiFXIVPhEaHPVR/HQOBBQRcDxsPHjcREAUOD?=
 =?us-ascii?q?QMIbh0CMTwDBQMEMgoSDAshBVUDQAZJCwMCGgUDAwSBMAUNGgIQGgYMJgMDE?=
 =?us-ascii?q?kkCEBQDOAMDBgMKMTBVQQxQA2UfMgk8CwQMGgIbGw0nIwIsQAMREgIWAyQWB?=
 =?us-ascii?q?DQRCQsmAyoGNwISDAYGCV0mBw8JBCUDCAQDKykDI3QRAwQKAxQHCwd4ghCBQ?=
 =?us-ascii?q?gMZKx1AAgELbT01BgMLGwY9Ap1FxHA0B4I0gWCBYQyfLwYTL4NuE4x1hjEOB?=
 =?us-ascii?q?pJZLodVkFEggjGmHIF6JoFZMxokgzZSCw4PjiCEK49HQDU7AgcLAQEDCYVGA?=
 =?us-ascii?q?QGDWoFGAQE?=
IronPort-PHdr: A9a23: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
 C7Vs8IovFys1OWCmGIPbQ==
IronPort-Data: A9a23:nu74rqhxPAbsnLm5Jt2JLsK5X161dBEKZh0ujC45NGQN5FlHY01je
 htvWmuFa6zZMzD2f4ogao7jpB4CsJ6Bm9NlTQpq/Hs8FH5jpJueD7x1DG+gZnLIdpWroGFPt
 phFNIGYdKjYaleG+39B55C49SEUOZmgH+a6UqieUsxIbVcMYD87jh5+kPIOjIdtgNyoayuAo
 tqaT/f3YTdJ4BYqdDpJg06/gEk35qiq4WlB5gdWic1j5TcyqVFFVPrzGonqdxMUcqEMdsamS
 uDKyq2O/2+x13/B3fv4+lpTWhRiro/6ZWBiuFIOM0SRqkQqShgJ70oOHKF0hXG7JNm+t4sZJ
 N1l7fRcQOqyV0HGsLx1vxJwS0mSMUDakVNuzLfWXcG7liX7n3XQL/pGPFMLZpI/wNtODV5At
 uApCCwcP06RiLfjqF67YrEEasULKc72IMUAt3smwTyx4fQOG8mZBf+QupkBgXFr7ixNNa62i
 84xTDN1bwnbJTBLNE0WDp0Wg+qiwHXyG9FdgAvJ+vtruDmPlGSd1pD8Dd73ccWQd/lSjx/fo
 mLZozrEPi8FYYn3JT2ttyjEavX0tSj8U4kTPKap8+ZjxlyV3G0aThMMPWZXutG8jVOiHc1SI
 QoY90LCsJQPyaBidfGlNzXQnZJOlkd0t3d4SoXWNCnlJmvoDwel6qwsSzlcdJo5ucVwSTFCO
 pplWT/2LWQHjVFXYSv1GnSoQfeaJiUfa2MPDcPBZRVQ+MHt+enfkTqWJuuO08eJYhndBjz6h
 TyHxMT7a3P/kuZTv5iGEZv7b/5Aa3QHosPZJukaY4590j5EWQ==
IronPort-HdrOrdr: A9a23:f/b7D6yw99xSg6C0KgFcKrPw+L1zdoMgy1knxilNoNJuA6mlfr
 OV7ZcmPHjP+U4ssRAb6Km90cy7Kk80mqQb3WB8B8bEYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 pdmupFebnN5DNB7foSjjPIceoI/PnC1ry0juHDyHpXQRhtcLwI1XYFNu/WKCxLrBItP+tDKH
 Nw3Ls8m9IqFE58UviG
X-Talos-CUID: 9a23:A43tIW/l+hpk2ajLobWVv34GJ5s6VUfg9XvvLQykOEZ1WezLW1DFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3ACntkdQ8RuoymwAlIcbZfzEOQf9ZV54alEVo/rZI?=
 =?us-ascii?q?X4o6ANTMsZQqhsiviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.05,211,1701126000"; 
   d="scan'208";a="147943940"
X-MGA-submission: =?us-ascii?q?MDHkNN0W53S2GM+goblGNhvZIuoO7K/+irWsjy?=
 =?us-ascii?q?8ZtNJdzgSn55vuUgAgb1h8nehGzZNqDJfwa09V6C89S9CVT1LbKICfxi?=
 =?us-ascii?q?auU47+uvmedErwqML/IdiKfSYDQDy4CiLHsULS9hxV2nrqy/Z+BEZeSu?=
 =?us-ascii?q?CGnhsIUHcCoVqQyyqzXHZaqQ=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 13:15:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1705925737; x=1706530537; i=markus.elfring@web.de;
	bh=JlI6oJ4yUpkIyWemM/YYc6/lnR2MeUov9gvivfsE8fI=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=aVUkt6ik4gUZeuYOBMXqAs+0YCD5aH6EVw3mslrH0x+3tvJ/PsyrAQT5+8upnshQ
	 hJb2cp4LnCXrGBVTdzT+f0FnpsEoY2jrSIGL7Qu/nTSDIRFZtK0yz7Rj3kGjtA1kK
	 +SGHis0SoZ2Z29UkTwJlmpi2nGDXXzUwpBhgB4oa6RHICpMmVFAVLhhVNBQpEdPWu
	 AGSX5s7H8LuJkRtPO5uU6qylB5VOUCi5acGpWI5/ZRMxVrfsbg41D0wfzfz/ozdK9
	 yhRepbikmU+7JQXN0ovoV+g+uNkyOCzzfe9YYWMwD7aoAT6VnoKZO2guKD4/ZI2Fw
	 S5dAuqUMrO7OHqiHYA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.87.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M8T7E-1rWGvw3I3c-004hJE; Mon, 22
 Jan 2024 13:15:36 +0100
Message-ID: <32eef8de-1e95-4e4e-85c5-9cc881b75bdf@web.de>
Date: Mon, 22 Jan 2024 13:15:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <ebd531dd-60e3-4ac3-821e-aa9890960283@web.de>
 <Za5SW6xdsOFylD7x@matsya>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <Za5SW6xdsOFylD7x@matsya>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Mn5UYh7mrmxQ0WaeWCTZLO++m6xX+ndy1U4RL6USooOPRiI2s3o
 YAFhZ1lMh/Qr9xsuSmfYRicdlojXl5ltelqkAnJmXeWKXZBDEV9gFE+HwQtcbBZ5pT29fQM
 SJPixYJXtJYtcJ9MhHqq+d1yx7VuzH9oG2hyLP3iEeCmDmfiOa5GaTD0dzp+STV3Z+N23xT
 u3kvQ6TBLC4klc35uhnmQ==
UI-OutboundReport: notjunk:1;M01:P0:efwrYv3DkmE=;f9/ozwvaAeYDo6XGikObS3hiJJp
 u6URE5Ns/fSKfVfLK2QcKl5c9cLYzynW1zScAJya4QcuLVCwNNCoXjcYQO3fvCWJltKn9ETbV
 IS09zzdZY6wEFxUV1JL/d+H9XPXb0d/cGTAB8Ck3M3uilqqVJkmHDkdmwpJ6lwD1OCFMzDLfw
 m48WsZ6y4gzaR2EbhkI1qrLGQWYl8KSsDETSXfK2N5sQ6cgi2pmDHviC3f8KTVwPpAy9VrZ+g
 bzTgZ7aFvAuHpKq9NMprZoFqhAEcbeZE6OnTnOaL/t8ahW3wtHI8e6rTXCyUfW5aS3DuYKc3L
 uW3EQY/STQbHbHCV2/8AL3xmxkU3iPm/vWEFCB+w1aPN+BNlMGNm6P5VUnyBRNm4reFwfTfuw
 tLRtRnRBHRPyr7UXOziQknJ+e/6z1ivhk9MHM+KHMvROll09H/idbW3Qk2W1AkiTtqDIHqVxo
 h0HqGhtUelAA4Cm7x/RlPLe8W+TLWff0vffJEEVH7vPDRw/EIgOW3r6eGwxCvZOfglugyh1dN
 gThzTkXHP4trMhr3g4Olj/BuArvGAwlQuiV5bJmgDYUGGFodVVglg/xO8hwzI4CRPQpWt3uz2
 aiGhX5Uf/mnr5RG0OBMmuPo/PUEdt1WDBP+Diocv3q8oC+WNtwawwqoNK0XGwEdJ/FKJp1qbG
 OAjRmLwLYEULjhOMK1b0HezRLNio3NcB7NaaOBI047y+P/A/auGw3qWoQnGAjktdE1/61a39l
 eONsPqv4kfzzI5OKPbF1/mJylHz1AqYMUbdzRncSMA7gRwWjAcH9U+s1XnBFkbUm5KqR5RYaj
 tRMkkBsWGRLG2YkbHovTK9mda3vaYBAWUrwczM0rjJi/nlvX9Ak+F88ONR2P1jU7ojugh+8lf
 DJzR0u/0xbaYHrLgCROMtt2+VJqc3WGAnKxdIB5FbhUnXyqK6r1VXkCYXeIn5c+Ug7buMkN1H
 8WEBkg==
Subject: Re: [cocci] [0/3] dmaengine: timb_dma: Adjustments for
 td_alloc_init_desc()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1475
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-01/32eef8de-1e95-4e4e-85c5-9cc881b75bdf%40web.de>

>> A few update suggestions were taken into account
>> from static source code analysis.
>
> was this anaysis done by you

Mostly, yes.


> or some tool reported this.

Some scripts for the semantic patch language (Coccinelle software) can hel=
p
to point places out for desirable source code transformations.


> Frabkly I dont see much value in these patches,

It is a pity that you view the presented update steps in this direction.


> can you fix something real please

You might occasionally find adjustments from my patch selection more worth=
while.

Regards,
Markus
