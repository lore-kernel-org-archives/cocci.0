Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22000D13588
	for <cocci@archiver.kernel.org>; Mon, 28 Oct 2024 10:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=UZa0wmPKZjG9YoeTmjVnba1ip9HxEQAlk41jsNA7vMw=;
  b=tWrQEE3WCJIU4eIZwsLi/kuWT9zgZHzvzKQPzstFJMq3VGvczB0JM3/2
   vN612bBdR3GJYaslaVHhNYnjzOziKF3U6L+h58QBk9EGGweHfiMVipa9a
   l/C1GZs8mK6Ir7A9R7bgWnt2QazULQ4DglS/c8swqCmnON2uVkIG1tEaj
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
X-IronPort-AV: E=Sophos;i="6.11,239,1725314400"; 
   d="scan'208";a="191030528"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Oct 2024 11:44:30 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 00F2AE0133; Mon, 28 Oct 2024 11:44:29 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 61DE4E00B7
	for <cocci@sympa.inria.fr>; Mon, 28 Oct 2024 11:44:25 +0100 (CET)
IronPort-SDR: 671f6b09_nw3cB8zyBI8+FwVUoSovJ9G3JFiRVWNjKGksBk8WVhB3sX9
 qtnQIFFYUkTJ/OD8dXo+Z/BSAi25NXBZG0CnI4Q==
X-IPAS-Result: =?us-ascii?q?A0ELAACAaR9n/wMP49RaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE/BQEBAQELAYJDB1sbBlQzBAtIhFaIHYcwgXQtA4Q7mASBV?=
 =?us-ascii?q?oF+DwEDAQ09BAECBAEBAwMBhQACiicCHgcBBDAJDgECBAEBAQEDAgMBAQEBA?=
 =?us-ascii?q?QEQAQEFAQEBAgEBAgQGAQKBCggLhTVGDYJiAYEkgSYBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQINOkQBAQECASMdAQERJgEEC?=
 =?us-ascii?q?wsaAiYCAlYGARQBAYJ9AYIvAQMOIwcNBq5sgTKBAYIMAQEGgVhB2EIfLCJXg?=
 =?us-ascii?q?WMDBoEaLgGFaYJiAYYkg0J6Jw+BVUSBPAuCRzE+gmEBAQKBXoNbgmmCVYYSg?=
 =?us-ascii?q?U0lV0ACAgIHAoU4gVlokUNSexwDWTIBVRMXCwcFgSsmLgOEblt/gTuBUwFGg?=
 =?us-ascii?q?mZKg0ccgUU4SYJNaUs6Ag0CNoIkJFmCUIElBAWDOoI2HUACAQttPTUJCxsGP?=
 =?us-ascii?q?ZtQR4JGgQEaEyyBRQtPKTKSZ49soms0B4I4gWWBYwyKJ5UuBhMvlz8OBpJ4m?=
 =?us-ascii?q?HcijVybI4FnPYFZMxokgzZSCw4PjiGDejOBC8sKQjUCCTACBwEKAQEDCYVGA?=
 =?us-ascii?q?QGKR4FLAQE?=
IronPort-PHdr: A9a23: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
 UNg/A==
IronPort-Data: A9a23:3ADV0aPUyFBLSsfvrR1jlsFynXyQoLVcMsEvi/4bfWQNrUol3jwOm
 jMWWGuAPa2NYWPwKYola9y2p0wP75/Sx9JlHHM5pCpnJ55ogZqcVI7Bdi8cHAvLc5adFBo/h
 yk6QoOdRCzhZiaE/n9BCpC48T8mk/vgqoPUUIbsIjp2SRJvVBAvgBdin/9RqoNziLBVOSvU0
 T/Ji5OZYQbNNwJcaDpOt/vb8kM35pwehRtB1rAATaAT1LPhvyJNZH4vDfnZB2f1RIBSAtm7S
 47rpF1u1j6xE78FU7tJo56jGqE4aua60Tum1hK6b5Ofbi1q/UTe5EqU2M00Mi+7gx3R9zx4J
 U4kWZaYEW/FNYWU8AgRvoUx/4iT8sSq9ZeeSUVTv/B/wGXoWmvLk/cxEHg9OL8myPlIUF522
 cEXfWVlghCr34pawZq+TfRwwNsuJo/nMevzuFk6lGufV6x5B8meBf6iCdxwhF/cguhrFOzde
 tFfRD5hdhXGbDVQN11RBJ9WcOKA3yimK2YA9QjMzUYxyyuN11Fq4IPkC/jce/WAGcsEnUuil
 kuTqgwVBTlfbrRz0wGt+XWnje7nhjL+QItUFbui9/csjkf77mgaFxQSUXOpoPyzkEf4WtRFK
 kVS9DBGhbY9/UmhT9Tndw+5pXSet1gdXcBRGqs08mmwJrH85gGEGi4bQzQHZNFOWNIKeAHGH
 2Shx7vBbQGDepXMIZ4w3u78Qe+aUcTUEYMDWcPAZQ4C/sWlv4w5yB7CJjqm/GhZkfWtcQwcA
 RjTxMT9u1nXpdEG3eO38DgrRhqy84PRQFddChr/BwqYA8AQWGJhT5Ol4x7X4J6s6Wpfokap5
 BA5piRV0AzC4VxhWsBArCXh0YxFP8q4DQA=
