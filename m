Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 124A7C25B7A
	for <cocci@archiver.kernel.org>; Wed, 22 May 2024 13:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ff2i24pirRh8vNpCKE6976pRTKIUsAKeeNiKCgRkvXk=;
  b=WI7Sm50PFvhbIC9OST+30BYkzbjSpPdL+BJusdLbpM4Phv4PJ2m2szfh
   2eIbdZBefOGYuUZwKvXiwUV9Q0KsUS6W2MgZjyPBcOpAprvIKO2Bhvz5t
   N3S+rCYrr99gEt8db9GR6j6gf4YhZsJxfOE+moCOf01fF4BtIuwDEdKqi
   M=;
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
X-IronPort-AV: E=Sophos;i="6.08,179,1712613600"; 
   d="scan'208";a="166896506"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 May 2024 15:12:43 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D09CFE0CCE; Wed, 22 May 2024 15:12:43 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 780C7E00B6
	for <cocci@sympa.inria.fr>; Wed, 22 May 2024 15:12:38 +0200 (CEST)
IronPort-SDR: 664def45_eqXSYb+1nStdSJ+wX+9E2sfpQ+vJL2k6ItY/3dPs9VLVURB
 oSmSoIgUlU8eRpSjo6oC7e/2smStFFcylB0Klnw==
X-IPAS-Result: =?us-ascii?q?A0HUBQBz7k1mhwQP49RaHgEBCxIMQIQTgQJUMwQLSIRWj?=
 =?us-ascii?q?0iBdYRrhzmHT4hxgxY+DwEDAQ1BAQIEAQEDBIR1AQkCiEQCHgcBBDQTAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBAhABAQEjFwcOECeFdA2CZwEQg?=
 =?us-ascii?q?Q6BJgEBAQEBAQEBAQEBAQEBAQEBARcCR0ICAQMjHQEBEScPCxoCJgICVgYBF?=
 =?us-ascii?q?AEBgnyCMAEDMQevfIEygQGCDAEBBtpZHywiV4FjCYEaLoguAYV8hEAnD4FVR?=
 =?us-ascii?q?IE8glIxPoRDg1uCaZl6kjZUfRwDWSETAVUTFws+CRYCFgMbFAQwDwkLJioGO?=
 =?us-ascii?q?QISDAYGBlk0CQQjAwgEAxAyAyBxEQMEGgQLB3WBcYE0BBNEA4E3iXAMgy+Bd?=
 =?us-ascii?q?SmEHghDbBWDcoF2DmGDUIRLY4EQgUeBFh1AAgELbT01CQsbBiIBHaszxiw0B?=
 =?us-ascii?q?4I2gWCBYQyfRAYTL4NyAZNGDgaSaJhjIKhqgXwjgVwzGiSDNk8DGQ+OIRmEF?=
 =?us-ascii?q?MtJQTU7AgcBCgEBAwmFRgEBg1qBSAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 A==
IronPort-HdrOrdr: A9a23:L+i416NWKzTofsBcTh+jsMiBIKoaSvp037BZ7TEVdfUzSL3gqy
 nOpoV86faQsl0ssR4b9uxoVJPwJU80sKQFhrX5Xo3NYOCFggeVxehZhOOO/9SjIVydygc378
 ddmsZFeb7NJGRbyeDn/QK/D9Es+9Wf9ru07N2utUuFATsKV0l6hT0Jcjpz/3cGPzWvjvcCfq
 ah2g==
X-Talos-CUID: 9a23:HuelcWxNZbqgJw3Vvu0OBgVFS+cZXX76nE7rIl3pBkMqRZSXY1GfrfY=
X-Talos-MUID: 9a23:oj/1kQumcU0XjbKRSs2n2h1sMspDpJaUD2dT1s8Ho9C5OQBeJGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.08,179,1712613600"; 
   d="scan'208";a="87682676"
