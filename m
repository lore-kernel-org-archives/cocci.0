Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DFF0C43334
	for <cocci@archiver.kernel.org>; Thu,  9 Jun 2022 17:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=GRg+oqoLIH6vUtWOBsWdpvnvrtCAY6aArDteuMvYLmw=;
  b=jVkucX1VEIUXS/aAL0wp0FM77ZLgRslersJ83xbbmhszNQvHMBhZ8Q6g
   qFI7tqq3yqhQQYYs0TZxZ2uRJ6HVvjHu10GUgFT1DURB+u5sgXsDQELJf
   1BL5HM8KoSA9rgcJDc30reOQppF6UY/cp02c8d3cbCImqSqoycopfLUiO
   g=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.91,287,1647298800"; 
   d="scan'208";a="40286157"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Jun 2022 19:34:41 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8FB1CE02DE; Thu,  9 Jun 2022 19:34:41 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 3AF89E010B
	for <cocci@sympa.inria.fr>; Thu,  9 Jun 2022 19:34:39 +0200 (CEST)
IronPort-SDR: 9JadCwyazcWKi954JfKwj5wwGcRio2cgPTtArvdfkYj7IDktuy7tHWOM+FYChhOYQyieiLZz6S
 BWfsswg4EaKaHXTlj9EY7t2rl7Qq5+DxXwsSi4xp1WkJTMN2XNeKyT3x+N3TaWJ4eu9YNxTtf/
 6voq2+xkDSaCy6JVTZE9bauWKIAGXRWBLuQBFoPjaV2JnkUJ59Diz5OVddkw6GSFoBM557hq4Q
 hCc6MM7f1E5+YmDhSyzKXIDZBVTMrw9fYOB2dRmrLm9kaClzxoLPp0Xo3E80AiKjwH+bf4i5EI
 WbNE4KcgeqVdkHcT2+0K6MOu
X-IPAS-Result: =?us-ascii?q?A0ApAAD2LaJihwsR49RaHQEBAQEJARIBBQUBQIE9BgELA?=
 =?us-ascii?q?YIjgVcuBAtEhE6REYQhhwmHG4oigXwLAQMBDT8BAgQBAYR4CgKFRgIdBwEEM?=
 =?us-ascii?q?gcOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBEwEBAQwNCQUICgcOE?=
 =?us-ascii?q?AU2Bl4GZASBSwSBdAs0DYI1KQGDZAECAgEjHQEBESYBDwsaAiYCAlcGDQgBA?=
 =?us-ascii?q?YJ5gmUBAw0jB6wRgTGBAYIIAQEGhEofLCJSgVwJgREsAY1veicQgVVEgTwMg?=
 =?us-ascii?q?QmBPjA+gQ+DNYNWgmWVfYIVJwQPAxotNBKBIXEBCAYDAwcKBTIGAgwYFAQCE?=
 =?us-ascii?q?xJTHQISBQcKHA4UHCQZDA8DEgMRAQcCCxIIFSwIAwIDCAMCAyMLAgMXCQcKA?=
 =?us-ascii?q?x0IChwSEBQCBBMeCwgDGR8sCQIEDgNFCAsKAxEEAxMYCxYIEAQGAwkvDSgLA?=
 =?us-ascii?q?xQPAQYDBgIFBQEDIAMUAwUnBwMhBwsmDQ0EHAcdAwMFJgMCAhsHAgIDAgYXB?=
 =?us-ascii?q?gICbwomDQgECAQcHSQQBQIHMQUELwIeBAUGEQkCFgIGBAUCBAQWAgISCAIIJ?=
 =?us-ascii?q?xsHFhkdGQEFNicGCwkhHAofCwYFBhYDI3EFCj4PKTU2PC8hHAokBiIBGwKZA?=
 =?us-ascii?q?2sIljOuRTQHghSBPYFEDJ4tBhMtllEOBpF2lmqnM4FoB4IHMxokgzdOAQIBA?=
 =?us-ascii?q?g0BAgIDAQIBAgkBAQKOHQwNCYQDii0/NDsCBgEKAQEDCYVHAQGJSAEB?=
