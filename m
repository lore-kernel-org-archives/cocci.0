Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 656D0C7EE30
	for <cocci@archiver.kernel.org>; Tue,  1 Jul 2025 12:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=jT2LUfBAPo9/KPbBIMRaA1XZHPTLhqSfYWhOYArZtZ8=;
  b=C9tggzbqBqopJH9xSh7zQev5+76+AusRhuxKJGfZLVmZRM0a9LYUdP+S
   AqMm08zRIM9gQ8jJIaVGW4sj8+KSprr9NXHgZfIWIn0GW0+SE0QLrBS8A
   hr7BHuRSGNfvOvm71dKDF9z7/18YeKy2CuA6RT7uJOdka54PYjFXBwA9u
   w=;
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
X-IronPort-AV: E=Sophos;i="6.16,279,1744063200"; 
   d="scan'208";a="229799472"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 01 Jul 2025 14:27:01 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id F1CB9E0AF6; Tue,  1 Jul 2025 14:27:00 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id DADF0E0131
	for <cocci@sympa.inria.fr>; Tue,  1 Jul 2025 14:26:58 +0200 (CEST)
IronPort-SDR: 6863d412_DbUHdquahMeH4Pj8Ob/oc+OjX5825V888Ax9ZV9FHMHfYnI
 5Ve65PYzdvfw7GoFa9ez7hhHxrTqsFy9u0pyR3w==
X-IPAS-Result: =?us-ascii?q?A0HuBwAK02NogAMP49RaHgEBCxIMQIFIC4JEgQZUMwQLS?=
 =?us-ascii?q?YRVj1CBdDCEO4c8h1OId4FVgX0CDwEDAQ1OAQIEAQEDBIUAAot0Ah4HAQQwC?=
 =?us-ascii?q?Q4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBOwcOCjGFew2CY?=
 =?us-ascii?q?gGBJIEmAQEBAQEBAQEBAQEBHQJHRAEBAQIBIx0BAREnDwsaAiYCAlYGARQBA?=
 =?us-ascii?q?YJ+giIBBhABAw4kB7AXgTKBAYIMAQEG2l4fLCJYgWUJgRsuhW2CZAGGJ4Q8J?=
 =?us-ascii?q?w+BVUSBPAuCeD6EQ4NbgmmCJoEWhHqTM1J4HANZLAFVExcLBwWBIEMDKjQxI?=
 =?us-ascii?q?w88BS0dgSd/gU0cgwmBDoQsK0+CJHWBeUEZP4NUHgZtDwaBHxtBQAIBC209N?=
 =?us-ascii?q?wkLGwY9kluHLcYnNAeCOIFmgWQMn2kGEy+XTA4GkwKZBSKpGoFoOoFcMxokT?=
 =?us-ascii?q?4JnTwMZD44hPoN1u09BNTwCBwEKAQEDCYVGAQGIDIFLAQE?=
IronPort-PHdr: A9a23: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
 sfCnuT/JWUbmzo11c4bGtSSN8+NdnYsY0KBJQ==
