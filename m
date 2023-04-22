Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 131F8C6FD18
	for <cocci@archiver.kernel.org>; Sat, 22 Apr 2023 13:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=X1rEfRx0I8D0IwwiGVga0Oqu3M2CI676vFJVE/LYFvE=;
  b=JPpARYH00sb1iGie3okstvDlFUJRdaTMd5WdWwtqCXXSDVuJS4EtvDFF
   e7XjeFTE5wAfe/zdz0fsTtwfAUOEo5h220s7M05hlGaJMkFfkUFhxJs5q
   i6ruqzPdYgrtHUVFLHtYzFCC7bie2WDeLUlKZUNE+uBkHnS5/hG6lhfnp
   s=;
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
X-IronPort-AV: E=Sophos;i="5.99,218,1677538800"; 
   d="scan'208";a="104294127"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Apr 2023 15:34:17 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2EA47E01D1; Sat, 22 Apr 2023 15:34:17 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 63673E019E
	for <cocci@sympa.inria.fr>; Sat, 22 Apr 2023 15:34:15 +0200 (CEST)
IronPort-SDR: 6443e256_14VGwhEETMB4gPC1juoIxa+EueAN9nHXXqKx2z/xRcNYFnT
 uxGZ9yvijbvH196d2VjcS+XaJ5kJWneSllyf5Lg==
X-IPAS-Result: =?us-ascii?q?A0FkAACf4ENkhw4P49RaHQEBAQEJARIBBQUBQIE9BgELA?=
 =?us-ascii?q?YItgUsvBAtGhFOPEIInhDCHLoc+iGqBVoFAPg8BAwENQQECBAEBAwSCC4J0A?=
 =?us-ascii?q?oU8Ah0HAQQyBw4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBQECEAEBA?=
 =?us-ascii?q?RoJFwcOEAUihWgNgjcpARFkgQgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBARICR?=
 =?us-ascii?q?z4BAgIBIx0BAREnBAsLGgImAgJXBgEMCAEBgnqCKAEDDiMHqwuBMoEBgggBA?=
 =?us-ascii?q?QacDB8sIlSBXgmBFC0BjR+EMScPgVVEgTwMgkcxPoREg1uCZ4lkjDSBM3SBJ?=
 =?us-ascii?q?4EygQQCCQIRa4EQCGiBdEACDWQLDnCBRYMXBAIUNA4MFgVCJQQOAxkrHUACA?=
 =?us-ascii?q?Qt1PTUJCx8GRAIfgWwEL1h3CgZKl3mECS8DoSShajQHgiuBVoFZDJ8NBhMvl?=
 =?us-ascii?q?wkOBpIlHpdZIKd/gWkBM4FcMxokgzZPAxkPjiAZHoNuj0g/ND0CBwEKAQEDC?=
 =?us-ascii?q?YVGAQGFfQEB?=
IronPort-PHdr: A9a23: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
 j3ni6/5bjtPoYq8FSo0As/JNISYPXBnPRe7QFbp
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:bE34RaqXS1Cv4zwJsLRfvi4aV5r1eYIsimQD101hICG9Afbo9P
 xG+85rrCMc6QxhPk3I/OrqBEDuexzhHPJOkO0s1PKZLW7bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QFpSWY+eRMbEVt7eZ3CCFM5IH3MSN9ryuiNzT1nF3UGhRGttdBktCazpyCSdNNXF77HcCZe
 GhDkErnVCdRUg=
X-Talos-CUID: 9a23:qiTIE2PxRctyMO5DG3E8+X4UJZkcc1aD83qOfkS7V3kzR+jA
X-Talos-MUID: 9a23:GeVTAQbgSJikp+BTnhHDgDRMM59UpIuXK0xSo5pe+MqZDHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,218,1677538800"; 
   d="scan'208";a="54039507"
X-MGA-submission: =?us-ascii?q?MDHNiziFPz4w5XSpAMLc1CazIA3GVcKAH+Ghiw?=
 =?us-ascii?q?oaejjgPp56oji8O/7RgIU7LIL4oGIxBE0UONBWnmk8SrLLW1kIT7adX8?=
 =?us-ascii?q?IbrtLrHt3s0vXWyAdnHRBlXWh/Qy+IwNIZp1ICKL5nf4o+FlWs7pHz/+?=
 =?us-ascii?q?LHqRsxWK1fiPWSC5Ideo0nng=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2023 15:34:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1682170453; i=markus.elfring@web.de;
	bh=0+fjyi7TRBFPqZf1CfQPJXvsANLqDVzb0ayiBV8zXTw=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=ShDG52nNG/P08wIdrCv5pcc7DQT8e7GlqL58B8SwJBYZMwW6PGMYyNngZ/JBTqVrm
	 juIDQc3hfEhMLCupKwNQBd4reE9RQvg9iEAgVT+goTwjpOhh530L8lnGoWNoLlC5Ny
	 kge7Io09w05YxiKegiFcQ1eeR9jY57JrFbM1mOp5x8oP8KQnA0OjWlWcPKLQsC0J/r
	 P50dYZ8fKRYaEF+hw41e2gRVEeuj8vkKmqTDWGDCzDrXrZLqRmZQcEjIlKhnSlfly1
	 mDj4BdOE7IdLJ3jpg1xDvD0Q+/2RIhBiIwZ7i+B4i8n/vOc3TvCZpVOp8gV603f76u
	 Fm/3Jnir8FNtg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N1d3k-1qIa6f2lY0-0124ec; Sat, 22
 Apr 2023 15:34:13 +0200
