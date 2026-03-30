Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14B70FB3CEA
	for <cocci@archiver.kernel.org>; Mon, 30 Mar 2026 09:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Hu3v2Ep9ix0JdestuXutDT3mun1Gt8jjUxJbtKHN4Uk=;
  b=QLajwDYqHP2R1lGI3QQnUgwM5yo1JxUU51Nwtl+RCqPsI2R85cCQN6YN
   pYcEHeU3rB33UfN2OjRODqOVMt1/S/Ca1SVikx6OL/GGCGT4gA8o3uiVv
   EhizLqx0ecjdz5pUQNnWWePs6xR4vDuOTT+yAZJhzU0GSXcnBO5BHRKUq
   k=;
X-CSE-ConnectionGUID: kKiSSMRwRMGi5W1hv6Bbgw==
X-CSE-MsgGUID: IYhMSLBBSHmR4Vy5xAM3vg==
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
X-IronPort-AV: E=Sophos;i="6.23,149,1770591600"; 
   d="scan'208";a="270099381"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Mar 2026 11:38:24 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id A520E81C5C; Mon, 30 Mar 2026 11:38:24 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 118B381C1D
	for <cocci@sympa.inria.fr>; Mon, 30 Mar 2026 11:38:23 +0200 (CEST)
X-CSE-ConnectionGUID: nYLvzJevSOGUrkdrsodyEg==
X-CSE-MsgGUID: MxHt9/hxQ+W1VfoxjRh2qQ==
IronPort-SDR: 69ca448e_YhGUQ0LyAs5Gm9OkZ9V9mZPyI9q81nRBo81cvFs2bJmDSDM
 kS8l1U/lXAX2eZ3/O1l7fuB8AibOCAs5lvknusQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FeBQDgQ8ppgAQP49RagluCP2h9NAQLSYQcPI9TgiSEO?=
 =?us-ascii?q?4c8h1WMSwIPAQMBDU4BAgQBAQMEhQACjSYCHgcBBDUFDQECBAEBAQEDAgMBA?=
 =?us-ascii?q?QEBAQEBAQEBAQsBAQUBAQECAQECBAYBAhABATsHDgoxhk8NgluBLIEmAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBHQJHRAEBAQIBDBcdAQERJwQLCQIaAhgOAgJWGwEBgn6CIwEGE?=
 =?us-ascii?q?AEDDycHmwOcPoEygQGCDAEBBoJp13sfLCJZgWcJgR8vhW6CZgGKbycPgVVEg?=
 =?us-ascii?q?TyCUjE+hENNgw6CaYImgQ6JG4dsUngcA1ksAVUTFwsHBYEjQwOBBiMPPAUtH?=
 =?us-ascii?q?YEjIR0XFR9YGwcFEiEqc4YUeQMuXhoOIgI5XEo+CgFSBYIFAoEgNQIBC209N?=
 =?us-ascii?q?wkLGwQ9jHwpgjWbUK5jNAeCOIFngWQMn20GEy+DcZNhDpMLmQapQYIAIoFcM?=
 =?us-ascii?q?xokgzZPAxkPklTEIkQyPQIHAgcNAwuFRAEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
 G3No9Qor1z0yoGy