IronPort-Data: A9a23:Z445HKPZln3bww3vrR1jk8FynXyQoLVcMsEvi/4bfWQNrUoq1jwFn
 WYZUTzSOfrZazD2edxyOd+x9xwEvZ7Wm9MwTXM5pCpnJ55ogZqcVI7Bdi8cHAvLc5adFBo/h
 yk6QoOdRCzhZiaE/n9BCpC48T8mk/vgqoPUUIbsIjp2SRJvVBAvgBdin/9RqoNziLBVOSvU0
 T/Ji5OZYQHNNwJcaDpOtvrc8Eo35ZwehRtB1rAATaAT1LPhvyJNZH4vDfnZB2f1RIBSAtm7S
 47rpF1u1j6xE78FU7tJo56jGqE4aua60Tum1hK6b5Ofbi1q/UTe5EqU2M00Mi+7gx3R9zx4J
 U4kWZaYEW/FNYWU8AgRvoUx/4iT8sSq9ZeeSUVTv/B/wGXvQ2vNzPA/DXs/BtVb8cU0D2J++
 u0xfWVlghCr34pawZq+TfRwwNsuJo/nMevzuFk6lGufV6x5B8meBf6iCdxwhF/cguhrFOzde
 tFfRD5hdhXGbDVQN11RBJ9WcOKA3yOnKGwI9Q/OzUYxyzTD4FQu4uWxC5nEf9OmbuBl3VfCg
 W2TqgwVBTlBaIzHkmramp62vcfLlDzyXIY6Bry9/ORjxlyV3G0aThMMPXOwpvKyi2alStdHI
 goV/DAvpO487iSWosLVWhqlvDibsxRaV9c4//AGBB+l45rEwgmcV2k+RwUZK9cF98E1dTM7/
 wrc9z/2PgBHvLqQQHOb076bqzKuJCQYRVPugwdbF2PpBPG8+ukOYgLzczp1LEKipvHYcQwcL
 hiPqzUiwaoeh4gH2s1XHGwrYRr9/PAlrSZsuG07u15JCCsnP+ZJgKT2szDmAQ5odtrxc7V4l
 CFsdzKixO4PF4qRsyeGXf8AGrqkj97cb2CF2gY/RMF8r2z2k5JGQWy2yG4uTKuOGplUEQIFn
 GeO4VsAjHOuFCD7NP4sPepd9exwkfK6TrwJqcw4nvIVPsgpL1/YlM2fTU+X2Wf22FMh+ZzTy
 r/LGftA+U0yUPw9pBLvH7l1+eZymkgWmzmPLbillUrP+eTFPha9F+xaWGZim8hjvMtoVi2Po
 44Hb6NnCnx3DIXDX8Ug2dRPcwhXdSBmWMyeRg4+XrfrHzeK0VoJU5f5qY7NsaQ890iMvraWo
 COOSQVDxUDhhHbKDwyPZzoxIPnsRJtz5zZzdyAlIV/iiTBpbJeN/ZUvUcI9XYAm0+h/kt9yb
 f0OIPubDtp1Fz/oxjU6bLvGlrJESiiFvwy1EhSAXCkeZL9lHgzAxc/ldFDg9Q4IFSuGivE9q
 LyBiCLeGIQPdz1/AJzoadaq9VeQvGccqs12TUDnMtleQ2Sy0YlIegjarO47HNEIEjrHngCl7
 gexBQwKgMX8uKon2YDtqYHdiKnxCMp4PE5RP1eD3IaMLSOAo1aSm95RYtiHbRX2dT3S+pz7Q
 c530vulEvkMvGgSgrpGC7wxkJ4PvYr+lYR7kDZhMm7ANWmwK7VaJXKD48lDm4tNypJduiq0Q
 ki/wcZbC5rYJPLaFEMtGyR9YtShzf00nhzg3cYxKmj+5w51++OjemdWNB+ulidcDeVUNKUI/
 OQfg/MVujeP0kcSDtW7jy5v5zutKF4EWP4ZrZ00OtLgpTcq7VBgWqbiLBHKzquBUegRDXlyE
 ASo3PLDo59+2nv9d2ECECmR/OhF2rULlhN47H4DAFWrwej6p+IF8yBQ1R8VTQ1l6ApN/MwuG
 2psNmxzfb6v+RUxjud9fmmcISNzLzzHxV7U1H0yi3z/c0mkckfvPV8NE7+B025B+l0NYwUB2
 q+TzVjUdArDfebz73MUYlFkofmydu5B3FTOt+7/FvvUAqRgRyTuh5KvQm86qxHHJ8cVr2+fr
 MlI+NdAU4HKBRQykYYaVbbDja8xTSqaLlNsWftipaMFPV/NcQGIhAShFRqDRdNvFdfrr2mDF
 M1cFuBeXU+f1QGPjAwhK4wiHrtWpMMttf0+Iu7FBGheqLaOjCtbgLSJ/AjEuWIbadFPk8E8F
 4DvSwy/AlGg3Xt5pmucg/RHa0yZYMYFbjLSxOqa0vsEPLNdvfBOcXMd6KqVvXKUPFFZ/jaRh
 gfiZrDX/cNm249Dj4vhKYQdJgSWePfYdvWEzxC3iPtKNejwCMbpsxgHj3XaJCFUAOchYMt2n
 rGzr9LH5kPJk7IoWWT/mZPaNa12yeitfehQaOTbEWJ7mHacZcrS/BczwWC0BphXmtd75MP8Z
 Q+ZatO1ROEFSeVm23xZRChPISkzU52tQP/bmhq8iPCQBjw28w/Ndoqn/EC0S1BrTHYDPpmmB
 zLkv/qr2Mtjk71NIx05HNBjPY5zJQ7yeKkhduCpjwKiMEuTvgqgtIfhxD0a0hOaOkncRYy+q
 djASwPlfRu/hLDQwZsL+8ZutxkQFzBmjfN2YksZ/MVshiunCHIda94QKogCFooehxmaOEsUv
 90RRDBK5eTBsTV4ndHU5dP+QkGAC+ZINtqRyvnFOa+LQ3/eOW9CKOIJGuRcD7NeZTbpiu2qQ
 T3b0mOlJQC/m/mFWs5KjsFWQo5bKjfy2X8Cv0zw+yA379DyHp1SvEFc8MFxueAr3i0DeIgn5
 YT4eIycfHyGdA==
