Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B331CD116FB
	for <cocci@archiver.kernel.org>; Sun, 27 Oct 2024 12:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=iaRM2QdMp0GMHmjaBIMJB+iu5WXi6RVx2H3puel849M=;
  b=Gw7fj/GBmTndgn5H9tN33YpJtNHdzbjRfBam756R4pOIoDZef3hvMpU2
   TQet9cVqnxes17p85VLojS6gGwFSqKrwpzGMc53jYz56LrazthRLFs65x
   cCtyIW08CmNMtcL/5CiWyedii/k25GrUGU/FMfcQ+FQiEBCMMMxt5tNrH
   E=;
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
X-IronPort-AV: E=Sophos;i="6.11,237,1725314400"; 
   d="scan'208";a="190914078"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Oct 2024 13:49:07 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4F6D3E0D1D; Sun, 27 Oct 2024 13:49:07 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 93871E00B7
	for <cocci@sympa.inria.fr>; Sun, 27 Oct 2024 13:49:04 +0100 (CET)
IronPort-SDR: 671e36bf_Rwuh4fVpHcmoWiyEXmrTFygRI3NXj5OnvmQL9mxYNZm1rav
 oOAHMBs3QlEJOecsupuaO3znDe9odwzWYgbbDZg==
X-IPAS-Result: =?us-ascii?q?A0FRAwBhNR5ngAMP49RaHgEBCxIMQIFIC4JEYhtaMwQLS?=
 =?us-ascii?q?C2EKY9NgXQthD6ZWoF+DwEDAQ07BgECBAEBAwEDgUmDNwJ3iTACHgcBBDAJD?=
 =?us-ascii?q?gECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQE7Bw4KMYV7DYJiA?=
 =?us-ascii?q?YEJG3QBAQEBAQEBAQEBAQEBASICAQEBAQEBAQEBAQEBHQINOkQCAQMjBBkBA?=
 =?us-ascii?q?REmAQ8LGgImAgJWGwEBgn0Bgi8BAzEHDQavM38zgQGCDAEBBoJo13MfLCJXg?=
 =?us-ascii?q?WMDBoEaLoVqgmIBimAnD4FVRIE8C4JHMT6CYQSBXk2DDoJpgmOHZiWIN2qRQ?=
 =?us-ascii?q?VJ7HANZMgFVExcLBwWBMDIwA4VQf4E7gVMBgyxKg0gcgUUFOEmCTWpLOgINA?=
 =?us-ascii?q?jeCJH2CUIElBAWDOoI5HUACAQttPTUJCxsGPZpqe0eCRoEuLIEgTYENkl2Pd?=
 =?us-ascii?q?qJrNAeCOIFlgWMMiieVLgYTL5c/DgaSeJgTZI1+lROGEIFnOoFcMxokgzZPA?=
 =?us-ascii?q?xkPjiGDejPMBkI1AgE4AgcBCgEBAwmFRgEBimqBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:k2X5FaOH/LeUL8BcThWjsMiBIKoaSvp037Dk7TEVdfUnSL3+qy
 nIpoVi6faUskdpZJhEo7u90ca7Lk80maQFgrX5eI3SOjUO21HHEGgB1+ffKlTbckWSygce79
 YFT0EUMr3N5DZB/KTHyTWZV/A93dKA7KekvuvGyWxxJDsaFp2Ioz0ZNu6BeHcGPzWu6KBJbq
 Z1bad8zQadRQ==
X-Talos-CUID: 9a23:NA7/jWAcA+K3Hoz6EydZrkA2Bdl4Tn/+7n7ccmSiOEROdbLAHA==
X-Talos-MUID: 9a23:7CiPSQVsXRqqKnDq/BSvgjwyOvVB2Z2VKVpUkK8Mh82PbjMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,237,1725314400"; 
   d="scan'208";a="100133953"
X-URL-ContentFilter: 
X-MGA-submission: =?us-ascii?q?MDFs05sYIMlaVjPN7iOQ7/FLBkFocefZY9Cl5Y?=
 =?us-ascii?q?uB46E7vKmV+K3Pvjy9aP2iwu8QsOtk7XP4EQMhQGXjUKcTsctyYz1NVN?=
 =?us-ascii?q?aFQiVqFpX7w4Bq6h48617x+3bShAk9lmj6yqS1sBggzSofNJtMhvcRi9?=
 =?us-ascii?q?02YavfP2JM8ag22DDrKzj9RQ=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2024 13:49:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1730033342; x=1730638142; i=markus.elfring@web.de;
	bh=iaRM2QdMp0GMHmjaBIMJB+iu5WXi6RVx2H3puel849M=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Lmb3tiNHQpX4x5rfQ4Ph/Oq2X2QDQ3Q510ypGbGnErudSAduH/tpKhzKbcw1kLTd
	 fho3z+9Fo+fGGb5ssBMwabHGFMsFSHuEdbjc7zOqvyfR1dwrgKWNq7Ud+Ln+Gwo8b
	 3z5CxAZRAbhjZFK/mXh4fmSIQD+1940CT3hsclWL3v4AcBLvOht6xJD4FWiQFAd93
	 n7unUmzVHIUptjDT0B/G5I5C1u6O8uZjyuKCtUt4L8uFn7JpxrJ6z4LlNsIiqE2Po
	 w3TbeuT8CTWmwWq4wCRsPb7APciQsn96weSS6MseMeQuKOatYnE9yEo8oFs2L+tRS
	 v2ng3TO7Q8uTn57VTQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MqIFD-1tiRuX25B5-00baDr; Sun, 27
 Oct 2024 13:49:02 +0100
