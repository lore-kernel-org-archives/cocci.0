Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF15DC77B73
	for <cocci@archiver.kernel.org>; Tue,  6 Jun 2023 16:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=L782aKjy7tqeUcBdWoXgKanPZDdetcFuDD2WpmCvPRE=;
  b=FNTOXcAAAnQZt4bGzfQq/d+KdwW9oRTiQyFXgwjyI+qBlTbi+ZaJYXQT
   lD4jkrZSf5U9jqQxrrhfXrH7aKbZK2n2+VsrkXsyl3yoRWRS2A/S+s40n
   se5egEqkG8obdujE00GaF3eNfyeI3ZcwW7MQyqO1LKiYgoN5Jyz1GVjVi
   o=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
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
X-IronPort-AV: E=Sophos;i="6.00,221,1681164000"; 
   d="scan'208";a="111556697"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Jun 2023 18:20:06 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 758ABE0CCC; Tue,  6 Jun 2023 18:20:07 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 293DFE0094
	for <cocci@sympa.inria.fr>; Tue,  6 Jun 2023 08:14:30 +0200 (CEST)
IronPort-SDR: 647ecec5_Zf0osmth1/x/y3bN7+omJxbSsrQjHpHDY+Hqa3uZdkTkWg9
 j0a2CwxY3o7M/sPR3+g/26oSCKqxuPY7zHPca/w==
X-IPAS-Result: =?us-ascii?q?A0HjCQDyzX5kkDKmJMJaHQEBPAEFBQECAQkBgWaBRQJmb?=
 =?us-ascii?q?wYDVC8HCIUZkVqEIpp2PggHAQMBDRQCERIJAgQBAQMEimICHgYBBDQTAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAUBAhABAQEBAQEgHhAOJ4VoDYI3I?=
 =?us-ascii?q?hlkgQgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBARICDYEiBIEvAgRoCAEBgnoBg?=
 =?us-ascii?q?lwHAQyecY8dfzOBAYR2mmqBFUMKBoFAAgEBh2eKHhs/gU6BPIJTAQGJDIJnB?=
 =?us-ascii?q?IwIgi+NWGaBKW+BHoEjfwIJAhFngQoIYIF0QAINVQsLZYEeglUCAhE8FAVMe?=
 =?us-ascii?q?yADBwQCgQUQLwcEMigGCRgwJwZTBy0kCRMVQgSDXQqBEkIVERGBcwQOAxkrH?=
 =?us-ascii?q?TYKAgELcD01CQsfBiYhggGBfEidIAOBekM+gUFoC4QQoG8Ojn2RfoIdgXUFg?=
 =?us-ascii?q?ViEbIMpggmVCQYTL4FKlV2KZ4dGmBGNWppagXojLoEuTScRgyNOAxkPjjmDW?=
 =?us-ascii?q?497QG4CBwsBAQMJhUiFfgEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:Qle9/qP1IB23EMBcTtyjsMiBIKoaSvp037BZ7TEVdfU1SKGlfq
 +V88jzuSWVtN9zYh8dcLK7VJVoKEm0nfUe3WB7B8bAYOCJghrLEGgv1+rf/wE=
X-Talos-CUID: =?us-ascii?q?9a23=3AGAPDHmivlRwVYeKjVYsInpVTvDJuSib2703CDn+?=
 =?us-ascii?q?CBkl2QpmYRFSP//M/nJ87?=
X-Talos-MUID: 9a23:njfligbTVBV/hOBTvA3+x2p5Mt9S34v2Eho0y4UdoJbaDHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.00,219,1681164000"; 
   d="scan'208";a="57939824"
X-MGA-submission: =?us-ascii?q?MDEUg4oQ+C065SgSLUIIRlmFYIXRrHpyB6RC6K?=
 =?us-ascii?q?sv7ZC4sHRCh9qT9lvF/9LgcYUILGAP0bK5lj0CcCCa4PHZVd7XKdUG+3?=
 =?us-ascii?q?e8VpufOHlbYZkPnDXQ9cxbOHP+GPzvOwkex6HHw3iEYgXsaKgO3XNK/V?=
 =?us-ascii?q?yACNKDlmlHiM4O33XtVCR6wQ=3D=3D?=
Received: from ouvsmtp1.octopuce.fr ([194.36.166.50])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 08:14:30 +0200
Received: from panel.vitry.ouvaton.coop (unknown [194.36.166.20])
	by ouvsmtp1.octopuce.fr (Postfix) with ESMTPS id 55EED140
	for <cocci@inria.fr>; Tue,  6 Jun 2023 08:14:28 +0200 (CEST)
Received: from [192.168.0.151] (unknown [83.159.33.34])
	by panel.vitry.ouvaton.coop (Postfix) with ESMTPSA id 13FC75E1BC2
	for <cocci@inria.fr>; Tue,  6 Jun 2023 08:14:28 +0200 (CEST)
