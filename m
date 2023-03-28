Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22CC8C77B60
	for <cocci@archiver.kernel.org>; Tue, 28 Mar 2023 12:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=V/5wKULXaOH9Z+g7OQ3W1cB1HDiRGRGclHfPu6w810c=;
  b=gi+rq6uw4p03h+KFfh+3hlsOQtXvNmuDjJb1S3CmE2d18oNMPFLatLm1
   mcjaqa3Jk72kTuJvn1XekszJJlXlghx/aSgyO3e4kDyIrJA/ESaN3Dd/e
   6y71fJKeQp8wc4ZghuE0fucYZD6gBuFBAAV2s0G+Zw5oEktEuGpJqgmAX
   I=;
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
X-IronPort-AV: E=Sophos;i="5.98,297,1673910000"; 
   d="scan'208";a="99511258"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Mar 2023 14:20:56 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C2E7EE0D46; Tue, 28 Mar 2023 14:20:56 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 4B8E3E0D40
	for <cocci@sympa.inria.fr>; Tue, 28 Mar 2023 14:20:55 +0200 (CEST)
IronPort-SDR: 6422dba6_Bd1+4oeXVd0dUMDNy8fFYB4Hru5YRaES5kzSeig6P/pdwzF
 TEgLnrTNiYjVdntxLdNs2VqT/kckbbzPAvSHkeQ==
X-IPAS-Result: =?us-ascii?q?A0EnAAAf2yJkhw4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYItdVYvBAtGCCKEKYgfiGKBGoNGjmaIaYFWgUA+DwEDAQ09BAECB?=
 =?us-ascii?q?AEBAwEDgUlCgnNthE4CHQcBBDAJDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBA?=
 =?us-ascii?q?gEBAgQEAQECEAEBARoJFwcOEAUihWgNgjcpARFWDoEGAgEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBEgINOhg7Zh0BAREmATQCJgJfAQwIAQGCegGCJwEDMQcMB?=
 =?us-ascii?q?q8sgTKBAYIIAQEGgmOZJx8sIlOBXgMGgRQtAYdHHliER4M2eicPgVVEgTyCU?=
 =?us-ascii?q?wEBgzcXBBiFHoJFIoIph1WEHYpFYAqBNHOBIA6BPYEEAgkCEWuBEghrgXxAA?=
 =?us-ascii?q?g1kCw5xgUoCZEyBFCUEDgMZKx1AAgELOzo/NQYDCyAGWGsCCSMREwUDCxUqR?=
 =?us-ascii?q?wQIOQZPEQIIDxIPLEQOQjc0EwZcASkLDhEDUIFHBIENfAoHJiSeRT+VGQkfk?=
 =?us-ascii?q?iGeDjQHgiiBVQWBVAyIaoEilQAGEy6DapMeDgaSI4Uckk4gjTKVBoVCgWM6g?=
 =?us-ascii?q?VwzGiSDNk8DGQ+OIBmDWTOEYYpnPzQCAQE3AgcBCgEBAwmFRgEBhXsBAQ?=
IronPort-PHdr: A9a23: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
 twCR+0CPLTQPuwXAAJpEY5aSKo=
IronPort-Data: A9a23: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
 RwjFqXMAyWM
IronPort-HdrOrdr: A9a23:3evXQ6+t0uui2nagWCJuk+AAI+orL9Y04lQ7vn2ZhyYlEPBw5P
 rPoB19726TtN9xYgBGpTnkAsK9qBznmqKdjbNhWItKPzOJhILLFu1fBOLZqlWMJ8SUzJ846U
 4PSdkcNPTNLRxdkdvw5hW+Hu0t2d+d7cmT9JzjJjtWLD2DcMtbnn5E4+ugYzVLrIIqP/AEKK
 Y=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,297,1673910000"; 
   d="scan'208";a="99511247"
X-MGA-submission: =?us-ascii?q?MDEx4GQMk02JCDQOJd0TkwDCda/3gftK1Truhw?=
 =?us-ascii?q?Qo+M5tIa2w+Ge8J0A69yQPcqaxwq/oYwy5kzRJZ4HE4Q6JbP8LhRmavt?=
 =?us-ascii?q?xITTYJuyL1a6xlLMv/kARsvlJcmJcK3URvxJlUYC8mra66MtiFX39q5W?=
 =?us-ascii?q?TO2CHkNjiU9zFYWH0eaSXcZw=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 14:20:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1680006052; i=markus.elfring@web.de;
	bh=zf37aKKfHFLzmGfp7ws8Y56M4dthACcGSMnSkvA5CPo=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=MdiGLlDA08z5DxdR9yjqnfG0vgDIYbET4kX6340VlfMOiW4hiBFcVr1WwT1PmX7te
	 LWaAhVFqVc0KbxBXJag0ZDhZCey8NH9ZIubO5xdDE2KdVw963eygy/6UZsRdy5mqd8
	 LwzYoQBUvloPc2T/ac6a609wHaSlGTBLTestMHaAmJ+9sx/CxyFlIhAQ4pxbnZxSMl
	 LAOsInUiet7iKRFqNcuPy3UBWiX2ilkH6Bi2hLddWDvqNAqkLhGmtkgrFSmFo8mWNR
	 lPS2Ksh1OHNyZawDbU9ElS+8AFkhqT6jAjcFIjr03lZR+xM+LxO1SPiuMz/8VVd/d/
	 U+LjZoQ7LgoFQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MmQYX-1q7hYr1DEH-00iSPA; Tue, 28
 Mar 2023 14:20:52 +0200
