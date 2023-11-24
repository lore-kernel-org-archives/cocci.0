Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42794C61D97
	for <cocci@archiver.kernel.org>; Fri, 24 Nov 2023 08:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=wmIJshhsX4rWq+W1CowM/wyfT2WRkFBoTfuzpK6RWYs=;
  b=IJo3yRaxQoBvewHvn2vDQlnHa8zCwctg5o0oVz0TzU85b5FxERX29oiU
   lSDYfGwRvywXKqxjMVdzgefJRf6t2cbrfO8RNi3Dkw1rvXkfsfK2oplJQ
   hjKXdMJoUEGjuCMK9RXW6/GYEfJZGMNQ1axl46sHQFvthfuTy5D15/HB7
   0=;
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
X-IronPort-AV: E=Sophos;i="6.04,223,1695679200"; 
   d="scan'208";a="138273589"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Nov 2023 09:55:46 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EDC5DE0CCE; Fri, 24 Nov 2023 09:55:45 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 954EEE0AF1
	for <cocci@sympa.inria.fr>; Fri, 24 Nov 2023 09:55:43 +0100 (CET)
IronPort-SDR: 65606511_DApLrRCvQ4dU0tMD51Y2HB1f2n4bn7tR5GnE12/yzg+gL3W
 IYx1XWgMvSWjW8kKQykM05C1bF/WiY0ZKkQGX+w==
X-IPAS-Result: =?us-ascii?q?A0H2AgB8Y2Bl/07ASNlaHgEBCxIMQIFEC4I5B3NWMAQLS?=
 =?us-ascii?q?IRTkTItA4Q7l22BVoFAPg8BAwENOQgBAgQBAQMEhH8ChykCHgcBBDAJDgECB?=
 =?us-ascii?q?AEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQFAQKBBhOFaA2CXAEQgQyBHgEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBARcCDTpCAQQBIx0BAREnBAsLGgImAgJXBgEJCwEBg?=
 =?us-ascii?q?nwBgikBAw4jBw0GsC2BMoEBggkBAQaBV0GtPR8sIlaBXwMGgRouiA0BhVmEN?=
 =?us-ascii?q?ScPgVVEgTyCUjE+gmEEgV6DW4JoiSQDBIYmhHh1iQ9dIgVCcBsDBwN/DysHB?=
 =?us-ascii?q?DAbBwYJFBgVIwZRBCghCRMSPgSBYIFRCoECPw8OEYJAKzY2GUiCWxUMNEp2E?=
 =?us-ascii?q?CoEFBeBEgRqGxMeNxESFw0DCHQdAhEjPAMFAwQzChINCyEFVgNFBkkLAwIaB?=
 =?us-ascii?q?QMDBIE2BQ0eAhAaBgwnAwMSTQIQFAM7AwMGAwsxAwcpVUQMTwNuHzYJPAsED?=
 =?us-ascii?q?B8CGx4NJyUCMkIDEQUSAhYDJBYEOBEJCysDLwY4AhMOBgYJHgQOAxkrHUACA?=
 =?us-ascii?q?QttPTUJCxsGPgInn2KDX2hXAnuBJEmSMLIONAeCMYFfgWAMihaVDQYTL5ciD?=
 =?us-ascii?q?gaST4gZkCcgjUeUeoVzgWM9gVkzGiSDNk8DGQ+OIAwWhAmEYYpmQDUCATgCB?=
 =?us-ascii?q?wEKAQEDCYVGAQGDWoFAAQE?=
IronPort-PHdr: A9a23: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
 BYCh7/1f917Cw==
IronPort-Data: A9a23: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
 YmwjQ==
IronPort-HdrOrdr: A9a23:2RjNUKnmJteqDJCK7anzO/DTenvpDfLy3DAbv31ZSRFFG/Fw5P
 re/8jzsiWE8Qr5OUtQ/+xoXZPqfZqyz/FICOUqTNOftUzdyQyVxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIObeEYZmIbsS+V2njbL/8d4J2g7L2ig/vYwkxgVAdwdshbnn1E40qgc3GfX2N9dOIE/X
 enl7F6T7HMQx4qUvg=
X-Talos-CUID: 9a23:qQ00Fm5oImn/svyaINss7BdLMJ8ncS3hwGbQKku+VUR5R6CyVgrF
X-Talos-MUID: 9a23:uTO/jAvfrv80iOgOMM2nhRpjJOFJv6mUWWs3qqpboe6vKGttNGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,223,1695679200"; 
   d="scan'208";a="138273573"
X-MGA-submission: =?us-ascii?q?MDG8OFANW5yMsDvoQiAzIhCBhOB8VbjZD5/+52?=
 =?us-ascii?q?wst/D4eUAJqavY9KmbVItZ12Egcn1FNCuruxQjA63qgpU+J7iZ6K2r8o?=
 =?us-ascii?q?vTebkDDnO0yySmR3Z673fzLup2sOH64khfFQy5IbinRT40tsyJQKYY2D?=
 =?us-ascii?q?58Y/PoV7gMlRcFONkLrSLr0A=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 09:55:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1700816134; x=1701420934; i=markus.elfring@web.de;
	bh=b0taiVtzzhTjM3eGEd6En7yQ3LhvltoDBr9cQyDekKA=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=DNGyZBu4OP/rFKRvWkB7hCwUC1j0QwyyyG0eznnF7Aa2X6tbG1cvs4k17bZQ3nhq
	 bTVBdAnzk/sIGBMNur8tlJTOKaxHQ3Qv4V6gJ/UGV+I6WAk9FCPOqEmJm1xEx4xPa
	 rWYJCed/FNi1HVBTGweli7juSd5OzXpaie6uhzDI2357G0EwIlkEfrdUwO4qjWDvK
	 YJMk+YJjx+9xm8it36FUv/Bw7sd6e8HlIxAi9Za81oppOetEEyAtqsoB2sdkYat6/
	 LhJoxy6s4FzOzsMUfcvorTbI6eTsrMuKD1n/5FW4QHWyNTVA9ZrvVv6dSbJdpFHGv
	 ntxyygPBmFHWqYLe6g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MhWkj-1rl1r30zlz-00ea8G; Fri, 24
 Nov 2023 09:55:34 +0100
