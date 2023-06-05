Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C101C7EE24
	for <cocci@archiver.kernel.org>; Mon,  5 Jun 2023 13:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=yZ44QdhE2RcuCvrMoAy5FdohPH6lsCI2jpncBxdJt48=;
  b=Tf1rXxwGCf9oVA2qzrN8/4gAVO1bcA0P0Ku3GpBtXiky3hQXAvd9xKCE
   JFE0KwVTieGeaaUgw2V3y9dVsQYusBp45vnhEOWMd73GMxvy+/Ea0AB+b
   Lu/esS4kibzkGPeAgGfnjDYfy+3XqII+p8ynhS1EcaVAEwlDyq4npa5nH
   4=;
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
X-IronPort-AV: E=Sophos;i="6.00,217,1681164000"; 
   d="scan'208";a="111282254"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Jun 2023 15:10:48 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 28808E00BA; Mon,  5 Jun 2023 15:10:50 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id BAFACE0094
	for <cocci@sympa.inria.fr>; Mon,  5 Jun 2023 15:10:44 +0200 (CEST)
IronPort-SDR: 647dded2_zb4sXhf51o00E6Ecyi4OQgeWG/VdV4p1li2kH3Ykatz6gUc
 yZN3y6WGvPUOelFvvBZ/mJnVFOI1OrXubQbbrag==
X-IPAS-Result: =?us-ascii?q?A0EWCABX3X1kh07ASNlaHQEBAQEJARIBBQUBQIFPgi91A?=
 =?us-ascii?q?1MwBAtHCCKEKJV8jnSIbIMWPg8BAwENOQgBAgQBAQMBA4FJQoNhhHYCHQcBB?=
 =?us-ascii?q?DQTAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAUBAhABAQEjFwcOECeFa?=
 =?us-ascii?q?A2CNyIZVg6BBgIBAQEBAQEBAQEBAQEBAQEBAQEBAQEBARICDTpoHQEBESc0A?=
 =?us-ascii?q?iYCYAwIAQGCegGCJwEDMQcNBq19gTKBAYIIAQEGgmaZKB8sIlWBXwMGgRUth?=
 =?us-ascii?q?1oeXoRZhFgPgVVEgTyGJASFOYJniSiFE44fgSlvgR6BI38CCQIRZ4EKCGCBd?=
 =?us-ascii?q?EACDVULC2WBHoJVAgIRPBQFTHsgAwcEAoEFEC8HBDIoBgkYMCcGUwctJAkTF?=
 =?us-ascii?q?UIEg10KgRJCFRERgSUlBA4DGSsdQAIBC3A9NQkLHwZFAoIBgQh0SJ0CA4MAg?=
 =?us-ascii?q?RArlUiwfjUHgjCBWwWBWAyIb4EjlQkGEy+DbpMlDgaSKy6XYiCNOpUUhUWBe?=
 =?us-ascii?q?iOBXDMaJIM2TwMZD44gGYNbM49IPzQCATgCBwEKAQEDCYVGAQGFfgEB?=
IronPort-PHdr: A9a23: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
 iff/IYGS76OjeSFjDZqAkMmlw==
IronPort-Data: A9a23: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
 PwhrIfvNMklYQl5TA==
IronPort-HdrOrdr: A9a23:ihJKgKqeJ9QMdUApMhllWG4aV5o8eYIsimQD101hICG9E/b5qy
 nApp4mPHPP5Qr5O0tApTnjAsa9qBrnnPYf3WB7B9mftXzdyQ6VxfZZnO/fKlPbdxEWjtQtt5
 uIJJIOa+HNMQ==
X-Talos-CUID: 9a23:4ScqOG6gxN8qQKLIlNss23UfWdpiXGHmxi3+B066D0N4ErKIcArF
X-Talos-MUID: 9a23:jw3vUQQQh35PahwiRXTVhTx+JcN42J6kUmIWz5RfhOitEQVZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.00,217,1681164000"; 
   d="scan'208";a="111282229"
