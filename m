Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1893BC4167B
	for <cocci@archiver.kernel.org>; Mon, 30 Oct 2023 10:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=4q3Ime47GKwPeLfeetjh03RUTQAsV/kKxPpqESe6mXI=;
  b=pt+j1HZzTMk7brSgPoc0+44Tr/spy+KAb1N/y0YsVjO9Bs4i3lhTEivQ
   6jM0iABDRHdCx/2TGEdv/l6c3xBS5abgCe8L+EjKCF5PTwm0cdVSDmjzy
   cy4cDt1ywJXd8baFncHc7Q95H7SJ9L1tGVwlMwkotWNL9eeZgo5oqG94u
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.03,263,1694728800"; 
   d="scan'208";a="133865277"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Oct 2023 11:17:24 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2509EE00BA; Mon, 30 Oct 2023 11:17:24 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 4FEDCE00B7
	for <cocci@sympa.inria.fr>; Mon, 30 Oct 2023 11:17:19 +0100 (CET)
IronPort-SDR: 653f82ae_tHZnLRpABPUySULQcQTXxgYm9sgU+VTUTgvK5V8xkmLo0lS
 Dp9b98bykNR4C5wPiBBotYDmxqpgYobcwKc2K9w==
X-IPAS-Result: =?us-ascii?q?A0GuCACagT9lhwQP49RaHgE8DAILFYQIelYwBAtIhFOPP?=
 =?us-ascii?q?IF1gQWDZo5+iG+DFj4PAQMBDTsGAQIEAQEDAwGCC4JqAYcmAh4HAQQ0EwECB?=
 =?us-ascii?q?AEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQFAQIQAQEBIxcHDhAnhWgNgjckG?=
 =?us-ascii?q?YEMgR4BAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QJHax0BAREnNAImAnQBAYJ6AYIpAQMxBw2nfoEygQGCCQEBBoJmrG4fLCJVg?=
 =?us-ascii?q?V8DBoEaLodwGgEFY4NMhXkPgVVEgTyCUoV/gw6CaIkwB4YsgS6LD4EABUJwG?=
 =?us-ascii?q?wMHA4EDECsHBDAiBgkWLSUGUQQtJAkTEj4EgzYKgQM/Dw4RgkNhNhlLglsJF?=
 =?us-ascii?q?Qw0TXYQKgQUF4ERbh8VHjcREhcNAwh2HQIRIzwDBQMENAoVDQshBVcDRAZKC?=
 =?us-ascii?q?wMCGgUDAwSBNgUNHgIQLScDAxlNAhAUAzsDAwYDCzEDMFdHDFoDbB82CTwLB?=
 =?us-ascii?q?AwfAhseDSkqAjsEDgMZKx1AAgELbT01CQsbBj4CnhFshCxNM5RTsVA0B4Ixg?=
 =?us-ascii?q?V4FgVoMiHOBI5UNBhMvg24Bky4OBpJJO5gDjWWVJIVIgXojgVwzGiSDNk8DG?=
 =?us-ascii?q?Q+OOYQSgQuOPEA1CzACBwEKAQEDCYVGAQGDJiwIgikBAQ?=
IronPort-PHdr: A9a23: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
 Q==
IronPort-Data: A9a23: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
 IT7qa2ogK12dKIpLftdRg==
IronPort-HdrOrdr: A9a23:VCQcXK2Ga2ZMeehreL2yVgqjBJAkLtp133Aq2lEZdPUnSL36qy
 nIpoV96faUskd0ZJhEo7u90ca7Lk80maQFg7X5Xo3NYOCFggeVxehZhOOO/9SKIVyaygcy78
 ddWpRfTPvtEFN9kcH22wWgFc08qeP3iJxAyd2+8593JzsaDZ2IAj0JczpymSBNLjV7OQ==
X-Talos-CUID: 9a23:IGFC6GFF08rTqVvRqmJ5rGAMS/8+Kkfjj3nWHhHoCF8zFreKHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3Ag30LfQ5rAT/bCsiA1EUzuGjsxowryuO1Kn8Qraw?=
 =?us-ascii?q?itveDKQdcOBfErx+oF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,263,1694728800"; 
   d="scan'208";a="70102229"
