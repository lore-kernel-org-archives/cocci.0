Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2EEBEB64DD
	for <cocci@archiver.kernel.org>; Tue, 20 Jun 2023 08:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=GDjrKCEilR/Am3ZbjgHvpeka7nImiYPqCPnoVXHOjMg=;
  b=SgHK2JM9QwMUCEmPrrtpR+MGdwp6YzoK7q1CkTEs6i3EWfVGx1n3Onyx
   qfkCUrtkq9gtz+FjdyGlPbs4IxuZrmybMesEz2bmUNQvz64EX0w2wUKk2
   p7HdyAOS5SgHrLIuWE/KA6d7mHa/3qS//1i13t8g/+hAgzVFCCc6g0Xft
   w=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.00,256,1681164000"; 
   d="scan'208";a="113708878"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Jun 2023 10:22:44 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A5A00E03AD; Tue, 20 Jun 2023 10:22:45 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 1C921E03AB
	for <cocci@sympa.inria.fr>; Tue, 20 Jun 2023 10:22:43 +0200 (CEST)
IronPort-SDR: 649161d1_yGJNH3oB3s768ZsOuGzQfCafcaK7AiihRkLLC6Ty8nqwPRj
 gcg3ZlpJljMuuvn46aRCw6md3Wo6OlnbMmTdluA==
X-IPAS-Result: =?us-ascii?q?A0HPBABQYZFkhwQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T4EAQELAYIudQNTMAQLRwiESpEjMYQ2jneIbIMWPg8BAwENPQQBAgQBAQMDA?=
 =?us-ascii?q?YFMP4JqCgKGAAIdBwEEMwYOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECB?=
 =?us-ascii?q?AUBAhABAQEjFwcOECeFaA2CNyIZZIEIAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQECRz8BAgIBIwQZAQERJwQLCw4MAiYCAlcGA?=
 =?us-ascii?q?QwIAQGCegGCJwEDDiMHDQavFH8zgQGCCAEBBoFXQZl2HywiVYFfAwaBFS0Bj?=
 =?us-ascii?q?S6EMScPgVVEgTyCUzE+gmIBA4Feg1uCZ44shWUHgVmJYIEob4EegSJ6AgkCE?=
 =?us-ascii?q?WeBCAhfgXJAAg1VCwtjgRyCUgICEScTFAVNeBsDBwOBBRAvBwQyHgkGCRgYF?=
 =?us-ascii?q?yUGUQctJAkTFUEEg1gKgQw/FQ4RglorNj8bUYIBJQQOAxkrHUACAQtwPTUJC?=
 =?us-ascii?q?x8GJgEeAimBVzBYcApHoA0Dgw5gCFnGUTUHgjCBW4FdDIoTlQkGEy+XFQ4Gk?=
 =?us-ascii?q?i+YGSCNO5pdgXkkgVwzGiSDNk8DGQ+OIBmEDoELjj0/NAIJMAIHAQoBAQMJh?=
 =?us-ascii?q?UYBAYYAAQE?=
IronPort-PHdr: A9a23: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
 EM6S/ZxrlvgnuTdklJa
IronPort-Data: A9a23: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
 D3QFrAc/vR8/32xedsu2w==
IronPort-HdrOrdr: A9a23:z55Zt6zvn+UwhGm5SLG7KrPw8r1zdoMgy1knxilNoG9uA6+lfq
 eV7Y0mPH7P+VAssRQb8uxoV5PufZqxz+8Q3WBVB8bEYOCEggWVxeNZgbcKqgeIc0DDH6xmpM
 JdmsNFaOEYY2IK7/rS3Cn9Nco8y9+a962Sif7Z1GoFd3ARV0gt1WZE4h3wKDwPeOCqP+tDKH
 IWi/Asmwad
X-Talos-CUID: 9a23:Y62pi2OcL718FO5DeQRl8BY9GNwefXTy8zSPG2CHAkZYYejA
X-Talos-MUID: 9a23:EdzZwgjNy3mnctzXURpFqcMpMOk0z6O0OUox0pxF6/OdazFCFi2DpWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.00,256,1681164000"; 
   d="scan'208";a="113708869"
X-MGA-submission: =?us-ascii?q?MDE35JGjT3dLf3Th3yORRaDnPaGeVvj6YGoZe8?=
 =?us-ascii?q?m2/UPD25y1PYM3CXnvGLnw7tioHdrjfPGxTV231zpS08bsAQTDY1Yp0C?=
 =?us-ascii?q?udzYtO4q5YNDhjF45lHvE2lPpAKK8vjuo+XQ0uF5vJm3rhkqZr1imKNi?=
 =?us-ascii?q?Q9p7fo2aMg/f3dVmOOBiUPwg=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 10:22:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1687249362; x=1687854162; i=markus.elfring@web.de;
 bh=GDjrKCEilR/Am3ZbjgHvpeka7nImiYPqCPnoVXHOjMg=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=sjqW5u08oLkbkDrYDNC3p0m0F2emF1mFERM4S1DRKqWSNDGxlHGYRhGMb3xq1GNJrExa/w+
 5O63XKGOhvVi7x66N7+PpNHn0VdTHoeCSsWPmbTeFDqP5219eYNi4SXIlZlSicDAH4X/Ncd6u
 FBS0jxWzRGZEJW24EX3oJihNl0EumJRCZ7GElNhLuc9D5OFzc+Dpu2bp9IruxRmqN0WGBMbkg
 4w8TrPX0GYwke+g6CvXWHY8VBBpY71HC+p+i4rVl8U4M3L/5yNLWDPCNO1R/XxewePQD2UH8o
 +CccENvqb/5CVYrOssmBhOqJ6KqatYUzGC5U24g2BjNQhfKhbh4w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MPKB7-1qRi2R0beP-00PVDo; Tue, 20
 Jun 2023 10:22:42 +0200
