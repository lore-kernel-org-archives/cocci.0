Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E5B6CA1012
	for <cocci@archiver.kernel.org>; Sat,  6 Sep 2025 12:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=IvrVmd0eKR5C6hhGqCs1w0/Ccmxi2aQAbrwRqZAhJ3M=;
  b=Vtb9UoPWr6BnPETBxRO6ZKTmfOzLnxO0bA4y+oD0hAE77AIRWMUprnRC
   hiiZsZLRnn39/onC/JA+a7b8EDI8pHjuNusrPm3rNLpkp4di5lf5hxkJZ
   IiMtNRCGHKWEMWBjhsU/3TNf/onMeJ2FGN+YXAiH9hBoTEVrXWLywqkkD
   0=;
X-CSE-ConnectionGUID: G6ikQz8qT9iB1rtrcaIosA==
X-CSE-MsgGUID: TUVQUsGjR3GStvFwhWctJQ==
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
X-IronPort-AV: E=Sophos;i="6.18,244,1751234400"; 
   d="scan'208";a="237813409"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Sep 2025 14:07:48 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 041BEE0264; Sat,  6 Sep 2025 14:07:48 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id D2257E0171
	for <cocci@sympa.inria.fr>; Sat,  6 Sep 2025 14:07:44 +0200 (CEST)
X-CSE-ConnectionGUID: VRrPfREfR5etguUciIdjrw==
X-CSE-MsgGUID: mg8dFXakQ6ilXn+ZExswug==
IronPort-SDR: 68bc2410_49CQJGfgrSLlLaj+C4b2nnqtKIGeqn9VdcLvTFUWJ0rXMYs
 oV0GGutSRwBgdslc+BFMAQhiG6JR+gZ6BTihIwQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FGAAApI7xog07ASNlaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYI/gQdUMwQLSYRViByHNIMDg1yHPIdViHmBVYF9Ag8BAwENTgECB?=
 =?us-ascii?q?AEBAwSFAAKMKQIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECA?=
 =?us-ascii?q?QECBAYBAhABAQEhGQcOO4ZPDYJiAYEkgSYBAQEBAQEBAQEBAQEBAQEBAQEXA?=
 =?us-ascii?q?kdEAgEDIx0BAREnDwsaAiYCAlYGARQBAYJ+giMBBhABAzUHsU6BMoEBggwBA?=
 =?us-ascii?q?QbaXx8sIlmBZAmBGy4BhWuCZAGGJwmEMycPgVVEgTyDAz6EQ4NbgmmCJoEWg?=
 =?us-ascii?q?1iMWIJ3iEVSeBwDWSwBVRMXCwcFgSBDAyo0MSNLBS0dgSd5gweBDYQdK0+CH?=
 =?us-ascii?q?HKBdD4ZQINTHgZrDwaBFRlJAgICBQJDPoFtIgYfEgIDAQICOlcQgX0CAgRLQ?=
 =?us-ascii?q?AIBC209NwkLGwY9lXOCPIMogTYMOsYDNAeCOIFngWQMn2wGEy+XUg4GkwWZB?=
 =?us-ascii?q?iKpH4FoOoFcMxokgzZPAxkPjiEMDQmEEborQTU8AgcBCgEBAwmFRgEBjFaBS?=
 =?us-ascii?q?wEB?=
IronPort-PHdr: A9a23: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
 xRwhgYsOYwQ
IronPort-Data: A9a23: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
 VUIqat4rI1XhKI//QuMu5KYJf3BgA7S8g==
IronPort-HdrOrdr: A9a23:EGXReqz2aaPt5rO2mCq9KrPw8r1zdoMgy1knxilNoG9uA6mlfq
 eV7Y0mPH7P+VAssRQb8uxoV5PufZqxz+8Q3WBVB8bEYOCEggWVxeNZgbcKqgeIc0DDH6xmpM
 VdmsNFaOEYY2IK7vrS3Cn9Nco8y9+a962Sif7Z1GoFd3ARV0gt1WZE4h3wKDwPeOCqP+tDKH
 IWi/Asmwad
X-Talos-CUID: 9a23:EnqFTW1uoX+PHZbGAGJxK7xfJPo/SnPn4XnqfkKkBntUQ7y0RV2K5/Yx
X-Talos-MUID: 9a23:I0M3HgUqwP6ORNvq/Drj1D1MBM5r2vqvDHAL0qcrq9KbKCMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,244,1751234400"; 
   d="scan'208";a="124821889"
