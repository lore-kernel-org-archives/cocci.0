Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E748C7619A
	for <cocci@archiver.kernel.org>; Tue, 11 Apr 2023 07:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=iNB83yl2V06B1uytpUorIsTegbPVRv907USo929Qo8Q=;
  b=X/Bkn6AtnG6LDHcHCXONrGJuOjMdbliAV8W9H06veRlPYIfRb3CO0SMD
   FYhbBxJUifCrZ/lypT0m+rmlyBh1uDEBCO7sVC/UAVfFKR0dLCCHUsaBe
   P9XLszyT+JgAU8zERulFHIe13+trcmZ6idkN6XZcwdgbfw2ZW7zzg50qw
   Y=;
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
X-IronPort-AV: E=Sophos;i="5.98,336,1673910000"; 
   d="scan'208";a="102347105"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Apr 2023 09:15:34 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 75817E7315; Tue, 11 Apr 2023 09:15:34 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 93629E72F8
	for <cocci@sympa.inria.fr>; Tue, 11 Apr 2023 09:15:28 +0200 (CEST)
IronPort-SDR: 6435090f_G34DLj0kDNTlf4DFcHTM+hNJLBqj5BlgQZZIpdb9PcVDKIM
 583nZWXuAdjKh477Objvxfcg1Xe//VnCbPamTxQ==
X-IPAS-Result: =?us-ascii?q?A0EpAACQBzVkhwwR49RaHQEBAQEJARIBBQUBQIE7CAELA?=
 =?us-ascii?q?YItdVYvBAtGhFOIHohhhGGObIhrgVaBQBYoDwEDAQ09BAECBAEBAwSEfwKFP?=
 =?us-ascii?q?QIdBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAUBAhABAQEaC?=
 =?us-ascii?q?RcHDhAFIoVoDYI3KQERZIEIAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQESAg0HM?=
 =?us-ascii?q?x4BAR4DAyMdAQERJw8LGgImAgJXBgEMCAEBgnoBgicBAzEHDKwrgTKBAYIIA?=
 =?us-ascii?q?QEGgUABmkofLCJUgV4DBoEULQGNCYQuAicPgVVEgTyCUzA+gmIEAReBRoNbg?=
 =?us-ascii?q?meOZYtPgTR0gSAOgTyBBAIJAhFrgRAIaoF5QAINYwsOb4FJY0yBewQCFDglB?=
 =?us-ascii?q?A4DGSsdQAIBC3U/NQYDCx8GWGsCCSMREwUDCxUqRwQIOAYcNBECCA8SDwYmR?=
 =?us-ascii?q?A5CNzMTBoEGCw4RA1CBRwQvXHwKBkucFIFdgiyBX4EYwwk0B4IqgVaBWQyKD?=
 =?us-ascii?q?ZUABhMvlwkOBpIll3MgjTOUX4VtgWM6gUgNBzMaJIM2EzwDGQ+OIBkegzszN?=
 =?us-ascii?q?48RPzQCOwIHAQoBAQMJhUYBAYV9AQE?=
IronPort-PHdr: A9a23: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
 AE7gE1ybLZ1nAo=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:Hcd0J6zo4rjsCSRnzgvQKrPw8r1zdoMgy1knxilNoG9uA6+lfq
 eV7Y0mPH7P+VAssRQb8uxoV5PufZqxz+8Q3WBVB8bEYOCEggWVxeNZgbcKqgeIc0DDH6xmpM
 JdmsNFaOEYY2IK7/rS3Cn9Nco8y9+a962Sif7Z1GoFd3ARV0gt1WZE4h3wKDwPeOCqP+tDKH
 IWi/Asmwad
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,336,1673910000"; 
   d="scan'208";a="53042913"
X-MGA-submission: =?us-ascii?q?MDF/BcJHQWEAVnm9C3dVihNp6y9Bn3lkdRJqI2?=
 =?us-ascii?q?dsHYTqN+t/yaEuipelkBIUBTvoIngryyipC9nQoo8AJrAF5hJQVMy0Uf?=
 =?us-ascii?q?GgEj1tlc5RhVf3hfExnfYb3Lw7eYoYw4wbOTcd2lUXERnfOBGZFH+kmO?=
 =?us-ascii?q?MhGNYUb9KPghxRnkK8to1DCA=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 09:15:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681197326; i=markus.elfring@web.de;
	bh=m8Ei7pg2kAnnEnZKHLfhUqKCKABHVApEc0sFJFaJi3I=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=t+NdBR6cOO+ynVPDTQ9wW9hjQynrjzSO7hAgktg2EBYBlVALrZKNpHV2Wcuo80aE/
	 tt4G1IYJduVD4FqhMB7GGqae/YnQBltgvXnvLSiZq6xmhEouI2zGsKL+J4q6mhtHLd
	 sBcIX539wingV/ufVrG5jLcztxbcl7XU8uAEP6ldPQK+Fm657Flm6WCyK9cQvc6QfL
	 5yfcBoD8f1kTRnT5GmGJFVR/fSXMwFW+ASPiurMsCqJXDkNJOIdEatwpEsmJ+8cyJX
	 wK6J7l4AvoeehJE7hgw+PWaqFkRR9MS285/ZkemAOPpllazUMwuzu7vv//ODlkdFKU
	 XG05ZOKtey5fQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MqZMQ-1q8Ju22eCu-00mtcE; Tue, 11
 Apr 2023 09:15:26 +0200