Message-ID: <209bec0e-c8c8-7a9f-28c7-f7e1d69b5c66@web.de>
Date: Tue, 20 Jun 2023 10:22:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-GB
To: Eric Wheeler <cocci@lists.ewheeler.net>, cocci@inria.fr
References: <b28e953-86e3-a6bb-fc84-1d2794a81135@ewheeler.net>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <b28e953-86e3-a6bb-fc84-1d2794a81135@ewheeler.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DaX3supm61naYVXNP3RZE5kZiJBDpS9ud6n6rFOPWy1QvTtYwTD
 wf1e6VjMIbCN2/uFLYWRq1scDl29G9Pcy1AS7Nnr3+Djd6CEs8ImF1sTeWDDXxJnruMhzPI
 Ye4IBphb0tPoRoavptkrzGychUyVwRRGxe/+VULkDcI0NAjpqJ5AoIiRMRNRTKreA6fKJjQ
 LDo2DvGEIpY59T45vlt+g==
UI-OutboundReport: notjunk:1;M01:P0:YtsZdBX2Cr8=;6v4NUg/JfAtc50PTzDGYhpsHU9h
 oC6rb36LSOGYdTtX6GlAIixAQxktqoJyxQqLfzNeBbAWCiIQJ4cWkGZH5jJ8e6lWYYQUf22tP
 F+WJVbUB1Cc1rLHVt/mjjUI8X/zXvrIMQQ9MNfFhY3af4/e7SU7Q22m6SMudSZCpTRlbULIQZ
 e6qj2stztb7zCedgJMccjgJ/jwZNuc8+teSoMtzW4dTVcpvB+IK4op2YWF6jjAyTZrsXx+4Ge
 dGMAsOWSTFqcyC31VSPm/Fo4wk21K35ZK0jEgJjKYcp34/ZWrDjwDZuiaUJRgBeQYjeLa+Ec0
 5abKZeM7/Uc10xBPR7OqK2vBVACt7ix01Q7y6K/TpiA7Lb1Y2HWu/F8XMAUXfBbAn8E2v80lB
 Q5RAe9fK5NAmFCnDHLOEO7Z+Lap0zMFNN55+YoHxFZVXCLjyiFe0zXv+z/cRdIWC6iCIY6KYc
 /XNC0WYna7B8s2D2a4ZhilPuqvRoIZW8M2X21vORvUYUPLYFJ2lF7AQuN4Q/5KbHDKLtgGgR4
 ndeVtEFqMiUOohOleQQ/ow0U0D7JCK5yp/iCSZrrPTgoWWAPnO/K8S/eNAIHrTVRc9kDOdTOK
 MIyUuN0Jv1Cas8733nQDo35KlH2tMNA87KxqQD+JPB4tcJx0P0kB7fhrXKqWgyDMuwV6G4us7
 BeqlEibCu5pgiN3jNgLYiDXkdLCYUrUT9H472sanapP/33gpHb2M7XPP3TcrxgnmtHrIPxxsJ
 fmbJX+7iub0FooFgLsXU+hn8KmwIsaMsGsIkyLXVs58WBuuyqZSt15jyXatMf2uvbuyPNc47z
 8mRV9KJq4mRnmSTLbzVz/kir3krbIKGIYcVdceq3BuL6I19eV+Z2Lw4bjqtx5NEiOcKUhhx9t
 aQCuNUNyof1QE9o6rrsBGS81jc0xXNyqc0lq8xfVdVbQEpYkDfi46l1B4pqjM/l2dSbRPy9Oe
 H9ndYg==
Subject: Re: [cocci] Strange spatch behavior while patching an array of
 structs
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1199
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-06/209bec0e-c8c8-7a9f-28c7-f7e1d69b5c66%40web.de>

> @@
> identifier R, X;
> @@
>
> -R->cal[0].X
> +rotor_cal_min(R)->X

Such SmPL code can be adjusted for another attempt to understand
the observed software behaviour better.

@display@
identifier R, X;
@@
*R->cal[0].X


Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> spatch --parse-c=
occi Eric_Wheeler-20230620-show.cocci
=E2=80=A6
@display@
expression _E2_0;
identifier X;
identifier R;
@@


(
*R*->*cal*[*0*]*.*X
|
*R*[*_E2_0*]*.*cal*[*0*]*.*X
)


Grep query
cal


It is presented that a SmPL disjunction is applied here.


> I am confused as to why it matched "rotors[i].cal" at all. It should not
> have matched "rotors[i]" at all, right?

How do you think about to disable the application of the isomorphism =E2=
=80=9Cptr_to_array=E2=80=9D
for your use case?
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/6608e45f85a10c57a3c91=
0154cf049a5df4d98e4/standard.iso#L557
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/6608e45f85a10c57a3c91=
0154cf049a5df4d98e4/docs/manual/cocci_syntax.tex#L67

Regards,
Markus