Message-ID: <7f8568d6-4405-4c7e-8dd0-90f140db8dd8@web.de>
Date: Sun, 27 Oct 2024 13:48:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr
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
Content-Language: en-GB
In-Reply-To: <582c1098-213f-4c6f-ab35-4a7fb508c2a6@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Q8DXRY+wOFePxdnHXPf2vM2ezUjTozN2BP+Y3FI9CcdlBGT6NZz
 Qnvj8hGQkky74CO5Ki/xp3Xh6fytkdmrsaJ5FpPRfGa+ME3fdhJz/Tg+u2mlLtwePdyOWIW
 VLOVSdWJIparEJJWoDLSP12k+mDMvXrNW0ts1wI+z8J4bH4KqMhTPlZAlah+s7LSH9AUQKZ
 417erMbTTrrbePgDScNAw==
UI-OutboundReport: notjunk:1;M01:P0:q75EZ0CKLvw=;I/UMINtiiHyXSO0DNAhFvSZtN+N
 AKkVxzW92HcazXiui/Xr7BXHwRq+9ACpLmShGZQh0Pk7sd9kdDJsmCOvQjBn5GH9n0+TZnk8t
 Cj1jczYBwFtqf6qAsMmwm314/ZdEQKYsGXIaxFhISEVFKzNzxzZEz2FEtU8T8jAASACrTbELf
 74U7hUnx4Aaa1WlIALymHyAgodldSloPqsObeYLXw2GMzMguTjl3h8V9XNd5oRoooBk2piCAL
 Y5LhAbHAP8b6rhk0DXoc6IyuKW0axvM9U7nIVJjiFEYkXI+Chr1K7+zq1OIyqs4SWy/K042Z0
 1tPzUkwFDQb7ss5hkCLO9FV816ZvHI/6H5sv3hs1rs1+ac7UiQyNbAMwVAQCThSF/Kpi8Z+xK
 EbSRGVgLPw9lYRIT1IM+r+qsZcj4GkghEFRkA5BFqY5Iy7Pvb5rW15DC6hkPiqYLpcfXIT/T6
 ZY5PdLq3B/rhdNlhkKsV1fn93FWtnfddL4bKLMBris3Ryl4SlE83CDNT/V443n8sYg4s2iFx1
 R3xD9x7DkedE6cByAWDMwo/MrGwsrkIlemB4P3t1x/IAxHwgUHG92W+t7xLweIYuTNnQyDxVq
 QjprJKouoXMaRsqEBp5uHgghsixsQWKCF28Jr5pWO5nDla99wUSBcRljvPeyn/uHrX2ZvNu/5
 cI4302LCaM7jjndNQ2fAUODosuhIU2TjIGh+Ng/LnNJsrceqwuz6mzGxKRsGhep9lXsfGBpEn
 z7HCtwkkW7zjefzMepYNisnAtKMeZabHVaSbbCUs0Aq2Hap9cuzC+Zam2fVlg/4RvPhnH1kil
 kVHBa6hK+v3fhrV+ph49LeLg==
Subject: Re: [cocci] Broken code block size determination in function
 implementations
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1940
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-10/7f8568d6-4405-4c7e-8dd0-90f140db8dd8%40web.de>

> * Do you plan to analyse any function implementation sizes (=E2=80=A6)?

I got into the mood to try further data processing out also together with
an SmPL script variant (like the following).


@initialize:python@
@@
import sys

records =3D {}

class integrity_error(Exception):
   pass

def store_data(places):
    """Add source code positions to an internal table."""
    for place in places:
       key =3D place.file, place.line, int(place.column) + 1

       if key in records:
          sys.stderr.write("\n".join(["-> duplicate data",
                                      "file:", key[0],
                                      "function:", place.current_element,
                                      "line:", str(place.line)]))
          sys.stderr.write("\n")
          raise integrity_error
       else:
          records[key] =3D place.current_element, int(place.current_elemen=
t_line_end) - int(place.line) - 1

@searching@
identifier f;
position p;
@@
 f(...)
 {@p
 ... when exists
 }

@script:python collection@
place << searching.p;
@@
store_data(place)

@finalize:python@
@@
if len(records) > 0:
   for key, value in records.items():
      sys.stdout.write("|".join([value[0],
                                 str(value[1]),
                                 key[0],
                                 key[1],
                                 str(key[2])
                                ]))
      sys.stdout.write("\n")
else:
   sys.stderr.write("No result for this analysis!\n")


Unfortunately, I stumbled on a few test results which trigger further deve=
lopment considerations.

Examples:

A) GENERATE_PERMUTATIONS_3_EVENTS(name)
   https://elixir.bootlin.com/linux/v6.12-rc4/source/lib/locking-selftest.=
c#L288
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> spatch =E2=80=
=A6/Projekte/Coccinelle/janitor/list_curly_bracket_positions_for_function_=
implementations4.cocci lib/locking-selftest.c
=E2=80=A6
-> duplicate data
file:
lib/locking-selftest.c
function:
W1R2_W2R3_W3R1_123
line:
290
=E2=80=A6

B) CTX_RQ_SEQ_OPS(name, type)
   https://elixir.bootlin.com/linux/v6.12-rc4/source/block/blk-mq-debugfs.=
c#L500
Markus_Elfring@Sonne:=E2=80=A6/elfring/Projekte/Linux/next-analyses> spatc=
h =E2=80=A6/Projekte/Coccinelle/janitor/list_curly_bracket_positions_for_f=
unction_implementations4.cocci block/blk-mq-debugfs.c
=E2=80=A6
-> duplicate data
file:
block/blk-mq-debugfs.c
function:
ctx_poll_rq_list_next
line:
512
=E2=80=A6


Will the chances grow to handle involved macro code better anyhow?

Regards,
Markus