X-MGA-submission: =?us-ascii?q?MDGnF4g4uJ59pq81tX4U21qz+aGt0rXt157opt?=
 =?us-ascii?q?Mx0+k11OESiFUFL20ymaBOFQtKRKQGj3ER8WStIFccg+UgfluliFnqFF?=
 =?us-ascii?q?lZznVGKKxKDR3/EBG89zJv30Sw++cIABhYaQaY+RSwr69MT7ahXetdtq?=
 =?us-ascii?q?+w9bqyGvP7tz8wTJvC5363qA=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 11:17:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1698661038; x=1699265838; i=markus.elfring@web.de;
	bh=4q3Ime47GKwPeLfeetjh03RUTQAsV/kKxPpqESe6mXI=;
	h=X-UI-Sender-Class:Date:To:From:Subject;
	b=SzdagXCd9MzOrjS+chM91HKM5jcCQC2gK/2ogU5wnWR8eXgGOfY+aMv4wYzooaGp
	 kSvxjw9nVb3/ftAvXwSHBDzqpCu6/4Hwuyk9UnJHQKticKykAS31URcWbQ5Y4NY20
	 HohIQZRVR77M/5yENek5vEAJLYSMgqeexGPB5Y358BPHwgGHy7MwZ5O0aamJBhuqi
	 AHk12ypKw8iXZJ77kkTUgYCqovozuFekKnEppg1Lw/jQk/bSuhmEmKA3R9daqm+R0
	 LHtWHruWq/u4ZKDE4xqwnvL5P+vYFLkOhE9vX8LkORH4HEJ1GscCJ4mkAexbIV2k5
	 nk1jvEGZvuuOzcoepA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MgRQJ-1rNyJl0hSh-00hglz for
 <cocci@inria.fr>; Mon, 30 Oct 2023 11:17:18 +0100
Message-ID: <76096d7e-7e6d-40bd-b473-0a7b2baca320@web.de>
Date: Mon, 30 Oct 2023 11:17:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nxn2TIzivVSGBJi0vyWphc0i7zMKagvzsRLgJJmoWH3B9KE6AvQ
 7VMREsrbeoMCgscjwd/L2Jn87Sq8oUToEABvPFBsw+wiHsQsEBVBbT2WJ8xSOMNAvnFLydj
 JMOd1lH52rVj4Uj7+1JtPGzhbrhvelktU7r15D4v3QuCw1KveUYSeFCVbcM0bawjVbxA01w
 /mKbKLRP+cET+Y9W1216g==
UI-OutboundReport: notjunk:1;M01:P0:tsE++K5MpC0=;+q5bUFdyx73iIardaiMhGpMclnv
 2dU+5hL/r8b1OYhV87GdFYdhkKqnH90ZHz1uSzbEV5pGaPh7dMahVHjGxaFBGyCW70Ieonxlg
 j1BWpj0oL4krCd3/J9rgoBzc0mGYOHRw80qq9OuxR2fRVpIMI/RaorEyhmr+62+hjwBwFJnQO
 URIY+1Ev+t0Dr4nteDSlqVr9OI81Gv6LStz8KVf4pfwnDhbvdWKOh+2Ppv9WZ/5550YSqf5mK
 TTYHBzpho5xGl/4XYeEAn8NMe/ZmEvQqGa/Fz7oJWI0l9K2v2d4GyWL+HmFtMa6YYvt4rIMx6
 dK+7R1oq9hN2T8G1rddzEE0TAPC1PyyQhTQaN0pCF06OOPdaC7Y6WqvAVzp43pI+rlCCg3qVj
 oooBjpCYzsrkRAHu9ifopzTFQa9TNb3MoivE3DKNTO1cVYVzHHulNZ1JrIP2JAfDXWX7EYJHF
 v/aHP606CSZ/ebaSYVmynNm7LOVajVRbDDjRofByD9vgKAYCMt1IX1/7MtM6AyJ0jMpBfPGIx
 eMpOG3q+hRbYHINl9vS2otO8CtkYx3Coem9adCp30jV1c4q3XVN5RoIeHK66im3092i4apN67
 ezhLuX+DzMmmme9lU+22sNkEsQGKbcRT51FZ3Jf103sIqJgA6Tnj5PputDKTCUK/eRHOm3onV
 vSHfWAAuNiHN4YZIXoMK3iu+LqyDuqsr/MyFGS10j98Tcukq6SR5pqpInj/ak3aRpzS6OL2Pr
 5Bp7VsBfx8a0innEUWebMFA/Jw/YYNxzl9DVaWYiSWczZxeFY0JXVgAk0LD1Wj7nDQ+gLDsqu
 EoZBS2ws3vpB72Lv21QDGBxdoP2+8iRgOAFekRFwOg/ffOupvemLpkeMfVx2ARHYFs1wkvWab
 JZtLeDggyonGhrSX+EWEDspeW+RxoyEhSBKE4I67Ta3Nw55AB8zAvvLRjzoDazB40mdx9Lpfz
 cF50WQ==
Subject: [cocci] Special constraints for the application of SmPL
 disjunctions
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1286
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-10/76096d7e-7e6d-40bd-b473-0a7b2baca320%40web.de>

Hello,

I noticed the commit =E2=80=9Cexplain about impossibility to add code afte=
r a disjunction=E2=80=9D
from 2023-10-27.
https://gitlab.inria.fr/coccinelle/coccinelle/-/commit/23ff8e4a3d8ba5f902d=
2d000e0c4e1089ea1db33

Is a temporary software limitation described here?

Regards,
Markus