IronPort-Data: A9a23:f6KEvKr2HjzfLAnoExpPmWZQdqxeBmIQYRIvgKrLsJaIsI4StFCzt
 garIBnUPK3cZmP9fdh+Yd6z9U1VsJCDyYNhQQplrCgxHi8W9OPIVI+TRqvSF3PLf5ebFCqLz
 O1HN4KedJhsJpP4jk3wWlQ0hSAkjclkfpKlVqicfHw3HVY6IMsYoUoLs/YjhYJ1isSODQqIu
 Nfjy+XSI1bNNwRcawr40Ird7kk01BjOkGlA5AJmPqsT5Aa2e0Q9VfrzG4nhdxMUfaEPRoZWd
 86bpJml82XQ+QsaC9/Nut7Tbk0QT7fOChOFg3xQVrLKqkAqSvsaj87XnNJFAatmo23hc+JZk
 L2hhrTsIesdBZAgrcxGO/Vu/46SCoUdkFPPCSDXXcV+VCQqeVO0qxllJBle0YH1Zo+bqIyBn
 BAVAGllU/yNuw656LSKbvd+pMk9F+7EAZkctmt7yj3IIPlzFPgvQ42SjTNZ9DI3m9wIAvvUI
 cYUAdZtRE6ZOVsVYAhRUc94wI9EhVGnG9FcgHecv6kq+C7+yAJr0b7iGMXYcJqGSK25m27C+
 TqerjWiXEBy2Nq37Cql7iPrhv/23hyiZowVBL+C9qRzuQjGroAUIEZKBQPg8abRZlSFc9lYI
 EcV0jE/qLA7sk2tVNj0GROiyENopTYZXMdMVfI34keBx8I4/jp1GEACfxpfev4rqvQRagEw1
 VOThNTlFBFg5ej9pW2myluCkd+lEQQ4RVLuiAcBShYZpcbuqsc/g3ojr+qP8obk0LUZ+hmqm
 FhmSRTSYZ1O3abnMI3mrDj6b8qE/MShc+LMzly/spiZAvxFiH6NPND4sQOLsp6s3a6YSV+Gp
 zAflqCj0Qz6NrnUzHblaLxVQtmBvq/ZWBWC2wIHN8d7qVyFpSX5FagOu24WGaucGpxUEdMfS
 BWD4VsJjHKSVVP2BZJKj3WZV5xxkPGwSoi8CJg5rLNmO/BMSeNOxwk2DWb44ownuBFEfXgXY
 M/BL5SfHjwBBL55zTG7Ye4Y3PV5jmo93G7fD9SzhRiuzbPUNjbfRKYnIWm+SLkzzJqFhwHJr
 PdZFc+BkCtEXMPEPyL4zI80LHIxF0YdO6zYkcJsW9S4ElJUI115U/716pE9SrNhhJVQx7vp/
 Gnie0p2y2jfpHzgKCesW0BBcr/feItFkmI+NikoIGTw8SMRXqey3ogidr8cX7ouxMp8x9FaE
 tgHfMS8PdpeQ2/56RUwU4LPqq56fhGghAy1ICuuZgYkTaNgXwDk/tzFfBPl0TsnVw6blJIZj
 eW79wX5RZEjeVxTPPzOYqjy82Lr7Gkvpu1iemDpfP9RQRzI26p3IXXTivQXHZk9GS/bzGHH6
 zfMUAYqnsiTkYob69KTuLulqb2uGO5AHkZ3OWnXwLK1FCvC9FqY3o5yf7eUTA/ZSV/L1v2uV
 cdNw9H4Fc83rlJAno5/MrRslIYVxd/koZ1ExQVFQlTPSXmWCY1bH3rX5vkX65VxxYJYtzCmB
 WOJ2N1RYouSNO3fTVU+GQsCb8a4788ypAX81/oPHRjF1HdFx4bfCUR2FDuQuRNZN4pwYd8Ew
 /9+mcs46D6fqxsNM/SgvxB27Wi8C2E6bLUivZQeHb2zoFEZ9XBfU7PhCwvdwpKGW/NTOGYEf
 x6Wg6vjgexH50zgKnAcK1nE7dB/t78v5i9Y6UAkHEuYvObFitsc/gxjwR5uQit7lhx4gv9OY
 E51PEhLFICy1jZPhvkbeVuzGgtEVSarymaox3QnzGTmHlSVDErTJ2gAOMGIzkAT00RYWhN5p
 Li46mLUYQzGTfHL/BkZeBBa8qT4bNlL6Af9ttitHJ2FE7kEcDPVuPKSSlRSmST3I/EapRPhn
 vZrztZSeKegFC83oo8HMae4+4kUaii5ID1lfak80oIPRXrRaROj6wiockqRQP5AF9bO0E2/C
 vFtGP5xagSD5H6OgAw2Va8oCJ1orcEt/+sHK+/KJ3ZZkr6xrQhJkZP39wrijjQVG/FoncIMK
 97SRQmjCU2Vv2NfwEXWnflHO025QNgKXxL91+aL69c0F4oPneVvUEMq2J6mli+xHC542SmLr
 SX/Z6Py5M5z+7RGxofDPP1KOFSpFInVSu+NzjGWj/1PStH+aeH1qAIfrwjcDTR8ZLc+dYx+q
 uWQjYTRwkjAgbcRVlLZkbmnE41ix527fMhTA/LNAEhqpwmwc+6y3EJb4EG9E4JDr/1F7Mr+R
 weYVtq5ReRIZ/hjnk9qewpsODdDLZ/ob5XQhzK39NWNLRk/7TbpDv2a8V3RUGUKURNQZrPfD
 Fb4tc/7s5oc5M5JCQQfDv5rP45gLRWxEeE6ftn2rn+DAnPunlqGvaD4mAE97S3QTEOJC9v+/
 YmPUy2WmM5eY00U5IoxX01OUhwr4LJVhO4tYgQC9tQwhz3S4Kvq6wgCGc1uN32WunWaOFLEi
 PXlc2YoTynwNdiBWQup+8ztB29zGcRXUuoU5VUVE4e8dCq8Qo+NaFekGuGM/F8uEgbeICqbx
 R3yN5E+0tVdAn2keArL2sGGvA==