Content-Type: multipart/mixed; boundary="------------m0T0mv99YibVe9lJzVeaPpju"
Message-ID: <5ac0affb-f517-7caa-d622-3b11acc96c7d@droneaud.fr>
Date: Tue, 6 Jun 2023 08:14:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
From: Yann Droneaud <yann@droneaud.fr>
To: cocci@inria.fr
Content-Language: fr-FR, en-US, en-GB
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] Matching the size of an array
Reply-To: Yann Droneaud <yann@droneaud.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1169
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-06/5ac0affb-f517-7caa-d622-3b11acc96c7d%40droneaud.fr>

This is a multi-part message in MIME format.
--------------m0T0mv99YibVe9lJzVeaPpju
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I've managed to use coccinelle to replace something like:

char array[123]

snprintf(array, 123, ...);

with:

#define SNPRINTF(array, fmt, ...) snprintf(array, sizeof(array), fmt, ## 
__VA_ARGS__)

char array[123];

SNPRINTF(array, ...)

The difficult part for me was to figure how to match array and size within
structures, part of typedef or not, anonymous or not, accessed through 
pointer
or not.

And I'm not proud of SmPL I wrote. See the attached monster.

I'm sure I've missed some ways to use simpler constructs.

The example can be found here, with the test case:

https://gitlab.com/ydroneaud/snprintf.cocci/

I hope someone could give some hints to simplify my mess.

Regards

-- 
Yann Droneaud

--------------m0T0mv99YibVe9lJzVeaPpju
Content-Type: text/plain; charset=UTF-8; name="SNPRINTF.cocci"
Content-Disposition: attachment; filename="SNPRINTF.cocci"
Content-Transfer-Encoding: base64

