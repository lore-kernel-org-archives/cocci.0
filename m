Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDFF2CCD192
	for <cocci@archiver.kernel.org>; Mon, 13 Oct 2025 14:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=t4YbVn7UuEQrxVmXBS9q88pwfFK3vA2fr6yZ+C+zAUc=;
  b=AjWsKC8B17DMZC6baZtJuIJ8Jkk3ff9bMPBXPfnaNt+3oZfApJIEhZ82
   i7mBnEDrH7I6DHbh8MpFY3L5g4mg6CqtvFr5dJGWmNjPyqWdTtMXaTs2P
   UnwHdimfhY8QmesKkTA2/2eFVbBobkuVfwsKfC7e961IEfhMzTl7/5ltJ
   c=;
X-CSE-ConnectionGUID: gX/BfwXHS4GBEzZgU1lBJw==
X-CSE-MsgGUID: pX93vuDgSH2wteZ4BBh+vQ==
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
X-IronPort-AV: E=Sophos;i="6.19,225,1754949600"; 
   d="scan'208";a="243925544"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Oct 2025 16:35:19 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DF8B5E0CD5; Mon, 13 Oct 2025 16:35:18 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 77D68E0171
	for <cocci@sympa.inria.fr>; Mon, 13 Oct 2025 16:35:14 +0200 (CEST)
X-CSE-ConnectionGUID: TWWIDQI2R0G/hW36ADb26A==
X-CSE-MsgGUID: LeG/7SyZSQqAC87sxyZJjQ==
IronPort-SDR: 68ed0e22_lvt/Ha67L24IKoKc2spNIt6hUXMUsd9mvnV2mUQpshQCVoq
 plz6jliIIJZxwf1pJIu9zTj7b/J7dnSIs64RAbA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GnAgA2De1ogAQP49RaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBUIJAZSNYMwQLSYRVj1KCJIQ7hzyHVYh5g1ICDwEDAQ1OAQIEAQEDB?=
 =?us-ascii?q?IIMgnQCjEoCHgcBBDQTAQIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECB?=
 =?us-ascii?q?AYBAhABATsHDgoxhhUHMw2CYgGBJIEmAQEBAQEBAQEBAQEBHQJHRAEBAQIBI?=
 =?us-ascii?q?x0BAREmAQQLCxoCJgICSwsGARQBAYJ+giMBBhABAw8nB68xgTKBAYIMAQEG2?=
 =?us-ascii?q?l8fLCJZgWQJgRwuhW2CZAGFXEuDQ3onD4FVRIE8gwM+hEODW4JpgiaBDoY0k?=
 =?us-ascii?q?BZSeBwDWSwBVRMXCwcFgSBDAyo0LSNLBS0dgSciIR4TYD0XQINJGwZoDwaBE?=
 =?us-ascii?q?xlJAgICBQJCOoFqBhwGHxICAwECAjpXDYF3AgIEgjGBEoIqD4RNAgELbT03C?=
 =?us-ascii?q?QsbBj2SQoN1ExyBFUDHNTQHgjiBZ4FkDJ9sBhMvhASNE4Y7DgaTBYNXgkuEc?=
 =?us-ascii?q?41xIqkfNoFJI4FcMxokgzZPAxkPiTaEawwWhBG5LkE1PAIHAQoBAQMJAYFVg?=
 =?us-ascii?q?3ABAYxWgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 GmlUVbOwhkRkdiJndsQLTgjssqi6jQyB+rE
IronPort-HdrOrdr: A9a23:AtpM5ayNvBJey9hujdGuKrPwFr1zdoMgy1knxilNoEpuA66lfq
 GV7Y0mPX2dslwssRQb9OxoV5PtfZqxz/BICMwqTNOftWrdyQ2VxeNZjbcKqgeIc0bDH6xmpM
 BdmsNFaeEYY2IUsS/S2njcLz9Z+qjlzJyV
X-Talos-CUID: 9a23:dHHOHW6xyBlHh8/sZtssyHErO+wcUyfnlFiXI3DjV09FQufLYArF
X-Talos-MUID: 9a23:xuaGpgWhS/5T3sfq/Bvhq3Y9D9Za2J23IWtdzo4WqvumNxUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,225,1754949600"; 
   d="scan'208";a="243925526"