IronPort-HdrOrdr: A9a23:DzRPKKx6or5qL3SEj9NqKrPwFr1zdoMgy1knxilNoYs8SK2lfh
 uV8sjzuiWetN98YhwdcKm7Scq9qCrnlaKdgrN/AV7BZniFhILAFugL0WKI+Vfd8kPFmtK1rZ
 0QFpRWOZnWAUVijcD8xBO3M/tI+qjizJyV
X-Talos-CUID: 9a23:uaw9SWNMGyT3Wu5DXhhD6lw2F94eVVLg1nTcOVS/BXdER+jA
X-Talos-MUID: 9a23:bIRZ7wWxU1xnakfq/Br8pC0zc8d42ueRUX4DloUEgcneLBUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,149,1770591600"; 
   d="scan'208";a="270099369"
X-MGA-submission: =?us-ascii?q?MDE6NPBwvXxa8bczTi2cBhxC8RnnIa2I0SSUKr?=
 =?us-ascii?q?aEfTAgVI1CEKavbYnNnw7hHf88kAjksPJsBZ16JsVp+6NSqTJOApHYA8?=
 =?us-ascii?q?rRgjN6hMlpnCD2GfIwwJ0WQgiL094XZOkpfZ/2hmfYDsu2hJONK6Kw10?=
 =?us-ascii?q?hMnundAtXMYDkWYUv/ElGxSA=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 11:38:22 +0200
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MTOlk-1vxDTF3K0q-00JWUl for
 <cocci@inria.fr>; Mon, 30 Mar 2026 11:38:21 +0200
Message-ID: <5c3257fb-1e91-46c0-ab00-f105ccb437d4@web.de>
Date: Mon, 30 Mar 2026 11:38:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr
References: <51b9e38a-7e91-4c39-86d1-25da2c6af376@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <51b9e38a-7e91-4c39-86d1-25da2c6af376@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:V5n89stlqTR9LRDiAe8FfXjQE5up51YxbEFWLRbjjQWYoHRGtmG
 Lip+gV0mYao3ECaYGprwWaladgwo8EfAEoEtQYqg2xdveffD7DCMoRx4vl1Ee2UQYPHmKW2
 h2SrXnsU5kiZvEbY/XyCo+CvMroMHGRv8hwFj4ze5VBlJj1kC6weLTbg/Fsf9WgbCHyZqlE
 vIgZ+gm6I4aVAlLnelvoA==
UI-OutboundReport: notjunk:1;M01:P0:/CvH//emHQE=;Ih+mNXLIKUd2w/RIahiO9LnUome
 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
 oqckSaktAEx8ArAQi6Y/
Subject: Re: [cocci] Logical consequences for applications of SmPL
 conjunctions
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3467
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/Fgbg5Vx7eIepvNI5ZEme3Q>

> Are involved subterms as often evaluated as they are specified for such =
SmPL conjunctions?

Will clarifications and development ideas evolve further also according to=
 another
SmPL script variant?


@Example@
@@
(
// X: Check data 1
&
// Y: Adjust data 2
)


Would a source code search start with the selection of entities which shou=
ld be matched?

Which item would you choose for a condition check here?

Is collateral evolution involved then for the specification of SmPL code
in companion branches like =E2=80=9CY=E2=80=9D?


Regards,
Markus