Message-ID: <f2216894-0eb7-6024-7114-4fc0e05a7157@web.de>
Date: Sat, 22 Apr 2023 15:34:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <037507d2-ab0a-7d93-bf3b-10e51e70fbc6@web.de>
 <alpine.DEB.2.22.394.2304221031370.2766@hadrien>
 <1f0089f3-3c8f-60e3-5520-f7813093076a@web.de>
 <alpine.DEB.2.22.394.2304221104340.2766@hadrien>
 <531d1abc-1023-a5ae-2a58-06dd52b26643@web.de>
 <alpine.DEB.2.22.394.2304221200090.2766@hadrien>
 <549ec2c2-0833-7988-61f6-685f0fa22104@web.de>
 <alpine.DEB.2.22.394.2304221329450.2766@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2304221329450.2766@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LsexYTtVtQNHCL6nSl3vj35fbwmoy+ycExPDSJ+P1CP0SPQviB/
 yMT+xbZ0UW3nQ1LK38QqtI4qwacoY9e86oQatxEae6QQa2DhZcCzp1yDHvu1ZwVMwZB4eFI
 fqsf7melk7Aqo8sxwXY9rctOxjAOspluLD+/ZpHfLVg44+YSQfxNUO1snUgH0odnfqFprrR
 dp//E4VGp+OxMRMiBrzvg==
UI-OutboundReport: notjunk:1;M01:P0:cx9eVkdMkws=;NblAaWWtCJTpgtKXpZeCfB6UsSI
 OQC5QTW1igiG0SO8O+MJVTnLLx2/J34InhElJCj/FW8C3w5g40nHLLDUO6OUdWdHZlogbvEXH
 YKb1+XPRNp9vIzZqkN8Ng69hv3K7xvVSa3Yga0SualWd0IWEk1TBKPk+YgdZdjUwXBV+92euZ
 6r1iom+p49NXp0Fs13gW0Zbpl/25CyAQbkOe3WYqod7lgNP790AQqWv+ddndCct6zF6RYHjjF
 w2oDLkHHhm/Vxv+k5y099WCgwwhqRimOcc0InzIOMimJmBchqV57bDYR2mPVdoZKD6y8Qypcu
 BG2zTuQm1Y+xhgnCNThecF6ysDMvMaBaNaQA4Ew9Q8uMh6e0AcKAGyD0IqtmUFUw87B+kShyX
 DWWW9+I+j3iTOy5E9pye5CtBawmonQ8mHi7bFKw0WNGb/bzprFQYjqPm5z+ffzQzJsvnZ2KCj
 HB7P5HHJGGEkCcLAEnjxZb/ig37vliSFDxK30i0h1xOXsnEn3BSPVszVfTyyZIW9Co7fuppgK
 itf3dlB5/uQGAKzJ8KjmSeGTITTiBJxtiPMIByq7r4kd47DJ4FEykd6dwVrKiUMJIyHJolWB5
 hBie3OP47Ex9Jf6PsWAfT/Pn+nDFpGvsvLb3v5/ZqUDsXPLLpTjriefj1pVmzeM08Y3JTGXUn
 fUdLaPrD/05TQkdc8nfbFj4WiG5lSsa7OFXQOoHmd9uf2V7L/z0m/xBvqNfuOhjCQoMAKgYXu
 0JT5LwCJV/dXgY8YvYDC2lv/6XYUg73TDM4GcWftMp1TknxSi3BvqkonrsCykILrw5lsJwluP
 ejy3xTvRT35S4B7h8BoFAUPvt0Wq/KpNE4/u9XrKfqzfOShCQoV/uyaoWyqGu1AGBuQgv5HV6
 BsycovrpSomPnbOhJVFjdrT7DPnR6eZF5SmYAC2lBBj14LH9WiylOlrGAoRHcvzIk9IfLEYcy
 Yx7vIw==
Subject: Re: [cocci] Checking data processing for capturing groups in
 regular expressions (with SmPL)
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1115
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/f2216894-0eb7-6024-7114-4fc0e05a7157%40web.de>

>> Do you find it easier to interpret the affected code in smaller steps?
>>
>> =E2=80=A6
>> @find_update_candidate@
>> constant char[] input_string;
>> expression input_context;
>> position pos;
>> @@
>>  seq_printf@pos(input_context, input_string);
>>
>> @script:python selection2@
>> =E2=80=A6
>> param << find_update_candidate.input_string;
>> pos << find_update_candidate.pos;
>> =E2=80=A6
>> @@
>> sys.stderr.write('param: ' + param + '\n')
>> match =3D re.match('"([^"]+)"', param)
>> if match:
>>    content =3D match.group(1)
>>    sys.stderr.write('content: ' + content + '\n')
>
> Why can't this branch just stop here?

Special circumstances trigger data processing surprises for the determinat=
ion
which data were assigned to the variable =E2=80=9Cparam=E2=80=9D (as a str=
ing literal).



> Can't the user just see whether the length of content is 1 from the line=
 above?

No.


>>    if (len(content) =3D=3D 1) or (=E2=80=A6):
>>       x =3D "c"
>>       =E2=80=A6
>>    else:
>>       x =3D "s"
>>       =E2=80=A6


But I expect that this case distinction will also occasionally be performe=
d
so that an appropriate character can be appended to a function name.


>>    coccinelle.call =3D "seq_put" + x
>>    sys.stderr.write('call: ' + coccinelle.call + '\n')
>>    =E2=80=A6
>> else:
>>    =E2=80=A6
>>    sys.stderr.write('include_match(False)\n')

Does such a code part work as expected in your software test environment?

Regards,
Markus