QEAKZXhwcmVzc2lvbiBEU1Q7CkBACi0gc25wcmludGYoRFNULCBzaXplb2YoRFNUKSwKKyBT
TlBSSU5URihEU1QsCiAgLi4uKTsKCi8vIG1hdGNoIGFuIGFycmF5IGRlY2xhcmVkIGFzIGEg
dmFyaWFibGUKQGFzX3ZhcmlhYmxlQAppZGVudGlmaWVyIERTVDsKZXhwcmVzc2lvbiBEU1RT
SVpFOwpAQAooCiAgY2hhciBEU1RbRFNUU0laRV07CnwKICBjaGFyIERTVFtEU1RTSVpFXSA9
IC4uLjsKKQoKQEAKaWRlbnRpZmllciBhc192YXJpYWJsZS5EU1Q7CmV4cHJlc3Npb24gYXNf
dmFyaWFibGUuRFNUU0laRTsKQEAKLSBzbnByaW50ZihEU1QsIERTVFNJWkUsCisgU05QUklO
VEYoRFNULAogIC4uLik7CgovLyBtYXRjaCBhIHN0cnVjdHVyZQpAaW5fc3RydWN0QAppZGVu
dGlmaWVyIFNUUlVDVDsKaWRlbnRpZmllciBEU1Q7CmV4cHJlc3Npb24gRFNUU0laRTsKQEAK
ICBzdHJ1Y3QgU1RSVUNUIHsKICAgICAgLi4uCiAgICAgIGNoYXIgRFNUW0RTVFNJWkVdOwog
ICAgICAuLi4KICB9CgpAQAppZGVudGlmaWVyIGluX3N0cnVjdC5TVFJVQ1Q7CnN0cnVjdCBT
VFJVQ1QgVkFSOwppZGVudGlmaWVyIGluX3N0cnVjdC5EU1Q7CmV4cHJlc3Npb24gaW5fc3Ry
dWN0LkRTVFNJWkU7CkBACi0gc25wcmludGYoVkFSLkRTVCwgRFNUU0laRSwKKyBTTlBSSU5U
RihWQVIuRFNULAogIC4uLik7CgpAQAppZGVudGlmaWVyIGluX3N0cnVjdC5TVFJVQ1Q7CnN0
cnVjdCBTVFJVQ1QgKlBUUjsKaWRlbnRpZmllciBpbl9zdHJ1Y3QuRFNUOwpleHByZXNzaW9u
IGluX3N0cnVjdC5EU1RTSVpFOwpAQAotIHNucHJpbnRmKFBUUi0+RFNULCBEU1RTSVpFLAor
IFNOUFJJTlRGKFBUUi0+RFNULAogIC4uLik7CgovLyBtYXRjaCBhIHN0cnVjdHVyZSB1c2Vk
IHRvIGRlY2xhcmUgYSBuZXcgdHlwZQpAYXNfdHlwZWRlZkAKaWRlbnRpZmllciBpbl9zdHJ1
Y3QuU1RSVUNUOwp0eXBlIFRZUEU7CkBACiAgdHlwZWRlZiBzdHJ1Y3QgU1RSVUNUIFRZUEU7
CgpAQAp0eXBlIGFzX3R5cGVkZWYuVFlQRTsKVFlQRSBWQVI7CmlkZW50aWZpZXIgaW5fc3Ry
dWN0LkRTVDsKZXhwcmVzc2lvbiBpbl9zdHJ1Y3QuRFNUU0laRTsKQEAKLSBzbnByaW50ZihW
QVIuRFNULCBEU1RTSVpFLAorIFNOUFJJTlRGKFZBUi5EU1QsCiAgLi4uKTsKCkBACnR5cGUg
YXNfdHlwZWRlZi5UWVBFOwpUWVBFICpQVFI7CmlkZW50aWZpZXIgaW5fc3RydWN0LkRTVDsK
ZXhwcmVzc2lvbiBpbl9zdHJ1Y3QuRFNUU0laRTsKQEAKLSBzbnByaW50ZihQVFItPkRTVCwg
RFNUU0laRSwKKyBTTlBSSU5URihQVFItPkRTVCwKICAuLi4pOwoKLy8gbWF0Y2ggYW4gYW5v
bnltb3VzIHN0cnVjdHVyZSB1c2VkIHRvIGRlY2xhcmUgYSBuZXcgdHlwZQpAaW5fYW5vbl90
eXBlZGVmQAppZGVudGlmaWVyIERTVDsKZXhwcmVzc2lvbiBEU1RTSVpFOwp0eXBlIFRZUEU7
CkBACiAgdHlwZWRlZiBzdHJ1Y3QKICB7CiAgLi4uCiAgY2hhciBEU1RbRFNUU0laRV07CiAg
Li4uCiAgfSBUWVBFOwoKQEAKdHlwZSBpbl9hbm9uX3R5cGVkZWYuVFlQRTsKVFlQRSBWQVI7
CmlkZW50aWZpZXIgaW5fYW5vbl90eXBlZGVmLkRTVDsKZXhwcmVzc2lvbiBpbl9hbm9uX3R5
cGVkZWYuRFNUU0laRTsKQEAKLSBzbnByaW50ZihWQVIuRFNULCBEU1RTSVpFLAorIFNOUFJJ
TlRGKFZBUi5EU1QsCiAgLi4uKTsKCkBACnR5cGUgaW5fYW5vbl90eXBlZGVmLlRZUEU7ClRZ
UEUgKlBUUjsKaWRlbnRpZmllciBpbl9hbm9uX3R5cGVkZWYuRFNUOwpleHByZXNzaW9uIGlu
X2Fub25fdHlwZWRlZi5EU1RTSVpFOwpAQAotIHNucHJpbnRmKFBUUi0+RFNULCBEU1RTSVpF
LAorIFNOUFJJTlRGKFBUUi0+RFNULAogIC4uLik7CgovLyBtYXRjaCBhIG5hbWVkIHN0cnVj
dHVyZSB1c2VkIHRvIGRlY2xhcmUgYSBuZXcgdHlwZQpAaW5fdHlwZWRlZkAKaWRlbnRpZmll
ciBTVFJVQ1Q7CmlkZW50aWZpZXIgRFNUOwpleHByZXNzaW9uIERTVFNJWkU7CnR5cGUgVFlQ
RTsKQEAKICB0eXBlZGVmIHN0cnVjdCBTVFJVQ1QKICB7CiAgLi4uCiAgY2hhciBEU1RbRFNU
U0laRV07CiAgLi4uCiAgfSBUWVBFOwoKQEAKdHlwZSBpbl90eXBlZGVmLlRZUEU7ClRZUEUg
VkFSOwppZGVudGlmaWVyIGluX3R5cGVkZWYuRFNUOwpleHByZXNzaW9uIGluX3R5cGVkZWYu
RFNUU0laRTsKQEAKLSBzbnByaW50ZihWQVIuRFNULCBEU1RTSVpFLAorIFNOUFJJTlRGKFZB
Ui5EU1QsCiAgLi4uKTsKCkBACnR5cGUgaW5fdHlwZWRlZi5UWVBFOwpUWVBFICpQVFI7Cmlk
ZW50aWZpZXIgaW5fdHlwZWRlZi5EU1Q7CmV4cHJlc3Npb24gaW5fdHlwZWRlZi5EU1RTSVpF
OwpAQAotIHNucHJpbnRmKFBUUi0+RFNULCBEU1RTSVpFLAorIFNOUFJJTlRGKFBUUi0+RFNU
LAogIC4uLik7CgoKCi8vIG1hdGNoIGFuIGFub255bW91cyBzdHJ1Y3R1cmUgdXNlZCB0byBk
ZWNsYXJlIGEgbmV3IHR5cGUKQGluX2Fub25fdmFyQAppZGVudGlmaWVyIERTVDsKZXhwcmVz
c2lvbiBEU1RTSVpFOwppZGVudGlmaWVyIFZBUjsKQEAKICBzdHJ1Y3QKICB7CiAgLi4uCiAg
Y2hhciBEU1RbRFNUU0laRV07CiAgLi4uCiAgfSBWQVI7CgpAQAppZGVudGlmaWVyIGluX2Fu
b25fdmFyLlZBUjsKaWRlbnRpZmllciBpbl9hbm9uX3Zhci5EU1Q7CmV4cHJlc3Npb24gaW5f
YW5vbl92YXIuRFNUU0laRTsKQEAKLSBzbnByaW50ZihWQVIuRFNULCBEU1RTSVpFLAorIFNO
UFJJTlRGKFZBUi5EU1QsCiAgLi4uKTsK

--------------m0T0mv99YibVe9lJzVeaPpju--
