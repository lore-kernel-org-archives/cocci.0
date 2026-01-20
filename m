Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52B5DD2ECE9
	for <cocci@archiver.kernel.org>; Tue, 20 Jan 2026 13:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=D2zDqeKS1SIqdod/aRXcUxDBK82vlcLAJuj3cOVCQSM=;
  b=V1uLR4dNqknMEcScGLGLzOUp//I8qKWUmJ+HxvV8hGZsZHZwrrEIEx9r
   JxYe8N/Hj8pZGOWj/saHMnQAO7xXOXgDVZRkiERb0G7zu5k8tpVTzWpN/
   LEvCCZgQYdNjBUGCMs2HnG80ZwgIvqWMlSft9irGliUQr4sL3CenHWyza
   k=;
X-CSE-ConnectionGUID: rj7Ph+QHSFCg4ypOL2kt9Q==
X-CSE-MsgGUID: k9JWkNUVSkSUj8RLJLqLjQ==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
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
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.21,240,1763420400"; 
   d="scan'208";a="259468390"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Jan 2026 14:45:39 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id EAA1883AAF; Tue, 20 Jan 2026 14:45:38 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 5864283780
	for <cocci@sympa.inria.fr>; Tue, 20 Jan 2026 14:45:37 +0100 (CET)
X-CSE-ConnectionGUID: Fe3fLyVDTIiRo/CnqUqShA==
X-CSE-MsgGUID: zJVMNBNWRJelnZri2M22IQ==
IronPort-SDR: 696f8701_ItpK5vE5ihXllVfqHX/KtXyVWvSFh+x6tOntiea6LfafGiq
 aftpeF/TFaUO6rJ7VaaXFrcbQknrLNBc810qhiw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HPDwBPhm9pgwsR49RaHgEBCxIMQIFSgj9oJVkzBAtJh?=
 =?us-ascii?q?FiPU4IkhDuHPIdVik+BfAIPAQMBDU4BAgQBAQMEggyCdAKMeQIeBwEENgQNA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABAQE6Bw47hk8Ng?=
 =?us-ascii?q?mIBgSSBJgEBAQEBAQEBAQEBAR0CR0QBAQECASMEGQEBESYBDwsaAiYCAlYGF?=
 =?us-ascii?q?QEBgn6CIwEGEAEDDycHrx9/M4EBggwBAQbaYx8sIlmBZwmBHy+FbYJlAYlte?=
 =?us-ascii?q?icPgVVEgTyCUjE+hEODW4JpgiaBDoMfkG9SeBwDWSwBVRMXCwcFgSNDA4EGI?=
 =?us-ascii?q?w88BS0dgSMhHRcTH1gbBwUTI2wGGwYcEgIDAQICOlMMgXUCAgSCE3uCAQ+HE?=
 =?us-ascii?q?YEABS5vGg4iAkFSAgELbT03CQsbBD2QCUeBMoILgW6yVJRjNAeCOIFngWQMn?=
 =?us-ascii?q?20GEy+XUg4GkW6BFx6YaKlBggIJF4FcMxokgzZPAxkPjiEZJYN1x05CNTwCB?=
 =?us-ascii?q?wEKAQEDCYVGAQGMVoFLAQE?=
IronPort-PHdr: A9a23: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
 hFOzb6qdewu
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:rkLDkK68ruu+UpnNswPXwBzXdLJyesId70hD6qm+c202TiXqrb
 HLoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhWotKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkaNDSaNzhHZKjBkWqFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkjuRRjz7LqVsLjM2fqbR+a
 DsnPauLFebE0gqUg==
X-Talos-CUID: 9a23:oI0NNWDiZGj82In6Ewdqr0AwC/4JTlzc9nCXCEmhNH9SSJTAHA==
X-Talos-MUID: 9a23:ReW8jAqLZp3zZyP9IcAezyNACuJOyYKRMmIAlZM0ocjeEHYqGg7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,240,1763420400"; 
   d="scan'208";a="259468369"
X-MGA-submission: =?us-ascii?q?MDEecvCZ1Zb1TfQk+fxzRsq2LWB3VjbH/pMZsh?=
 =?us-ascii?q?xPxr4eJdI9rjckfJpbXV+bgMKds9/57optXAplfb7ygFdL7z7i9iA5d/?=
 =?us-ascii?q?PRFyFj6II52p7wAMiNSdBWnpWW9uENg1A98CRiwN1SfMRsLOf6T69K4T?=
 =?us-ascii?q?Zc1YSeElk9hcwgN//EpVmP8g=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 14:45:36 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.179]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MyvBA-1w3aaY12aQ-013HZc; Tue, 20
 Jan 2026 14:45:36 +0100
Message-ID: <9cc072a0-3d5b-47dd-b849-89401b681d61@web.de>
Date: Tue, 20 Jan 2026 14:45:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci <cocci@inria.fr>
References: <e12b2a95-f1e6-4f8b-ab62-151c9789e798@web.de>
 <ca324487-4858-9054-14e8-dbeabae9728a@inria.fr>
 <78df0ed3-2bb4-438a-bba5-c858dd20c1f1@web.de>
 <2e04b3-525f-c970-4d51-ae20a9cd7a2@inria.fr>
 <3eb7e985-02b5-4be3-9414-78d7e155bf84@web.de>
 <ba44f42c-202e-4fc2-b906-ff06f0aca80a@web.de>
 <c3137d6-dcfc-b982-9db-4edf95a12ae3@inria.fr>
 <93ad7521-d583-4997-b21e-91433aa602ec@web.de>
 <1496228462.18059952.1768915809347.JavaMail.zimbra@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <1496228462.18059952.1768915809347.JavaMail.zimbra@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LnQH8s1rEXeHOzH0nro2WuLrExiTg8Dbb19Yltpm81XJU/PxN2x
 OkBLfYcrNENfU3Grp4mBTshHUGl4NFm3KD+dPbrxAyDQZlh7WwwcZBLxzCz3JPrGyZ+UgRm
 3/bgV7j3T6Ezi06hiet6isjZk7aZsP8iIMjOZpRhqaHrHNG4ZaIGvHDzj+13mgLwp64vGZD
 46UKIHICW0TkKpKhFngTg==
UI-OutboundReport: notjunk:1;M01:P0:xMyffVjK7KM=;WYLggEqXIawBHFEgfexWTHbAo7Z
 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
 TpAOvUY/f8dJqbkCO1lj8ygnFyIXF
Subject: Re: [cocci] Checking data structure member accesses after function
 return value assignments?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3290
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-01/r9vHXrY4zr7nbgwCHZBt7w>

>> Can such an SmPL code variant prevent the interpretation as an =E2=80=
=9Cempty statement=E2=80=9D?
>=20
> Yes, because as already explained the () forces the <+... ...+> to be co=
nsidered to be an expression.

Thanks for your clarification.


>>> This should you give what you seemed to want, with pointer->member in =
the
>>> immediately following statement only.
>>
>> Another SmPL script variant can be tried out:
>> @refined_display@
>> expression action;
>> expression * pointer;
>> identifier member;
>> @@
>> *pointer =3D action(...);
>> (
>> <+...
>> *pointer->member
>> ...+>
>> );

How will the software run characteristics evolve further
if it would be dared to apply such a generic source code search pattern
on more files?

Regards,
Markus