X-MGA-submission: =?us-ascii?q?MDHeiEG7Xs7OlMU1eYdQh7cI/q1YHUz9Ort67V?=
 =?us-ascii?q?/SFfgSxQVRB2LDPY3QRqQFkF0vZNzAg5i8cjhy1um0dvhcfqzhuWDIx7?=
 =?us-ascii?q?nhyxFLxdfCWDF3/lKHUbuY5SxdKWR+q6OsHCg4ITgc79hNGIxgDXP+MY?=
 =?us-ascii?q?nJcJTuJeOQqACcmaMw8eIlhg=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2025 14:07:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1757160463; x=1757765263; i=markus.elfring@web.de;
	bh=IvrVmd0eKR5C6hhGqCs1w0/Ccmxi2aQAbrwRqZAhJ3M=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=q1JuBFhcnwQelOUN/Kx1cYCoo61rhZXDIuBR+4VEAvjY4Tdsv6bG7HaoswD6Yb8C
	 Ak0wYcxilfhGa4XQlJQXBn1/3gH99wvqsBcoVqDj9ecWtb51FgnpAzRuwa5VuR2pG
	 8Yb03Qr+gEcyrXvXlRzMnTqxkcp3MmnAdXfjNnvEuUEKxbT4U0LsPqtiPal5/YNYK
	 E1gUvpwlNuyFbPCJyELUhQs8klnt3Z3GNT3POEDWy5E7awPM7/uwWSMjHvmnYtJBx
	 W6YuaqC7rEMehMCCZ6Lq2CuLJx2yhmXoSILuN/FPzzjUnFOE+0aTAbTs/XWqqjQUb
	 M7tukQB2sqAnOBgghw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.215]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M43GU-1uurhn0acy-001mE5; Sat, 06
 Sep 2025 14:07:43 +0200
Message-ID: <469a978c-5b6f-4cfd-99c6-69671de653ad@web.de>
Date: Sat, 6 Sep 2025 14:07:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <6c2e0db1-033f-4f66-9cf7-dc0eae4bcde7@web.de>
 <f798ce14-0401-4116-bbee-2b78ad0f774b@web.de>
 <4c46da9-1fa9-9b4f-f0c7-6c7fd094e163@inria.fr>
 <b0221946-43a5-43c0-8573-32c12e149681@web.de>
 <ba87aeca-594d-10b6-960-cd4aa1fcd1e6@inria.fr>
 <d28c6f76-6708-4dba-a446-910170e27572@web.de>
 <b2e58328-97f3-4f1-e588-4647c6ff30d3@inria.fr>
 <13ed7845-6fd9-4a8e-9670-3d2b7e7a0f4e@web.de>
 <ce7a7254-bbb3-4666-8a57-2e6cccaa51fc@web.de>
 <4959806f-e03e-9a59-63eb-f71b6bf6f954@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <4959806f-e03e-9a59-63eb-f71b6bf6f954@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dXtPUiropMLHI/J8kXQ2yOKIyB9eHuswx1RS02c7KbDhkvTaaIC
 nrZMf6RllUrXD6QZmRqLFhVHhjkefg3zWwqynC8InFxz9M6WCKkGwLctocdkDje/DneTOfa
 CI6tzNOEXsIE5C/545K50FxzH4tHjLFP/WczP2Ny/U6qov3DnllhmSJqMsLJBIpagAr9CZ3
 uABiAnIMk4x9SJKAzWx6Q==
UI-OutboundReport: notjunk:1;M01:P0:EEsmJhBQX7I=;jVBG6TU2AlGMXJNhIQEbXcwRIHk
 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
 p
Subject: Re: [cocci] Searching for selected variable assignments (with
 SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3005
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-09/469a978c-5b6f-4cfd-99c6-69671de653ad%40web.de>

>> @find@
>> expression e;
>> position place;
>> type t;
>> t * pointer;
>> @@
>>  pointer =3D e(...);@place
>>
>> @display@
>> position find.place;
>> statement s;
>> type find.t;
>> t * find.pointer;
>> @@
>> *;@place
>>  if (!pointer)
>>     s
>>  ... when !=3D pointer
>=20
> how about:
>=20
> pointer =3D e(...);
> if (!pointer) s
> ... when !=3D pointer
> ? pointer =3D ...;

Do you support to split the search approach into multiple SmPL rules
also with the application of additional position variables?

The following SmPL script variant seems to work as expected.

@display@
expression e;
statement s;
type t;
t * pointer;
@@
*pointer =3D e(...);
 if (!pointer)
    s
 ... when !=3D pointer


Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> /usr/bin/spat=
ch --no-loops =E2=80=A6/Projekte/Coccinelle/janitor/show_unused_addresses_=
from_variable_assignments2.cocci arch/arm/kernel/devtree.c
=E2=80=A6
@@ -77,7 +77,6 @@ void __init arm_dt_init_cpu_maps(void)
=20
        u32 tmp_map[NR_CPUS] =3D { [0 ... NR_CPUS-1] =3D MPIDR_INVALID };
        bool bootcpu_valid =3D false;
-       cpus =3D of_find_node_by_path("/cpus");
=20
        if (!cpus)
                return;


Regards,
Markus