X-MGA-submission: =?us-ascii?q?MDGYBVFY4Mz/eowGWZZb2JhhQgtUfsyyRyTiSd?=
 =?us-ascii?q?BmXZZNzvBVyzCRvZlkRPGsUs0SLG8FutN4eJfwFHIfIFYVkh545CHzmt?=
 =?us-ascii?q?IriYCQCT/w5nUAbdZTvxT4EylysAp4oS74H/Wssqz1WbdoT1MNUX7JGv?=
 =?us-ascii?q?dbwHb1gIaHopIwLJzX0DdqoQ=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 15:10:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1685970643; x=1686575443; i=markus.elfring@web.de;
 bh=yZ44QdhE2RcuCvrMoAy5FdohPH6lsCI2jpncBxdJt48=;
 h=X-UI-Sender-Class:Date:To:From:Subject;
 b=Wi2YkVJykdX7Q6o7zyxTT1Qp1zeoH33a69ak+ky9wuFWkpJnZ/3JWcQzCm+PL+58GjNue1U
 4qAGVeHavDFLZkuoysVq/q0EOs1xl0pa8jbVaSySDCDC2Ic+nSoE++pTe47QPcH5hCt6+nhF1
 BPLRYdTGHskr+CUq6mkdfzzsA2QWmUozWs5Jdp5qMy0/OCjE9bGEnFMTCB/EP0Lk9PUiZqM33
 8K1VGSQMAS6j34c8tdFlMRD2bN1lNrFqD2OeISW6TSzeLUYM2qkSkukxo7VfM1AGYOYhNSY1D
 K8GTU1QQlSWzbNpjx6aaVm3li76UFyj+Zri1A7Rd8Bp8wbsDSf3g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1My6pZ-1qG61M2qCt-00zXUv; Mon, 05
 Jun 2023 15:10:43 +0200
Message-ID: <a8f7072f-b8e7-33df-291b-97d5b6444f3c@web.de>
Date: Mon, 5 Jun 2023 15:10:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
To: kernel-janitors@vger.kernel.org, cocci@inria.fr
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LvKUrnS4RKtrISAdc4JP4GJ6ShFo36TnHKSmVLVXW8QNk6CiTGQ
 gppC/+xxyCitDv3JwiKCmyeRJm3nJYHYJIb0sadxrGIq/hxazUQLMI8xY7gCbqwM7ThUCOB
 kf+ZE/IBPyIHoqeFra4La8q78VBvgvFIDa15yHlgvVzvDSzjXAtXvAFUpcX0tnsFihplxj7
 hJkZ2jpRhTEOIaiEL5wgw==
UI-OutboundReport: notjunk:1;M01:P0:m5Jgy94CWvQ=;H/CbdbbNah0oNm0TKeIgtyDzZ4b
 B03OOo63+KlqUa2q6Y1gOm10rIbWoF9zajzxW9zEBPHLUQ7UMtPB4ZiehVWTFrnJv/pXdxb/K
 HPwDJFiLGVgiI91fP50eiqUmD5budQt+QOrgVbN9DkK2jBRbKshdOfQQLrqWEy+46MA9Lkr/o
 aOmPPXPBmYJIpoph35TPAaCJdfPez9D1MLsx9uzQ5C/B7UGTPai8CpJdBPSrKogKbi2I70FRb
 /Sl28dOE7T0FzC1xDLNdp+DLY7GMhAC1azuUP1u3VCMj6YsFczDL9rFzTfwBa40j8vpWzZUhK
 JlXnlMve1r0rxkQmHV6sP+fhxQMw77seBpzbjy+qnHPXwnakdZdoiRX0BpVLkjP6ghfUiMDgW
 4G1KBaY+2Mr00MOYKBKq+5fyesonLa5NGEZ7MekPHXeLifPp5AHHbjLn4P36VVcSeAI55CQ7w
 /ASPWcd+WB6nIP1WPWFhecVRLw9F2GIq9yYuOmKgIwbU6wEnT+VT4hvlPHLOSnK12pVtVNw3e
 IhMa3K+9tvh7FnQKcASkZghxy18EUAA3PvsQfS2ms+jN1EPciWUhe2olHUV0apgbHLHki8KGk
 6+r6cJyQQwLvYP9Fx9LYSbwcw9Z6h5hyN8ZU4qDBZevSnVqBQduEUPeGFaOusJU12a/yjk2hh
 510vaTDv/ta2EgaXNK4qQnh2W/0fENUWb8XTayEVmCMq/0oz01algb8IW/ytsjyZg24FVqGwt
 h0ihDWTwkpc23OFkXz0+ZJaWBzm0B9kBtcKq5xcCwEHCS2jr1np0UxRvK7vS26beOLNPOYicv
 d4VTIxZi3/oXc2ROg4vlSIy6Qm/BPSTx6/2TBytHcRHDVLUTvoyAeomuOEKa5nde9k4Le3sRv
 T8ig/RhWu1KvL0s2B0XdDvIOzQlaBTkdZ7eRb0z/lcWooORXmf2ZgvMFdRH+uklVhzKMYjg2S
 y+Cfkw==
Subject: [cocci] Using seq_puts() more often?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1167
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-06/a8f7072f-b8e7-33df-291b-97d5b6444f3c%40web.de>

Hello,

I tried the following SmPL script out also on the source files from
the software =E2=80=9CLinux next-20230605=E2=80=9D.

@replacement@
constant string;
expression context;
@@
-seq_printf
+seq_puts
 (context,
 string
 )


708 source code places were found where a more appropriate function call
can be applied.
https://elixir.bootlin.com/linux/v6.4-rc4/source/fs/seq_file.c#L672

Will any more developers (besides me) get into the mood to pick correspond=
ing
change possibilities up?

Regards,
Markus