IronPort-PHdr: A9a23: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
 4qX/EoWAChP+ZTY8JlEb/U=
IronPort-Data: A9a23:Idb/c6ttc7ls/OkWigv4LCMfdefnVExYMUV32f8akzHdYApBsoF/q
 tZmKTqAOP+CMzSke98ibdi+/UwOv8XRndNmQQM9qX9nEXtBgMeUXt7xwmXYb3rDdJWbJK5Ex
 5xDMYeYdJhcolv0/ErF3m3J9CEkvU2wbuOgTraCYEidfCc8IMsboUsLd9UR38g52LBVPyvX4
 Ymo+5OHaAf+s9JJGjt8B5yr+EsHUMva42twUmwWPZina3eD/5W9JMt3yZCZdxMUcKEMdgKJb
 7qrIIWCw4/s10xF5uVJPVrMWhZirrb6ZWBig5fNMkSoqkAqSicais7XOBeAAKtao23hojx/9
 DlCnZmqcS02JJzQpLsUXRhSDREvepRr1ZaSdBBTseTLp6HHW37r3ukoE0w8e4EVkgp1KTsXr
 7pCcm9LN0/F3rveLLGTEoGAguwGJdPoIZhZl3Vu1zDfAt45TJqFT6iiCdpwgG9q1p4XQKy2i
 8wxNDBxNRmZfjh1FxQUK8k6nueCmWGgSmgNwL6SjfNqvzaKlVIZPKLWGNHScdeLbd5Em16R4
 GPA5WXwRB8AXPSbwCWM9naElO7KlznyHoMUDryxsPBw6GB/3UQWDwAKE0S2q7+1hyZSRu6zN
 WQR4BIEsrID6HD0R9f8VQOI8Tm9kzM1Do84//IB1CmBza/d4gC8D2cCTyJcZNFOiPLaVQDGx
 XfUx4+yX2AHXKm9FiLEpu38QSaaZHBNRVLucxPoWiMpzrEPSqkWiRTTR9xqDbTdYjbdRG+sm
 mjiQMQWvbUejMgP3qO3uGjJija+zqUloyYw4RjLGH2o5EV1aeZJhrBEC3CLs56sz67AHzFtW
 UTofeDAtIji6rnTzUSwrB0lRu3B2hp8GGS0baRTN5cg7S+x3HWoYJpd5jpzTG8wbJtYJmayO
 BSN5lgPjHO2AJdMRfAnC25WI5t7pZUM6fy5DJg4k/ITPskvL1XvEN9GPxXOgDCFfLcQfVEXY
 MrHL5/1Ux72+Iw+gmP+RuEB3KUtyzx2zGy7eHwI50TP7FZqX1bMEe1tGALWMIgRtfrYyC2Ir
 Yo3H5bUmn13DbymCgGKoNV7BQ1bfRATW8irw+QJLLLrClQ9QgkJVaSOqY7NjqQ+wsy5YM+Tp
 CDlMqKZoXKj7UD6xfKiOys6Mu61AMYgxZ/5VAR1VWuVN7EYSd7HxM8im1EfJNHLLcRvkqx5S
 ecrYcKFDqgdQzjL4WpPcpT36oBvLUz5iQWLNiujQT4+Y585G12XoIC5JFO3+XlcFDezuOs/v
 6akiFHRT60DcAI+XszYX/SikgGqtn8HleMuBEbFe4EBeEjl/IVwBTb2i/s7f5MFJRnZmGmF2
 gzQDRpB/bvBpIo88d/og6GYrt71QrUkQRcARzHWtO/kOzPb82yvxZ57fNyJJT2NBnnp/KiCZ
 PlOy6+uOvMwnGFM79h2HYFtwP9s/NDovbJbkl9pEXiXPVSmDrRsfiuP0cVV7/Qfw7hEpU2pV
 0jJ9tQDYeeFP8bsEVgwIgs5b73fhK9OxWSItaw4cBfg+St63LubSkEMbROCvyxqKucnOo0Sx
 +p86tUd7Bayi0ZxP9va3DpY8X+Aci4JX6k978hIBYj2lkw0x1sEbZGFUn3655SGatNtNEg2I
 2bI1fSY2OkGnhLPIygpCHzA/etBnpBQ6hpE+181IQjbkNTygPJqjgZa9i46T1gOwxhKuw6p1
 rOH66GoyWSyEzZUaAxrWmexB0deCRff9kGZJ57lUoHGZxHAa4APBDRV1SWxEIQx7G9WODRWl
 F1d4HiwSi7kJakdwQNrMXOIaJXfoRhZ6QDI3syqdyhA81/WfhK96pKTiaE0R9cLzC//aIArZ
 QWnwQqoVZDGCA==
