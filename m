Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE623C6FD18
	for <cocci@archiver.kernel.org>; Wed, 19 Apr 2023 07:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=x61/hqi5siQwZQsL/Fl+nfxphtZDih2eWXNncH6QJKM=;
  b=On9ZeM/whcO9/EczvhIw6ecvA5RWM/NzHWvjtmPCqIzQHv4P4jyXZWI0
   ZeaPeumlhQNl6OeI+nWd41opDpmgMVCCRl5Nq3d5zVO8YMccRiri7hRJp
   d0jFDxmDhZfOBUjFkReUqSf7xfARB/sfP7tVy+X8noHXFXegXyTtwetHV
   U=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="5.99,208,1677538800"; 
   d="scan'208";a="103737695"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Apr 2023 09:49:59 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7E611E013D; Wed, 19 Apr 2023 09:49:59 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id D3579E004E
	for <cocci@sympa.inria.fr>; Wed, 19 Apr 2023 09:49:56 +0200 (CEST)
IronPort-SDR: 643f9d24_V2p5ch5nX8JzMT2k443x7KXJnwVQEh1R1hw8hxJfXALhyrl
 7ycU3JxtAGp+v6DfX68F1uu1PQhGCUSzqaoE1/A==
X-IPAS-Result: =?us-ascii?q?A0FAAABunD9khwMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TwGAQELAYItdVYvBAtGAwUihCmRNoQwjmyEZ4QDgVaBQD4PAQMBDTsGAQIEA?=
 =?us-ascii?q?QEDAQOBSYJwRgJrhFECHQcBBDEIDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBA?=
 =?us-ascii?q?gEBAgQFAQIQAQEBGgkXBw4QBSKFaA2CNykBEVYOgQYCAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQESAg06PgECAgEjHQEBESYBBAsLGgIfBwICVwYBDAgBAYJ6A?=
 =?us-ascii?q?YInAQMOIwcMBqsmgTKBAYIIAQEGnAsfLCJUgV4DBoEULQGMUT+DNnonD4FVR?=
 =?us-ascii?q?IEVJwyCRzE+gmIBA4Feg1uCZ48GiyNFgTR2gSAOgTyBBAIJAhFrgRAIajmBQ?=
 =?us-ascii?q?EACDWQLDnGBSWNMgXsEAhQ2Dg4YBhclBA4DGSsdQAIBCzs6PTUGAwsfBlZrA?=
 =?us-ascii?q?gkjERMFAwsVKkcECDgGGzQRAggPEg8GJkQMQjczEwYFVwEpCw4RA06BIh8GB?=
 =?us-ascii?q?CQLXHwKBgEmJJxSgXNzgTmVGbBvNAeCK4FWgVkMig2VAAYTL4N9jGaGJg4Gk?=
 =?us-ascii?q?iUuhzKQFyCNM5pMgWUCNoFcMxokgzZPAxkPjiAZHoM7M48JAT4/NAIBBTUCB?=
 =?us-ascii?q?wsBAQMJhUYBAYV9AQE?=
IronPort-PHdr: A9a23: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
 Aufh31cdWJKW/d4+ppX
IronPort-Data: A9a23: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
 bkjx5E7AvR9LlyFiwreCjxXTNqLHs/n+08=
IronPort-HdrOrdr: A9a23:Vy/OuqDsFcVEDw7lHely55DYdb4zR+YMi2TDGXoBMyC9Ffbo6f
 xG/c5rqiMc7Qx7ZJhOo6HnBEDtewK6yXcx2/h0AV7AZniFhILLFvAa0WKK+VSJcUHDH6xmpM
 JdmsNFeaXN5DZB/L3HCcqDferIAuPpzEllv4fjJ9oHd2xXgyYK1XYENu5OeXcGOTWuzKBZZf
 mh2vY=
X-Talos-CUID: 9a23:i+a0MGxNU2zI92Cv5o+4BgU1O+smQG/3yUvIAGSDBkEqQqSuDkOfrfY=
X-Talos-MUID: =?us-ascii?q?9a23=3AiY4nrQ5dT32D7BRQvMVhp/GvxoxU+aCcUxwGla8?=
 =?us-ascii?q?J5cyYJDVPHhif0RSoF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,208,1677538800"; 
   d="scan'208";a="103737689"
X-MGA-submission: =?us-ascii?q?MDH+ao0N32S6X40Dr1nSmnFz4TdhHdmBIyvUeg?=
 =?us-ascii?q?1Eu5Pw28Jw7alQ9MtHS27/H44byqHrEtA6WXwgpwSi2fmur/m1E/oq6z?=
 =?us-ascii?q?xQLaRTZxN5g7P2ohDmooF9Irw3EIjeiqSUrRtPQGbM/i34ph0B0cXtj9?=
 =?us-ascii?q?Hawgd7x/5pIs/ORBNMiqbnXg=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 09:49:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681890579; i=markus.elfring@web.de;
	bh=x61/hqi5siQwZQsL/Fl+nfxphtZDih2eWXNncH6QJKM=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=LpJhpkF/e8iHZXvJNh7loGHayrMHhsleBiwLkNC5GpcKOIqMhUoc4rfEgIRfh/75j
	 l8EWSV2GIQSYV/zLDjbRo6UKh1jZYjV9UjCLldMPeFnuwatn83hSE69+0V7vPCxG/2
	 AGS5R0o/IvC7LC/P1l+YDZTGOlt+PhtszBam1ncSOXsx89Rg0xl7gEAQV7goSCsHzf
	 BkC36K6O2NlyPqZVJliXLjp4LEnuqGR7BMytRWQCLTQ8gPSD3xfVN8ecesSgNrwKuS
	 19dGPfx4zUuT2coFfQMuxBrmMLFKNqQJMJW88zwMg4wCW3et6q8D1EVHMBf58b/OJn
	 LFokeQm7C/zRQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MHEbk-1pbrIB1htw-00DemS; Wed, 19
 Apr 2023 09:49:39 +0200
