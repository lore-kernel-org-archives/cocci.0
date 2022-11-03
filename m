Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCB17C4332F
	for <cocci@archiver.kernel.org>; Thu,  3 Nov 2022 13:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=um7Iw5z7GjkfIzI9jpeyXKvObTvN3FXFQHDep34E7cY=;
  b=fs6iviWCGl4j9lh9YvX14VFSEdwp+RjuoXBX1qYqXPUkohQV88e+5r+L
   /zXlFeRhNcS4MONckLfaFd70Fhulr6GQoaoy23ccTGBKZCjC/E2UXy87I
   391NouqBpgkI0RscPGGcqSB1L1kXgFZ2cq1KFQzoZTLaVY+I332euHiFi
   A=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.96,235,1665439200"; 
   d="scan'208";a="72824595"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Nov 2022 14:08:06 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E4BA6E738B; Thu,  3 Nov 2022 14:08:05 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 7670BE7385
	for <cocci@sympa.inria.fr>; Thu,  3 Nov 2022 14:08:02 +0100 (CET)
IronPort-SDR: 6363bd32_XFEteaupBMoKzRvAxbZiG8L9ZeRc8vrAiN/IU/pIb/U/phl
 cevZzyEXmSd1JRTBYf85kuhexvTXLoF1ebaZpiw==
X-IPAS-Result: =?us-ascii?q?A0BoBQC7vGNjhw4P49RaHgEBCxIMQIN8gQEDUy4EC0WET?=
 =?us-ascii?q?pBsMYQojkmMMg8BAwENOwYBAgQBAYRARQKEeQIdBwEENBMBAgQBAQEBAwIDA?=
 =?us-ascii?q?QEBAQEBAwEBBQEBAQIBAQIEBAETAQEBGQkXBw4QBSKFaA2CNSkBg2QBAgIBI?=
 =?us-ascii?q?x0BAREnDwsaAiYCAlcGAQwIAQGCeQGCbAEDDSMHDKsHgTKBAYIIAQEGgmGVM?=
 =?us-ascii?q?R8sIlOBXQMGgREsjE4JhCcnEIFVRIE8gwM+gmICAoFeg1eCZo8Bh18mBA4DG?=
 =?us-ascii?q?SsdQAIBC20DCkwbMScOCR8cCgQXDQUGEgMgbgUKNw8oL2crHBsHgQwqKBUDB?=
 =?us-ascii?q?AQDAgYTAyACDSkxFAQpEw0rByNxCQIDImUFAwMEKCwDCSEfBxYRJDwHVzoBB?=
 =?us-ascii?q?AMCECI6BgMJAwIiWHMCLxEVBQMNFyUIBU0ECDoCBQZSEgIKEQMSDwYmRw5KP?=
 =?us-ascii?q?jkWBid5Dw4UA2CBcAY1mCyDUyACWYEkwkg0B4IegUyBTAyJcpRwBhMulmwOB?=
 =?us-ascii?q?pIUly8gjSOWDIQogXkjgVszGiSDNhM8AxkPjiAZg1kziixANDsCBwEKAQEDC?=
 =?us-ascii?q?YVHAQGEdQEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 D3QFrAc/vR8/32xedsu2w==
IronPort-HdrOrdr: A9a23:ZeW88a629kamR8EGlwPXwBbXdLJyesId70hD6qkDc20wTiX+rb
 HWoB17726TtN91YhodcL+7V5VoLUmslqKdpLNhWotKPzOJhILLFu1fBOLZqlWMJ8S9zJ856U
 4KSchD4bPLfDpHpPrbpC+lDt0n3N6Ly6ywg/zCpk0dNz2CJ5sA0+9jYDzranGeqTM2fqbQn/
 enjPZ6mw==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,235,1665439200"; 
   d="scan'208";a="72824563"
X-MGA-submission: =?us-ascii?q?MDHW0SG7Yu5oCZZaQqV6zlTPboMckrtHv8+rHR?=
 =?us-ascii?q?7i3mr9Zqrha7beYqpaf82zqQrMITxRX4Z0W/JB8j6ptSgxzQJ9R59PWe?=
 =?us-ascii?q?JddOPTJih4mr/6K8hUFqiTnUGX2wrUgTOjJKDQR05iovN8j6ATgu0Eo5?=
 =?us-ascii?q?PXmK88+5/iiq4zhOVTC2K2vQ=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 14:08:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1667480879; bh=um7Iw5z7GjkfIzI9jpeyXKvObTvN3FXFQHDep34E7cY=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:In-Reply-To;
	b=GVVQ1k2ixcHslDIWH+2kd1eOOui5fNdDe1kAvIrDWx9ibFY/53zifhdzjWrSO9MlN
	 sKKE9u7WIlGJHp9GKeGqlokIbmQpjDAGaGzQxLZj7V3vjIyt+XB2c1pPMaF82MzCWx
	 hmV4dRMufLW9VwNrQByo5HGXK1zbowklVFMhewCFJH7eqq9sCkM83tHkKAkcmwRgTs
	 54K765ezVm0q6YxPb+F188w2B8R192rtppU8tfTKmj+wwy8Rk+RUat7eUl/QZ6pqg3
	 Biymlook61s86+Ztr2+8PhVrjQHxlAkuC9NeAff5RxHds+Pb51Kor/E92oNU7hBmYJ
	 zETRfRfIK56yA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MlsON-1pFyvs2NYR-00j29t; Thu, 03
 Nov 2022 14:07:59 +0100