IronPort-HdrOrdr: A9a23:SAqD8KzqBgm53zRZIbYvKrPwCL1zdoMgy1knxilNoNJuA6mlfr
 OV7ZcmPHjP+U4ssRAb6Km90cy7Kk80mqQb3WB8B8bEYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 pdmupFebnN5DNB7foSjjPIcerIjOPnzEiy792utEuFoDsaEZ2J1m1Ce3um+sYafmN7OaY=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.91,287,1647298800"; 
   d="scan'208";a="40286152"
X-MGA-submission: =?us-ascii?q?MDEiBfodZBdpeOOS4hEXj66ag7I67rJ393HVlA?=
 =?us-ascii?q?HnJ7S0v6Y+Ys06aZOr/iqWgid/HlN5NPjhWKzhB4GEb9xu2sL4Cvw9jf?=
 =?us-ascii?q?Nj0MsTme40AU/Y9dNkCPoZFmWhCR83fLDdCLqGLfkzyEq0/XrzMtmtTI?=
 =?us-ascii?q?N5XAac8Y16/w/MpITibjExeg=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 19:34:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1654796074;
	bh=GRg+oqoLIH6vUtWOBsWdpvnvrtCAY6aArDteuMvYLmw=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=IU3S5A0Y4lkOAn5X8gyI3G3+BernPKLpWwIhHtw93gCcOaectPHlqLuVrPRcV6WBo
	 vydRD92o9jj0nuWMFTSsvdpmbGGP9TgrfzgUnQH2lq+nrnYEzcjrajrpwh802LSd47
	 6VQGdnM/OjZtDJX1EJzNeZNX5OTXRKYYIfqxDAn4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.155.143]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MuVGC-1nhPWi2TI2-00rf5t; Thu, 09
 Jun 2022 19:34:34 +0200
Message-ID: <8f9bbad3-1812-6448-52e6-2570e6368f0d@web.de>
Date: Thu, 9 Jun 2022 19:34:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr, kernel-janitors@vger.kernel.org,
 Nicolas Palix <nicolas.palix@imag.fr>,
 =?UTF-8?Q?J=c3=a9r=c3=a9my_Lefaure?= <jeremy.lefaure@netatmo.com>