IronPort-HdrOrdr: A9a23:Ag/x3KxSDtX6Evxf+EW5KrPw+L1zdoMgy1knxilNoNJuA66lfr
 OV7ZAmPHjP+U4ssRAb6Km90cy7Kk80mqQb3WB8B8bEYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 pdmupFebjN5DNB7foSjjPIcOoI/PnC1ry0juHDyHpXQRhtcLwI1XYFNu/WKCxLrBItP+tDKH
 Nw3Ls8m9IqFE58UviG
X-Talos-CUID: 9a23:CRXYyW1IDr+8id1F79pEc7xfNOk1VS3fk2vpKEqKN1R2d+yqcXOt9/Yx
X-Talos-MUID: 9a23:WVJzfwjQOnYWpfz1IFfYRMMpd5lzvr+eM0k2s5wHksPYO31zNg2tpWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,239,1725314400"; 
   d="scan'208";a="191030521"
X-MGA-submission: =?us-ascii?q?MDGzNJZPpvEzDtHB+qvupGqnxYlNuoDFk6FBCy?=
 =?us-ascii?q?0Og8lDeZbz8Z0DBSjQu8LrG/z3yug8dAfHJNsqwkvy9Ai88sq/Ab9Nqi?=
 =?us-ascii?q?ReCZc+73IgxKCYBtWRykHjC2j/Mp8qs81orUzjF9J7L6DJ50gSdgO1o6?=
 =?us-ascii?q?omCJ6qZqPKVkAoHcTODeeaTw=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 11:44:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1730112254; x=1730717054; i=markus.elfring@web.de;
	bh=UZa0wmPKZjG9YoeTmjVnba1ip9HxEQAlk41jsNA7vMw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=F5tFYONBQEo+AAUaRw0uxuTNI81dHBrM2p4Ko+uR8/3Yk8dNnEZ5MPdwbm/shRF3
	 hVnQXzf1PyOaawzr8S4kQmb7VETsgpA1yTZMJoo/MO1kJTheZDz69kgApnQuwBZpR
	 VWZNINX+kMFMsq6nSke/vVvtIneznBnDg6edbKCfuxjqbO3kjg1DdGvhYmrU0etg9
	 IVLFaSYMGxC7AgUAsKToKjqTWUNhmxtCD+HVRoXfuBAzGWWjqWrgQQNY0OB4MgLcE
	 Vcwa1Rhcr4la2WwzJP3kl+T36QUzYqJJbeoZ9v8PGrmsHdgZeS5c3I54lo4n28nfl
	 QgnCZ7N2Zk4TQAheHw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N7gbW-1u04J20TIY-00u7B9; Mon, 28
 Oct 2024 11:44:14 +0100
Message-ID: <2ff4043a-8b5f-4781-8026-84e21682fbe5@web.de>
Date: Mon, 28 Oct 2024 11:44:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: "Derek M. Jones" <derek@knosof.co.uk>,
 Victor Gambier <victor.gambier@inria.fr>
References: <11e0e0d6-a20f-4740-adb0-2f72b79df5e8@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241646040.3352@hadrien>
 <de874a79-09cd-49cd-bfe4-b5efff4b7e57@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241728210.3352@hadrien>
 <4872cc2f-3ca3-4bfe-b48a-ebbe5ab8a534@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241736480.3352@hadrien>
 <3d11c8fb-6503-4a29-8889-03a91ca14088@knosof.co.uk>
 <6534a8d0-78e8-48ef-b80c-a9fd3b80f562@knosof.co.uk>
 <ce176aaa-4ce2-4cd3-a943-527724957f9c@web.de>
 <d32d5bc4-3299-4977-bb0a-a3b0a53c829e@knosof.co.uk>
 <582c1098-213f-4c6f-ab35-4a7fb508c2a6@web.de>
 <7f8568d6-4405-4c7e-8dd0-90f140db8dd8@web.de>
 <alpine.DEB.2.22.394.2410271429560.3498@hadrien>
 <80d4b3c8-f29d-466e-b9e2-15f2c78a2f74@web.de>
 <alpine.DEB.2.22.394.2410271803580.3498@hadrien>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2410271803580.3498@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eFr7ETfX1T7QF6/cAt6hApDxN2Pyv1M5NbAd7sZxGBruAlAsFxa
 w+DpsSNW2blZewtQ5XK6AdHexKd4k83/USPChVmQBiFXX7gtnud6ZgipYq94mDN5dNCpGsT
 dPHJ1Cu+EsFHB4KQVwrp8NXU/BH602yuW32KseSKLeW/fVFxKq+ZrrhDCHCFUQkb2pw9bkf
 sQhwPWoI5j8TW1dfZo6+w==