X-MGA-submission: =?us-ascii?q?MDFHB7JtJ2wo+WkWiBI3WxdVujA3Ce0XlKYnrq?=
 =?us-ascii?q?1/+LXtulOf/OMWjLeQdmDHhGdXxSCnZt/XBwmXAxOQ2ivLfrhS8CEDas?=
 =?us-ascii?q?k+Kez24NkCpl0reQWCQVUxIyXv2mHPZOz2U0uln4GcK4so99h1q+RxVg?=
 =?us-ascii?q?JaCxJUfMJjhCi2oqxy675aOA=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 15:12:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716383556; x=1716988356; i=markus.elfring@web.de;
	bh=ff2i24pirRh8vNpCKE6976pRTKIUsAKeeNiKCgRkvXk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=wEG9rdv3g5OGMJNeqCoNXQc6Irod5Y29MXRmlgiZsD2RF8mhPUWa+GGpTIQ1lAiw
	 Zzm64QXt88mi7hIWrfvhj5pOonS+0eAqDMQyO8Jxi0hLmxS9asD9uXy5/YHQK9Haq
	 eHNQCtlmGWUruewRGWkAXyiOzXTFLcL47M5tJR+Y+MbktNvi/szXSMkrQGA5L2mwG
	 AxQ4RUNYWTEkdr+7H/BEYKR8tWnblFQHl92tchLIKXq0Irsd7Xz6qM8m+OL3TJwzJ
	 R8BvrcapQ+7dNTHyQMnhcLUsFTlnTeqfEQj0nzYq/7E0dxRZn4DjpzGokWn5xSUDI
	 7bvweedscCNRX10iiQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MEUWM-1sLI6g1W7G-00G8Ha; Wed, 22
 May 2024 15:12:36 +0200
Message-ID: <0bc588b1-afc9-453d-b79c-151963e88092@web.de>
Date: Wed, 22 May 2024 15:12:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <bf850b64-b4bc-4738-9086-43018b8fbe93@web.de>
 <594a83eb-b693-4f5b-b330-c0c4cb655661@web.de>
 <9b4af55-40c-3082-52f3-12b4b535376f@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <9b4af55-40c-3082-52f3-12b4b535376f@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qrIUG0upnWjy1Y8mKcFkXN6iCCxdiyTDzXb7GYChEI1XSVx5wYl
 0z90PacZTPpvXWxWfQtbm0YL5OSZL3oPlfZFr4A7RaMSL33aMR6hc+IxbrHIgJzJm+BSs3R
 5qJsAx9JLBAV2dyO3cPgIMCA/+z35xkRNi+SH0v4Z84pUjrja+l/kqARqAhLRHjo6Ux3X1L
 yP8dAMwsLGLp/gbykDzWw==
UI-OutboundReport: notjunk:1;M01:P0:BHebL2yQLZA=;omAb9MZnTxO4F7pmdAbDyVPy/20
 fiIdlDtd7HDXIcC7torPIOwO0xwoBJDx5Tuy41Rb2OZWDAfgwqgVOc8/2HMXvC5SEf84R9pTD
 T9aTmcESy7th94FiVQGvxOvq03He3pdwmbUq1PYOTNwKjZfdoPrzdD0ucsRbm/uV+fY7iJfBY
 +CrsnZFLCEM5Ealz3NqoDfghq5sVTKkzYSwdMcV3f7ck10s6cqtlfLKLq8jfHCPFkDZFhXlOs
 hhIFGGQgm55IG90CWC7tVkXeyEIdIDGeKGLFT80KXGoN/M8ok3xXlpDnBktKVd4JSiGRhmVlJ
 V0eXE+Cz0WsyxVpGN3eMVKad6HPuo1hDztKmPOepqSHPngdHBIZXMecZ8TNC6xzNFYO0vEZbd
 jW+H3lmvqeYIYN9B+UieQMRwoMxb2KI6oK0buO8Nk+hv35NmLz0XLZJAbKjS6Yrd51ur26i/B
 v/iLlHlspa7SYLkoGyL5nwaW9ubjOq5pCnQk/EVp/PrM/7l5itfdsJriGzz3lybMSedYDIYpe
 SREfbfMArvQSVeC1LfPiXtA6RjjnXzO2YBcWBDGZ7RSP4z8p+fImSpH6AQ46LQFZyDtzHk+8h
 vSr0xNcqNovZkSG7KMitcOCFZXiOzTu9puChHYihZiUFP0XGxWIRz1ahp0zFrfSzs+oFwr7iS
 vQ/4aVECJmhvGIQcX3D7fBkObUrpiLLwlV37NZNFZerw/qGPrlQ5JTOHXFDflCPNtoJYfLXtO
 EQmxXXDI97GbrAXpQ1nITZ4CD2FGAtAqJYcHQwHLtcqriPDPU98lbI0t9kckODohY28FYDNcl
 v5T+fJBg8q0EJevnyV3A2lSbRPJC3hMkWvDPN+6La3q8Y=
Subject: Re: [cocci] Searching for repeated source code with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1751
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/0bc588b1-afc9-453d-b79c-151963e88092%40web.de>

> --noloops mean that the back edge of a loop is ignored.

Should the program parameter =E2=80=9C--no-loops=E2=80=9D influence also t=
he handling
of Linux =E2=80=9Citerators=E2=80=9D (like =E2=80=9Clist_for_each_entry_sa=
fe=E2=80=9D) anyhow?

Regards,
Markus