Message-ID: <a858402e-c733-bf31-4955-82cbb2417ab1@web.de>
Date: Wed, 19 Apr 2023 09:49:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-GB
To: Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy@kernel.org>,
 kernel-janitors@vger.kernel.org, linux-media@vger.kernel.org,
 linux-staging@lists.linux.dev,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hans Verkuil <hverkuil-cisco@xs4all.nl>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Xiaomeng Tong <xiam0nd.tong@gmail.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <d8ed4e5d-49d4-ca7e-1283-1ec166bf643d@web.de>
 <ZDmJsemYldOsMMrH@smile.fi.intel.com>
 <9b243f3e-92ad-197f-f0a6-b22eaf71238a@redhat.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <9b243f3e-92ad-197f-f0a6-b22eaf71238a@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TV8gDFo1TnZt3B98WD6A6w6dKaFDyinWNbl/mR8s9XB5zgwMT9I
 4qmzOJCnx8/wMb9gtny28ULPbXeHlh4KOwDup+IQolbc67yiKmkWwBDiDASlXiUMBhZ+x1T
 OtWg3ZXCEkhC+8Y5w8B1cAnX7TThBzDeRQG0AouM7VCThmTjDVeoe7kUlKRO2VGAKO0xJUn
 2/NVHn5wzv7GhAj8TyM/A==
UI-OutboundReport: notjunk:1;M01:P0:EJW0Jc56o2o=;4o0Y7odLzLJd7t+EIXXb4PORwCF
 ySceqoteVgGfHSYnlEdnpV31W2ADWWOvwUpQdOD0xf4P7RKAFr8o+XxcmMzvdHY8ukDYBdlnE
 DKHl4M8t07Rsh2Uo4w1az5xLzKFrUR4xOmcBD46JaG5UJqeFExD2ATSTJD8K0z73VFr14e/Ez
 oOEOllm8ptElGM3oletrSRJqHQSHNPqyBXstqurBUJ3I9+2GDz1YrzOBDC3CBHkCOnz7yXF3p
 ksIft/hxLFhdMHFRyFcK22hXRuIEQuYHrRMfQLhdbZ8tA81CVNSw/TXHbMX0+u+UyPCHfDwbS
 uy4i/IRuIj9Y9VEAMmDBJq2poTDvTgD2eVrEWscQ9RmOPOS4YtqShIm9arkkEW8EUapDSKyMc
 QJ6O2N+VOx2t2pyUUsydTU8gRBxcIVj/FYOzijYrN+ydshK4q9W8PN+ks5XCZ49u3OBBTbOdu
 8s//eTM9HE8XX70+tdhpbX7PaGLXr0IsaGhI44TmY3Jsg4UXKNSFT6Tlmx+N2cNojMBYNiSQ9
 +Cd/76puAGjNJSVKKdgilKP4bQyv1D9z39ZUmRP9APLpO9ukoyJ/JpLoZ5dcKgU2N6mcJpwm4
 zw1wmhhUMZBdkWm98+IDIXawfc0hSukoZNAWsdhb3/qbhZmzk4UJaK4tROubuHB+JB8OB8fu2
 VEaSP2Zbd6zUmV7Truj/oWunuoEX1Lda3mJ/6KRd6ionF0mFk2y8/ijkrKnrlxvGUoJ6KU0y5
 HkZj/f5wxdoaIkZKjGDZ9WoktjY+csY3HIMjOqQ2nmMc6/0Lwn0MlugRzvgczz6SJoY6wCN2a
 lGsWsvwfbUjh7yXmhHW9WGwD7mEyY/uJ0HxKWXbw5zJ7lZjoz5GhSe/xLIAK/41eVUBsKWt0q
 vpW88hftH4Ts5kZnATHZSZCI+A30U+5L8fjtls+o0IsLft8pGq/mREwCb
Subject: Re: [cocci] media: atomisp: Move a variable assignment behind a
 null pointer check in atomisp_cp_general_isp_parameters()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1093
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/a858402e-c733-bf31-4955-82cbb2417ab1%40web.de>

> Instead of this patch, can you please audit the callers of this function=
?

How will the determination evolve further if null pointer checks would be =
still
relevant for three input parameters according to this function implementat=
ion
at the moment?
https://elixir.bootlin.com/linux/v6.3-rc7/source/drivers/staging/media/ato=
misp/pci/atomisp_cmd.c#L2721


> I expect that you will likely find that the callers
> already unconditionally deref css_param themselves,
> or they guarantee a non NULL value in other ways
> (e.g. address of local variable).
>
> So I expect that the check can simply be dropped completely,
> which would be a much better fix.

Will affected implementation details be reconsidered any more?

Regards,
Markus