Message-ID: <d36b547b-a4d2-4e0d-a028-fb9237f99f2e@web.de>
Date: Fri, 24 Nov 2023 09:55:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <7b59cdf8-5850-49b0-8f91-16d67bf39595@web.de>
 <alpine.DEB.2.22.394.2311240807170.3349@hadrien>
 <05cc07d3-385d-48ea-9e4d-be32c3e863fa@web.de>
 <14be81ed-ab8e-cd1-205e-db30745442d3@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <14be81ed-ab8e-cd1-205e-db30745442d3@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KlhdC8uzDRegzvIsRAthWLVdBTZzMIUZgJIFb8lCCKv/YcUrLVZ
 W5RoH38RYnPNAg6cTAuy0eNdVyOq6gvospftL9BVcO0aXIe6bk/TdxwQLTR1VGgnsPAL1ff
 n6j/8Ao2hU0+CW2lIju4ov61nbTrl02PRPA9e7H0HEcWhzpbwqxcDzOBbz54TS8Sva/CsrR
 ksPgUJUFUfvbhqhonBYzw==
UI-OutboundReport: notjunk:1;M01:P0:OowuJ1EEy3o=;zqWTslCdGwDHtH8t1vPmYqSBhkS
 rK3h6hg61u3Ibfdx7m80wWOFmRkJOUqtbriU49dQujrSaihye6Ikp39KHqWVAYnJF7X5UcE/Q
 QrmON2MHtzdooAZleyl2M+/xzJu8cIcHFWk/5Z9e0WmP5IPJQMMHt4Ugzd1FDYecDTvKP4utI
 Keil6iO3jWk9k2GNGyyVetpu2hLdawCrTnXy+gjRTk4x0tjxghBUMIi5hUCFqzaSH6ZbK5ASB
 N1cQh1cYBqDzaXtcUkiEdCZfD2t7w9IlNPABLexTaPzL7eRfSpU5bOawMzCLwehulS3cDsUtU
 uUBaE/KDgFgBTIYOpBp6c2+w+L6OJL6VNWXNsI6ve24yOdQI23Z8y0QkVuQA52paZxMblS2xS
 L4jy8mxaBMUs+JtwBND0lu7NeXRG6iJX6TKbvtn7oiA2j8vdxbtZ3Qd83+gyQDgBGncbxoJKz
 3QgKS39mY9NZJ2kNPEDhigBmUGkYRKerUw52Wm1B2jJeV5Fz5X/7O2leeO5dvCUv8Ie/sHuKR
 X13rJjw0Ur3Y4My6K2Irb0OSmzfkOAZXbuuan8EFvo3Wf2iYZwBmIX/vAK8vWLUJPFxY2Cg+5
 SffHKaZuP0sI6ThhKaqFw17+TBfjoAVa0k+iPYuwT7C/eJwUnAywHukAQFVwBK1Q66/6RqflF
 bSG3gOkz8KlmL4fy8VxIQGnGpCq2FsREPNx6ymF0Spatqc6paE2JsK0PUw7SUzHtPxLA+UhtJ
 lhJulnvYz37q7W0WgZJ2NX7Y/5qJ3v9LyZaQ+VUU0L8j7L/JNNcqP9KeX7jZFset8LfF1Lod+
 In4Xd5AhvMDZeEvNO9+GVMxvw8m9XCKNWJ9rOqnahMTpl98maoEaPSnmhN7pSplYj6pf4n8i9
 +w/zNvEObCFQhSE+Dggc5oHFSBYryRWa3Wc9NyBUyer2h/hVGETkfXALvcOHMf8POjMAnOVr2
 LVCeTg==
Subject: Re: [cocci] Rechecking Python mapping for position variables
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1329
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-11/d36b547b-a4d2-4e0d-a028-fb9237f99f2e%40web.de>

>>>> Test result:
>>>> Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> spatch disp=
lay_position_information_for_one_return.cocci only_return_from_main.c
>>>> =E2=80=A6
>>>> (<coccilib.elems.Location instance at 0x7f8fc4fcefa0>,)
>>>
>>> The type of a position variable in python is an array.
>>
>> It seems that the output from a call of the function =E2=80=9Cpprint=E2=
=80=9D did not indicate this.
>> https://docs.python.org/3/library/pprint.html#pprint.pprint
>
> I have no idea.

Such feedback should be reconsidered.


> You access the thing as p[0].line, p[1].line, etc.

The specification of =E2=80=9Carray=E2=80=9D indices would be needed if se=
veral items
would actually be available for a script rule.


> I don't know what type is involved.

I guess that the knowledge can be extended accordingly.


>>> So if you want a location, you would take the first element of the arr=
ay.
>>
>> How do you think about the possibility to avoid such data processing?
>>
>> May it be expected that only a single source code place will be passed =
to
>> the shown script rule?
>
> No.  When you use ... by default it considers all paths.  Therefore in
>
> a();
> ...
> b@p();
>
> multiple positions can be matched.

This search functionality is generally fine.


> It doesn't make any sense to have a special case for the case
> where there happens to be only one.

I got an other development view.

* Can it actually happen that more position items are passed to a script r=
ule
  by a local variable?

* Would it be possible to restrict the transferred data amount by a relate=
d
  metavariable type?


Regards,
Markus
