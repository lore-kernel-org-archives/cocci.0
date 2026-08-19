Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECA28C5DF81
	for <cocci@archiver.kernel.org>; Mon, 24 Aug 2026 07:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=n2CrEiwzvWLp6cO8L2iHrpavs6fwUzTI44Aw93gKJUE=;
  b=FT8I6yel7TBrmOZ+8F1buqRS90zzN3H9QZ8uXswTQ3PtdBkXqQ+H+sKM
   VoK05y2IuLYcVIiGhd5Gv7Fhz9Is1HEns0rxREK7k3MG9D9G6WtvY/fdU
   Gvg/MljSnNgjLyjWy1zWUTnm8xLqTF40nr+MOnq8bkUFcJyereTFvxM15
   g=;
X-CSE-ConnectionGUID: dvj8H09DTySWuhMDtfVAug==
X-CSE-MsgGUID: r3xxsrxWTBmpr+XzEl4cCg==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
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
X-IronPort-AV: E=Sophos;i="6.25,240,1779141600"; 
   d="scan'208";a="291206898"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Aug 2026 09:35:07 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 5DD8581696; Mon, 24 Aug 2026 09:35:07 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 8E3528056B
	for <cocci@sympa.inria.fr>; Wed, 19 Aug 2026 20:31:00 +0200 (CEST)
X-CSE-ConnectionGUID: NFIPIRdcRomwSWaSNUOS4Q==
X-CSE-MsgGUID: 1JdIcNg8QyiDikcly9hRgg==
IronPort-SDR: 6a85f660_J4bg0uMinIBJRcY4sqQiyCTlvGcoGGZj0F2tvrh4nCFyIh0
 Mh4oVGhhIVA9p/4Tw4FnrddKnSNlOeKVJO8Ux1A==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HPAQC99YVqgAwR49RaglmCQYFoNAQLSYRYj1KBdIRrh?=
 =?us-ascii?q?zyQT4FVgXwCDwEDAQ1OAQIEAQEBAgSCC4JzjW4CHgcBBDAJDgECBAMCAwEBA?=
 =?us-ascii?q?QEBAQEBAQEBCwEBAQQBAQECAQECBAMBAQEBAhABATsHDjuGTw2CYgGBJIEmA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBHQJHRicEGQEBESYBNAIYDgJeFQEBgn6CIwEGEAEDNwfFD?=
 =?us-ascii?q?H8zgQGCDAEBBoJq138fLCJdgWkJgR8uhXGCURwBBW6FBAGEAoEhD4FVRIE8C?=
 =?us-ascii?q?4tVgmqCJoEMk0OBShwDWSwBVRMXCwcFgWYDgQZuMh2BIz4XNVgbBgWBHYEoh?=
 =?us-ascii?q?DcjGTZ8gQlegSsqYQESF4EJggoCgnCBKlwCAUlFDgkMC209NwkLGQQ9j0Agg?=
 =?us-ascii?q?XOBFT4TgURUlA2zBDQHgjmBaIFmDIkJlmUGEy+XUw6TC5kIo2qFWYFoOoFcM?=
 =?us-ascii?q?xokgzZQAxkPklbLaEUyPQIHAgcOAwuFRAEBjFaBTAEB?=
IronPort-PHdr: A9a23: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
 5cEDLNWBgRd/hYyFUlvWtAPcs8fYw==
IronPort-Data: A9a23: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
 FUI
IronPort-HdrOrdr: A9a23:R5aTZKOsquRQgMBcThmjsMiBIKoaSvp037Dk7TESdfUnSL36qy
 nIpoV86faUskd3ZJhEo7u90ca7Lk80maQFhLX5Xo3NYOCFggeVxehZhOOO/9SKIVybygcy78
 ddWpRfTPvtEFN9kcH22wWgFc08qeP3i5xAyd2+8593JzsaEp2IAj0JcjpymSBNLjV7OQ==
