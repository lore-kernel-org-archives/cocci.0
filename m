Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E86C48BF8
	for <cocci@archiver.kernel.org>; Thu, 22 Feb 2024 14:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=FWJsG2djkdi4Md/UBn2ybwjbfNYrn4ZeIeNxrYQclto=;
  b=kaMbZe0rOtdZMbG8hjG3zb1qpzyMh0L2xZKOHf274W51GzJNy6xKKwKQ
   hgkiLvHOYqFCJq7ziROdT1WaZadreFGdxGRPYOXgsOZc8baTn7sQd1Dqp
   E2/Pcu4Wpk9c2AU1yXio0vGyFevmnCsPgI80g8L3Vl9Cgyq5zwiN7dyDm
   4=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.06,179,1705359600"; 
   d="scan'208";a="153280618"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Feb 2024 15:27:45 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 72661E0CD6; Thu, 22 Feb 2024 15:27:45 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 4607FE00B7
	for <cocci@sympa.inria.fr>; Thu, 22 Feb 2024 15:27:40 +0100 (CET)
IronPort-SDR: 65d759db_rp0bncqNc/Fl94376lCj+fWNKPi6cOQFnBMKGp3agFhly6z
 nnquZOQq+Lf5SEn2n4Y5NOZ6aKF/7yIiXtP9R8g==
X-IPAS-Result: =?us-ascii?q?A0FrCgDGWNdlhwsR49RaHQEBAQEJARIBBQUBQIFPAoI3f?=
 =?us-ascii?q?1MyBAtIhFOPRIF1MIQ7hzeHTohwgxY+DwEDAQ1BAQIEAQEDBIR/AodsAh4HA?=
 =?us-ascii?q?QQ1BQ0BAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECEAEBASMTBAcOB?=
 =?us-ascii?q?QsnhWwNglwBEIEOgSYBAQEBAQEBAQEBAQEBAQEBAQEXAkdBAQICASMdAQERJ?=
 =?us-ascii?q?wQLCxoCJgICVgYBFAEBgnyCKwEDDiMHsESBMoEBggoBAQavXB8sIlaBYQmBG?=
 =?us-ascii?q?i4BiCUBhW+EPCcPgVVEgTyDAz6EQ4NbgmiOT5FMVH8cA4EFBFoNGxAeNxEQE?=
 =?us-ascii?q?w0DCG4dAjE6AwUDBDIKEgwLHwVUA0AGSQsDAhoFAwMEgTAFDRoCEBoGDCYDA?=
 =?us-ascii?q?xJJAhAUAzgDAwYDCjEwVUEMUANnHzIJPA8MGgIbGw0kIwIsQAMJChACFgMdF?=
 =?us-ascii?q?gQwEQkLJgMqBjYCEgwGBgZdIwcPCQQlAwgEAyspAyF0EQMECgMTBwsHeIIJg?=
 =?us-ascii?q?T0EE0QDEIE0iiYMghwDGSsdQAIBC209NQkLGwYiAR0ComiCLMYlNAeCNIFgg?=
 =?us-ascii?q?WEMnzgGEy+XMQ4GkmCYWSCoWIF8IoFcMxokgzZPAxkPjiAZhBSPR0I1OwIHA?=
 =?us-ascii?q?QoBAQMJhUYBAYNagUYBAQ?=
IronPort-PHdr: A9a23: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
 8SJi6/5bjtPoYq8FS40GMXebs6KYiJJDA==
IronPort-Data: A9a23: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
 IT1qa15rJmHdHPM
IronPort-HdrOrdr: A9a23:TDVYn6896aQCUny0Mtxuk+AxI+orL9Y04lQ7vn2ZKSY/TiX+rb
 HVoB17726StN5yMEtMpTnuAsW9qB/nm6KdgrNhWYtKPjOW21dARbsKheHfKlvbehEWndQ86U
 4PScdD4aXLfD1HZL3BkWuFOudl+8Of+KSkwc/V0ndqSmhRGsddxjY8MRyDGkl6ADFbCYY0UL
 qQj/A33waISDAtdN2yAnRAZeTZuNHR/aiWGCIuNloc8QGLgHeS5KTnFgXw5GZkbw9y
X-Talos-CUID: 9a23:mnKxzm1NJ8gxabHu+SWsPLxfKPEPYFfM8W7selKCB08wQZOKbFKP0fYx
X-Talos-MUID: 9a23:Awu+9Ag4O0hjL4Hdj4CGlsMpPcAy2KuMVX4xkowYvsCbCmtuaxi/tWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.06,179,1705359600"; 
   d="scan'208";a="80354772"