X-MGA-submission: =?us-ascii?q?MDFUJrE2iMJEs7DaNuh5PmwsJ03J7zTnHOv/ot?=
 =?us-ascii?q?hXShA3Jtsml8E81VsKKaLpGtr0Jv66zpEruMvIym++P5oSFvr3hk7WDd?=
 =?us-ascii?q?FAD5YQ/e+bRQRktFr8utfaOq1jno6NlHESe64FKpOYhVbxJsY4JIY8QP?=
 =?us-ascii?q?8ZfoFQqwWeoOlxz09WNAYA2g=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 16:35:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1760366108; x=1760970908; i=markus.elfring@web.de;
	bh=t4YbVn7UuEQrxVmXBS9q88pwfFK3vA2fr6yZ+C+zAUc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=s6VOMfYwB7n9llZddKuqQfwE9rtPLHg5hAdMs5C72WjwTQ0k+H6fFTOY7MsP6Njd
	 5agp6S8/eRlikemMyzxxRTJ67OKwfwL4Xw12t2K6SVdn2V8LqO8Evz//2kYqmAXXH
	 UoqdsY6p+L80ZK0YJD7l1/HUSFiHRiRJBTFGe4F0te9q6+drc8XeXfU4wD/eSCRIB
	 8VMX4BKTv+MwjUnBXvIY0iQX5TND7kETDPxsijx0D863eRPrhvty2/mBEWlXwhuFL
	 6IG+kUJaC6nqoIgvq8weaoPdCe/p9D7Jm/jWn8QlHL+kj/xqqzfkd9Xt0Bb6EGt3n
	 jDp9QWDXcUQSCKRsBQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.186]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MhFlm-1ueDkM11hi-00jYFG; Mon, 13
 Oct 2025 16:35:08 +0200
Message-ID: <8480276b-ee1e-454e-954f-b25890c79add@web.de>
Date: Mon, 13 Oct 2025 16:35:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: linux-cifs@vger.kernel.org
References: <335b0fe9-313f-4e3d-a01d-1954f3c46489@web.de>
 <805f36f6-ea15-cbc9-f510-45856eb6f6d7@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <805f36f6-ea15-cbc9-f510-45856eb6f6d7@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vReqd/9oMpsaaHqbrIJ5+J63+bR4BFcmR3USpowEQsPYC6v9bDN
 Rmzxbho0E5vcFAYrxez8OR7BECScE0Sk7W4gv2Po8ze2Yd73+OWkeXtmc1Jz9d2j8W5eCOu
 Stm7lklN5U+fNfGjlN0sk55/l2d1jTTIs139J7cEu3qls5zrjTo85zp3t4I7ni6/qsZonXP
 2YCQXzEYUtIYeVchl3rQA==
UI-OutboundReport: notjunk:1;M01:P0:DGcuGOkEwGo=;UgVyhxqlbPJ7WetXq8z4ajCUc3X
 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
 aoXDA==
Subject: Re: [cocci] Improving source code parsing for =?UTF-8?Q?=E2=80=9C?=
 =?UTF-8?Q?fs/smb/client/dir=2Ec=E2=80=9D=3F?=
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3070
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-10/8480276b-ee1e-454e-954f-b25890c79add%40web.de>

> If you want the problem to be solved, please make some effort to narrow =
it
> down to a smaller number of lines. =E2=80=A6

How do you think about to improve data processing for another source file =
example
like the following?


static int my_test_condition(void)
{
#ifdef MY_CONFIG_LEGACY_OPTION
 if (0)
    {
        my_log("working?");
    }
 else
    {
        /* Test comment */
    }
my_info:
 if (0)
    my_log("reminder!");
 else
    {
#else
    {
#endif
     my_log("special part");
    }
 return 0;
}


Questionable test result (according to the software combination =E2=80=9CC=
occinelle 1.3.0=E2=80=9D):
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> /usr/bin/spatch =
=2D-parse-c test-ifdef-legacy3.c
=E2=80=A6
PB: not found closing brace in fuzzy parsing
ERROR-RECOV: found sync '}' at line 23
=E2=80=A6
parse error=20
 =3D File "test-ifdef-legacy3.c", line 24, column 0, charpos =3D 282
  around =3D '',
  whole content =3D=20
badcount: 22
bad: static int my_test_condition(void)
=E2=80=A6
bad:  return 0;
BAD:!!!!! }
=E2=80=A6
nb good =3D 0,  nb passed =3D 3 =3D=3D=3D=3D=3D=3D=3D=3D=3D> 12.00% passed
nb good =3D 0,  nb bad =3D 22 =3D=3D=3D=3D=3D=3D=3D=3D=3D> 12.00% good or =
passed


Will similar test cases trigger more desirable improvements?

Regards,
Markus