X-Talos-CUID: 9a23:NMhXu242TGzF7aQSAtss0mA1IuEffnbny3LPGHCxMkBUb4bJcArF
X-Talos-MUID: 9a23:YPT0igYBU4KIaOBT7h3gpTpEO5dR8qWCCUMGlYRXu/OLOnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,231,1779141600"; 
   d="scan'208";a="154551224"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDGwJkaDwuL3JrE9cIVWYJGwMw8pSl4Xk4zVLf?=
 =?us-ascii?q?RTitAxBIVJ/1k+VZ8xu0JjVgZ/glpkFQu4qBH0QGoysvlhL/MNPrHphy?=
 =?us-ascii?q?XY8/AVLJ5M9b7lDcPNyvm5Fyhbsfom6ym2H0PBtYRtZeiIC+xBX8EUcD?=
 =?us-ascii?q?tCP27oMMrbS7lkaGZBZD7szQ=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 20:30:57 +0200
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MNfY9-1xL9Wu3RKl-00Lt5Q; Wed, 19
 Aug 2026 20:30:55 +0200
Message-ID: <8e35309f-c87f-4123-a0f3-9fb4195cd8f7@web.de>
Date: Wed, 19 Aug 2026 20:30:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci <cocci@inria.fr>
Content-Language: en-GB, de-DE
Cc: Victor Gambier <victor.gambier@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RVpeRL1zSdZO/kJ/VQ4Rk83V7qA/Ttx8P/32z+vGfja6CjQrXLG
 9CxYg4HtxyJlfujyF7YtzcRyiXEVCSEprXbKmXy4guqVZWzQ/JImvroWnd3c1d6xDqmLmZY
 bRxL9spyqaV4pBjxs22zOFc6wku3eM298o4PnpU/N+hb7sjTL4H7vrH/W3ICbWzqg0hEIB9
 Vq6gEca8qh37BRs/SSVQA==
UI-OutboundReport: notjunk:1;M01:P0:Wz9wgqyaKDs=;aUKsxOD7upbKPbg6w27Fb/1GkuL
 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
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] Building Coccinelle 1.3.2
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3699
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-08/udnZrpJzOiRLE0FYlvD_Yw>

Hello,

I would like to build the software =E2=80=9CCoccinelle 1.3.2=E2=80=9D whic=
h was released yesterday.

Unfortunately, I stumbled on the following information on my openSUSE Tumb=
leweed system.

Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/20160205> LANG=3DC make=
 world
make -C bundles/stdcompat all
make[1]: Entering directory '/home/altes_Heim2/elfring/Projekte/Coccinelle=
/20160205/bundles/stdcompat'
cd stdcompat-current; make && cp *.mli *.cmi *.cmx *.cma *.cmxa *.a *.so .=
.
make[2]: Entering directory '/home/altes_Heim2/elfring/Projekte/Coccinelle=
/20160205/bundles/stdcompat/stdcompat-current'
ocamlfind ocamlopt -c  -bin-annot -no-alias-deps -nolabels -I . -alert -de=
precated stdcompat__format_s.mli -o stdcompat__format_s.cmi
File "stdcompat__format_s.mli", lines 44-50, characters 0-27:
44 | type formatter_out_functions =3D Format.formatter_out_functions =3D
45 |   {
46 |   out_string: string -> int -> int -> unit ;
47 |   out_flush: unit -> unit ;
48 |   out_newline: unit -> unit ;
49 |   out_spaces: int -> unit ;
50 |   out_indent: int -> unit }
Error: This variant or record definition does not match that of type
         Format.formatter_out_functions
       An extra field, out_width, is provided in the original definition.
make[2]: *** [Makefile:1675: stdcompat__format_s.cmi] Error 2
make[2]: Leaving directory '/home/altes_Heim2/elfring/Projekte/Coccinelle/=
20160205/bundles/stdcompat/stdcompat-current'
make[1]: *** [Makefile:3: all] Error 2
make[1]: Leaving directory '/home/altes_Heim2/elfring/Projekte/Coccinelle/=
20160205/bundles/stdcompat'
make: *** [Makefile:533: /home/altes_Heim2/elfring/Projekte/Coccinelle/201=
60205/bundles/stdcompat/stdcompat.cmxa] Error 2


How can questionable software dependencies be resolved?

Regards,
Markus