UI-OutboundReport: notjunk:1;M01:P0:Wylt8WwUQtc=;k8xgRXguyJYWQFmZm3LdXUIPgG3
 aALYkzXhdx2HyMYV6L2STSEsYo938hVA/ZungfBr5tcwdVXwxi5gOZ0PvYAcE4Mt/ozs6U6fe
 o/ZYtxCVK+WeD4qDrHBAXCilC7cbIo3SRtr/emHRzIWWEqKv6e36ADk9oJ5dv03p5p8YjPrQZ
 kXM29lU1wScpFGEeeG+czJdu92OsPMw98y8PSag0Gque876X17vqnL/HmYwSEMR+FYhkz2yyl
 uxZFsB7i68dXLOu4cqJVnVmEKw/nmVah1Pf+J3CZ/c4uQmb6/3AUVg38g/RYT4pM/IFVSZpiJ
 tioVJZ3obHrWYGb/xsICMLnWJi1dG/MtzE77+OTw2cdWlmqC0yHmPgi/NiN0fviE/ScMeMQrP
 ChjgQexViZvIsVwJuCXPUlQNQ8CuVcLckpASowu0Nzl/rh+zGHKkLgLl6aBnt6Kew430/TKqd
 sQycEoSiVg1mL63/jSyw880l1VbUb/dKBWxP7Xvnwh+DNoVHtBS4KBms3KxJyUhT8TIAX9mTX
 7fNHXnB2ShTRmB929PvIDEsGdDcNhuv61ZttvnFXReVFywEkUYV9gunGxy0z1Zj0iLgXT9MRD
 uCwuCri+lOidC6TyNreE6VWrZBHbJHxuoqrlp8v6dIT5Y6DBuP8jrV111euNQTzfmBYBCd/qS
 FCg08nH20EHq6MLtxpFx7ZGAGH7qI3oIWUSWNtPw4jc3qV41fs4hXrzEHQH5rwFmEdIKbPuir
 SA0sYPZPANW9qStYQukC3ud4MrSsufYSQIkZRKMicthRe7VWCexm6Ts0Kek8OMeYYYcGA+p/D
 tLHewVCDckHxqu5TqsM3i/zQ==
Subject: Re: [cocci] Broken code block size determination in function
 implementations
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1956
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-10/2ff4043a-8b5f-4781-8026-84e21682fbe5%40web.de>

> I guess the problem is that EARLY_PCI_OP is not recognized as a declarer=
 name,
> and so a parse error is found,

There are probably other data processing challenges involved.


> causing the macro to be expanded.
Would we usually like to analyse (and eventually transform) unexpanded sou=
rce code?
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/7bc8a7acf4673a3143cae=
7aa00ef9374c9fdf893/docs/manual/introduction.tex#L1
https://github.com/coccinelle/coccinelle/blob/7bc8a7acf4673a3143cae7aa00ef=
9374c9fdf893/docs/manual/introduction.tex#L1

Do you find the following data representations helpful
also for further clarifications and development considerations?

Another example script for the semantic patch language:
@initialize:python@
@@
import sys

def show_data(places):
   for place in places:
      sys.stdout.write("|".join([place.current_element,
                                 str(int(place.current_element_line_end) -=
 int(place.line) - 1),
                                 place.file,
                                 place.line,
                                 str(int(place.column) + 1)
                                ]))
      sys.stdout.write("\n")

@searching@
identifier f;
position p;
@@
 f(...)
 {@p
 ...
 }

@script:python presenting@
place << searching.p;
@@
show_data(place)



Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> time spatch -=
-profile =E2=80=A6/Projekte/Coccinelle/janitor/list_curly_bracket_position=
s_for_function_implementations5.cocci arch/sh/drivers/pci/common.c
=E2=80=A6
early_read_config_byte|3|arch/sh/drivers/pci/common.c|36|1
early_read_config_dword|3|arch/sh/drivers/pci/common.c|36|1
early_read_config_word|3|arch/sh/drivers/pci/common.c|36|1
early_write_config_byte|3|arch/sh/drivers/pci/common.c|36|1
early_write_config_dword|3|arch/sh/drivers/pci/common.c|36|1
early_write_config_word|3|arch/sh/drivers/pci/common.c|36|1
fake_pci_dev|17|arch/sh/drivers/pci/common.c|13|1
pci_is_66mhz_capable|35|arch/sh/drivers/pci/common.c|51|1
pcibios_enable_err|5|arch/sh/drivers/pci/common.c|90|1
pcibios_enable_serr|5|arch/sh/drivers/pci/common.c|99|1
pcibios_enable_timers|7|arch/sh/drivers/pci/common.c|108|1
pcibios_handle_status_errors|34|arch/sh/drivers/pci/common.c|125|1
=2D--------------------
profiling result
=E2=80=A6
Rule searching                           : 0.003574 sec          1 count
=E2=80=A6
real    0m0,229s
user    0m0,179s
sys     0m0,050s
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> time spatch -=
-profile =E2=80=A6/Projekte/Coccinelle/janitor/list_curly_bracket_position=
s_for_function_implementations6.cocci arch/sh/drivers/pci/common.c
=E2=80=A6
profiling result
=E2=80=A6
Rule searching                           : 0.012334 sec          1 count
=E2=80=A6
real    0m0,263s
user    0m0,194s
sys     0m0,042s


Regards,
Markus
