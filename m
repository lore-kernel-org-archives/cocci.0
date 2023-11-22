Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09113C072A2
	for <cocci@archiver.kernel.org>; Wed, 22 Nov 2023 08:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Hz37CEjH1MQfK7bONAlGH3z4hWnagbXzOMiq+Tchn4M=;
  b=lZ7h90HE+zcoow4vPNewxI0alZb3iDMFQAbZBa+LTZqEMsY8f9YPb60g
   XMXtAWfUptGonSff40j7oauNps2OOHoBLkNb/XiN0ZpMY/AGLBAGf3o2E
   54/hkTEERs4IPvD6kWI0Q+Rp+ylycbMSPYosfnXe13MORTzfLX0lAEf7b
   A=;
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
X-IronPort-AV: E=Sophos;i="6.04,218,1695679200"; 
   d="scan'208";a="137763156"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Nov 2023 09:21:15 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B6487E0CCA; Wed, 22 Nov 2023 09:21:15 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id CA1DAE004E
	for <cocci@sympa.inria.fr>; Wed, 22 Nov 2023 09:21:10 +0100 (CET)
IronPort-SDR: 655db9e7_ahOhKGreUM9ILbEeNOpu3CpgqsVyanh6tBlQFTPK10kop9j
 jMTBf0+h8xUyHNX0ArAXq4vUEgTmXlG6T7M/4fw==
X-IPAS-Result: =?us-ascii?q?A0GCBQCfuV1l/wQP49RaHgEBCxIMQIQIB3NWMAQLSIRTj?=
 =?us-ascii?q?z2BdS0DhDuOfohvgxY+DwEDAQ07BgECBAEBAwMBgguCdAKHKQIeBwEENBMBA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBQECgQYThWgNglwBEIEMgR4BA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQJHQgEEA?=
 =?us-ascii?q?SMdAQERJw8LGgImAgJXBgEUAQGCfAGCKQEDDiMHDa10gTKBAYIJAQEGr1UfL?=
 =?us-ascii?q?CJWgV8DBoEaLogNAYVZhDUnD4FVRIE8C4EJgW8+hEODW4JogVaCGIU5BzKFd?=
 =?us-ascii?q?IM+aIpUXSIFQnAbAwcDfw8rBwQtGwcGCRQYFSMGUQQoIQkTEj4EgWGBUQqBA?=
 =?us-ascii?q?j8PDhGCPis2NhlIglsVDDUERnYQKgQUF4ESBGobEx43ERIFEg0DCHQdAhEjP?=
 =?us-ascii?q?AMFAwQzChINCyEFVgNFBkkLAwIaBQMDBIE2BQ0eAhAaBgwnAwMSTQIQFAM7A?=
 =?us-ascii?q?wMGAwsxAzBVRAxPA24fNgk8DwwfAhseDSclAjJCAwkKBRICFgMkFgQ2EQkLK?=
 =?us-ascii?q?wMvBjgCExUGBgkSBA4DGSsdQAIBC209NQYDCxsGPgInn2WDID5hNSsgApR2s?=
 =?us-ascii?q?g40B4IxgV+BYAyKFpUNBhMvhAGTIQ4Gkk+YQCCCMIsXmm2BeiaBWTMaJE+CZ?=
 =?us-ascii?q?08DGQ+OIIQrgQuOPEA1CzACBwEKAQEDCYVGAQGDWoFAAQE?=
IronPort-PHdr: A9a23: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
 BI72FIWiQEF6zrmpVs6dAKimQ==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:YZTWKqA5v03MvPXlHely55DYdb4zR+YMi2TDpHoBLCC9Ffbo7v
 xG/c5rsyMc7Qx7ZJhOo7+90cW7MBfhHNtOkO4s1NSZMjUO2lHFEGgK1+KLrgEIWReOlNK1vp
 0BT0ERMqySMXFHrYLd/BSyFcomzeKK6aaymI7lvg1QpE1RCp2J9G1Ce36m+6BNNXJ77RFVLv
 Ch2vY=
X-Talos-CUID: 9a23:QNIC62OiTu63Iu5DXXc4yUBMOtgfTHzf61HeIROlCX5sV+jA
X-Talos-MUID: 9a23:xOKfzgXJcKfhgaLq/CC3iQg+N+FF2oTwUxwfy6s9pfeoPCMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,218,1695679200"; 
   d="scan'208";a="137763026"
X-MGA-submission: =?us-ascii?q?MDGZ+nP3dnF23Fk28isJGT1A3P8YqZ6rN5Ok15?=
 =?us-ascii?q?mtuyk5EgCcPF3/IfPjb00X69KWTXb8E7xrqTiXQ8r25xdKQ/md59cZzY?=
 =?us-ascii?q?VZALdW5kWQzeC580W2eGECuYhPUMs/W2krBkhDve/fVzca1vtt0GGw44?=
 =?us-ascii?q?x3l5yXUmy9A5yzN7KNAHNsmg=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 09:20:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1700641241; x=1701246041; i=markus.elfring@web.de;
	bh=xwzJfxByKHqrZLnYP9JjejQ73tYKSd2LgMYmZu6nSHE=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=kL8AKHMlpqkCtT33C8n+7tLt3HF0OprcF76NZQj3PGFUyoZ5t6R9p7PYxU5EWiSp
	 YOjpT4NUH64Ipl7RZhpAj4eItX395NPReFQ+3aivyuNQmiQh1fv+93vBBX3uKXFSl
	 SRwlIBvd3TLciYEIUBRmfzJKQYB9dpb8qqi1SNj94YsqYBmImcTQW9UPedbE9fw/P
	 3rnByk/wZw8w647ez0nK4qVezUifRrHa2BBbCwU/Gq0JqGmfN72wRkRdw8Y8QB4tR
	 MswFDxS5Lfzi8PvVhuxJmRpJI1ViLLklewPJc6BDM7bUle5nXyk7dKVqhSvCLOJ9E
	 o1NEofr0+WgjFBQOuw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MbTLB-1rcI8O3GMD-00bQYm; Wed, 22
 Nov 2023 09:20:41 +0100