References: <AS8PR03MB760365A0DE3A8522136471BE93A59@AS8PR03MB7603.eurprd03.prod.outlook.com>
 <415ca02b-9618-b447-6471-6bcd0e2215e8@web.de>
 <alpine.DEB.2.22.394.2206072138160.2960@hadrien>
 <15a253a6-469b-9632-8c7d-983554604451@web.de>
 <alpine.DEB.2.22.394.2206091740520.2380@hadrien>
 <da86bc36-36af-7bd7-6bee-861e160ba6a4@web.de>
 <alpine.DEB.2.22.394.2206091824560.2380@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2206091824560.2380@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:19QSRhPhwpEY15XWRsaLgCd0TSiUTdJRqGcCrisu1jck45mVmib
 6c+Dvo8knUyLupkEcIS5kWx17DPp0KgN/l6ptEHfCpmyTLCluv7X5AE6KEVYLO9njfcnXZ3
 h9dRLO7w6aHD9CrHWv52xdqwX4Y3UYCgGi9FXFhGoOkZdsxnlows4y30TRw/xVqaCmgZV9z
 mqa0UQtQOGYD8Q+3TWf4w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DHC5XvEDNcY=:Pij5Kwe32zeF55DBH26cF5
 /kI/gk9crp7cq7je+9HyXogGwNWOKezC9UpujljrdGNAsjjXMzazjt4K/ilRRVB0FC9A4Bajz
 KV4BpgVFHRqrt+a6IwKIgTe48eUID1SAJ9bht7vlAxmXLeM2YPkEh+tpOXvDVolJ+ng607IlI
 HijN9FnHs1MOw/bpIJfPuRMHIvc4+tyQtGkEFixZdIjHyJPNFSrreuUE1vDtbwp6LR/P2JwQ4
 R2W6Om4UzhZPANSoAYMobbf2MiQkR51lgspXhVwLxMSjmsZuCS+qqT1LvnT9hwpruDPeEF5lX
 2o+XavtHb3wEZ+eHZiLLftpKbm9AMJH9+UwVVd5bPu0oFUyO/dg+e4aTTzRnWpQcEOkAV3dcM
 AD1qcwIhCjuMSAsRGX4lhnUzDYI6ZKPhCFwE3MXYhqoqOWaXV6J6fYLIn963OiAONcZvGRWAJ
 SeLUG5+cfqRUnxNTWdeGO52QBTsnd/uW47xS1E/dEweYWlInOdEiCe9pbvcViR5aUZpuC+SIM
 1oEoljNHt7WCoiV3FYUSnC1xcKK+2K3Qroef/x5BD3wkS/vZnZWgQO4997es5UlOwNTITURjF
 bbiMC7Za5cQW/Es3ar/Mgtkcy4OOL+RAz/iXjEooC/ePw7jSZp4bNtVa4w9w4UGYLPzjmqffj
 m1irD6q19XX89jo87AGpHn321pu6LpqhlcQyXBuIuskUEFZHOIMD4RfTDV00xLPnrE9ImYiUN
 4ijjJlRev4e4rGMGwcAY4Nv1Z5Kc+FyWNwDGWhJ5j1qE+oMSdOtHO9pQDrFkzBpZYqSfjLncu
 eapUbaLwCsUfL/3I9A98/OiOAqQpZF5L1AyDM16Wjvnf45+1kBz4tc+KAdB1T6mLdNFmFkn2W
 8pTWjzgHLNSQ8kcmyA8SQdbQp2EU6fH+HFfaOTTGwndLfiLS3CX51k04hhgdbRtgQt3yUOBSq
 fUYyU5sf/uQ4aMb/vDfziK/C+uYG+kC55L89oxxOK7OYlf/ZQXVskVEZwrhqIvkyIn20nHWfU
 S8/iWKDj9wQN8iRy2/nTI4rXhkYtwuwmjq4AOB3n2iY8GRv0AupGZTknlQyaUlgtgLW+ekxng
 sPUSVeA03cxuAcq+b28xSBiq19ipk1fDURdmze2RRLD2lXwyw6jsATCqw==
Subject: Re: [cocci] coccinelle: ifaddr: Find address test in more complex
 conditions
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 430
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-06/8f9bbad3-1812-6448-52e6-2570e6368f0d%40web.de>

>>> How about trying an example?
>> You might interpret the following test result as an expected one accord=
ing to
>> your understanding of implementation details.
>>
>> Markus_Elfring@Sonne:/home/altes_Heim2/elfring/Projekte/Coccinelle/Prob=
e> spatch show_address_determination_in_checks-20220609.cocci initialisati=
on_test2-20220609.c
>> =E2=80=A6
>> @@ -1,8 +1,6 @@
>> =C2=A0void check(void)
>> =C2=A0{
>> =C2=A0int s =3D 1;
>> -bool t =3D &s ? 0 : 1;
>> =C2=A0bool u;
>> -u =3D &t ? 1 : 0;
>> =C2=A0}


Can it be that special transformations (which are not represented as a par=
sing result
from the application of named isomorphisms) were applied here?



>> I observed that no questionable places were marked in the following sou=
rce code.
>>
>>
>> void check(void)
>> {
>> int s =3D 1;
>> bool t =3D (&s);
>> }
>>
>>
>> Will this test case trigger further development considerations?
> It seems to be doing what it should.

I would expect that the usage of the address-of operator within extra pare=
ntheses
should also be marked for reconsideration of such source code.

Regards,
Markus