Message-ID: <bac05976-cacf-1a2b-a1d0-712dbad725f1@web.de>
Date: Thu, 3 Nov 2022 14:07:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr, Sebastiano Miano <mianosebastiano@gmail.com>
References: <CAMENy5qK-KB1_D-zgh=UyLarKVaup-J0yRdZwTL-fkyn_gQhJg@mail.gmail.com>
 <1b150ca0-402b-9b1a-7a47-da1a118d61d7@web.de>
Content-Language: en-GB
In-Reply-To: <1b150ca0-402b-9b1a-7a47-da1a118d61d7@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wtLgVnd8Un9J2FfhTICdSGBKh+Pp+D+y3GHVy9vDOQLpkL0U9Xm
 /gLca2qXXPchKSHQuzSKKgJMA3M9SZdS5yAs2Ig9NW2rtC45Siz1Yajh2RuquGSX8NPc2Rg
 Ytbuc3zKws4mv1qocpSU+G8dV8piGfKju4n15RDeKY73XS7WjtwbG8i0ryoRRWhbWYWiSC9
 akYMPnKubPDmhpjr/AIlQ==
UI-OutboundReport: notjunk:1;M01:P0:tbJeiEQCm0c=;nzbjk0I0CnMJ4ua80ieWE7Qi4xe
 wBcJNYAmBYoJeqv9FnppvrFbVSViBLdAwkzpdcaS0844rn/c+dKbgCo74xHr85jTHKMMX93LO
 2kGXt7d6WUPRjZRpPoLYBEd+pdG0upWxV5BaBif06QMHPQgLOeoEyo0rDH2z0CCg/kynqwFnp
 C5ZHOqbccvlAx6h9ZnuUnMwSeCVPYgSCwCJXpsk5LKfcFkRErbxOVfQOQ4H2p9ASn6aIoSdL0
 LHznhd7cb0UR4FOZ34ofom7Ya/RvXdv4IR37E2setV0lw1c/U7cIBr+rXKMwMl5yvy/w9Nhuj
 UR8Ogs/UKV3KvSIc1AJcWt/MVxM8fCNLGghPeL+V20QJkRLkYUKC0MxOVkURvAPgDQHYAHKyr
 ow5nNuyMZ1B0cPdIO2qrBBlHMgsnchYwj2hQjZVk1QgGf8KFEp4OZVcIL7NUW0ZR4+Vbhh2Cy
 VBAOKMJrsWVrQ6oEkEcu+e/7rnIoHLBBGx2fNxbIfzip4uVinH1ml/oq/UId00zNr6dmDQ1qN
 KW3mm7gPTluj45V6BksO+P6msvvffx/oZdjXuSJ6YYdDTCEnE4zCsViA865IZ2DHTVG8f9E2F
 pv7NX0VG67llL6DFynv7CXpzHsZLwy7TPmn8ENcUnJoeqx3UUEXP353czXZdylCUG9sR6NAux
 3DQaFiOrdJp7eZhmYxmLazkvHwZFJGD89oaD2idA/uzKqc8fjgXI0rjnvUgwnwfcNphFCep8x
 LaLgX3I/e9Qxz8CzHXDr1P2GCY7b+QgzzB2vismfI2inQ9F+z5VqlJR7IR2sWMzMUnV/skn1Q
 tCsngGfo7yyrgKvm7Om2d8YeLo/gRgHayM0s5CuRMcebOnB/v9v9XCtbIlXztd7EUaS0p4p2y
 aqjlGuXgakc0IFvF5aLNneDNXs5j/96GCqCVX67xoRX1fQgIesrzLfFEum22X00zK0Z53Z+TH
 AKV/yg==
Subject: Re: [cocci] Replace custom function multiple times
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 709
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-11/bac05976-cacf-1a2b-a1d0-712dbad725f1%40web.de>

>> Any ideas on how to solve this issue?
> How do you think about to use the following SmPL rule variants instead?

I got the impression that the usage of position variables can have desirab=
le
data processing effects for the safer evaluation of some SmPL rules.

See also previous clarification approaches:
2016-10-26
Propagating values back from Python script to SmPL rule with other metavar=
iable
type than =E2=80=9Cidentifier=E2=80=9D
https://github.com/coccinelle/coccinelle/issues/86#issuecomment-256453084


Thus I tried another SmPL script variant out.

@initialize:python@
@@
import os

@searching@
position pos;
expression path, fn;
@@
=C2=A0MERGE_FUNCTION_OPENED@pos(path, fn, ...);

@script:python generation@
pos << searching.pos;
path << searching.path;
fn << searching.fn;
new_fn;
include_name;
@@
coccinelle.new_fn =3D cocci.make_expr(fn.strip('\"'))
pre, ext =3D os.path.splitext(path.strip('\"'))
coccinelle.include_name =3D cocci.make_ident("\n#include \"%s.h\"" % (pre)=
)

@replacement@
position searching.pos;
expression searching.path, searching.fn, generation.new_fn;
@@
-MERGE_FUNCTION_OPENED@pos
+new_fn
=C2=A0(
- path, fn,
=C2=A0 ...
=C2=A0);

@addition depends on replacement@
identifier generation.include_name;
@@
=C2=A0#include <...>
+include_name


Will interests grow for remaining development concerns (also according to
the construction of preprocessor directives)?

Regards,
Markus