IronPort-HdrOrdr: A9a23:mGlutanrpjFUfE9gXD3/zdh/5gfpDfLy3DAbv31ZSRFFG/Fw5P
 re+cjzsiWE8Qr5OUtQ/+xoXZPqfZqyz/FICOUqTNOftUzdyQyVxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIOauEYZmIbsS+V2njaL/8d4J2g7L2ig/vYwkxgVAdwdshbnn1E40qgc3GfX2N9dOIE/X
 enl7F6T7HMQx4qUvg=
X-Talos-CUID: =?us-ascii?q?9a23=3A0v8eLWnywOMm+28P92RuxYAYwsbXOVTt3FbfJh6?=
 =?us-ascii?q?5M29SEP6eahye+5NrguM7zg=3D=3D?=
X-Talos-MUID: 9a23:dEG0LgT0F7mKLK5vRXSwlB06a/U1v5/tGUUCvb4ji4qVbwt/bmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,279,1744063200"; 
   d="scan'208";a="120398553"
X-MGA-submission: =?us-ascii?q?MDEFfrj8tkjTmyx6Ue7a0dCPFrYsoe6k3o4LYZ?=
 =?us-ascii?q?6r6kgSOLKy7oW+0WGMAovmy3U6Thxu8NXJldrWymU/v4rI5iE+unO2Mm?=
 =?us-ascii?q?utCaRp8WgztlkXbNKWdeRykTsA9RALSNGmN5rjBlwURTna7waopAfLIl?=
 =?us-ascii?q?7YYzctUkPdeSJ8BeIeIUyf4w=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 14:26:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1751372817; x=1751977617; i=markus.elfring@web.de;
	bh=jT2LUfBAPo9/KPbBIMRaA1XZHPTLhqSfYWhOYArZtZ8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=A68SjWFc9DA3WRCBjmt9GuZtsto4fpLk97VI/s4279YK+i00VudSqIhpDRTAvCd2
	 dmaFcklpmayahGIZ6kHt+I5fbo2Suo/TzS6tX/GhO2u6cM+yM1hdfPiOFjzZ/dSmn
	 La7dNIpRG228ccw3PhVfbWF6ztsyz8kFrfUBHvH4jl+P56k8NfZ7lMpgBH31a8vDh
	 lcKROAu5Uubg+cfYNU26TZMZgrRv5adBJWjriF32GBi3fPm91qu5j7mSVevzvlcmd
	 M0lfH1+jHOySUBAPWxmCugoEywrSlNfbk1zXW6YvtoWv8ATV0R211Sw1SI0dDeNXi
	 ORgE1evKk2lZyU0DGA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.242]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M76bb-1udRhG2WB5-008zVf; Tue, 01
 Jul 2025 14:26:57 +0200
Message-ID: <b05db8f8-9902-46d2-8c2f-844ff426973a@web.de>
Date: Tue, 1 Jul 2025 14:26:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <3675aefe-7163-4b02-a4ad-07b7a23a4b13@web.de>
 <701689c5-3003-417e-91bf-866355e2fe65@web.de>
 <4fe8ff5-73f8-2362-078-2b1c8432ade@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <4fe8ff5-73f8-2362-078-2b1c8432ade@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tdZ602ZwRbGn9H0okyFE6ZTP19opVs2MO/WXMM6VBJ3Q2zJnC5w
 xNyIniGzOFBY9hVvreEmBcWVBRms51vgrVwVVjm9Gg7IPcNSYyq256Bup4cIrXy/+U4DSf7
 U2P2Wgwf7AhaBBLBLmQ1vw7reIQUjE/7LOevEg4fqVCzAmjp/O3u9sfpgHygtcnwdF7eodH
 TqzfWvIg8NFZ1q6/MnkXw==
UI-OutboundReport: notjunk:1;M01:P0:k0pLM3WOm/E=;EtZFUfgBOcRHR5BTEU5yVxbnuBj
 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
 95nhnMKzYHmwPAMta4m01jB4NMu2xvyA=
Subject: Re: [cocci] Searching function implementations with variable
 declarations and statements?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2834
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/b05db8f8-9902-46d2-8c2f-844ff426973a%40web.de>

>> Should any diff output be produced accordingly?
> Probably not.  Statement list metavariables only match the list of
> statements that occur at top level within {}.

Do you occasionally prefer a source code search approach like the followin=
g?

Another SmPL script example:
@display2@
statement s;
identifier i;
type t;
@@
 <+...
*t i;
 ...+>
 s


Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> time /usr/bin=
/spatch --no-loops =E2=80=A6/Projekte/Coccinelle/janitor/show_variable_dec=
larations_before_statements2.cocci include/=E2=80=A6
@@ -666,7 +666,6 @@ static inline int usb_endpoint_maxp(cons
=E2=80=A6
@@ -721,7 +720,6 @@ struct usb_ss_ep_comp_descriptor {
=E2=80=A6
real    0m0,250s
user    0m0,202s
sys     0m0,048s


Regards,
Markus