Message-ID: <5defca25-d893-f61a-ec24-aa99ba39d8a7@web.de>
Date: Tue, 11 Apr 2023 09:15:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr,
 kernel-janitors@vger.kernel.org
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <alpine.DEB.2.22.394.2304092044020.3028@hadrien>
 <95caa4c1-2455-2733-ef4b-3ab07783c725@web.de>
 <alpine.DEB.2.22.394.2304100824510.3387@hadrien>
 <2de88997-0732-d0dd-5178-f9d42b5a3be5@web.de>
 <alpine.DEB.2.22.394.2304100959310.3387@hadrien>
 <31b51efc-afbe-ec34-255e-9df60983ec3d@web.de>
 <alpine.DEB.2.22.394.2304101415040.2875@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2304101415040.2875@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LqKUc5hlMziEfBVeSF/MJ6hC7vUClDcFwthmQJNVj5Giuw9ZB/0
 W6CdtJGNkIAQvrNWnyRBs2OW+riU152wRCZXhxCeitEBCGvyTg97o1d/B5c+91CeeqNSQ1k
 BshQDGctZvbFrBFydRdRz/RhHv/4jiwHOGqjNlMZmL09EJlNHRVovrkRq6tc18DOxGSVM3F
 l0cyDkIbbYrOstjIPy+sQ==
UI-OutboundReport: notjunk:1;M01:P0:eoDhHWhRt0E=;Kv0PXnmEEMzyMHawfbg6AAOGXAG
 p1M7FUXeT/RV4R2XGQlFnOTHiQvArT35sgte0k2hOXjOF/Y9t0T6IZl3FYNhdQZvIW9i5zsqF
 cvmZDjyOK4BDuycEAR+X+I2qN4qMIC78w3xpUGw02qSrAmvAaLbr3TDk58BGKna6kVz/66AJE
 q87mNWy+/Z33q4VAKTlCws1T17ewH+AUJZ+jWGbNOJoK5W197hZ+JH5etlPtR2zy5Ew9RkEJO
 ZOG/YmkzFfCHPcCz2brhiRKGtznWhBCu4wuB7huAon2QyZiJn6Aii2MwWRw14sIjW436p9OaS
 zCsslG3DIFUde/mLX9+Srcr6yWPQXrWIk923BAC0us9IyMyMtwFVuK4UdfJ5uvaNXWX/Se2pS
 QNdx6CqbKiJabX528FJ1PRLCFu/BQ9bhLV+OYUTqKJhXTZZF5JRpkfNsR0alo/fAqjkCIgefd
 haFHxS9NtO1MCi9UnpgZvK4grijyg2WjnCjheMIOqAba797nSgxzPd4h2gmjuLuId46xlQMEx
 j8nDPGu/78bOaXl85J+DwPXWx+LAHZYAdC/YMKh6aGD5e4gabBPbAxJkwbFQubx6WrLdDSpm3
 w2uPYUGgYTgnfd/B0fLi3pKE5gAKhCJtstqFFNWtBt2nxSfUaCG9gsf48TnOzgY9b+RP4Ty4v
 ePppkMsIolDKR0BEClyXPnURVdsTO60QNlXUVfsmfeRRaMlOu1zFvp3y61LQ45SBABozCTBly
 Pnq53YxXRQjYJTobLki4AlaV7/bL2E9tzpaGQfjbQ6OCt/BQ/mb697jix81XzYNbCT9C2Asvc
 GwaunYY1/JtnitQCBsVkYT8W/pzrIqwfqrv6uxlzA7RTcpMcaXVz8eJaxU+94MHR4PDkb/psh
 PYcT/vNDCUjb0GmGT81XaS42dO3VeYri5D2fHuaV/LQFUZFR7gIR+U5bV
Subject: Re: [cocci] Reconsidering pointer dereferences before null pointer
 checks (with SmPL)
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1025
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/5defca25-d893-f61a-ec24-aa99ba39d8a7%40web.de>

>>>> https://stackoverflow.com/questions/25725286/does-taking-address-of-m=
ember-variable-through-a-null-pointer-yield-undefined-be
>>>> https://en.cppreference.com/w/c/language/behavior
>>>
>>> The statement:
>>>
>>> "... &((*ptr).second) which dereferences an object instance pointer"
>>>
>>> is not correct.  &((*ptr).second) does not dereference *ptr any more t=
han
>>> &x deferences x.  The semantics of & doesn't work like that.
>>
>> Does the usage of the operator =E2=80=9Cmember access through pointer=
=E2=80=9D (arrow) mean also
>> a dereference in comparison to the asterisk operator in the C programmi=
ng language?
>
> Not when there is a & in front.  you can just look at the generated
> assembly code to see that.  The goal of & is to take the address of
> something, not to evaluate the thing.

Would you like to take another look at recent responses by David Svoboda?
https://wiki.sei.cmu.edu/confluence/display/c/EXP34-C.+Do+not+dereference+=
null+pointers?focusedCommentId=3D405504153#comment-405504153

Regards,
Markus