Message-ID: <4fb82a9a-a80c-5a2f-238c-e0130e102b28@web.de>
Date: Tue, 28 Mar 2023 14:20:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-GB
To: linux-doc@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CXk1p+QslUxwVVj8XcoMnieSQBNfSeun+cj2uPYRGVWaWRguoLk
 kv9MaxihqKPlHdb1WKqPCyYn9GTKNb1i8aCkCsR+qTbsCs5gP3qAlE4ke/lzMEoE+/dCLu8
 WIh33io0fQgkgiufQ81ixF5sdgk5rCg1hV7Ioba+8djj1NYGCD/0A+kXJo3sHXmPywqkZFT
 +Hu0/9dwmbCRiznWucqIw==
UI-OutboundReport: notjunk:1;M01:P0:/THovtVt1cM=;haQ1DRZJjAwErHOTe7E7KprkTBM
 ONVchShtnDpS8Z1IoQfDNdvns1VTAFQI1YAm8WctR1C5ziC2DIhVAQp2YNYJnh2csASlG3Yxw
 G5s3yKnPalC/SNAYgp1gioFLQJGSUtDCGNJoGbR5k9HtaBfCSVbSJ0TZUHsnXU0Xl2NmvYkfz
 jNTgIK/V+E+9AIoD+DFbhAb9ddB+Sx2rAkM6QhusjYG6g/UxjNEU+lkMi8Cz/rQC9YEl4dFkh
 1uY9KdxDm5Ef0YRKHRtuQH32mR6D6AbrZtJxCLVbD09BUoiwwVIBmqJTTg+Xppd/m2VWSocz9
 Bv1VKEJ9jtuYvaOpesA288rmPDKiSpkVkWf0uJIw40EvvxT4y3UghxqBQhA7CK0lwi4huDm2R
 5UVDT33++5nvx45b3/vwBU0m9sBXn447Oq8h7q1JvPHGik2EXqj2YEYithlqUyIdPN+wBVDK3
 TMXvXmT+Y1N15F3O3K+/tXP0gV5hWX79oBG8R5QsUS7DSCZdEQXVv32gktejeYhHHAPUByQ/1
 jfb5exhJKl2Jd5i+WRVllJg7vHRu7xzcrygWbukLNnUuhhLjyEig8x9JpcfkFOpvB4UiVZtug
 UHw/i482maqGCXh1lHHPb/jZ1Gpt6s23uGAoXn75yWhYPXS4exv1ttQuWoVzpv9VLh4SRYy7t
 G0o8U6OpuWk0B9hHalkdSnNciKZzaj9SooejVBItxzlegICG02qFy0M2RRGgvyuF1faw4vnNp
 REOWaAU8deM7glAK7LOG3k+kKkZ57bscyWOmfzry99wgNBvGmmLrtIO+7DjzBJaQMSoQVulZZ
 lOdJWH67U/9ivmTUhPL2nXdft2p1+DD6tj+QlDDYwoR9NqMjXPpXGhrzSeXKGkEIwyM9m0j8n
 09gNPL/hwx/h6QRomIVsr8gtDqeXM11Kqts3AYX1XjIf24IY6k2h2s7b9
Subject: [cocci] Improving documentation for application of error pointers
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 968
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/4fb82a9a-a80c-5a2f-238c-e0130e102b28%40web.de>

Hello,

I found three places in the software documentation where the term =E2=80=
=9Cerror pointer=E2=80=9D
is mentioned.

Example:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/core-api/printk-formats.rst?h=3Dv6.3-rc4#n95


I am looking for more helpful explanations also according to details
like the following.

1. Can any functions be especially marked for returning an error code
   within a pointer (after a failed call)?
   https://elixir.bootlin.com/linux/v6.3-rc4/source/include/linux/err.h#L1=
1

2. Does a possibility remain that such functions would occasionally return
   a null pointer?


Regards,
Markus