X-MGA-submission: =?us-ascii?q?MDHEIsiwibkMteEeKRfUyReoWy5AKzb/efjDrB?=
 =?us-ascii?q?8L45MuoMKWb45u3W/fO82/qg1Qp6FJTrFP+vF38cUankm1/6moCTHnIS?=
 =?us-ascii?q?NspFxGcbVV0ZKXRVw0Gg0WClDFRcYCc+Of4DMTNKJPcpKpE/be0T90uh?=
 =?us-ascii?q?LwrGR8y/yQcfiR6FBmVulsmQ=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 15:27:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1708612059; x=1709216859; i=markus.elfring@web.de;
	bh=FWJsG2djkdi4Md/UBn2ybwjbfNYrn4ZeIeNxrYQclto=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=iuPqdwrrTAkOZbaB8g3j/i8iljl0rzVldQzgoIWud3j0uVXoS1tQRttrqY3ib3Zc
	 +T8dVCSBGLsnhnT5BpAN117y7ik0UosLZttpDBDNRRTstUxLox11NV61UHVOf8saj
	 gbx1o3iixxSfhI7CvmA6s1ygUv2lvFUXz7AZuLUifUeGj7XT4ZHDE3l6mXbyB4npD
	 C668qU+FI58qpn8+abaBCyiDcvG92xe/I6HjwjA2cvcp479Gym7n79c3rrMQJtKZ9
	 13faC+C0m5hd8uiPeaHQFaz6Ighmt27y1n6MT42u+aJiPC/9r8IzB3cInO12of5UP
	 RlS4OjeC4bRD5fdn8Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mfc8o-1r1sHa3h04-00g9SM; Thu, 22
 Feb 2024 15:27:38 +0100
Message-ID: <ff7a8f13-c5ae-44c9-8e66-9ebcc7f8ba7a@web.de>
Date: Thu, 22 Feb 2024 15:27:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <814fc9f8-9ef1-42fc-ae9f-ef8d4a82979a@web.de>
 <8548519-fb2f-5860-bd86-3a4d20669c5c@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <8548519-fb2f-5860-bd86-3a4d20669c5c@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:S850pA0GCTc/TjoCSEDuTNq3ekDI/PQG5QMbY1pMh5m0d0X9nyp
 BlTYYSQJkmLYnh86pboiORuj9rnf7yqVVqWMLDEWjSJMMp724Pc0wEuTkkggqE7ySdvS+bF
 3NX0TDFqQkwLXByVPrvDVSCkcQJuInhbAExhrfwKVf12fVijB1vpRj/dI8qt3/GpTMp/RXr
 nBYLFKbYqj/+iK5gdVKbA==
UI-OutboundReport: notjunk:1;M01:P0:XgjKQMU+MJo=;NP7f1C+KVU2++0xGK6a3dhhbRqH
 Y5u4Ni1F4lhD8/93y8mskuqduwvblg7OHnSZ5qnJBHUoIKbz6js+uy30GZvZXghRkwVmihUcN
 wbOts0eJDIWjGS9RQBa6SDMdUP65/vaaIREo0ZTEuh/+0lPNRWlMYqmNJqzlG/tp/ckWIgUsN
 ePvTsiIS7RmC/n5Y685ElEBDYKvfNrzkRaAEbC++E3qT0luLGrnphX6xGO95ufm17pRVRz0sS
 oDfyvyv20cpPLJ8gCLDZGI4ggeSRAboHHFo4ElqkJT31cNkHMO4O295+n35RXl7zUl0kcsyTz
 21yhU/Zty9NstxUK7StYhX+QxNvvBrn6QcxCK/Ebk0k++c++tHUr+egmlrPSUDdGqL26RyAX2
 MWt+5wi9albhCMp/lVDUiUtiH/n78A884N4vVzIrA/OJt42uQsi3Fn9fPeplzaNN/HZaGAeHC
 VWMmFGdcLIIvhfntRSJyBOdgqrVQXWQDJ8aAIh1cVItmZIpL22dWSVUzELvPSwVJwd0R5FSrr
 aahzo7/3CQhGqSh1XfAPONv05UHK3jKGlj7Y6KWIq35qzW3uCNIb/HVPZS0LkzWZoKACjgkgs
 fRyq6fVH4pJ3mpJEjZQnsdB0fBn/1TtMhDl9THJ7tPrY3uzHNcyttuF0WF8QCKFIaGfhABhPF
 KoB8NBK9yCdMiO/FgACATZ817uhDleKsuInBSdf0ZbBt70DVWwENX6VvxAmjivhUAPZTSQKga
 uPuKL8d7kbmMIaYRcLT92EQ3VT8YyPEQag5/ofkEgMlLzG+357Z0kCf9vskr9Lis9d3VH6NGF
 OYePw+zJZGP5o2+NJCgw4YT43NWvBNISow3Q7vx0ryMuE=
Subject: Re: [cocci] Detecting misused expressions with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1595
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/ff7a8f13-c5ae-44c9-8e66-9ebcc7f8ba7a%40web.de>

> What do you expect the ... with the * in front of it to match?

I hope that the application of a SmPL asterisk can point a bit of source c=
ode out
for further development considerations also at this place.


> I think it will match a single expression.

It is expected that a questionable passed parameter to a call of
the function =E2=80=9CPTR_ERR=E2=80=9D should be presented.
But I do not want to exclude the possibility that more source code
would be similarly affected as mentioned in the published patch.

Unfortunately, it seems that the shown SmPL code exclusion needs to be enc=
losed by
curly brackets so far.
I am unsure how a single statement like =E2=80=9Creturn dev_err_probe(=E2=
=80=A6);=E2=80=9D
could be matched then (without repeating it explicitly).


> The fact that no * is detected does seem like a problem.

I would appreciate adjustments accordingly.

Regards,
Markus