Message-ID: <bd4cf465-63ed-4161-ab05-429e6a23338c@web.de>
Date: Wed, 22 Nov 2023 09:20:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Jacob Keller <jacob.e.keller@intel.com>, Julia Lawall
 <Julia.Lawall@lip6.fr>, cocci@inria.fr
References: <20231109161846.148524-1-przemyslaw.kitszel@intel.com>
 <e7263df7-be7d-47a4-b708-e04393f7887a@intel.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <e7263df7-be7d-47a4-b708-e04393f7887a@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TSjfWeJlvpLgRjf3cBKZpAhOufxRHOkB/iRA/nCI3U5hbjLxrMH
 L+arLBVLTEGTHac85r/dznoCx9F8u5WvT8AEVQJzC6ft3SONd5KkQrevmkKCoxtsNBwF0J6
 Y5D3nnpoKhtOhlbXTSjdCGnXuj0u2z2EOCxdLdAZ6PpgeUshriwJ1p7knTIYNrtv1yBwOAH
 yKFG69UIGMRtEoHiPUDZQ==
UI-OutboundReport: notjunk:1;M01:P0:KjtPKXKdL3Q=;M8151UdPYxvlVv85Df/0NNDSnNy
 AO+EwvW7XH3L3iAM5nszVJOZXB2eYeu8uA9ppi3sXarm004c3oigeUTyF8BOpXZUiizo3M1FZ
 dVQKXA/t85beWhMTCYrpDuxGERf45q9rdRFuvHJ3mzgHRrzm9s0ERGBDuV0bhzc8lrIzTy5qQ
 i3cZUAJgyDVPdCiKHjbqsn3wubBP9949yDk5NJ4gi4JMu9lPoFUXHNzZ1TbXr7LTg/bJ1eyKK
 rkbl7SGAqmklOr4ZAL/dMAaud9BgK82DwBpMLIQXpxVrHQFMvLpchBEETbf434znBkc+VYkPP
 6Av1SOqOX3QWddrO2T2Fig9oHOQonrTonyp/JJkHGZWD9eUjeeAGwNuioLZasMBwJy/HsSInC
 Gb4p4PYmYgIRYXUEi3AzRL+ptG9udO1VmbZ0ON7rw/SIfPcQ5gn6yCOi+REaNObyEUN07H29Q
 L+zoJDD8x/tn6u9437rX7KBv4e1MOfxbVRNRQ3ePixCJi20IuI4QgFnGRVIOPNlGSqkO7atRK
 3RjKFQyMuaW9SyDgz3RroHfKz6Z3HGiwJ0Ho2T+g4AZgq0llH3g/i7jONwZ8o04qnDHB78G0b
 GNpor4MpiNnWd2Cs9Wb7dFK6N6NiV5+Y3T8P8AWNaU4rvgR7ObTLNKCd/fFiSYNPg39+XXviH
 7RTgsYwIAF8GIIMBwxTQX2sxgHk/PBptHTWnO3b7/PoJnLQXfP9WlGHjWlNRHZ3TpEfH0Hx5b
 NtdXZvkkwdaHBnCa8RZexCVGrxw6YbI+2fGakPmuXgOL97AHuXtHZV5szuKfu2cBDw6Jo1j/U
 Ph3RhbzJ2p3+zL2gs1tutuAZ1sbAS/92joPceY5wPEv0o6+6T6pgljnTTAihAzD9S7B+oLesf
 qyHTJJG8mJO4bDuNWVDR4ztwaT2bbjCi3CVMvUKKK8rn2E6fazQnpADd2DYFBGB1tky0g7pcC
 hQ5aQg==
Subject: Re: [cocci] [BUG] exponentially slow spatch
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1305
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-11/bd4cf465-63ed-4161-ab05-429e6a23338c%40web.de>

>> we were bothered by, what we have called a "flaky spatch" issues
>> in our CI servers, which have manifested as spatch "just exiting",
>> without any proper exit codes.
>> Jake & Jesse found out that processing large files (like 100kloc
>> amalgamate builds...) or parallel processing makes it more common,
>> so we have disabled those.
>> Now I see that those builds were likely killed (or spatch "crashes"?).
>>
>> The issue hit me again, so I dig deeper, and the case is that processin=
g
>> time grows exponentially for seemingly easy case, attached.
=E2=80=A6
>> +++ b/small.cocci
>> @@ -0,0 +1,8 @@
>> +@@
>> +expression list E;
>> +expression hw;
>> +@@
>> +(
>> +- ice_info(hw,E);
>> ++ dev_info(ice_hw_to_dev(hw),E);
>> +)

How do you think about to use a script variant (for the semantic patch lan=
guage)
like the following?

@adjustment@
expression hw;
@@
-ice_info
+dev_info
         (
+         ice_hw_to_dev(
          hw
+                      )
          ,
          ...
         )
 ;



Do you observe more desirable run time characteristics for the Coccinelle =
software
also according to another update?

avoid double call to line_removed
2023-11-21
https://gitlab.inria.fr/coccinelle/coccinelle/-/commit/162a9149cfa92702fa4=
c26e513cb69e310ab0e10


Regards,
Markus
